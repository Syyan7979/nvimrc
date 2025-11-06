return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "williamboman/mason.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "saadparwaiz1/cmp_luasnip",
        -- ✅ Autopairs plugin
        "windwp/nvim-autopairs",
        -- ✅ LuaSnip with jsregexp
        {
            "L3MON4D3/LuaSnip",
            dependencies = {
                { "L3MON4D3/jsregexp", lazy = false },
                "rafamadriz/friendly-snippets",
            },
            config = function()
                local jsregexp_path = vim.fn.stdpath("data") .. "/lazy/jsregexp/?.lua"
                if not string.find(package.path, jsregexp_path, 1, true) then
                    package.path = package.path .. ";" .. jsregexp_path
                end
                local ok, jsregexp = pcall(require, "jsregexp")
                require("luasnip").setup({
                    enable_autosnippets = true,
                    parser_nested_assembler = ok and jsregexp or nil,
                })
                require("luasnip.loaders.from_vscode").lazy_load()
            end,
        }
    },
    config = function()
        local keymaps = require("keymaps")
        local cmp = require("cmp")
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        -- ✅ Setup autopairs
        require("nvim-autopairs").setup({
            check_ts = true, -- Use treesitter for better context awareness
            ts_config = {
                lua = { "string", "source" },
                javascript = { "string", "template_string" },
                java = false, -- don't check treesitter on java
            },
        })

        require("mason").setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })
        require("mason-lspconfig").setup({
            ensure_installed = {
                -- Core languages
                "lua_ls",
                "rust_analyzer",
                "ts_ls",
                "gopls",
                "basedpyright", -- Python (fallback to pyright if preferred)
                "intelephense", -- PHP (fallback to phpactor if preferred)
            },
            handlers = {
                -- Default handler for most servers
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        on_attach = keymaps.on_attach,
                        capabilities = capabilities,
                    })
                end,
                -- Lua: better defaults for Neovim config
                ["lua_ls"] = function()
                    require("lspconfig").lua_ls.setup({
                        on_attach = keymaps.on_attach,
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = { globals = { "vim" } },
                                workspace = {
                                    checkThirdParty = false,
                                    library = vim.api.nvim_get_runtime_file("", true),
                                },
                                telemetry = { enable = false },
                            },
                        },
                    })
                end,
            },
        })
        require("lazy").load({ plugins = { "LuaSnip"} })

        -- ✅ Configure nvim-cmp with autopairs integration
        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
            }, {
                { name = "buffer" },
            }),
        })

        -- ✅ Integrate autopairs with nvim-cmp
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

        cmp.setup.cmdline("/", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
            },
        })
        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "path" },
            }, {
                { name = "cmdline" },
            }),
            matching = { disallow_symbol_nonprefix_matching = false },
        })
    end,
}
