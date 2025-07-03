-- init.lua - Convenience module that loads all snippets
-- This allows requiring the entire collection at once

local snippets = {}

-- Dynamically load all snippets from the snippets directory
-- Note: In a real Factorio mod, you'd need to explicitly require each file
-- since Factorio's require system doesn't support dynamic loading

-- For now, we'll manually add snippets as they're created
-- Example structure:
-- snippets.teleport = require("snippets.teleport")
-- snippets.clear_pollution = require("snippets.clear_pollution")

-- When used as a mod, register remote interface
if script then
    remote.add_interface("snippets", snippets)
end

return snippets
