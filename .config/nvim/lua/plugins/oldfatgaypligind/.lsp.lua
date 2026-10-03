return {
	{
		"neovim/nvim-lspconfig",
		---@class PluginLspOpts
		opts = {
			---@type lspconfig.options
			servers = {
				-- pyright will be automatically installed with mason and loaded with lspconfig
				pyright = {},
			},
		},
		config = function()
			require("lspconfig").lua_ls.setup({})
			vim.diagnostic.config({
				virtual_text = true, -- Show inline diagnostics
				signs = true, -- Enable signs in the sign column
				update_in_insert = false, -- Disable diagnostics during insert mode
				float = {
					border = "rounded", -- Make the floating window rounded
					source = "always", -- Always show source in floating window
				},
			})

			-- Keybinding to go to the next diagnostic
			vim.api.nvim_set_keymap("n", "[d", ":lua vim.diagnostic.goto_prev()<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "]d", ":lua vim.diagnostic.goto_next()<CR>", { noremap = true, silent = true })
			vim.diagnostic.config({
				virtual_text = false,
			})

			-- Show line diagnostics automatically in hover window
			vim.o.updatetime = 250
			vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])
		end,
	},
}
