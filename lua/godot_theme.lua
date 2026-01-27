-- Godot Engine Default Theme for NeoVim (from editor_theme_manager.cpp)
-- Generated based on Godot 4.x TextEditor source code logic
-- https://github.com/voylin/godot_color_theme
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

local function darkened(hex, amount)
	local r, g, b = hex_to_rgb(hex)
	local f = 1.0 - amount
	return rgb_to_hex(r * f, g * f, b * f)
end

local function lightened(hex, amount)
	local r, g, b = hex_to_rgb(hex)
	return rgb_to_hex(
		r + (255 - r) * amount,
		g + (255 - g) * amount,
		b + (255 - b) * amount
	)
end

local function lerp_color(hex_a, hex_b, t)
	local r1, g1, b1 = hex_to_rgb(hex_a)
	local r2, g2, b2 = hex_to_rgb(hex_b)

	local r = r1 + (r2 - r1) * t
	local g = g1 + (g2 - g1) * t
	local b = b1 + (b2 - b1) * t

	return rgb_to_hex(r, g, b)
end


function M.setup(opts)
	opts = opts or {}

	local is_modern = opts.is_modern ~= false -- Default is true

	local defaults = {
		modern = { base = "#292929", accent = "#569eff", font = "#e0e0e0" },
		classic = { base = "#363d4a", accent = "#70bafa", font = "#e0e0e0" }
	}

	local style_key = is_modern and "modern" or "classic"
	local default = defaults[style_key]

	local base_color = opts.base_color or default.base
	local accent_color = opts.accent_color or default.accent
	local font_color = opts.font_color or default.font
	local contrast = opts.contrast or 0.3

	local bg_editor = darkened(base_color, contrast)
	local bg_gutter = darkened(base_color, contrast * 0.4)
	local bg_selection = lerp_color(accent_color, base_color, 0.4)
	local bg_current_line = lightened(bg_editor, 0.04)

	local palette = {
		bg = bg_editor,
		fg = font_color,

		gutter_bg = bg_gutter,
		line_nr = lerp_color(font_color, bg_editor, 0.5),
		selection = bg_selection,
		curr_line = bg_current_line,

		symbol = "#abc9ff",
		keyword = "#ff7085",
		control_flow = "#ff8ccc",
		base_type = "#42ffc2",
		engine_type = "#8fffdb",
		user_type = "#c7ffed",
		comment = "#8796a5",
		string = "#ffeda1",
		number = "#a1ffe0",

		function_def = "#66e5ff",
		function_call = "#57b3ff",
		builtin_func = "#a3a3f5",

		member_var = "#bce0ff",
		gd_node_path = "#baab76",
		gd_annotation = "#ffb373",

		error = "#ff6666",
		warning = "#ffdd66",
	}

	vim.cmd("hi clear")
	if vim.fn.exists("syntax_on") then vim.cmd("syntax reset") end
	vim.g.colors_name = "godot"

	local hl = vim.api.nvim_set_hl
	local popup_bg = lightened(palette.bg, 0.15)

	-- UI Highlights
	hl(0, "Normal", { fg = palette.fg, bg = palette.bg })
	hl(0, "NormalFloat", { fg = palette.fg, bg = popup_bg })
	hl(0, "FloatBorder", { fg = palette.gutter_bg, bg = popup_bg })
	hl(0, "LineNr", { fg = palette.line_nr, bg = palette.gutter_bg })
	hl(0, "CursorLine", { bg = palette.curr_line })
	hl(0, "CursorLineNr", { fg = palette.accent, bold = true, bg = palette.gutter_bg })
	hl(0, "Visual", { bg = palette.selection })
	hl(0, "Search", { bg = palette.selection, fg = palette.fg })
	hl(0, "MatchParen", { bg = palette.bg, fg = palette.base_type, underline = true })

	-- Basic Syntax
	hl(0, "Comment", { fg = palette.comment, italic = true })
	hl(0, "String", { fg = palette.string })
	hl(0, "Number", { fg = palette.number })
	hl(0, "Float", { fg = palette.number })
	hl(0, "Boolean", { fg = palette.keyword })
	hl(0, "Identifier", { fg = palette.fg })
	hl(0, "Function", { fg = palette.function_call })
	hl(0, "Statement", { fg = palette.keyword })
	hl(0, "Conditional", { fg = palette.control_flow })
	hl(0, "Repeat", { fg = palette.control_flow })
	hl(0, "Operator", { fg = palette.symbol })
	hl(0, "Keyword", { fg = palette.keyword })
	hl(0, "Type", { fg = palette.base_type })
	hl(0, "Constant", { fg = palette.member_var })

	hl(0, "Delimiter", { fg = palette.symbol })

	-- Diagnostics
	hl(0, "DiagnosticError", { fg = palette.error })
	hl(0, "DiagnosticWarn", { fg = palette.warning })
	hl(0, "DiagnosticInfo", { fg = palette.symbol })
	hl(0, "DiagnosticHint", { fg = palette.comment })

	-- Markdown
	hl(0, "markdownH1", { fg = palette.function_def, bold = true })
	hl(0, "markdownH2", { fg = palette.function_call, bold = true })
	hl(0, "markdownH3", { fg = palette.base_type })
	hl(0, "markdownH4", { fg = palette.member_var })
	hl(0, "markdownH5", { fg = palette.symbol })
	hl(0, "markdownH6", { fg = palette.comment })

	-- Autocompletion popup
	hl(0, "Pmenu", { fg = palette.fg, bg = popup_bg })
	hl(0, "PmenuSel", { fg = palette.fg, bg = palette.selection, bold = true })
	hl(0, "PmenuSbar", { bg = lightened(palette.bg, 0.05) })
	hl(0, "PmenuThumb", { bg = lightened(palette.bg, 0.25) })

	-- Autocompletion popup (Cmp)
	hl(0, "CmpItemAbbr", { fg = palette.fg })
	hl(0, "CmpItemAbbrMatch", { fg = palette.accent, bold = true })
	hl(0, "CmpItemMenu", { fg = palette.comment })

	hl(0, "CmpItemKind", { fg = palette.symbol })
	hl(0, "CmpItemKindUnit", { fg = palette.number })
	hl(0, "CmpItemKindField", { fg = palette.member_var })
	hl(0, "CmpItemKindValue", { fg = palette.string })
	hl(0, "CmpItemKindClass", { fg = palette.user_type })
	hl(0, "CmpItemKindMethod", { fg = palette.function_def })
	hl(0, "CmpItemKindStruct", { fg = palette.user_type })
	hl(0, "CmpItemKindSnippet", { fg = palette.gd_annotation })
	hl(0, "CmpItemKindKeyword", { fg = palette.keyword })
	hl(0, "CmpItemKindVariable", { fg = palette.member_var })
	hl(0, "CmpItemKindProperty", { fg = palette.member_var })
	hl(0, "CmpItemKindConstant", { fg = palette.member_var })
	hl(0, "CmpItemKindFunction", { fg = palette.function_def })
	hl(0, "CmpItemKindInterface", { fg = palette.user_type })
	hl(0, "CmpItemKindEnumMember", { fg = palette.member_var })
	hl(0, "CmpItemKindConstructor", { fg = palette.base_type })
	hl(0, "CmpItemKindTypeParameter", { fg = palette.user_type })

	-- TreeSitter Specifics (Mapped to match GDScript Highlighting)
	-- - Keywords
	hl(0, "@keyword", { fg = palette.keyword })
	hl(0, "@keyword.function", { fg = palette.keyword })
	hl(0, "@keyword.return", { fg = palette.control_flow })
	hl(0, "@keyword.conditional", { fg = palette.control_flow })
	hl(0, "@keyword.repeat", { fg = palette.control_flow })

	-- - Functions
	hl(0, "@function", { fg = palette.function_def })
	hl(0, "@function.call", { fg = palette.function_call })
	hl(0, "@function.builtin", { fg = palette.builtin_func })
	hl(0, "@function.method", { fg = palette.function_def })
	hl(0, "@function.method.call", { fg = palette.function_call })

	hl(0, "@method", { fg = palette.function_def })
	hl(0, "@method.call", { fg = palette.function_call })

	-- - Variables / Properties
	hl(0, "@variable", { fg = palette.fg })
	hl(0, "@variable.member", { fg = palette.member_var })
	hl(0, "@variable.special", { fg = palette.symbol })
	hl(0, "@variable.parameter", { fg = palette.member_var })

	hl(0, "@property", { fg = palette.member_var })
	hl(0, "@constant", { fg = palette.member_var })
	hl(0, "@constant.builtin", { fg = palette.keyword })

	-- Types
	hl(0, "@type", { fg = palette.user_type })
	hl(0, "@type.builtin", { fg = palette.base_type })
	hl(0, "@constructor", { fg = palette.base_type })

	-- Literals
	hl(0, "@string", { fg = palette.string })
	hl(0, "@number", { fg = palette.number })
	hl(0, "@boolean", { fg = palette.keyword })

	-- GDScript Specifics
	hl(0, "@string.escape", { fg = palette.gd_annotation })
	hl(0, "@string.special", { fg = palette.gd_node_path })
	hl(0, "@attribute", { fg = palette.gd_annotation })

	-- Punctuation / Symbols (brackets, commas, etc.)
	hl(0, "@punctuation", { fg = palette.symbol })
	hl(0, "@punctuation.bracket", { fg = palette.symbol })
	hl(0, "@punctuation.delimiter", { fg = palette.symbol })
	hl(0, "@punctuation.special", { fg = palette.symbol })

	hl(0, "@operator", { fg = palette.symbol })

	-- Markdown
	hl(0, "@markup.heading.1", { fg = palette.function_def, bold = true })
	hl(0, "@markup.heading.2", { fg = palette.function_call, bold = true })
	hl(0, "@markup.heading.3", { fg = palette.base_type })
	hl(0, "@markup.heading.4", { fg = palette.member_var })
	hl(0, "@markup.heading.5", { fg = palette.symbol })
	hl(0, "@markup.heading.6", { fg = palette.comment })

	hl(0, "@markup.italic", { italic = true })
	hl(0, "@markup.strong", { bold = true })
	hl(0, "@markup.strikethrough", { strikethrough = true })

	hl(0, "@markup.raw", { fg = palette.string })
	hl(0, "@markup.raw.block", { fg = palette.string })

	hl(0, "@markup.link", { fg = palette.function_call, underline = true })
	hl(0, "@markup.link.label", { fg = palette.function_call })
	hl(0, "@markup.link.url", { fg = palette.comment, underline = true })

	hl(0, "@markup.list", { fg = palette.symbol })
	hl(0, "@markup.list.checked", { fg = palette.base_type })
	hl(0, "@markup.list.unchecked", { fg = palette.comment })

	hl(0, "@markup.quote", { fg = palette.comment, italic = true })
	hl(0, "@markup.hr", { fg = palette.symbol })

	-- Comments
	hl(0, "@comment.todo", { fg = palette.warning, bold = true })
	hl(0, "@comment.note", { fg = palette.symbol })
	hl(0, "@comment.warning", { fg = palette.warning })
	hl(0, "@comment.error", { fg = palette.error })

	-- Other languages
	hl(0, "@label", { fg = palette.symbol })
	hl(0, "@field", { fg = palette.member_var })
	hl(0, "@macro", { fg = palette.gd_annotation })
	hl(0, "@module", { fg = palette.user_type })
	hl(0, "@namespace", { fg = palette.user_type })

	hl(0, "@type.definition", { fg = palette.user_type })
	hl(0, "@type.qualifier", { fg = palette.keyword })
end

return M
