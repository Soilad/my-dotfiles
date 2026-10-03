return {
  {
    'mfussenegger/nvim-jdtls',
    ft = { 'java' },
    config = function()
      -- Ensure jdtls is installed and Java 17+ is available
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- The on_attach can be used to set keymaps, etc.
      local on_attach = function(client, bufnr)
        -- Your LSP keymaps here
      end

      local config = {
        cmd = { 'jdtls' },   -- Assumes 'jdtls' is in PATH (via Mason)
        root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', 'mvnw', '.git' }, { upward = true })[1]),
        on_attach = on_attach,
        capabilities = capabilities,
        -- Optional: specify jdtls settings
        settings = {
          java = {
            configuration = {
              runtimes = {
                {
                  name = 'JavaSE-17',
                  path = vim.fn.expand('~/.sdkman/candidates/java/17.0.12-tem/'), -- adjust
                },
              },
            },
          },
        },
      }

      -- Auto-start when opening a Java file
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'java',
        callback = function()
          require('jdtls').start_or_attach(config)
        end,
      })
    end,
  },
}
