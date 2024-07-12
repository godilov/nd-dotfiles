return {
    ['nd-even'] = {
        lua = {
            libs = {
                '/usr/share/nvim/runtime/lua',
                '/usr/share/nvim/runtime/lua/lsp',
            },
            globals = {
                'vim',
                'screen',
                'client',
                'root',
            },
        },
    },
}
