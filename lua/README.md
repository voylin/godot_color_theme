# Godot Color Theme - NeoVim
## Usage
You can get this through Lazy: `{"voylin/godot_color_theme"}`
Example config:
```lua
{
  "voylin/godot_color_theme",
  priority = 1000,
  config = function()
    require("godot_theme").setup()
  end,
}
```

### Manual
1. Put the `godot_theme.lua` inside of your `nvim/lua` folder;
2. From your your `init.lua` you paste following lines and adjust the defaults to your personal editor settings:
```lua
require('godot_theme').setup({
    is_modern = false,
    base_color = "#3d3d3d",
    accent_color = "#70bafa",
    font_color = "#e0e0e0",
    contrast = 0.3
})
```

## Options
| Option | Default | Description |
| :--- | :--- | :--- |
| `is_modern` | `true` | Use the new default theme colors of 4.6+. |
| `base_color` | `#363d4a` | The main color of the UI panels. |
| `accent_color` | `#70bafa` | Used for selection borders, matching parenthesis, etc. |
| `font_color` | `#e0e0e0` | Used for selection borders, matching parenthesis, etc. |
| `contrast` | `0.3` | Controls how much darker the text area background is compared to the `base_color`. |

> **Note:** For the best experience (especially with GDScript), ensure you have `nvim-treesitter` installed and configured.

## Need help setting up NeoVim with Godot?
[Watch this tutorial!](https://www.youtube.com/watch?v=9xTiuiomIy0)

## Extra's
If you want to have more of the Godot experience inside of NeoVim, consider adding this snippet:
```lua
vim.opt.list = true
vim.opt.listchars = {
	tab = '»  ',
	leadmultispace = '≈   ',
	trail = '·',
	extends = '›',
	precedes = '‹',
	nbsp = '␣'
}
```

## Support this project, and all my other projects!
[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/R6R4M1UM6)
