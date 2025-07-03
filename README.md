# Factorio Automation

A collection of scripts and tools for automating various aspects of Factorio gameplay.

## Description

This project provides automation solutions for Factorio, including a collection of useful Lua commands/snippets, blueprint management, factory optimization, and game state monitoring.

## Structure

- `snippets/` - Individual Lua functions for Factorio, one per file
- `examples/` - Example usage and scenarios
- `docs/` - API documentation and Factorio references
- `scripts/` - Development and testing utilities
- `init.lua` - Convenience module that loads all snippets

## Features

- [x] Lua command snippets collection
- [ ] Blueprint generation and management
- [ ] Factory layout optimization
- [ ] Resource monitoring and alerts
- [ ] Production chain analysis
- [ ] Automated factory planning

## Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/factorio-automation.git
cd factorio-automation

# Install dependencies
# Add installation instructions here
```

## Usage

### Lua Snippets

**As a Factorio Mod:**
1. Copy this entire directory to your Factorio mods folder
2. Enable the mod in-game
3. Use commands via the console: `/c remote.call("snippets", "function_name", args...)`

**As Individual Snippets:**
Copy the needed `.lua` file from `snippets/` into your own mod and require it:
```lua
local teleport = require("snippets.teleport")
teleport(game.player, {x=0, y=0})
```

### Development
Run `luacheck` to lint code:
```bash
luacheck snippets/
```

## Configuration

Configuration files should be placed in the `config/` directory.

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Requirements

- Python 3.8+
- Factorio (version X.X.X or higher)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Factorio community for inspiration
- Contributors and testers

## Support

If you encounter any issues or have questions, please open an issue on GitHub.
