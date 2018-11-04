set encoding=utf-8
filetype off
filetype plugin indent off

call plug#begin('~/.vim/plugged')
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
  Plug 'osyo-manga/vim-anzu'
  Plug 'tpope/vim-fugitive'
  Plug 'scrooloose/nerdtree'
  Plug 'mileszs/ack.vim'
  Plug 'airblade/vim-gitgutter'
  Plug 'altercation/vim-colors-solarized'
  Plug 'tpope/vim-surround'
  Plug 'cohama/lexima.vim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'bronson/vim-trailing-whitespace'
  Plug 'houtsnip/vim-emacscommandline'
  Plug 'thinca/vim-zenspace'
  Plug 'fatih/vim-go'
call plug#end()

let g:fzf_layout = { 'down': '~30%' }
let g:fzf_prefer_tmux = 1

nmap n <Plug>(anzu-n)
nmap N <Plug>(anzu-N)
nmap * <Plug>(anzu-star)
nmap # <Plug>(anzu-sharp)

augroup anzu-update-search-status
  autocmd!
  autocmd CursorHold,CursorHoldI,WinLeave,TabLeave * call anzu#clear_search_status()
augroup END

syntax enable
set background=dark
colorscheme solarized

set cursorline
hi clear CursorLine
hi CursorLineNr ctermfg=136
set number
set showmatch matchtime=1
set list listchars=tab:>\ ,extends:<
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set autoindent
set smartindent
set splitright
set splitbelow
set nobackup
set noswapfile
set hlsearch
set hidden
set incsearch
set ignorecase
set smartcase
set laststatus=2
set showcmd
set backspace=indent,eol,start
set scrolloff=3
set clipboard=unnamed,autoselect
set showtabline=2
set vb t_vb=
set list listchars=tab:\▸\-

let mapleader = "\<Space>"
let NERDTreeShowHidden=1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'solarized'

nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <Space>s :%s/
nnoremap <Space>/ *
nnoremap <Space>a :Ag<CR>
nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>
nnoremap <C-p> :Files<CR>
nnoremap t :Files<CR>
nnoremap ; :Buffers<CR>
nnoremap r :Tags<CR>
nnoremap <Leader>d :Gdiff<CR>
nnoremap <Leader>n :NERDTreeToggle<CR>
nnoremap <silent> <Space><Space> "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>
inoremap <C-e> <END>
inoremap <C-a> <HOME>
cmap w!! w !sudo tee % > /dev/null

set t_Co=256
highlight Folded ctermfg=130 ctermbg=0
set secure

let g:toggle_window_size = 0
function! ToggleWindowSize()
  if g:toggle_window_size == 1
    exec "normal \<C-w>="
    let g:toggle_window_size = 0
  else
    :resize
    :vertical resize
    let g:toggle_window_size = 1
  endif
endfunction
nnoremap <Leader>m :call ToggleWindowSize()<CR>

filetype plugin indent on
