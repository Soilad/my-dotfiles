return {
    "neovim/nvim-lspconfig",
    config = function()
	vim.lsp.enable("rust_analyzer")
	vim.diagnostic.config({virtual_text = true, update_in_insert = true})
	vim.lsp.enable('ruff')
	vim.lsp.enable('lua_ls')
    end,
}
