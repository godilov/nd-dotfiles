local type_lib      = require 'nd.lib.type'
local assert_lib    = require 'nd.lib.assert'

local is_tab        = type_lib.is_tab

local nd_assert     = assert_lib.get_fn(ND_RES_IS_DEBUG)
local nd_err        = assert_lib.get_err_fn 'nd.res.nvim.lsp'

local bash_fn       = nil
local lua_fn        = nil
local cmake_fn      = nil
local cpp_fn        = nil
local glsl_fn       = nil
local rust_fn       = nil
local haskell_fn    = nil
local clojure_fn    = nil
local csharp_fn     = nil
local sql_fn        = nil
local html_fn       = nil
local css_fn        = nil
local typescript_fn = nil
local json_fn       = nil
local yaml_fn       = nil
local toml_fn       = nil
local texlab_fn     = nil


bash_fn = function(_)
    return {}
end

lua_fn = function(config)
    local cfg     = config or {}

    local libs    = cfg.libs or {}
    local globals = cfg.globals or {}

    return {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            format = {
                enable = true,
                defaultConfig = {
                    indent_style = 'space',
                    indent_size = '4',
                    quote_style = 'single',
                    call_arg_parentheses = 'remove',
                    continuation_indent = '4',
                    trailing_table_separator = 'smart',
                    insert_final_newline = 'false',
                    space_around_table_field_list = 'true',
                    space_before_attribute = 'true',
                    space_before_function_open_parenthesis = 'false',
                    space_before_function_call_open_parenthesis = 'fales',
                    space_before_closure_open_parenthesis = 'false',
                    space_before_function_call_single_arg = 'true',
                    space_before_open_square_bracket = 'false',
                    space_inside_function_call_parentheses = 'false',
                    space_inside_function_param_list_parentheses = 'false',
                    space_inside_square_brackets = 'false',
                    space_around_table_append_operator = 'false',
                    ignore_spaces_inside_function_call = 'false',
                    space_before_inline_comment = '1',
                    space_around_math_operator = 'true',
                    space_after_comma = 'true',
                    space_after_comma_in_for_statement = 'true',
                    space_around_concat_operator = 'true',
                    align_call_args = 'false',
                    align_function_params = 'false',
                    align_continuous_assign_statement = 'true',
                    align_continuous_rect_table_field = 'true',
                    align_if_branch = 'true',
                    align_array_table = 'true',
                },
            },
            workspace = {
                library = libs,
                checkThirdParty = false,
            },
            diagnostics = {
                globals = globals,
            },
        },
    }
end

cmake_fn = function(_)
    return {}
end

cpp_fn = function(_)
    return {
        skip = true,
    }
end

glsl_fn = function(_)
    return { skip = true }
end

rust_fn = function(_)
    return {
        ['rust-analyzer'] = {
            check = {
                command = 'clippy',
            },
            rustfmt = {
                extraArgs = { '+nightly' },
            },
        },
    }
end

haskell_fn = function(_)
    return {}
end

clojure_fn = function(_)
    return {}
end

csharp_fn = function(_)
    return {}
end

sql_fn = function(_)
    return {}
end

html_fn = function(_)
    return {}
end

css_fn = function(_)
    return {}
end

typescript_fn = function(_)
    return {}
end

json_fn = function(_)
    return {}
end

yaml_fn = function(_)
    return {
        yaml = {
            yamlVersion = 1.2,
            format = {
                enable         = true,
                singleQuote    = true,
                bracketSpacing = true,
                proseWrap      = 'never',
                printWidth     = 0,
            },
            schemas = {},
            schemaStore = {
                url = 'https://www.schemastore.org/api/json/catalog.json',
                enable = true,
            }
            ,
            completion = true,
            validate = true,
            hover = true,
        },
    }
end

toml_fn = function(_)
    return {}
end

texlab_fn = function(_)
    return {}
end

return function(config)
    nd_assert(is_tab(config), nd_err, 'fn(): config must be of type table')

    return {
        { 'bashls',        bash_fn(config.bash) },
        { 'lua_ls',        lua_fn(config.lua) },

        { 'cmake',         cmake_fn(config.cmake) },
        { 'ccls',          cpp_fn(config.cpp) },
        { 'glslls',        glsl_fn(config.glsl) },
        { 'rust_analyzer', rust_fn(config.rust) },
        { 'hls',           haskell_fn(config.haskell) },
        { 'clojure_lsp',   clojure_fn(config.clojure) },

        { 'omnisharp',     csharp_fn(config.csharp) },
        { 'sqlls',         sql_fn(config.sql) },
        { 'html',          html_fn(config.html) },
        { 'cssls',         css_fn(config.css) },
        { 'tsserver',      typescript_fn(config.typescript) },

        { 'jsonls',        json_fn(config.json) },
        { 'yamlls',        yaml_fn(config.yaml) },
        { 'taplo',         toml_fn(config.toml) },

        { 'texlab',        texlab_fn(config.latex) },
    }
end
