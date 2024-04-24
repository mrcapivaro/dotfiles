return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = {
      { "<leader>m", "<cmd>Mason<cr>", desc = "Open the Mason menu." },
    },
    opts = {},
    config = function(_, opts)
      local mason = require("mason")
      local mason_utils = require("util.mason")
      local servers = require("config.servers")
      mason.setup(opts)
      vim.api.nvim_create_user_command("MasonInstallAll", function()
        mason_utils.installServers(servers.lsp, "LspInstall")
        mason_utils.installServers(servers.linter, "MasonInstall")
        mason_utils.installServers(servers.formatter, "MasonInstall")
        mason_utils.installServers(servers.dap, "MasonInstall")
      end, {})
    end,
  },

  { "folke/neodev.nvim", opts = {} },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "nvim-lspconfig",
      "mason.nvim",
      "neodev.nvim",
    },
    config = function()
      require("mason-lspconfig").setup()
      local lspconfig = require("lspconfig")
      local servers = require("config.servers")
      local capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
      )

      for _, server in ipairs(servers.lsp) do
        lspconfig[server].setup({ capabilities = capabilities })
      end

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
          },
        },
      })

      -- lspconfig.clangd.setup({
      --   capabilities = capabilities,
      --   cmd = { "clangd", "-offset-encoding=utf-8" },
      -- })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "mason.nvim" },
      { "folke/neodev.nvim", opts = {} },
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP keymaps/actions.",
        callback = function(event)
          local opts = { buffer = event.buf }
          local map = vim.keymap.set
          map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
          map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
          map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
          map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
          map("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
          map("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
          map("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
          map("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
          map("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
          map({ "n", "x" }, "<leader>fm", function()
            vim.lsp.buf.format({ async = false })
          end, opts)
          map("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
          map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
          map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
        end,
      })
    end,
  },
}
