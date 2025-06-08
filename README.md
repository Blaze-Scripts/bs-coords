# Coordinate Display Tool for RedM Development

A sleek, lightweight coordinate and heading display tool for RedM development. Easily view and copy coordinates in various formats with a hotkey. This developer tool provides a clean interface for obtaining precise location data, making map and script development significantly easier.

## ✨ Features

- 🔌 **Standalone**: Works with any framework with no dependencies
- 🧩 **Lightweight Design**: Minimal performance impact with configurable refresh rate
- 📋 **One-Click Copy**: Copy coordinates in multiple formats
- 📐 **Multiple Formats**: Support for vector3, vector4, and individual coordinate components
- 💯 **Real-Time Updates**: Coordinates update in real-time as you move
- 🎮 **Keyboard Shortcuts**: Quick access to all functions via configurable key bindings
- 🎨 **Customizable Position**: Position the display in any corner or side of the screen via config
- 🔄 **Toggle Visibility**: Quickly show/hide the display without disabling functionality

## 📝 Preview

![bs-coords preview](https://i.imgur.com/NBJYQUn.jpeg)

## 🔧 Installation

1. Place the `bs-coords` folder in your server's resources directory
2. Add `ensure bs-coords` to your server.cfg
3. Restart your server or start the resource manually

## ⌨️ Controls

| Key | Action |
|-----|--------|
| DEL | Toggle display visibility |
| E | Copy vector3 format |
| R | Copy vector4 format |
| G | Copy X coordinate |
| H | Copy Y coordinate |
| J | Copy Z coordinate |
| L | Copy heading |

## ⚙️ Configuration

Edit the `config.lua` file to customize the tool:

```lua
Config = {}

-- Default settings
Config.DefaultVisible = true -- UI is visible by default
Config.RefreshRate = 100 -- Update rate in ms

-- Keybindings (can be customized)
Config.Keys = {
    display = 0x4AF4D473, -- DEL - Toggle display visibility
    copyVector3 = 0xCEFD9220, -- E - Copy vector3
    copyVector4 = 0xE30CD707, -- R - Copy vector4 
    copyX = 0x760A9C6F, -- G - Copy X coordinate
    copyY = 0x24978A28, -- H - Copy Y coordinate 
    copyZ = 0xF3830D8E, -- J - Copy Z coordinate
    copyHeading = 0x80F28E95, -- L - Copy heading
}

-- UI Settings
Config.Position = "center-right" -- Position options: top-left, top-right, bottom-left, bottom-right, center-left, center-right
```

## 📦 Usage Examples

### Copying Coordinates for Script Development

1. Position your character at the desired location
2. Press `E` to copy the vector3 format or `R` for vector4 (includes heading)
3. Paste directly into your code

### Creating Polyzone Definitions

1. Move to each corner point of your desired zone
2. Use the coordinate tool to copy each position
3. Build your polyzone definition with precise coordinates

## 🤝 Support
For support, join our Discord server: https://discord.gg/xUcj2R4ZX4
> At Blaze Scripts, we’re here to make your life easier - so if you ever run into a hiccup with one of our resources, just reach out and we’ll jump in to help. We strive to support all major frameworks, but on the rare occasion you’re using something outside our usual expertise, we might not be able to provide direct assistance. Either way, we’ll always point you toward resources or guidance to keep your project moving forward.

## 🔗 Links

- 💬 Discord: [Join our Discord](https://discord.gg/xUcj2R4ZX4)
- 👀 More Free Scripts: [Blaze Scripts](https://github.com/Blaze-Scripts/)

## 📜 License

This resource is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
