return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local function pdc_lualine()
                local theme = vim.g.colors_name
                if theme == "pdc-dark" then
                    return {
                        normal = {
                            a = { fg = "#0d0806", bg = "#FF6B35", gui = "bold" },
                            b = { fg = "#EDE7F4", bg = "#2a1810" },
                            c = { fg = "#999999", bg = "#141414" },
                        },
                        insert = {
                            a = { fg = "#0d0806", bg = "#8B9A6B", gui = "bold" },
                        },
                        visual = {
                            a = { fg = "#0d0806", bg = "#FF8C00", gui = "bold" },
                        },
                        command = {
                            a = { fg = "#0d0806", bg = "#61afef", gui = "bold" },
                        },
                        inactive = {
                            a = { fg = "#666666", bg = "#141414" },
                            b = { fg = "#666666", bg = "#0d0806" },
                            c = { fg = "#666666", bg = "#0d0806" },
                        },
                    }
                elseif theme == "pdc-light" then
                    return {
                        normal = {
                            a = { fg = "#ebe4f4", bg = "#7C3AED", gui = "bold" },
                            b = { fg = "#1a1a2e", bg = "#d8d0f0" },
                            c = { fg = "#666677", bg = "#ddd6ec" },
                        },
                        insert = {
                            a = { fg = "#ebe4f4", bg = "#5A7A4D", gui = "bold" },
                        },
                        visual = {
                            a = { fg = "#ebe4f4", bg = "#6D28D9", gui = "bold" },
                        },
                        command = {
                            a = { fg = "#ebe4f4", bg = "#4078f2", gui = "bold" },
                        },
                        inactive = {
                            a = { fg = "#999aaa", bg = "#ddd6ec" },
                            b = { fg = "#999aaa", bg = "#ebe4f4" },
                            c = { fg = "#999aaa", bg = "#ebe4f4" },
                        },
                    }
                end
                return "auto"
            end

            require("lualine").setup({
                options = { theme = pdc_lualine() },
            })

            vim.api.nvim_create_autocmd("ColorScheme", {
                callback = function()
                    require("lualine").setup({
                        options = { theme = pdc_lualine() },
                    })
                end,
            })
        end,
    },
}
