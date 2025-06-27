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
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {},
	},
	{ "nvim-telescope/telescope.nvim", tag = "0.1.8" },
	{ "folke/which-key.nvim" },
}
