local str_lib    = require 'nd.lib.core.str'
local type_lib   = require 'nd.lib.core.type'
local assert_lib = require 'nd.lib.core.assert'

local concat2s   = str_lib.concat2s

local is_str     = type_lib.is_str
local is_tab     = type_lib.is_tab

local nd_assert  = assert_lib.get_fn(ND_RES_IS_DEBUG)
local nd_err     = assert_lib.get_err_fn 'nd.res.core.key.nvim.main.lsp'

return function(config)
    local api    = config.api
    local leader = config.leader
    local opts   = config.opts

    nd_assert(is_tab(api), nd_err, 'fn(): api must be of type table')
    nd_assert(api.nvim, nd_err, 'fn(): api.nvim must be of type value')

    nd_assert(is_tab(leader), nd_err, 'fn(): leader must be of type table')
    nd_assert(is_str(leader.lsp), nd_err, 'fn(): leader.lsp must be of type string')
    nd_assert(is_str(leader.lsp_goto), nd_err, 'fn(): leader.lsp_goto must be of type string')
    nd_assert(is_tab(opts) or not opts, nd_err, 'fn(): opts must be of type table or nil')

    local lsp      = leader.lsp
    local lsp_goto = leader.lsp_goto

    return function()
        local diag  = api.nvim.diagnostic
        local inlay = api.inlay

        return {
            { 'n', concat2s(lsp, 'q'),      '<CMD>Telescope diagnostics<CR>',           opts },
            { 'n', concat2s(lsp, 'e'),      diag.open_float,                            opts },
            { 'n', '[d',                    diag.goto_prev,                             opts },
            { 'n', ']d',                    diag.goto_next,                             opts },
            { 'n', concat2s(lsp_goto, 'D'), '<CMD>Telescope lsp_type_definitions<CR>',  opts },
            { 'n', concat2s(lsp_goto, 'd'), '<CMD>Telescope lsp_definitions<CR>',       opts },
            { 'n', concat2s(lsp_goto, 'i'), '<CMD>Telescope lsp_implementations<CR>',   opts },
            { 'n', concat2s(lsp_goto, 'r'), '<CMD>Telescope lsp_references<CR>',        opts },
            { 'n', concat2s(lsp, 'i'),      '<CMD>Telescope lsp_incoming_calls<CR>',    opts },
            { 'n', concat2s(lsp, 'o'),      '<CMD>Telescope lsp_outgoing_calls<CR>',    opts },
            { 'n', concat2s(lsp, 'sd'),     '<CMD>Telescope lsp_document_symbols<CR>',  opts },
            { 'n', concat2s(lsp, 'sw'),     '<CMD>Telescope lsp_workspace_symbols<CR>', opts },
            { 'n', concat2s(lsp, '\\'),     inlay.toggle,                               opts },
        }
    end
end
