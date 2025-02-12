local lspconfig = require("lspconfig")

local tools = {}

local my_capabilities = require("blink.cmp").get_lsp_capabilities()
my_capabilities.textDocument.completion.completionItem.snippetSupport = true

local my_on_attach = function(c, buf)
    local navic = require("nvim-navic")
    navic.attach(c, buf)
    -- if c.server_capabilities.documentsSymbolProvider then
    --     navic.attach(c, buf)
    -- end
end

local lsp_setup = function(lsp, opts)
    opts.capabilities = my_capabilities
    opts.on_attach = my_on_attach
    lspconfig[lsp].setup(opts)
end

-- nvim-lspconfig {{{
-- Documentation for lsp configuration:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

tools.lspconfig = {}

tools.lspconfig.items = {
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
}

tools.lspconfig.handlers = {
    -- Default Handler
    function(server)
        lspconfig[server].setup({
            capabilities = my_capabilities,
            on_attach = my_on_attach,
        })
    end,
    -- fix for the error `this document has been excluded`
    -- https://www.reddit.com/r/neovim/comments/1fkprp5/how_to_properly_setup_lspconfig_for_toml_files/
    ["taplo"] = function()
        lsp_setup("taplo", {
            filetypes = { "toml" },
            root_dir = require("lspconfig.util").root_pattern(
                "*.toml",
                "*.git"
            ),
        })
    end,
    ["clangd"] = function()
        lspconfig.clangd.setup({
            capabilities = my_capabilities,
            on_attach = my_on_attach,
            cmd = { "clangd", "--enable-config" },
        })
    end,
    ["lua_ls"] = function()
        lspconfig.lua_ls.setup({
            capabilities = my_capabilities,
            on_attach = my_on_attach,
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
}

-- }}}
-- None LS {{{

tools.null_ls = {}

tools.null_ls.items = {
    "prettierd",
    "stylua",
    "shfmt",
}

tools.null_ls.handlers = {
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
}

-- }}}

return tools
