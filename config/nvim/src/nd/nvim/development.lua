local fn_lib     = require 'nd.lib.fn'

local res        = require 'nd.nvim.res'
local cache_res  = require 'nd.nvim.res.cache'
local scheme_res = require 'nd.nvim.res.scheme'

local ivals      = fn_lib.ivals
local mapi       = fn_lib.mapi
local filter     = fn_lib.filter
local collect    = fn_lib.collect
local each       = fn_lib.each

local apply_keys = scheme_res.apply_keys

local cmp        = require 'cmp'
local cmp_lsp    = require 'cmp_nvim_lsp'
local snip       = require 'luasnip'

local mason      = require 'mason'
local mason_lsp  = require 'mason-lspconfig'
local lsp_cfg    = require 'lspconfig'

local inlayhints = require 'lsp-inlayhints'

local treesitter = require 'nvim-treesitter.configs'

local crates     = require 'crates'


local is_not_skip_fn = nil


is_not_skip_fn = function(elem)
    return not elem[2].skip
end

return function(config)
    local key_scheme = cache_res.get_keys(config.keys)

    local lsp = res.lsp(config.lsp)

    apply_keys(key_scheme.lsp_fn())

    vim.diagnostic.config {
        signs            = true,
        underline        = true,
        severity_sort    = true,
        update_in_insert = true,
        virtual_text     = false,
    }

    cmp.setup {
        snippet = {
            expand = function(args)
                snip.lsp_expand(args.body)
            end,
        },
        mapping = key_scheme.cmp_fn(),
        sources = {
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'path' },
            { name = 'crates' },
        },
    }

    inlayhints.setup {
        inlay_hints = {
            highlight = '@type',
        },
    }

    mason.setup {}
    mason_lsp.setup {
        ensure_installed = collect(mapi(1, filter(is_not_skip_fn, ivals(lsp)))),
    }

    local capabilities = cmp_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

    each(function(elem)
        local key = elem[1]
        local val = elem[2]

        lsp_cfg[key].setup {
            settings     = val,
            capabilities = capabilities,
            on_attach    = function(client, bufnr)
                client.server_capabilities.semanticTokensProvider = nil

                vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]

                inlayhints.on_attach(client, bufnr)

                apply_keys(key_scheme.lsp_buf_fn(bufnr))
            end,
        }
    end, ivals(lsp))

    treesitter.setup {
        ensure_installed = res.treesitter(config),
        highlight = {
            enable = true,
        },
        playground = {
            enable = true,
            disable = {},
            updatetime = 25,
            persist_queries = false,
            keybindings = key_scheme.treesitter_fn(),
        },
    }

    crates.setup()
end
