-- control.lua - Main control file for Factorio mod
-- This file is loaded when the mod is used as a Factorio mod

-- Load the snippets manager
local snippets_manager = require("snippets_manager")

-- Register snippet commands
for _, snippet in pairs(snippets_manager.get_all_snippet_names()) do
    commands.add_command(snippet, "Run snippet: " .. snippet, function(cmd)
        local player = game.players[cmd.player_index]
        snippets_manager.execute(snippet, player)
    end)
end

-- Event handlers
script.on_init(function()
    log("Factorio Automation snippets loaded")
    for _, player in pairs(game.players) do
        add_snippets_gui(player)
    end
end)

script.on_configuration_changed(function(data)
    log("Factorio Automation configuration changed")
end)

script.on_event(defines.events.on_player_created, function(event)
    local player = game.players[event.player_index]
    add_snippets_gui(player)
end)

function add_snippets_gui(player)
    if player.gui.top.snippet_button then return end
    player.gui.top.add{type="sprite-button", name="snippet_button", sprite="utility/play", tooltip="Open Snippets"}
end

script.on_event(defines.events.on_gui_click, function(event)
    if not (event and event.element and event.element.valid) then return end
    local player = game.players[event.player_index]
    if event.element.name == "snippet_button" then
        open_snippet_window(player)
    elseif event.element.tags and event.element.tags.snippet then
        snippets_manager.execute(event.element.tags.snippet, player)
    end
end)

function open_snippet_window(player)
    local frame = player.gui.center.snippet_frame or player.gui.center.add{type="frame", name="snippet_frame", caption="Snippets", direction="vertical"}
    frame.clear()
    for _, snippet in pairs(snippets_manager.get_available_snippets(player)) do
        frame.add{type="button", caption=snippet.name, tags={snippet=snippet.name}}
    end
end

-- Add remote interface
remote.add_interface("your_mod",
{
    run_snippet = function(snippet, player_index)
        snippets_manager.execute(snippet, game.get_player(player_index))
    end,
    list_snippets = function()
        return snippets_manager.get_all_snippet_names()
    end
})
