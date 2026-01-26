-- Godot Engine Default Theme for NeoVim
-- Generated based on Godot 4.x TextEditor source code logic
--
-- Options:
-- is_modern (true)
-- base_color ("#363d4a")
-- accent_color ("#70bafa")
-- font_color ("#e0e0e0")
-- contrast (0.3)

M = {}

local function hex_to_rgb(hex)
	hex = hex:gsub("#", "")
	return tonumber("0x" .. hex:sub(1, 2)), tonumber("0x" .. hex:sub(3, 4)), tonumber("0x" .. hex:sub(5, 6))
end


local function rgb_to_hex(r, g, b)
	return string.format("#%02x%02x%02x", math.min(255, math.max(0, r)), math.min(255, math.max(0, g)),
		math.min(255, math.max(0, b)))
end


local function lerp_color(hex_a, hex_b, t)
	local r1, g1, b1 = hex_to_rgb(hex_a)
	local r2, g2, b2 = hex_to_rgb(hex_b)

	local r = r1 + (r2 - r1) * t
	local g = g1 + (g2 - g1) * t
	local b = b1 + (b2 - b1) * t

	return rgb_to_hex(r, g, b)
end


local function blend(fg_hex, bg_hex, alpha)
	return lerp_color(bg_hex, fg_hex, alpha)
end


function M.setup(opts)
	opts = opts or {}

	local is_modern = opts.is_modern ~= false -- Default is true

	local defaults = {
		modern = { base = "#292929", accent = "#569eff", font = "#e0e0e0" },
		classic = { base = "#363d4a", accent = "#70bafa", font = "#e0e0e0" }}

	local style_key = is_modern and "modern" or "classic"
	local default = defaults[style_key]

	local base_color = opts.base_color or default.base
	local accent_color = opts.accent_color or default.accent
	local font_color = opts.font_color or default.font
	local contrast = opts.contrast or 0.3

	local mono_color = "#ffffff"
	local error_color = "#ff6666"
	local warning_color = "#ffdd66"
	local bg_color = lerp_color(base_color, "#000000", contrast * 1.2)
	local palette = {
		bg = bg_color,
		fg = font_color,
		symbol = "#abc9ff",
		keyword = "#ff7085",
		control_flow = "#ff8ccc",
		base_type = "#42ffc2",
		engine_type = "#8fffdb",
		user_type = "#c7ffed",
		comment = blend(font_color, bg_color, 0.5),
		doc_comment = blend("#99b3cc", bg_color, 0.8),
		string = "#ffeda1",
		number = "#a1ffe0",
		function_col = "#57b3ff",
		member_var = lerp_color("#57b3ff", mono_color, 0.6),

		-- UI Elements
		line_nr = blend(font_color, bg_color, 0.5),
		caret = mono_color,
		selection = blend(accent_color, bg_color, 0.4),
		current_line = blend(mono_color, bg_color, 0.07),
		search_result = blend(mono_color, bg_color, 0.07),
		bracket_bad = error_color,

		-- GDScript Specifics
		gd_func_def = "#66e6ff",
		gd_node_path = "#b8c47d",
		gd_annotation = "#ffb373",
	}

	vim.cmd("hi clear")
	if vim.fn.exists("syntax_on") then vim.cmd("syntax reset") end
	vim.g.colors_name = "godot"

	local hl = vim.api.nvim_set_hl

	hl(0, "Normal", { fg = palette.fg, bg = palette.bg })
	hl(0, "LineNr", { fg = palette.line_nr })
	hl(0, "CursorLine", { bg = palette.current_line })
	hl(0, "CursorLineNr", { fg = palette.accent_color, bold = true })
	hl(0, "Visual", { bg = palette.selection })
	hl(0, "Search", { bg = palette.selection, fg = palette.fg })
	hl(0, "CurSearch", { bg = palette.string, fg = palette.bg })
	hl(0, "MatchParen", { bg = palette.bg, fg = palette.keyword, underline = true })

	-- Syntax
	hl(0, "Comment", { fg = palette.comment, italic = true })
	hl(0, "String", { fg = palette.string })
	hl(0, "Number", { fg = palette.number })
	hl(0, "Float", { fg = palette.number })
	hl(0, "Boolean", { fg = palette.keyword })

	hl(0, "Constant", { fg = palette.member_var })
	hl(0, "Identifier", { fg = palette.fg })
	hl(0, "Function", { fg = palette.function_col })

	hl(0, "Statement", { fg = palette.keyword })
	hl(0, "Conditional", { fg = palette.control_flow })
	hl(0, "Repeat", { fg = palette.control_flow })
	hl(0, "Label", { fg = palette.keyword })
	hl(0, "Operator", { fg = palette.symbol })
	hl(0, "Keyword", { fg = palette.keyword })
	hl(0, "Exception", { fg = palette.control_flow })

	hl(0, "PreProc", { fg = palette.gd_annotation })
	hl(0, "Include", { fg = palette.control_flow })

	hl(0, "Type", { fg = palette.base_type })
	hl(0, "Structure", { fg = palette.base_type })
	hl(0, "Typedef", { fg = palette.user_type })

	hl(0, "Special", { fg = palette.symbol })
	hl(0, "Error", { fg = error_color })
	hl(0, "Todo", { fg = palette.bg, bg = palette.gd_annotation })

	-- Treesitter Specifics
	hl(0, "@variable", { fg = palette.fg })
	hl(0, "@variable.member", { fg = palette.member_var })
	hl(0, "@property", { fg = palette.member_var })

	hl(0, "@function", { fg = palette.function_col })
	hl(0, "@function.builtin", { fg = palette.gd_func_def })
	hl(0, "@constructor", { fg = palette.base_type })

	hl(0, "@keyword", { fg = palette.keyword })
	hl(0, "@keyword.function", { fg = palette.keyword })
	hl(0, "@keyword.return", { fg = palette.control_flow })

	hl(0, "@type", { fg = palette.user_type })
	hl(0, "@type.builtin", { fg = palette.base_type })

	hl(0, "@string.special", { fg = palette.gd_node_path })
	hl(0, "@constant.builtin", { fg = palette.base_type })

	hl(0, "@attribute", { fg = palette.gd_annotation })

	-- Diff/Git
	hl(0, "DiffAdd", { bg = blend("#00ff00", palette.bg, 0.15) })
	hl(0, "DiffChange", { bg = blend("#ffff00", palette.bg, 0.15) })
	hl(0, "DiffDelete", { bg = blend("#ff0000", palette.bg, 0.15) })

	-- Diagnostics
	hl(0, "DiagnosticError", { fg = error_color })
	hl(0, "DiagnosticWarn", { fg = warning_color })
	hl(0, "DiagnosticInfo", { fg = palette.symbol })
	hl(0, "DiagnosticHint", { fg = palette.comment })
end

return M
