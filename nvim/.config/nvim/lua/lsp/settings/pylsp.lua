return {
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    enabled = false
                },
                mccabe = {
                    enabled = false
                },
                pyflakes = {
                    enabled = false
                },
                flake8 = {
                    enabled = false
                },
                pylint = {
                    enabled = false
                },
                pydocstyle = {
                    enabled = false
                },
                autopep8 = {
                    enabled = false
                },
                black = {
                    enabled = false
                },
                yapf = {
                    enabled = false
                },
                ruff = {
                    enabled = true,
                    formatEnabled = true,
                    extendSelect = { 'I' },
                    format = { 'I' },
                    unsafeFixes = true
                },
                pylsp_mypu = {
                    enabled = true,
                    live_mode = true
                },
                jedi_completion = {
                    fuzzy = true
                },
                rope_autoimport = {
                    enabled = true
                }
            }
        }
    }
}
