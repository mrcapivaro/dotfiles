local M = {}

M.lspconfig = {
    items = {
        "lua_ls",
        "html",
        "cssls",
        "emmet_ls",
        "clangd",
        "pyright",
        "ruff",
        "bashls",
        "ts_ls",
        "taplo",
    },
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
    handlers = {
        -- Default Handler
        function(server)
            local lspconfig = require("lspconfig")
            local capabilities = require("blink.cmp").get_lsp_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport =
                true
            lspconfig[server].setup({ capabilities = capabilities })
        end,
        -- fix for the error `this document has been excluded`
        -- https://www.reddit.com/r/neovim/comments/1fkprp5/how_to_properly_setup_lspconfig_for_toml_files/
        ["taplo"] = function()
            local lspconfig = require("lspconfig")
            lspconfig.taplo.setup({
                filetypes = { "toml" },
                root_dir = require("lspconfig.util").root_pattern(
                    "*.toml",
                    "*.git"
                ),
            })
        end,
        ["clangd"] = function()
            local lspconfig = require("lspconfig")
            lspconfig.clangd.setup({
                cmd = {
                    "clangd",
                    "--enable-config",
                },
            })
        end,
        ["lua_ls"] = function()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({
                workspace = {
                    checkThirdParty = false,
                    library = vim.tbl_deep_extend(
                        "force",
                        vim.api.nvim_get_runtime_file("", true),
                        {
                            "/usr/share/awesome/lib",
                            "/usr/share/lua",
                        }
                    ),
                },
                diagnostics = {
                    globals = {
                        "awesome",
                        "awful",
                        "client",
                        "screen",
                        "tag",
                        "root",
                    },
                },
                telemetry = { enabled = false },
            })
        end,
    },
}

-- Formatters and Linters as LSPs
M.null_ls = {
    items = {
        "stylua",
        "prettierd",
        "shfmt",
    },
    handlers = {
        shfmt = function(source_name, methods)
            require("mason-null-ls").default_setup(source_name, methods)
            local null_ls = require("null-ls")
            null_ls.register(null_ls.builtins.formatting.shfmt.with({
                extra_args = { "-i", "4", "-ci" },
            }))
        end,
        prettierd = function(source_name, _)
            -- require("mason-null-ls").default_setup(source_name, methods)
            local null_ls = require("null-ls")
            null_ls.register(null_ls.builtins.formatting[source_name].with({
                disabled_filetypes = { "html", "markdown" },
            }))
        end,
    },
}

return M
