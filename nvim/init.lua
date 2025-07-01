require("config.lazy")

vim.cmd("set undodir=~/.vim/undo")
vim.cmd("set undofile")

vim.opt.termguicolors = true
vim.cmd("set tabstop=4 shiftwidth=4")

require("config.keymaps")
require("autoclose").setup()
vim.cmd("colorscheme sunbather")
vim.cmd("set number")
vim.cmd("set relativenumber")

-- require("ibl").setup()
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

-- Setup for nvim-cmp
local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#expand"](args.body) -- Use vim-vsnip for snippets (optional)
		end,
	},
	mapping = {
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<Enter>"] = cmp.mapping.confirm({ select = true }), -- Confirm completion
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "path" },
	},
})

-- LSP configuration
local lspconfig = require("lspconfig")

-- Python (Ruff)
lspconfig.ruff.setup({
	settings = {
		ruff = {
			linting = true, -- Enable linting
			formatting = true, -- Enable formatting
		},
	},
})

-- Python (Pyright)
lspconfig.pyright.setup({
	settings = {
		pyright = {
			linting = true, -- Enable linting
			formatting = false, -- Enable formatting
		},
	},
})
-- Rust (rust-analyzer)
lspconfig.rust_analyzer.setup({
	settings = {
		["rust-analyzer"] = {
			cargo = {
				runBuildScripts = true, -- Automatically run build scripts
			},
		},
	},
})

-- Lua (sumneko_lua)
lspconfig.lua_ls.setup({
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT", -- You can set this to 'Lua' if you're using pure Lua
			},
			diagnostics = {
				globals = { "vim" }, -- Prevent errors on 'vim' global variable
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true), -- Include runtime files in workspace
			},
		},
	},
})

vim.lsp.enable("ruff")
vim.lsp.enable("pyright")

require("lspconfig").pyright.setup({})
require("lspconfig").ruff.setup({})
require("lspconfig").rust_analyzer.setup({})

local fineline = require("fine-cmdline")
local fn = fineline.fn

fineline.setup({
	cmdline = {
		enable_keymaps = true,
		smart_history = true,
		prompt = ": ",
	},
	popup = {
		position = {
			row = "40%",
			col = "50%",
		},
		size = {
			width = "40%",
		},
		border = {
			style = "rounded",
		},
		win_options = {
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
		},
	},
	hooks = {
		set_keymaps = function(imap, feedkeys)
			-- Restore default keybindings...
			-- Except for `<Tab>`, that's what everyone uses to autocomplete
			imap("<Esc>", fn.close)
			imap("<C-c>", fn.close)

			imap("<Up>", fn.up_search_history)
			imap("<Down>", fn.down_search_history)
		end,
	},
})

require("visual-surround").setup({
	use_default_keymaps = false,

	surround_chars = { "{", "}", "[", "]", "(", ")", "'", '"' },

	-- your config
})
