require("config.lazy")
require("config.keymaps")

vim.cmd("set undofile")

vim.opt.termguicolors = true
vim.cmd("set tabstop=4 shiftwidth=4")

vim.cmd("colorscheme sunbather")
vim.cmd("set number")
vim.cmd("set relativenumber")

vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end
)

vim.api.nvim_create_autocmd({'TextYankPost'}, {
  callback = function()
    vim.hl.on_yank()
  end,
})

-- vim.opt.colorcolumn = {81}

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = "yes"
vim.opt.cursorline = true

require("mini.indentscope").setup({
	-- Draw options
	draw = {
		-- Delay (in ms) between event and start of drawing scope indicator
		delay = 100,

		-- Whether to auto draw scope: return `true` to draw, `false` otherwise.
		-- Default draws only fully computed scope (see `options.n_lines`).
		predicate = function(scope)
			return not scope.body.is_incomplete
		end,

		-- Symbol priority. Increase to display on top of more symbols.
		priority = 2,
	},

	-- Module mappings. Use `''` (empty string) to disable one.
	mappings = {
		-- Textobjects
		object_scope = "ii",
		object_scope_with_border = "ai",

		-- Motions (jump to respective border line; if not present - body line)
		goto_top = "[i",
		goto_bottom = "]i",
	},

	-- Options which control scope computation
	options = {
		-- Type of scope's border: which line(s) with smaller indent to
		-- categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
		border = "both",

		-- Whether to use cursor column when computing reference indent.
		-- Useful to see incremental scopes with horizontal cursor movements.
		indent_at_cursor = true,

		-- Maximum number of lines above or below within which scope is computed
		n_lines = 10000,

		-- Whether to first check input line to be a border of adjacent scope.
		-- Use it if you want to place cursor on function header to get scope of
		-- its body.
		try_as_border = false,
	},

	-- Which character to use for drawing scope indicator
	symbol = "│",
})

require("toggleterm").setup({
	float_opts = {
		border = "curved",
		winblend = 3,
		title_pos = "center",
	},
	direction = "float",
	open_mapping = [[<c-/>]], -- or { [[<c-\>]], [[<c-¥>]] } if you also use a Japanese keyboard.
	insert_mappings = true, -- whether or not the open mapping applies in insert mode
	terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
})

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		always_show_tabline = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
			refresh_time = 16, -- ~60fps
			events = {
				"WinEnter",
				"BufEnter",
				"BufWritePost",
				"SessionLoadPost",
				"FileChangedShellPost",
				"VimResized",
				"Filetype",
				"CursorMoved",
				"CursorMovedI",
				"ModeChanged",
			},
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "filetype", "branch", "diff", "diagnostics" },
		lualine_c = {},
		lualine_x = { "filename" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = { "mode" },
		lualine_b = { "filetype", "branch", "diff", "diagnostics" },
		lualine_c = {},
		lualine_x = { "filename" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})

