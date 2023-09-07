vim.filetype.add {
  filename = {
    ['.envrc'] = 'bash',
    ['.xinitrc'] = 'bash',
    ['.xsession'] = 'bash',
    ['.xprofile'] = 'bash',
    ['flake.lock'] = 'json',
    ['devenv.lock'] = 'json',
    ['direnvrc'] = 'bash',
  },
  extension = {
    blif = 'blif',
    conf = 'conf',
    frag = 'glsl',
  },
}
