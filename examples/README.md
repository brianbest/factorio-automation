# Examples

This directory contains example usage scenarios and small demo scripts for the Lua snippets.

## Console Commands

Quick commands you can run in the Factorio console:

### Teleport Examples
```lua
-- Teleport to spawn
/c local tp = require("snippets.teleport"); tp(game.player, {x=0, y=0})

-- Teleport to specific coordinates
/c local tp = require("snippets.teleport"); tp(game.player, {x=100, y=-50})
```

### Pollution Examples
```lua
-- Clear all pollution on current surface
/c local cp = require("snippets.clear_pollution"); cp(game.player.surface)

-- Clear pollution in a specific area
/c local cp = require("snippets.clear_pollution"); cp(game.player.surface, {{left_top={x=-50, y=-50}, right_bottom={x=50, y=50}}})
```

## Using as Remote Interface

If loaded as a mod, you can use the remote interface:

```lua
-- Teleport player
/c remote.call("snippets", "teleport", game.player, {x=0, y=0})

-- Clear pollution
/c remote.call("snippets", "clear_pollution", game.player.surface)
```

## Integration Examples

See the individual files in this directory for more complex integration scenarios.
