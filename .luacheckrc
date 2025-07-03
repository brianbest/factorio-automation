-- Luacheck configuration for Factorio Lua snippets
max_line_length = 120
ignore = {
    "113", -- accessing undefined variable (for Factorio globals)
    "212", -- unused argument (common in Factorio event handlers)
}

-- Factorio global variables
globals = {
    "game",
    "script",
    "remote",
    "commands",
    "settings",
    "rcon",
    "rendering",
    "global",
    "log",
    "localised_print",
    "serpent",
    "table_size",
    "defines",
    "data",
    "mods",
    "util",
}

-- Allow access to _G
allow_defined_top = true
