-- control.lua - Main control file for Factorio mod
-- This file is loaded when the mod is used as a Factorio mod

-- Load all snippets and register them as remote interface
local snippets = require("init")

-- Load individual snippets
snippets.teleport = require("snippets.teleport")
snippets.clear_pollution = require("snippets.clear_pollution")

-- Add any initialization code here
script.on_init(function()
    log("Factorio Automation snippets loaded")
end)

-- Add any configuration changed handlers here
script.on_configuration_changed(function(data)
    log("Factorio Automation configuration changed")
end)

-- Example: Register a custom command
commands.add_command("tp", "Teleport to coordinates: /tp x y", function(command)
    local player = game.players[command.player_index]
    if not player then return end
    
    local params = {}
    for param in command.parameter:gmatch("%S+") do
        table.insert(params, tonumber(param))
    end
    
    if #params >= 2 then
        local success = snippets.teleport(player, {x = params[1], y = params[2]})
        if not success then
            player.print("Failed to teleport to " .. params[1] .. ", " .. params[2])
        end
    else
        player.print("Usage: /tp x y")
    end
end)
