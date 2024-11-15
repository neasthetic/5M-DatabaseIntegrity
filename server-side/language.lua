--------------------------------------------------------------------------------
-- LANGUAGES
--------------------------------------------------------------------------------

-- # NOTE: Make sure not delet "%s" on messages since it will get values on main code.

LANGUAGES = {

    ["en"] = {
        -- # SUCCESS
        ["WrapperDetected"] = "[\27[92mSUCCESSO\27[37m] SQL Wrapper detected: %s",
        ["AllTablesStable"] = "All tables are correctly structured.",
        ["IntegrityStable"] = "[INTEGRITY]: Table '\27[97m%s\27[37m' integrity is stable.",

        -- # WARNS
        ["NoWrapperDetected"] = "[\27[ERROR\27[37m]: No active SQL wrapper detected!",
        ["TableNotFound"] = "[INTEGRITY]: Table '\27[97m%s\27[37m' does not exist or has no columns.",
        ["IntegrityIssues"] = "[INTEGRITY]: Integrity issues found in table '\27[97m%s\27[37m':",
        ["TypeError"] = "Error: Incorrect data type for column '\27[97m%s\27[37m' (Expected: %s, Got: %s)",
        ["DefaultError"] = "Error: Incorrect default value for column '\27[97m%s\27[37m' (Expected: %s, Got: %s)",
        ["UnexpectedColumn"] = "Error: Unexpected column found in database: %s",
        ["MissingColumn"] = "Error: Expected column missing in table: %s",


        ["TablesWithIssues"] = "[\27[91mWARNING\27[37m] Integrity issues detected:",
        ["Tables"] = "\nTables:",
        ["Issues"] = "\nIssues:"
    },

    ["pt-br"] = {
        -- # SUCESSO
        ["WrapperDetected"] = "[\27[92mSUCESSO\27[37m] Identificado \27[97m%s\27[37m como seu Wrapper SQL.",
        ["AllTablesStable"] = "[\27[92mSUCESSO\27[37m] Todas as tabelas estão corretamente estruturadas.",
        ["IntegrityStable"] = "[\27[92mSUCESSO\27[37m] Integridade da tabela '\27[97m%s\27[37m' confirmada.",

        -- # ALERTAS
        ["NoWrapperDetected"] = "[\27[91mALERTA\27[37m]: Nenhum wrapper SQL ativo foi detectado!",
        ["TableNotFound"] = "[\27[91mERRO\27[37m]: Tabela '\27[97m%s\27[37m' não existe ou não possui colunas.",
        ["IntegrityIssues"] = "[\27[91mERRO\27[37m]: Problemas de integridade na tabela '\27[97m%s\27[37m':",
        
        ["TypeError"] = "Tipo de dado incorreto para a coluna '\27[97m%s\27[37m' (Esperado: %s, Obtido: %s)",
        ["DefaultError"] = "Valor padrão incorreto para a coluna '\27[97m%s\27[37m' (Esperado: %s, Obtido: %s)",
        ["UnexpectedColumn"] = "Coluna inesperada encontrada: \27[97m%s\27[37m",
        ["MissingColumn"] = "Coluna esperada faltando: \27[97m%s\27[37m",
        
        ["TablesWithIssues"] = "[\27[91mALERTA\27[37m] Identificado problemas de integridade:",
        ["Tables"] = "\nTabelas:",
        ["Issues"] = "\nProblemas:"
    },
    
}