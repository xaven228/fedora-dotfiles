set nocompatible
filetype plugin indent on
syntax on

set encoding=utf-8
set fileencoding=utf-8
set number
set relativenumber
set cursorline
set hidden
set nowrap
set mouse=a
set clipboard=unnamedplus
set scrolloff=8
set sidescrolloff=8
set updatetime=300
set signcolumn=yes

set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set autoindent

set ignorecase
set smartcase
set incsearch
set hlsearch

set nobackup
set nowritebackup
set noswapfile

set termguicolors
set background=dark

let mapleader=" "

call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" ---------- NERDTree ----------
nnoremap <leader>e :NERDTreeToggle<CR>
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeWinSize = 30

" ---------- FZF ----------
nnoremap <leader>f :Files<CR>
nnoremap <leader>g :Rg<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>h :History<CR>

" ---------- Airline ----------
let g:airline_powerline_fonts = 1
let g:airline_theme = 'dark'

" ---------- Coc.nvim ----------
set completeopt=menuone,noinsert,noselect

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gy <Plug>(coc-type-definition)
nnoremap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> gr <Plug>(coc-references)
nnoremap <leader>rn <Plug>(coc-rename)
nnoremap <leader>ac  <Plug>(coc-codeaction)
nnoremap <leader>qf  <Plug>(coc-fix-current)

nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    execute 'h ' . expand('<cword>')
  endif
endfunction

augroup mygroup
  autocmd!
  autocmd CursorHold * silent call CocActionAsync('highlight')
augroup end

" ---------- Git / Fugitive ----------
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gd :Gdiffsplit<CR>
nnoremap <leader>gb :Git blame<CR>

" ---------- Полезные клавиши ----------
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>x :wq<CR>
nnoremap <leader>nh :nohlsearch<CR>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
