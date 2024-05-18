return function(_)
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
            },
            completion = true,
            validate = true,
            hover = true,
        },
    }
end
