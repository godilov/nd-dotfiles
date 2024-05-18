local str_lib    = require 'nd.lib.core.str'
local type_lib   = require 'nd.lib.core.type'
local assert_lib = require 'nd.lib.core.assert'

local concat2s   = str_lib.concat2s

local is_str     = type_lib.is_str
local is_tab     = type_lib.is_tab

local nd_assert  = assert_lib.get_fn(ND_RES_IS_DEBUG)
local nd_err     = assert_lib.get_err_fn 'nd.res.core.key.nvim.main.editor'

return function(config)
    local leader = config.leader
    local opts   = config.opts

    nd_assert(is_tab(leader), nd_err, 'fn(): leader must be of type table')
    nd_assert(is_str(leader.files), nd_err, 'fn(): leader.files must be of type string')
    nd_assert(is_tab(opts) or not opts, nd_err, 'fn(): opts must be of type table or nil')

    local files = leader.files

    return function()
        return {
            { '',  '<up>',               '<nop>',                         opts },
            { '',  '<down>',             '<nop>',                         opts },
            { '',  '<left>',             '<nop>',                         opts },
            { '',  '<right>',            '<nop>',                         opts },
            { 'n', '<F2>',               '<CMD>Dashboard<CR>',            opts },
            { 'n', '<F33>',              '<CMD>NdApplyConfig<CR>',        opts },
            { 'n', '<F34>',              '<CMD>NdApplyFile<CR>',          opts },
            { 'n', concat2s(files, 'd'), '<CMD>NvimTreeToggle<CR>',       opts },
            { 'n', concat2s(files, 'f'), '<CMD>Telescope find_files<CR>', opts },
            { 'n', concat2s(files, 'g'), '<CMD>Telescope git_status<CR>', opts },
            { 'n', concat2s(files, ';'), '<CMD>Telescope live_grep<CR>',  opts },
            { 'n', concat2s(files, '`'), '<CMD>Telescope help_tags<CR>',  opts },
            { 'n', concat2s(files, '~'), '<CMD>Telescope highlights<CR>', opts },
            { 'n', '<F5>',               '<CMD>SessionsSave<CR>',         opts },
            { 'n', '<F8>',               '<CMD>SessionsLoad<CR>',         opts },
            { 'n', '<C-h>',              '<C-w>h',                        opts },
            { 'n', '<C-j>',              '<C-w>j',                        opts },
            { 'n', '<C-k>',              '<C-w>k',                        opts },
            { 'n', '<C-l>',              '<C-w>l',                        opts },
            { 'n', '<S-h>',              '<C-w>H',                        opts },
            { 'n', '<S-j>',              '<C-w>J',                        opts },
            { 'n', '<S-k>',              '<C-w>K',                        opts },
            { 'n', '<S-l>',              '<C-w>L',                        opts },
            { 'n', '<C-S-h>',            '<C-w>4<',                       opts },
            { 'n', '<C-S-j>',            '<C-w>4-',                       opts },
            { 'n', '<C-S-k>',            '<C-w>4+',                       opts },
            { 'n', '<C-S-l>',            '<C-w>4>',                       opts },
            { 'n', '<M-h>',              '<CMD>:tabprevious<CR>',         opts },
            { 'n', '<M-j>',              '<CMD>:tabclose<CR>',            opts },
            { 'n', '<M-k>',              '<CMD>:tabnew<CR>',              opts },
            { 'n', '<M-l>',              '<CMD>:tabnext<CR>',             opts },
            { 'n', '<C-M-h>',            '<CMD>:-tabmove<CR>',            opts },
            { 'n', '<C-M-l>',            '<CMD>:+tabmove<CR>',            opts },
        }
    end
end
