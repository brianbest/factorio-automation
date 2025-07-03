--- Clears pollution from a specified area or the entire surface
--- @param surface LuaSurface The surface to clear pollution from
--- @param area table|nil Optional bounding box {{left_top={x,y}, right_bottom={x,y}}} - if nil, clears entire surface
--- @return number amount_cleared The amount of pollution cleared
local function clear_pollution(surface, area)
    if not surface or not surface.valid then
        return 0
    end
    
    local pollution_cleared = 0
    
    if area then
        -- Clear pollution in specified area
        for x = area.left_top.x, area.right_bottom.x do
            for y = area.left_top.y, area.right_bottom.y do
                local current_pollution = surface.get_pollution({x, y})
                surface.pollute({x, y}, -current_pollution)
                pollution_cleared = pollution_cleared + current_pollution
            end
        end
    else
        -- Clear all pollution on surface
        -- Note: This is a simplified version - in practice you'd want to iterate chunks
        local total_pollution = surface.get_total_pollution()
        surface.clear_pollution()
        pollution_cleared = total_pollution
    end
    
    game.print("Cleared " .. string.format("%.1f", pollution_cleared) .. " pollution units")
    return pollution_cleared
end

return clear_pollution
