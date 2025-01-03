local map = vim.keymap.set

local keys = {
    { { 'n', 'x' },      'j',          "v:count == 0 ? 'gj' : 'j'",   { desc = 'Down', expr = true, silent = true, } },
    { { 'n', 'x' },      'k',          "v:count == 0 ? 'gk' : 'k'",   { desc = 'Up', expr = true, silent = true, } },
    { { 'n', 'x' },      '<Down>',     "v:count == 0 ? 'gj' : 'j'",   { desc = 'Down', expr = true, silent = true, } },
    { { 'n', 'x' },      '<Up>',       "v:count == 0 ? 'gk' : 'k'",   { desc = 'Up', expr = true, silent = true, } },

    { 'n',               '[t',         '<CMD>tabprevious<CR>',        { desc = 'Prev Tab' } },
    { 'n',               ']t',         '<CMD>tabnext<CR>',            { desc = 'Next Tab' } },
    { 'n',               '[q',         vim.cmd.cprev,                 { desc = 'Prev Error' } },
    { 'n',               ']q',         vim.cmd.cnext,                 { desc = 'Next Error' } },

    { 'n',               '<C-h>',      '<C-w>h',                      { desc = 'Go to Left Window', remap = true } },
    { 'n',               '<C-j>',      '<C-w>j',                      { desc = 'Go to Lower Window', remap = true } },
    { 'n',               '<C-k>',      '<C-w>k',                      { desc = 'Go to Upper Window', remap = true } },
    { 'n',               '<C-l>',      '<C-w>l',                      { desc = 'Go to Right Window', remap = true } },

    { 'v',               '<',          '<gv', },
    { 'v',               '>',          '>gv', },
    { { 'n', 'i', 'v' }, '<ESC>',      '<CMD>noh<CR><ESC>',           { desc = 'Clear hlsearch', } },

    { 'n',               '<C-Up>',     '<CMD>resize +2<CR>',          { desc = 'Increase Window Height' } },
    { 'n',               '<C-Down>',   '<CMD>resize -2<CR>',          { desc = 'Decrease Window Height' } },
    { 'n',               '<C-Left>',   '<CMD>vertical resize -2<CR>', { desc = 'Decrease Window Width' } },
    { 'n',               '<C-Right>',  '<CMD>vertical resize +2<CR>', { desc = 'Increase Window Width' } },

    { 'n',               '<A-h>',      '<CMD>bprev<CR>',              { desc = 'Prev Buffer' } },
    { 'n',               '<A-j>',      '<CMD>bdelete<CR>',            { desc = 'Delete Buffer' } },
    { 'n',               '<A-k>',      '<CMD>enew<CR>',               { desc = 'Create Buffer' } },
    { 'n',               '<A-l>',      '<CMD>bnext<CR>',              { desc = 'Next Buffer' } },

    { 'n',               '<C-A-h>',    '<CMD>tabprevious<CR>',        { desc = 'Prev Tab' } },
    { 'n',               '<C-A-j>',    '<CMD>tabclose<CR>',           { desc = 'Delete Tab' } },
    { 'n',               '<C-A-k>',    '<CMD>tabnew<CR>',             { desc = 'Create Tab' } },
    { 'n',               '<C-A-l>',    '<CMD>tabnext<CR>',            { desc = 'Next Tab' } },

    { 'n',               '<leader>bc', '<CMD>enew<CR>',               { desc = 'Create Buffer' } },
    { 'n',               '<leader>bd', '<CMD>bdelete<CR>',            { desc = 'Delete Buffer' } },

    { 'n',               '<leader>tc', '<CMD>tabnew<CR>',             { desc = 'Create Tab' } },
    { 'n',               '<leader>td', '<CMD>tabclose<CR>',           { desc = 'Delete Tab' } },

    { 'n',               '<leader>ul', '<CMD>Lazy<CR>',               { desc = 'Lazy' } },
    { 'n',               '<leader>ui', '<CMD>Inspect<CR>',            { desc = 'Inspect Position' } },
    { 'n',               '<leader>uI', '<CMD>InspectTree<CR>',        { desc = 'Inspect Tree' } },
}

for _, v in ipairs(keys) do
    map(v[1], v[2], v[3], v[4])
end
