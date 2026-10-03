require("config.lazy")
require("config.keymaps")
vim.cmd("set undofile")

vim.opt.termguicolors = true
vim.cmd("set tabstop=2 shiftwidth=2")

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

vim.opt.wrap = false

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

require('mini.surround').setup()
-- require('mini.animate').setup()
require('mini.ai').setup()
-- require('mini.files').setup()

require('treesj').setup({
  langs = {
    gdscript = {
      -- Arrays: e.g., [1, 2, 3] ↔ multi‑line without orphaned commas
      array = {
        format = 'list',
        recursive = true,
        nodes = {
          element = { 'expression' },   -- actual elements inside the array
          separator = { ',' },      -- comma nodes
        },
        trailing_comma = false,     -- don't add a trailing comma when splitting
        max_partners = 10,
      },
      -- Dictionaries: e.g., {a = 1, b = 2}
      dictionary = {
        format = 'pairs',
        recursive = true,
        nodes = {
          element = { 'pair' },     -- each key‑value pair
          separator = { ',' },
        },
        trailing_comma = false,
      },
      -- Function parameter lists
      parameters = {
        format = 'identifier',
        recursive = false,
        nodes = {
          element = { 'identifier', 'default_parameter' }, -- parameters
          separator = { ',' },
        },
      },
      -- Function call arguments
      arguments = {
        format = 'expression',
        recursive = false,
        nodes = {
          element = { 'argument' }, -- in newer grammar may be 'argument' or 'value'
          separator = { ',' },
        },
      },
      -- Function definition (uses built‑in formatter)
      function_definition = {
        format = 'function',
        recursive = true,
      },
      -- If / for / while / match / class (use block formatter)
      if_statement = { format = 'block', recursive = true },
      for_statement = { format = 'block', recursive = true },
      while_statement = { format = 'block', recursive = true },
      match_statement = { format = 'block', recursive = true },
      match_case = { format = 'block', recursive = true },
      class_definition = { format = 'block', recursive = true },
      -- Signals and enums
      signal_definition = {
        format = 'list',
        recursive = false,
        nodes = {
          element = { 'identifier' }, -- signal parameters
          separator = { ',' },
        },
      },
      enum_definition = {
        format = 'list',
        recursive = true,
        nodes = {
          element = { 'enum_item' },
          separator = { ',' },
        },
      },
    },
  },
})

require('gitsigns').setup {
  signs = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signs_staged = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signs_staged_enable = true,
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    follow_files = true
  },
  auto_attach = true,
  attach_to_untracked = false,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
    virt_text_priority = 100,
    use_focus = true,
  },
  current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },

  vim.lsp.config("roslyn", {
      on_attach = function()
	  print("This will run when the server attaches!")
      end,
      settings = {
	  ["csharp|inlay_hints"] = {
	      csharp_enable_inlay_hints_for_implicit_object_creation = true,
	      csharp_enable_inlay_hints_for_implicit_variable_types = true,
	  },
	  ["csharp|code_lens"] = {
	      dotnet_enable_references_code_lens = true,
	  },
      },
  })
}
