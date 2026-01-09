return {
      'nvim-treesitter/nvim-treesitter',
      branch = 'master',
      lazy = false, -- Lazy loading breaks the plugin
      build = ':TSUpdate',
      main = 'nvim-treesitter.configs',
      opts = {
        ensure_installed = { 'c', 'comment' },
        auto_install = true,
        highlight = {
          enable = true
        }
      }
    }
