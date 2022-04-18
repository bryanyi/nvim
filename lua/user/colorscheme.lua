vim.cmd [[
  try
    colorscheme nightfox
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
