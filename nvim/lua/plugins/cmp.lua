return {
	{
		{
			"hrsh7th/nvim-cmp", -- Autocompletion plugin
			event = "InsertEnter", -- Load on Insert mode
			config = function()
				local cmp = require("cmp")

				cmp.setup({
					snippet = {
						expand = function(args)
							vim.fn["vsnip#expand"](args.body) -- Use vim-vsnip for snippets
						end,
					},
					mapping = {
						["<C-n>"] = cmp.mapping.select_next_item(),
						["<C-p>"] = cmp.mapping.select_prev_item(),
						["<Tab>"] = cmp.mapping.confirm({ select = true }), -- Confirm completion
					},
					sources = {
						{ name = "nvim_lsp" },
						{ name = "buffer" },
						{ name = "path" },
					},
				})
			end,
		},
		{
			"hrsh7th/cmp-nvim-lsp", -- LSP completion source
			after = "nvim-cmp",
		},
		{
			"hrsh7th/cmp-buffer", -- Buffer completion source
			after = "nvim-cmp",
		},
		{
			"hrsh7th/cmp-path", -- Path completion source
			after = "nvim-cmp",
		},
		{
			"neovim/nvim-lspconfig", -- LSP configuration
			config = function()
				-- LSP config example for Pyright
				local lspconfig = require("lspconfig")
				lspconfig.pyright.setup({})
			end,
		},
	},
	{ "autoclose.nvim" },
	{
		"kylechui/nvim-surround",
		version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- here, or leave empty to use defaults
			})
		end,
	},
}
