--- Teleports a player to a given position
--- @param player LuaPlayer The player to teleport
--- @param position table Position table with x and y coordinates {x=number, y=number}
--- @param surface LuaSurface|nil Optional surface to teleport to (defaults to player's current surface)
--- @return boolean success Whether the teleport was successful
local function teleport(player, position, surface)
    if not player or not player.valid then
        return false
    end
    
    if not position or not position.x or not position.y then
        return false
    end
    
    -- Use current surface if none specified
    local target_surface = surface or player.surface
    
    -- Teleport the player
    local success = player.teleport(position, target_surface)
    
    if success then
        player.print("Teleported to " .. position.x .. ", " .. position.y)
    else
        player.print("Failed to teleport to " .. position.x .. ", " .. position.y)
    end
    
    return success
end

return teleport
