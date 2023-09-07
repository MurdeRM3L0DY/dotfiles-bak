local keymap = require('utils.keymap')

-- Leader Key
keymap.set('n', '<space>', '<nop>')
vim.g.mapleader = keymap.t('<space>')

keymap.set('n', '<leader><cr>', '<cmd>source %<cr>')
keymap.set('n', '<leader>l', '<cmd>Lazy<cr>')

-- window relative keymaps
-- keymap.set('n', '<C-h>', '<C-w>h')
-- keymap.set('n', '<C-j>', '<C-w>j')
-- keymap.set('n', '<C-k>', '<C-w>k')
-- keymap.set('n', '<C-l>', '<C-w>l')

keymap.set('n', '<C-q>', '<C-w>q')
keymap.set('n', '<C-s>', function()
  vim.cmd.write()
end)

-- don't copy when pasting over selection
keymap.set('x', 'p', '"_dP')
keymap.set('x', 'P', '"_dp')

-- post center cursor
keymap.set('n', '<C-u>', '<C-u>zz')
keymap.set('n', '<C-d>', '<C-d>zz')
keymap.set('n', '<C-i>', '<C-i>zz')
keymap.set('n', '<C-o>', '<C-o>zz')

-- window resize
keymap.set('n', '<M-h>', '<C-w><')
keymap.set('n', '<M-j>', '<C-w>-')
keymap.set('n', '<M-k>', '<C-w>+')
keymap.set('n', '<M-l>', '<C-w>>')

keymap.set('n', '<leader>cj', '<cmd>cnext<cr>')
keymap.set('n', '<leader>ck', '<cmd>cprevious<cr>')

keymap.set('n', '<leader>tj', '<cmd>tabnext<cr>')
keymap.set('n', '<leader>tk', '<cmd>tabprevious<cr>')

-- easy escape terminal mode
keymap.set('t', '<C-esc>', [[<C-\><C-n>]])

-- Add undo break-points
keymap.set('i', ',', ',<c-g>u')
keymap.set('i', '.', '.<c-g>u')
keymap.set('i', ';', ';<c-g>u')

-- Resize window using <ctrl> arrow keys
keymap.set('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase window height' })
keymap.set('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease window height' })
keymap.set('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease window width' })
keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase window width' })

-- better up/down
keymap.set({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })
keymap.set({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { expr = true })
keymap.set({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
keymap.set({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { expr = true })
