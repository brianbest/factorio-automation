# Documentation

This directory contains API documentation and references for the Factorio Lua snippets.

## Factorio API References

- [Official Factorio Lua API](https://lua-api.factorio.com/latest/) - Complete API documentation
- [Factorio Wiki - Console](https://wiki.factorio.com/Console) - Console commands and usage
- [Factorio Wiki - Lua](https://wiki.factorio.com/Tutorial:Scripting) - Lua scripting tutorial

## Common Patterns

### Error Handling
All snippets should include basic validation:
```lua
if not player or not player.valid then
    return false
end
```

### Documentation Format
Use LuaDoc style comments:
```lua
--- Brief description
--- @param parameter_name type Description
--- @return return_type Description
```

### Remote Interface
When creating mod functions, register them with the remote interface:
```lua
if script then
    remote.add_interface("snippets", {
        function_name = function_name
    })
end
```

## Useful Factorio Objects

- `game` - Global game state
- `game.player` - Current player (console context)
- `game.players` - All players
- `game.surfaces` - All surfaces
- `script` - Event system and mod lifecycle
- `remote` - Inter-mod communication
- `defines` - Game constants and enums

## Best Practices

1. Always validate input parameters
2. Provide meaningful error messages
3. Use consistent naming conventions
4. Include comprehensive documentation
5. Handle edge cases gracefully
6. Test with multiplayer scenarios when applicable
