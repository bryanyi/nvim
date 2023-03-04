local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local colors = {
  bg = "#202328",
  fg = "#bbc2cf",
  yellow = "#ECBE7B",
  cyan = "#008080",
  darkblue = "#081633",
  green = "#98be65",
  orange = "#FF8800",
  violet = "#a9a1e1",
  magenta = "#c678dd",
  blue = "#51afef",
  red = "#ec5f67",
}
local bubble_theme_colors = {
  blue = "#80a0ff",
  cyan = "#79dac8",
  black = "#080808",
  white = "#c6c6c6",
  red = "#ff5189",
  violet = "#d183e8",
  grey = "#303030",
  darkerCyan = "#037e91",
  darkPink = "#e0849f",
}
local bubbles_theme = {
  normal = {
    a = { fg = bubble_theme_colors.black, bg = bubble_theme_colors.darkPink },
    b = { fg = bubble_theme_colors.white, bg = bubble_theme_colors.grey },
    c = { fg = bubble_theme_colors.white, bg = colors.bg },
  },
  insert = { a = { fg = bubble_theme_colors.black, bg = bubble_theme_colors.blue } },
  visual = { a = { fg = bubble_theme_colors.black, bg = bubble_theme_colors.cyan } },
  replace = { a = { fg = bubble_theme_colors.black, bg = bubble_theme_colors.red } },

  inactive = {
    a = { fg = bubble_theme_colors.white, bg = bubble_theme_colors.black },
    b = { fg = bubble_theme_colors.white, bg = bubble_theme_colors.black },
    c = { fg = bubble_theme_colors.black, bg = bubble_theme_colors.black },
  },
}

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

-- local theme = require("lualine.themes.material")
local theme = require("lualine.themes.nightfly")

local icons = require("user.icons")

local filename = {
  "filename",
  file_status = true, -- Displays file status (readonly status, modified status)
  newfile_status = false, -- Display new file status (new file means no write after created)
  path = 0, -- 0: Just the filename
  -- 1: Relative path
  -- 2: Absolute path
  -- 3: Absolute path, with tilde as the home directory

  shorting_target = 40, -- Shortens path to leave 40 spaces in the window
  -- for other components. (terrible name, any suggestions?)
  symbols = {
    modified = "[+]", -- Text to show when the file is modified.
    readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
    unnamed = "[No Name]", -- Text to show for unnamed buffers.
    newfile = "[New]", -- Text to show for new created file before first writting
  },
}

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  -- sections = { 'error', 'warn', 'info', 'hint' },
  sections = { "error", "warn", "hint" },
  -- symbols = { error = "🐞 ", warn = "🚧 ", info = "🌻 ", hint = "💡 " },
  symbols = {
    error = icons.diagnostics.BoldError,
    warn = icons.diagnostics.BoldWarning,
    info = icons.diagnostics.Information,
    hint = icons.diagnostics.Hint .. " ",
  },
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.orange },
    color_info = { fg = colors.green },
    hint = { fg = colors.yellow },
  },
  always_visible = false,
}

local diff = {
  "diff",
  colored = true,
  -- symbols = { added = "+", modified = "~", removed = "-" }, -- changes diff symbols
  symbols = {
    added = icons.git.Add .. " ",
    modified = icons.git.Mod .. " ",
    removed = icons.git.Remove .. " ",
  },
  -- cond = hide_in_width,
}

local mode = {
  "mode",
  fmt = function(str)
    return "-- " .. str .. " --"
  end,
}

local filetype = {
  "filetype",
  icons_enabled = false,
  icon = nil,
}

local branch = {
  "branch",
  icons_enabled = true,
  icon = "",
}

local location = {
  "location",
  padding = 0,
}

-- cool function for progress
local progress = function()
  local current_line = vim.fn.line(".")
  local total_lines = vim.fn.line("$")
  local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
  local line_ratio = current_line / total_lines
  local index = math.ceil(line_ratio * #chars)
  return chars[index]
end

local spaces = function()
  return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local current_signature = {
  function()
    local buf_ft = vim.bo.filetype

    if buf_ft == "toggleterm" or buf_ft == "TelescopePrompt" then
      return ""
    end
    if not pcall(require, "lsp_signature") then
      return ""
    end
    local sig = require("lsp_signature").status_line(30)
    local hint = sig.hint

    if not require("user.functions").isempty(hint) then
      -- return "%#SLSeparator#│ : " .. hint .. "%*"
      -- return "%#SLSeparator#│ " .. hint .. "%*"
      return "%#SLSeparator# " .. hint .. "%*"
    end

    return ""
  end,
  cond = hide_in_width_100,
  padding = 0,
}

-- lualine.setup({
-- 	options = {
-- 		icons_enabled = true,
-- 		theme = theme,
-- 		component_separators = { left = "", right = "" },
-- 		section_separators = { left = "", right = "" },
-- 		disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
-- 		always_divide_middle = true,
-- 	},
-- 	sections = {
-- 		lualine_a = { mode, branch, diagnostics },
-- 		lualine_b = { "filename" },
-- 		lualine_c = { current_signature },
-- 		-- lualine_x = { "encoding", "fileformat", "filetype" },
-- 		lualine_x = { diff, spaces, "encoding", filetype },
-- 		lualine_y = { location },
-- 		lualine_z = { progress },
-- 	},
-- 	inactive_sections = {
-- 		lualine_a = {},
-- 		lualine_b = {},
-- 		lualine_c = { "filename" },
-- 		lualine_x = { "location" },
-- 		lualine_y = {},
-- 		lualine_z = {},
-- 	},
-- 	tabline = {},
-- 	extensions = {},
-- })

lualine.setup({
  options = {
    icons_enabled = true,
    -- theme = "auto",
    theme = bubbles_theme,
    -- component_separators = { left = "", right = "" },
    -- section_separators = { left = "", right = "" },
    -- component_separators = { left = "", right = "" },
    component_separators = "|",
    -- section_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", diff },
    lualine_c = { diagnostics, filename },
    lualine_x = { "filetype" },
    lualine_y = { "filesize" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {},
})
