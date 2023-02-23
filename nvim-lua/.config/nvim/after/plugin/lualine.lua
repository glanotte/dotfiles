require('lualine').setup {
  options = {
    icons_enabled = true,
    section_separators = "",
    component_separators = "",
    theme = 'gruvbox-baby',
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_x = { "encoding", "fileformat", "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
  }
}
