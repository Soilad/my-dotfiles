return {
    'nvim-telescope/telescope.nvim', version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- optional but recommended
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
        vim.keymap.set("n", "<space>l", require("telescope.builtin").live_grep)
        -- vim.keymap.set("n", "<space>", require("telescope.builtin").find_files)
    end;
}
