--------------------------------------------------------------------------------
-- WRAPPERS
--------------------------------------------------------------------------------

-- # Here I have just gathered the most common ones.
-- # Feel free to add a specific one that you use.

WRAPPERS = {
    
    {
        'oxmysql',
        function (promise, sql_text, params)
            exports['oxmysql']:query(sql_text, params, function(result)
                promise:resolve(result)
            end)
        end,
    },
    
    {
        'ghmattimysql',
        function (promise, sql_text, params)
            exports['ghmattimysql']:execute(sql_text, params, function(result)
                promise:resolve(result)
            end)
        end,
    },
    
    {
        'GHMattiMySQL',
        function (promise, sql_text, params)
            exports['GHMattiMySQL']:QueryResultAsync(sql_text, params, function(result)
                promise:resolve(result)
            end)
        end,
    },

    {
        'mysql-async',
        function (promise, sql_text, params)
            exports['mysql-async']:mysql_fetch_all(sql_text, params, function(result)
                promise:resolve(result)
            end)
        end,
    }

}