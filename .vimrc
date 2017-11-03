set encoding=utf-8

call plug#begin('~/.vim/plugged')
  Plug 'itchyny/lightline.vim'
  Plug 'osyo-manga/vim-anzu'
  Plug 'tpope/vim-fugitive'
  Plug 'thinca/vim-quickrun'
  Plug 'Shougo/vimproc.vim', { 'do': 'make' }
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
  Plug 'scrooloose/nerdtree'
  Plug 'altercation/vim-colors-solarized'
  Plug 'mileszs/ack.vim'
  Plug 'fatih/vim-go'
  Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }
call plug#end()

let g:lightline = {
        \ 'colorscheme': 'solarized',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename', 'anzu' ] ]
        \ },
        \ 'component_function': {
        \   'modified': 'LightlineModified',
        \   'readonly': 'LightlineReadonly',
        \   'fugitive': 'LightlineFugitive',
        \   'filename': 'LightlineFilename',
        \   'fileformat': 'LightlineFileformat',
        \   'filetype': 'LightlineFiletype',
        \   'fileencoding': 'LightlineFileencoding',
        \   'mode': 'LightlineMode',
        \   'anzu': 'anzu#search_status'
        \ }
        \ }

function! LightlineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'RO' : ''
endfunction

function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' | ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
    return fugitive#head()
  else
    return ''
  endif
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

nmap n <Plug>(anzu-n)
nmap N <Plug>(anzu-N)
nmap * <Plug>(anzu-star)
nmap # <Plug>(anzu-sharp)

augroup anzu-update-search-status
  autocmd!
  autocmd CursorHold,CursorHoldI,WinLeave,TabLeave * call anzu#clear_search_status()
augroup END

set background=dark
colorscheme solarized

set cursorline
hi clear CursorLine
hi CursorLineNr ctermfg=136
set number
set showmatch matchtime=1
set list listchars=tab:>\ ,extends:<
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
set smartindent
set splitright
set splitbelow
set nobackup
set hlsearch
set incsearch
set ignorecase
set smartcase
set laststatus=2
set showcmd
set backspace=indent,eol,start
set scrolloff=3
set clipboard+=unnamed

let mapleader = "\<Space>"
let NERDTreeShowHidden=1

noremap <CR> o<Esc>
nnoremap <silent> j gj
nnoremap <silent> k gk
noremap <S-h> ^
noremap <S-j> }
noremap <S-k> {
noremap <S-l> $
nnoremap <Space>/  *
nnoremap <C-h> <C-w> h
nnoremap <C-j> <C-w> j
nnoremap <C-k> <C-w> k
nnoremap <C-l> <C-w> l
noremap <Space>s :%s/
nnoremap <silent> <Esc><Esc>  :<C-u>nohlsearch<CR>
nnoremap <Leader>b            :Buffers<CR>
nnoremap <Leader>ag           :Ag<CR>
nnoremap <Leader>f            :GFiles<CR>
nnoremap <Leader>d            :Gdiff<CR>
nnoremap <Leader>n            :NERDTreeToggle<CR>
nnoremap <Leader>q            :QuickRun<CR>
noremap <silent> <leader>e   :call fzf#run({
\   'down': '40%',
\   'sink': 'edit' })<CR>
nnoremap <silent> <Leader>f  :call fzf#run({
\   'down': '40%',
\   'sink': 'botright split' })<CR>
nnoremap <silent> <Leader>v   :call fzf#run({
\   'right': winwidth('.') / 2,
\   'sink':  'vertical botright split' })<CR>
cmap w!! w !sudo tee % > /dev/null

highlight Folded ctermfg=130 ctermbg=0

set t_Co=256
