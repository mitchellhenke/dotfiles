local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')
Plug('junegunn/fzf.vim')
Plug('junegunn/fzf')
Plug('Raimondi/delimitMate')
Plug('AndrewRadev/splitjoin.vim')
Plug('tpope/vim-commentary')
Plug('keith/swift.vim')
Plug('elixir-lang/vim-elixir')
Plug('tpope/vim-endwise')
Plug('tpope/vim-fugitive')
Plug('tpope/vim-repeat')
Plug('tpope/vim-sleuth')
Plug('tpope/vim-surround')
Plug('christoomey/vim-tmux-navigator', { commit = 'c33a8a97028cac38040f1b8d9292337104026ad6' })
Plug('janko-m/vim-test')
Plug('jgdavey/tslime.vim')
Plug('tpope/vim-rhubarb')
Plug('shaunsingh/solarized.nvim')
Plug('neovim/nvim-lsp')
-- https://github.com/elixir-lang/expert?tab=readme-ov-file#nightly-builds
Plug('neovim/nvim-lspconfig')
vim.call('plug#end')

-- Disable unused providers
vim.g.loaded_python_provider = 1
vim.g.loaded_python3_provider = 1
vim.g.loaded_ruby_provider = 1
vim.g.loaded_node_provider = 1
vim.g.ruby_no_expensive = 1

-- Elixir LSP
vim.lsp.config('expert', {
  cmd = { '/Users/mhenke/.config/nvim/expert_darwin_arm64', '--stdio' },
  root_markers = { 'mix.exs', '.git' },
  filetypes = { 'elixir', 'eelixir', 'heex' },
})

vim.lsp.enable 'expert'

-- LSP keymaps
local opts = { noremap = true, silent = true }
vim.keymap.set('n', 'gd', vim.lsp.buf.declaration, opts)
vim.keymap.set('n', '<c-]>', vim.lsp.buf.definition, opts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
vim.keymap.set('n', 'gD', vim.lsp.buf.implementation, opts)
vim.keymap.set('n', '<c-k>', vim.lsp.buf.signature_help, opts)
vim.keymap.set('n', '1gD', vim.lsp.buf.type_definition, opts)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
vim.keymap.set('n', 'g0', vim.lsp.buf.document_symbol, opts)
vim.keymap.set('n', 'gW', vim.lsp.buf.workspace_symbol, opts)
vim.opt.omnifunc = 'v:lua.vim.lsp.omnifunc'

-- Colorscheme
vim.opt.background = 'light'
vim.cmd('colorscheme solarized')

-- Leaders
vim.g.mapleader = ','
vim.g.maplocalleader = ';'

-- FZF mappings
vim.keymap.set('n', ';', ':Buffers<CR>')
vim.keymap.set('n', '<C-p>', ':Files<CR>', { silent = true })
vim.keymap.set('n', '<leader>f', ':Tags<CR>')
-- Copy file path
vim.keymap.set('n', '<leader>p', ":let @+=expand('%')<CR>", { noremap = true })

-- Line numbers
vim.opt.number = true

-- Clipboard
vim.opt.clipboard = 'unnamed'

-- Remove trailing whitespace
vim.keymap.set('n', '<leader>w', ':%s/\\s\\+$//e<CR>', { silent = true })

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Mouse
vim.opt.mousehide = true

-- Auto-read changed files
vim.opt.autoread = true

-- Indentation
vim.opt.autoindent = true

-- Grep program
if vim.fn.executable('rg') == 1 then
  vim.opt.grepprg = 'rg --color=never'
  vim.g.ackprg = 'rg --vimgrep --no-heading --smart-case'
elseif vim.fn.executable('ag') == 1 then
  vim.g.ackprg = 'ag --vimgrep'
end

-- Backspace
vim.opt.backspace = { 'indent', 'eol', 'start' }

-- Completion
vim.opt.complete:remove('i')

-- Smart tab
vim.opt.smarttab = true

-- ;; to escape insert mode
vim.keymap.set('i', ';;', '<esc>')

-- <leader><leader> to go to previous file
vim.keymap.set('n', '<leader><leader>', '<c-^>', { noremap = true })

vim.keymap.set('n', '<leader>e', ":edit <C-r>=expand('%:p:h').'/'<CR>", { noremap = true })
vim.keymap.set('n', '<leader>v', ":view <C-r>=expand('%:p:h').'/'<CR>", { noremap = true })

-- Scroll offset
vim.opt.scrolloff = 8

-- Timeouts
vim.opt.timeoutlen = 300
vim.opt.ttimeoutlen = 10

-- History
vim.opt.history = 20

-- Replace word with yanked text
vim.keymap.set('n', 'S', 'diw"0P', { noremap = true })

-- vim-test
vim.g['test#strategy'] = 'tslime'
vim.g.tslime_always_current_session = 1
vim.g.tslime_always_current_window = 1
vim.keymap.set('n', '<leader>t', ':TestNearest<CR>', { silent = true })
vim.keymap.set('n', '<leader>T', ':TestFile<CR>', { silent = true })
vim.keymap.set('n', '<leader>a', ':TestSuite<CR>', { silent = true })
vim.keymap.set('n', '<leader>l', ':TestLast<CR>', { silent = true })
vim.keymap.set('n', '<leader>g', ':TestVisit<CR>', { silent = true })

-- Backup/swap directories
vim.opt.backup = true
vim.opt.backupdir = { '~/.vim-tmp', '~/.tmp', '~/tmp', '/var/tmp', '/tmp' }
vim.opt.directory = { '~/.vim-tmp', '~/.tmp', '~/tmp', '/var/tmp', '/tmp' }

-- Show whitespace characters
vim.opt.list = true
vim.opt.listchars = { tab = '>-', trail = '.' }

-- Allow unsaved buffers in background
vim.opt.hidden = true

-- Navigate autocomplete list with C-j/C-k
vim.keymap.set('i', '<C-j>', function()
  return vim.fn.pumvisible() == 1 and '<C-n>' or '<C-j>'
end, { expr = true })
vim.keymap.set('i', '<C-k>', function()
  return vim.fn.pumvisible() == 1 and '<C-p>' or '<C-k>'
end, { expr = true })

-- Double tab to autocomplete
vim.keymap.set('i', '<tab><tab>', '<c-x><c-o>')

-- FZF
vim.env.FZF_DEFAULT_COMMAND = 'ag -g ""'
vim.opt.rtp:append('/usr/local/opt/fzf')
