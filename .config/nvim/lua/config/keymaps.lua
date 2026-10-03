vim.keymap.set("n", "<leader>e", ":Telescope find_files<cr>")
vim.keymap.set("n", "<leader>f", ":Telescope live_grep<cr>")
-- vim.keymap.set("n", ";", "<Cmd>BufferPrevious<CR>")
-- vim.keymap.set("n", "'", "<Cmd>BufferNext<CR>")

local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<Up>', '<Nop>', opts)
vim.keymap.set('n', '<Down>', '<Nop>', opts)
vim.keymap.set('n', '<Left>', '<Nop>', opts)
vim.keymap.set('n', '<Right>', '<Nop>', opts)

local function toggle_oil_right(width)
  width = width or 30  -- default width in columns
  local oil_wins = {}
  -- Find all windows that contain an oil buffer
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].filetype == "oil" then
      table.insert(oil_wins, win)
    end
  end

  if #oil_wins > 0 then
    -- Close all oil windows
    for _, win in ipairs(oil_wins) do
      vim.api.nvim_win_close(win, true)
    end
    vim.notify("Closed oil windows", vim.log.levels.INFO)
  else
    -- Open oil in a right vertical split with specified width
    vim.cmd(string.format("leftabove %svsplit | Oil", width))
    vim.notify("Opened oil (width " .. width .. ")", vim.log.levels.INFO)
  end
end

vim.keymap.set('n', 'p', 'pzz', opts)
vim.keymap.set('n', 'P', 'Pzz', opts)
vim.keymap.set('n', 'n', 'nzz', opts)
vim.keymap.set('n', 'N', 'Nzz', opts)
vim.keymap.set('n', '[d', '<Cmd>lua vim.diagnostic.goto_prev()<CR>zz', { desc = '…' })
vim.keymap.set('n', ']d', '<Cmd>lua vim.diagnostic.goto_next()<CR>zz', { desc = '…' })

vim.keymap.set('n', '<Tab>', function() toggle_oil_right(35) end, opts)
