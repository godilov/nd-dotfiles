local str_lib    = require 'nd.lib.str'
local tab_lib    = require 'nd.lib.tab'
local type_lib   = require 'nd.lib.type'
local assert_lib = require 'nd.lib.assert'

local concat2s   = str_lib.concat2s

local merge      = tab_lib.merge

local is_str     = type_lib.is_str
local is_tab     = type_lib.is_tab

local nd_assert  = assert_lib.get_fn(ND_NVIM_IS_DEBUG)

return function(config)
    local api    = config.api
    local leader = config.leader
    local opts   = config.opts

    nd_assert(is_tab(api), 'api must be of type table')
    nd_assert(api.nvim, 'api.nvim must be of type value')

    nd_assert(is_tab(leader), 'leader must be of type table')
    nd_assert(is_str(leader.lsp), 'leader.lsp must be of type string')
    nd_assert(is_tab(opts) or not opts, 'opts must be of type table or nil')

    local lsp = leader.lsp

    return function(bufnr)
        local buf      = api.nvim.lsp.buf
        local inspect  = api.nvim.inspect
        local opts_buf = merge {
            { buffer = bufnr },
            opts,
        }


        local on_wl = function() print(inspect(buf.list_workspace_folders())) end
        local on_f  = function() buf.format { async = true } end

        return {
            { 'n', '<C-Space>',         buf.hover,                   opts_buf },
            { 'n', '<M-Space>',         buf.signature_help,          opts_buf },
            { 'n', concat2s(lsp, 'wa'), buf.add_workspace_folder,    opts_buf },
            { 'n', concat2s(lsp, 'wr'), buf.remove_workspace_folder, opts_buf },
            { 'n', concat2s(lsp, 'wl'), on_wl,                       opts_buf },
            { 'n', concat2s(lsp, 'r'),  buf.rename,                  opts_buf },
            { 'n', concat2s(lsp, 'a'),  buf.code_action,             opts_buf },
            { 'n', concat2s(lsp, 'f'),  on_f,                        opts_buf },
        }
    end
end
