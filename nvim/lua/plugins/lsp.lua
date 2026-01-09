return {
    "neovim/nvim-lspconfig",
    config = function()
	vim.lsp.enable("rust_analyzer")
	vim.diagnostic.config({virtual_text = true, update_in_insert = true})
	vim.lsp.enable('ruff')
	vim.lsp.enable('lua_ls')
	vim.lsp.enable('typescript-language-server')
	vim.lsp.enable('tailwindcss-language-server')
	vim.lsp.enable('vscode-html-language-server')
    end,
}
