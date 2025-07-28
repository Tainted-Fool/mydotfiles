return {
    cmd = {
        "pwsh",
        "-NoLogo",
        "-NoProfile",
        "-Command",
        "~/.local/share/nvim/mason/packages/powershell-editor-services/PowerShellEditorServices/Start-EditorServices.ps1",
        "-HostName",
        "nvim",
        "-HostProfileId",
        "Neovim",
        "-HostVersion",
        "1.0.0",
        "-LogPath",
        "powershell_es.log",
        "-LogLevel",
        "Information",
        "-BundledModulesPath",
        "~/.local/share/nvim/mason/packages/powershell-editor-services",
        "-EnableConsoleRepl",
        "-SessionDetailsPath",
        "powershell_es.session.json",
        "-DebugServiceOnly",
    },
    settings = {
        powershell = {
            developer = {
                editorServicesLogLevel = "Information",
            },
            integratedConsole = {
                showOnStartup = false,
                suppressStartupBanner = true,
            }
        }
    }
}
