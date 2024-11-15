--------------------------------------------------------------------------------
-- SETTINGS
--------------------------------------------------------------------------------

Config = {}

Config.Language = "pt-br"

--------------------------------------------------------------------------------
-- TYPEMAPPING
--------------------------------------------------------------------------------

TYPEMAPPING = {

    -- INTENGERS
    ['tinyint'] = 'tinyint',
    ['smallint'] = 'smallint',
    ['mediumint'] = 'mediumint',
    ['int'] = 'int',
    ['integer'] = 'int',
    ['bigint'] = 'bigint',
    ['bit'] = 'bit',
    
    -- FLOATS
    ['float'] = 'float',
    ['double'] = 'double',
    ['decimal'] = 'decimal',
    
    -- STRINGS
    ['varchar'] = 'varchar',
    ['character varying'] = 'varchar',
    ['char'] = 'char',
    ['tinytext'] = 'tinytext',
    ['text'] = 'text',
    ['mediumtext'] = 'mediumtext',
    ['longtext'] = 'longtext',
    ['json'] = 'json',
    ['uuid'] = 'uuid',
    ['inet4'] = 'inet4',
    ['inet6'] = 'inet6',

    -- BINARY
    ['binary'] = 'binary',
    ['varbinary'] = 'varbinary',
    ['tinyblob'] = 'tinyblob',
    ['blob'] = 'blob',
    ['mediumblob'] = 'mediumblob',
    ['longblob'] = 'longblob',

    -- DATE/TIME
    ['date'] = 'date',
    ['time'] = 'time',
    ['year'] = 'year',
    ['datetime'] = 'datetime',
    ['timestamp'] = 'timestamp',

    -- SPACIAL
    ['point'] = 'point',
    ['linestring'] = 'linestring',
    ['polygon'] = 'polygon',
    ['geometry'] = 'geometry',
    ['multipoint'] = 'multipoint',
    ['multilinestring'] = 'multilinestring',
    ['multipolygon'] = 'multipolygon',
    ['geometrycollection'] = 'geometrycollection',

    -- OTHER TYPES
    ['unknown'] = 'unknown',
    ['enum'] = 'enum',
    ['set'] = 'set',
}