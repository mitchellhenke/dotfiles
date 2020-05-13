call plug#begin('~/.config/nvim/plugged')
 Plug 'ElmCast/elm-vim'
 Plug 'junegunn/fzf.vim'
 Plug 'mileszs/ack.vim'
 Plug 'Raimondi/delimitMate'
 Plug 'AndrewRadev/splitjoin.vim'
 Plug 'tpope/vim-commentary'
 Plug 'keith/swift.vim'
 Plug 'elixir-lang/vim-elixir'
 Plug 'leafgarland/typescript-vim'
 Plug 'tpope/vim-endwise'
 Plug 'tpope/vim-fugitive'
 Plug 'tpope/vim-repeat'
 Plug 'tpope/vim-sleuth'
 Plug 'tpope/vim-surround'
 Plug 'christoomey/vim-tmux-navigator', {'commit': 'c33a8a97028cac38040f1b8d9292337104026ad6' }
 Plug 'janko-m/vim-test'
 Plug 'jgdavey/tslime.vim'
 Plug 'tpope/vim-rhubarb'
 Plug 'prabirshrestha/async.vim'
 Plug 'prabirshrestha/vim-lsp'
 Plug 'prabirshrestha/asyncomplete-lsp.vim'
 " Plug 'Shougo/echodoc.vim'
call plug#end()

let g:loaded_python_provider = 1
let g:loaded_python3_provider = 1
let g:loaded_ruby_provider = 1
let g:loaded_node_provider = 1
" let g:python3_host_prog = '/usr/local/bin/python3'
" let g:pythonx_host_prog = '/usr/local/bin/python3'
" let g:python_host_prog = '/usr/local/bin/python2'

" set pyxversion=3
let ruby_no_expensive = 1

" WHO TF knows
" Disable showing completion preview at the top
set completeopt-=preview

au User lsp_setup call lsp#register_server({
      \   'name': 'elixir-ls',
      \   'cmd': {server_info->['/Users/mitchellhenke/.config/elixir-ls/language_server.sh']},
      \   'whitelist': ['elixir'],
      \ })
nnoremap gQ :LspDocumentFormat<CR>
nnoremap <C-]> :LspDefinition<CR>
set keywordprg=:LspHover
set omnifunc=lsp#complete
let g:lsp_diagnostics_enabled = 0         " disable diagnostics support

set termguicolors
set background=light
colorscheme NeoSolarized

nmap ; :Buffers<CR>
nmap <silent> <C-p> :Files<CR>
nmap <leader>f :Tags<CR>

" Toggle paste mode
" DISABLING FOR NOW
" nmap <silent> ,p :set invpaste<CR>:set paste?<CR>

" System default for mappings is now the "," character
let mapleader = ","
let maplocalleader = ";"

" Shows line numbers to the left
set number

" Add the unnamed register to the clipboard
set clipboard=unnamed
" set clipboard+=unnamedplus

" remove trailing whitespace in a file with <leader>w
nmap <silent> <leader>w :%s/\s\+$//e<CR>

" ignore case on search
set ignorecase
set smartcase

" Hide the mouse pointer while typing
set mousehide

" Automatically read a file that has changed on disk
set autoread

" Enable autoindent
set autoindent

if executable('rg')
  set grepprg=rg\ --color=never

  let g:ackprg = 'rg --vimgrep --no-heading --smart-case'
elseif executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" make backspace work correctly
set backspace=indent,eol,start

" matches for insert mode completion
set complete-=i
"
" use spaces for <Tab> when appropriate
set smarttab

" hit ;; to go to normal mode
imap ;; <esc>

" <leader> <leader> to go to previous file
nnoremap <leader><leader> <c-^>

map <leader>e :edit %%
map <leader>v :view %%

" When the page starts to scroll, keep the cursor 8 lines from the top and 8
" lines from the bottom
set scrolloff=8

" time between multi-key macro in milliseconds
set timeoutlen=300
" some other time
set ttimeoutlen=10

" Keep some stuff in the history
set history=20

" Replace word with yanked text
nnoremap S diw"0P
" run vim-test tests in neovim
let test#strategy = 'tslime'
let g:tslime_always_current_session = 1
let g:tslime_always_current_window = 1
" vim-test macros
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

" enable deoplete
" let g:deoplete#enable_at_startup = 1

" Keep temp/swap files away from working directories
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

set list
set listchars=tab:>-,trail:.

" Make sure that unsaved buffers that are to be put in the background are
" allowed to go in there (ie. the "must save first" error doesn't come up)
set hidden

" %% to insert current file's directory path in command
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:p:h').'/' : '%%'
" cnoremap <expr> %% expand("%:p:h") . "/"<CR>

" Navigate autocomplete list with j and k
inoremap <expr> <C-j> ((pumvisible())?("\<C-n>"):("\<C-j>"))
inoremap <expr> <C-k> ((pumvisible())?("\<C-p>"):("\<C-k>"))

" map two tabs to autocomplete
imap <tab><tab> <c-x><c-o>

" format on save
let g:elm_format_autosave = 1
let g:elm_setup_keybindings = 1

let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" fzf location
set rtp+=/usr/local/opt/fzf

if has("autocmd")
  augroup filetype_elixir
    au!
    autocmd FileType elixir autocmd BufEnter * :syntax sync fromstart
  augroup END
endif

