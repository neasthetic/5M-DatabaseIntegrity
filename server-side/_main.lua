--------------------------------------------------------------------------------
-- LOGGER FUNCTION
--------------------------------------------------------------------------------
local function logger(key, ...)
    local lang = LANGUAGES[Config.Language] or LANGUAGES["en"]
    local message = lang[key] or LANGUAGES["en"][key] or key
    if select("#", ...) > 0 then
        return string.format(message, ...)
    else
        return message
    end
end

--------------------------------------------------------------------------------
-- WRAPPER DETECTION
--------------------------------------------------------------------------------
local SqlWrapper

local function DetectWrapper()
    for index, wrapper in ipairs(WRAPPERS) do
        local scriptName, executeFunc = table.unpack(wrapper)
        if GetResourceState(scriptName) == 'started' then
            SqlWrapper = executeFunc
            print(logger("WrapperDetected", scriptName))
            return
        end
    end
    print(logger("NoWrapperDetected"))
end

AddEventHandler("onResourceStart", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        Wait(1000)
        DetectWrapper()
    end
end)

--------------------------------------------------------------------------------
-- TABLE / COLUMN EXISTS
--------------------------------------------------------------------------------

function DatabaseTableExist(TableName, ColumnName)
    local Promise = promise.new()
    local Query
    local Params

    if ColumnName then
        Query = [[
            SELECT COUNT(*) as count 
            FROM information_schema.columns 
            WHERE table_schema = DATABASE() 
              AND table_name = ? 
              AND column_name = ?
        ]]
        Params = { TableName, ColumnName }
    else
        Query = [[
            SELECT COUNT(*) as count 
            FROM information_schema.tables 
            WHERE table_schema = DATABASE() 
              AND table_name = ?
        ]]
        Params = { TableName }
    end

    SqlWrapper(Promise, Query, Params)

    local Result = Citizen.Await(Promise)

    return Result[1] and Result[1].count > 0
end

--------------------------------------------------------------------------------
-- TABLE INTEGRITY
--------------------------------------------------------------------------------
function DatabaseIntegrity(TableName, ExpectedColumns)
    local IntegrityResult = true
    local Promise = promise.new()
    local ErrorMessages = {}

    local Query = [[
        SELECT column_name, data_type, column_default
        FROM information_schema.columns
        WHERE table_schema = DATABASE() 
          AND table_name = ?
    ]]

    SqlWrapper(Promise, Query, {TableName})

    local Result = Citizen.Await(Promise)

    if not Result or #Result == 0 then
        table.insert(ErrorMessages, logger("TableNotFound", TableName) .. " [\27[91m" .. TableName .. "\27[37m]")
        return false, ErrorMessages
    end

    for _, dbColumn in pairs(Result) do
        local colName = dbColumn.column_name
        local colNameLower = string.lower(dbColumn.column_name)
        local colTypeRaw = string.lower(dbColumn.data_type)
        local colType = TYPEMAPPING[colTypeRaw] or colTypeRaw
        local colDefault = dbColumn.column_default and string.lower(tostring(dbColumn.column_default):gsub("%s+", ""))

        local expectedColumn = nil
        for expectedColName, expectedColData in pairs(ExpectedColumns) do
            if string.lower(expectedColName) == colNameLower then
                expectedColumn = expectedColData
                expectedColumn.name = expectedColName
                break
            end
        end

        if expectedColumn then
            local expectedType = expectedColumn.type
            local expectedDefault = expectedColumn.default and string.lower(expectedColumn.default)

            if colType ~= expectedType then
                IntegrityResult = false
                table.insert(ErrorMessages, logger("TypeError", expectedColumn.name, expectedType, colType) .. " [\27[91m" .. TableName .. "\27[37m]")
            end

            if expectedColumn.default then
                if not colDefault or colDefault ~= expectedDefault then
                    IntegrityResult = false
                    table.insert(ErrorMessages, logger("DefaultError", expectedColumn.name, expectedDefault, colDefault or "NULL") .. " [\27[91m" .. TableName .. "\27[37m]")
                end
            end
        else
            IntegrityResult = false
            table.insert(ErrorMessages, logger("MissingColumn", colName) .. " [\27[91m" .. TableName .. "\27[37m]")
        end
    end

    for expectedName, _ in pairs(ExpectedColumns) do
        local columnFound = false
        for _, dbColumn in pairs(Result) do
            if string.lower(dbColumn.column_name) == string.lower(expectedName) then
                columnFound = true
                break
            end
        end
        if not columnFound then
            IntegrityResult = false
            table.insert(ErrorMessages, logger("UnexpectedColumn", expectedName) .. " [\27[91m" .. TableName .. "\27[37m]")
        end
    end

    return IntegrityResult, ErrorMessages
