return {
  {
    {
      'LazyVim/LazyVim',
      lazy = false,
      config = function()
        -- Folding
        vim.opt.foldlevel = 99
        vim.opt.foldtext = "v:lua.require'lazyvim.util'.ui.foldtext()"

        vim.opt.statuscolumn = [[%!v:lua.require'lazyvim.util'.ui.statuscolumn()]]

        vim.opt.foldmethod = 'expr'
        vim.opt.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()"
      end,
    },
  },
}
