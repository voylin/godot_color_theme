# Godot Color Theme - NeoVim

## Usage
1. Put the `godot_theme.lua` inside of your `nvim/lua` folder;
2. From your your `init.lua` you paste following lines and adjust the defaults to your personal editor settings:
```lua
require('godot_theme').setup({
    base_color = "#363d4a",   -- Default Godot Dark Blue
    accent_color = "#70bafa", -- Default Godot Blue Accent
    contrast = 0.3            -- Default Contrast
})
```

## Options
| Option | Default | Description |
| :--- | :--- | :--- |
| `base_color` | `#363d4a` | The main color of the UI panels. |
| `accent_color` | `#70bafa` | Used for selection borders, matching parenthesis, etc. |
| `contrast` | `0.3` | Controls how much darker the text area background is compared to the `base_color`. |

> **Note:** For the best experience (especially with GDScript), ensure you have `nvim-treesitter` installed and configured.

## Need help setting up NeoVim with Godot?
[Watch this tutorial!](https://www.youtube.com/watch?v=9xTiuiomIy0)

## Support this project, and all my other projects!
[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/R6R4M1UM6)
