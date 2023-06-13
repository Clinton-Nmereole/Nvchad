local plugins = {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "gopls",
        "rust-analyzer",
        "golines",
        "goimports",
        "pyright",
        "mypy",
        "ruff",
        "black",
        "debugpy"
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },
  {
    "dreamsofcode-io/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function(_,opts)
      require("dap-go").setup(opts)
    end
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {"mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui"},
    config = function (_,opts)
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(opts)
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = {"go","python"},
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
    end,
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
  {
    "ziglang/zig.vim",
    ft = "zig",
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    opts = function()
      return require "custom.configs.rust-tools"
    end,
    config = function(_,opts)
      require("rust-tools").setup(opts)
    end,
  },
  {
    "saecki/crates.nvim",
    ft = {"rust", "toml"},
    config = function (_,opts)
      local crates = require("crates")
      crates.setup(opts)
      crates.show()
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function ()
      local M = require "plugins.configs.cmp"
      table.insert(M.sources, {name = "crates"})
      return M
    end,
  },
  {
    "rcarriga/nvim-notify",
    config = function ()
      require("notify")("My super important message")
    end,
    init = function ()
      vim.notify = require("notify")
    end
  },
}
return plugins
