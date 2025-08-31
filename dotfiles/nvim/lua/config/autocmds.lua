local ft = vim.filetype

ft.add({ pattern = { [".*/hyprland%.conf"] = "hyprlang" } })
ft.add({ pattern = { ["*.modulemap"] = "modulemap" } })
