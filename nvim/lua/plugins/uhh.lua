return {
	{ "akinsho/toggleterm.nvim", version = "*", config = true },
	{ "elkowar/yuck.vim" },
	{ "astral-sh/ruff-lsp" },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{ "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons" },
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},

	{ "echasnovski/mini.indentscope" },
	{ "VonHeikemen/fine-cmdline.nvim", dependencies = { "MunifTanjim/nui.nvim" } },
	{ "nvim-telescope/telescope.nvim", tag = "0.1.8" },
	{ "folke/which-key.nvim" },
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required

			-- Only one of these is needed.
			"nvim-telescope/telescope.nvim", -- optional
		},
	},
}
