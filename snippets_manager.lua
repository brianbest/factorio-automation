--- Snippets Manager
--- Handles loading, registering, and executing all snippets
--- Provides unified interface for commands, GUI, and remote calls

local snippets_manager = {}

-- Load all available snippets
local snippets = {
    teleport = require("snippets.teleport"),
    clear_pollution = require("snippets.clear_pollution"),
}

-- Snippet definitions with metadata
local snippet_definitions = {
    ["teleport-spawn"] = {
        name = "teleport-spawn",
        description = "Teleport to spawn point",
        admin_only = false,
        func = function(player)
            if not player or not player.valid then return false end
            local spawn_pos = player.force.get_spawn_position(player.surface)
            return snippets.teleport(player, spawn_pos)
        end
    },
    ["clear-pollution"] = {
        name = "clear-pollution",
        description = "Clear all pollution from current surface",
        admin_only = true,
        func = function(player)
            if not player or not player.valid then return false end
            return snippets.clear_pollution(player.surface)
        end
    },
    ["give-100-iron"] = {
        name = "give-100-iron",
        description = "Give 100 iron plates",
        admin_only = false,
        func = function(player)
            if not player or not player.valid then return false end
            player.insert{name = "iron-plate", count = 100}
            player.print("Received 100 iron plates")
            return true
        end
    },
    ["kill-all-biters"] = {
        name = "kill-all-biters",
        description = "Kill all enemies on all surfaces",
        admin_only = true,
        func = function(player)
            local count = 0
            for _, surface in pairs(game.surfaces) do
                local enemies = surface.find_entities_filtered{force = "enemy"}
                for _, enemy in pairs(enemies) do
                    enemy.destroy()
                    count = count + 1
                end
            end
            if player and player.valid then
                player.print("Destroyed " .. count .. " enemies")
            else
                game.print("Destroyed " .. count .. " enemies")
            end
            return true
        end
    },
    ["day-time"] = {
        name = "day-time",
        description = "Set time to day",
        admin_only = true,
        func = function(player)
            if not player or not player.valid then return false end
            player.surface.daytime = 0.5
            player.print("Time set to day")
            return true
        end
    },
    ["night-time"] = {
        name = "night-time", 
        description = "Set time to night",
        admin_only = true,
        func = function(player)
            if not player or not player.valid then return false end
            player.surface.daytime = 0
            player.print("Time set to night")
            return true
        end
    }
}

-- Check if player has permission to run a snippet
function snippets_manager.has_permission(player, snippet_name)
    local snippet = snippet_definitions[snippet_name]
    if not snippet then return false end
    
    if snippet.admin_only and not player.admin then
        return false
    end
    
    return true
end

-- Execute a snippet
function snippets_manager.execute(snippet_name, player)
    local snippet = snippet_definitions[snippet_name]
    if not snippet then
        if player and player.valid then
            player.print("Unknown snippet: " .. snippet_name)
        end
        return false
    end
    
    if not snippets_manager.has_permission(player, snippet_name) then
        if player and player.valid then
            player.print("You don't have permission to run: " .. snippet_name)
        end
        return false
    end
    
    local success, result = pcall(snippet.func, player)
    if not success then
        if player and player.valid then
            player.print("Error running snippet " .. snippet_name .. ": " .. tostring(result))
        end
        log("Error running snippet " .. snippet_name .. ": " .. tostring(result))
        return false
    end
    
    return result
end

-- Get list of available snippets for a player
function snippets_manager.get_available_snippets(player)
    local available = {}
    for name, snippet in pairs(snippet_definitions) do
        if snippets_manager.has_permission(player, name) then
            table.insert(available, {
                name = name,
                description = snippet.description,
                admin_only = snippet.admin_only
            })
        end
    end
    return available
end

-- Get all snippet names
function snippets_manager.get_all_snippet_names()
    local names = {}
    for name, _ in pairs(snippet_definitions) do
        table.insert(names, name)
    end
    return names
end

-- Get snippet definition
function snippets_manager.get_snippet_definition(name)
    return snippet_definitions[name]
end

return snippets_manager
