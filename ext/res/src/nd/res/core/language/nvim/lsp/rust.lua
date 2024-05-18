return function(_)
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
