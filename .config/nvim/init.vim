call plug#begin('~/.config/nvim/plugged')
 Plug 'junegunn/fzf.vim'
 Plug 'mileszs/ack.vim'
 Plug 'Raimondi/delimitMate'
 Plug 'AndrewRadev/splitjoin.vim'
 Plug 'tpope/vim-commentary'
 Plug 'keith/swift.vim'
 Plug 'elixir-lang/vim-elixir'
 Plug 'tpope/vim-endwise'
 Plug 'tpope/vim-fugitive'
 Plug 'tpope/vim-repeat'
 Plug 'tpope/vim-sleuth'
 Plug 'tpope/vim-surround'
 Plug 'christoomey/vim-tmux-navigator', {'commit': 'c33a8a97028cac38040f1b8d9292337104026ad6' }
 Plug 'janko-m/vim-test'
 Plug 'jgdavey/tslime.vim'
 Plug 'tpope/vim-rhubarb'

 " Plug 'prabirshrestha/asyncomplete.vim'
 " Plug 'prabirshrestha/async.vim'
 " Plug 'prabirshrestha/vim-lsp'
 " Plug 'prabirshrestha/asyncomplete-lsp.vim'

 Plug 'neovim/nvim-lsp'
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

lua << END
  require'nvim_lsp'.solargraph.setup{}

  do
    local method = "textDocument/publishDiagnostics"
    local default_callback = vim.lsp.callbacks[method]
    vim.lsp.callbacks[method] = function(err, method, result, client_id)
      default_callback(err, method, result, client_id)
      if result and result.diagnostics then
        for _, v in ipairs(result.diagnostics) do
          v.filename = result.uri
          v.module = string.sub(result.uri, -20)
          v.lnum = v.range.start.line + 1
          v.col = v.range.start.character + 1
          v.text = v.message
        end
        vim.lsp.util.set_qflist(result.diagnostics)
      end
    end
  end

  require'nvim_lsp'.elixirls.setup {
    cmd = { "/Users/mitchellhenke/.config/elixir-ls/language_server.sh" };
    settings = {
    }
  }

END

nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
set omnifunc=v:lua.vim.lsp.omnifunc

" WHO TF knows
" Disable showing completion preview at the top
" set completeopt-=preview

" au User lsp_setup call lsp#register_server({
"       \   'name': 'elixir-ls',
"       \   'cmd': {server_info->['/Users/mitchellhenke/.config/elixir-ls/language_server.sh']},
"       \   'whitelist': ['elixir'],
"       \ })
" nnoremap gQ :LspDocumentFormat<CR>
" nnoremap <C-]> :LspDefinition<CR>
" set keywordprg=:LspHover
" set omnifunc=lsp#complete
" let g:lsp_diagnostics_enabled = 0         " disable diagnostics support

set background=light
colorscheme solarized

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

let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" fzf location
set rtp+=/usr/local/opt/fzf

" if has("autocmd")
"   augroup filetype_elixir
"     au!
"     autocmd FileType elixir autocmd BufEnter * :syntax sync fromstart
"   augroup END
" endif
