return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		version = false,
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>sf", "<cmd>Telescope git_files<cr>", desc = "Find Files (root dir)" },
			{ "<leader><space>", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
			{ "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Search Project" },
			{ "<leader>ss", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Search Document Symbols" },
			{ "<leader>sw", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Search Workspace Symbols" },
		},
		opts = {
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
		},
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		config = function()
			require("telescope").load_extension("fzf")
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"jonarrien/telescope-cmdline.nvim",
		},
		keys = {
			{ ":", "<cmd>Telescope cmdline<cr>", desc = "Cmdline" },
		},
		config = function(_, opts)
			require("telescope").setup(opts)
			require("telescope").load_extension("cmdline")
		end,
	},
}
