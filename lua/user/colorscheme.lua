vim.cmd[[
  try

  colorscheme nightfly

  catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme default
    set background=dark
  endtry

  highlight TSVariable guifg=#FF6464
  highlight TSVariableBuiltin guifg=#24A19C
  highlight TSKeyword guifg=#54BAB9
  highlight TSText guifg=#EFDAD7
  highlight TSMethod guifg=#DCDCAA
  highlight TSProperty guifg=#54BAB9
]]

-- local status, _ = pcall(vim.cmd, "colorscheme nightfly")
-- if not status then
--   print("Colorscheme not found!") -- print error if colorscheme not installed
--   return
-- end