end

--------------------------------------------------------------------------------
-- MULTIPLE TABLE INTEGRITY
--------------------------------------------------------------------------------
function DatabaseIntegrityMultiple(tables)
    local TablesIntegrityResult = true
    local AllErrorMessages = {}
    local TablesWithIssues = {}

    for TableName, ExpectedColumns in pairs(tables) do
        local IntegrityResult, ErrorMessages = DatabaseIntegrity(TableName, ExpectedColumns)
        if not IntegrityResult then
            TablesIntegrityResult = false
            table.insert(TablesWithIssues, TableName)
            for _, msg in ipairs(ErrorMessages) do
                table.insert(AllErrorMessages, "  • " .. msg)
            end
        end
    end

    Wait(500)
    if TablesIntegrityResult then
        print(logger("AllTablesStable"))
    else
        print(logger("TablesWithIssues"))
        
        print(logger("Tables"))
        for _, tableName in ipairs(TablesWithIssues) do
            print("  • " .. tableName)
        end

        print(logger("Issues"))
        for _, msg in ipairs(AllErrorMessages) do
            print(msg)
        end
    end

    return TablesIntegrityResult
end

RegisterCommand("dbexist", function()
    local Table1 = "routes"
    local Table2 = "monkeysgg"
    local Column1 = "expiration"
    local Column2 = "gorilagg"

    print("A tabela "..Table1.." existe?", DatabaseTableExist(Table1))
    print("A tabela "..Table2.." existe?", DatabaseTableExist(Table2))
    print("A tabela "..Table1.." existe com a coluna "..Column1.."?", DatabaseTableExist(Table1, Column1))
    print("A tabela "..Table1.." existe com a coluna "..Column2.."?", DatabaseTableExist(Table1, Column2))
end)

RegisterCommand("dbintegrity", function()
    local expectedColumns = {
        ['group_name'] = { type = 'int', default = nil },
        ['buff_value'] = { type = 'int', default = nil },
        ['expiration'] = { type = 'bigint', default = nil },
    }

    local IntegrityResult, ErrorMessages = DatabaseIntegrity("routes", expectedColumns)

    if IntegrityResult then
        print("deubom")
    else
        for _, msg in ipairs(ErrorMessages) do
            print(msg)
        end
    end
end)

RegisterCommand("dbintegrity2", function()
    local expectedTables = {
        routes = {
            ['group_name'] = { type = 'int', default = nil }, 
            ['buff_value'] = { type = 'int', default = nil },
            ['expiration'] = { type = 'bigint', default = nil },
        },

        chests = {
            ['id'] = { type = 'int', default = nil },
            ['name'] = { type = 'varchar', default = nil },
            ['weight'] = { type = 'int', default = nil },
            ['perm'] = { type = 'varchar', default = nil },
            -- ['logs'] = { type = 'tinyint', default = nil },
            ['macaco'] = { type = 'tinyint', default = nil },
        },
    }
    
    DatabaseIntegrityMultiple(expectedTables)
end)



