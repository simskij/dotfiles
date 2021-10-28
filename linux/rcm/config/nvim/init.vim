set nocompatible
filetype off

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'moll/vim-node'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'HendrikPetertje/vimify'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'for': ['go', 'markdown'] }

Plug 'airblade/vim-gitgutter'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/vim-emoji'
Plug 'haya14busa/vim-keeppad'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle'] }
Plug 'connorholyday/vim-snazzy'
Plug 'arcticicestudio/nord-vim'
Plug 'mhinz/vim-startify'
Plug 'rhysd/git-messenger.vim'
Plug 'prettier/prettier'
Plug 'tpope/vim-fugitive'
Plug 'kien/ctrlp.vim', {'on': ['CtrlP', 'CtrlPMixed', 'CtrlPMRU']}
Plug 'mattn/emmet-vim'
Plug 'JamshedVesuna/vim-markdown-preview', {'for': ['markdown']}
Plug 'eliba2/vim-node-inspect'
Plug 'wellle/context.vim'
Plug 'Valloric/YouCompleteMe'


call plug#end()

filetype plugin indent on


" Misc
" ---

let mapleader = ","
set mouse=a
" Emojis
" ---
if emoji#available()
  let g:gitgutter_sign_added = emoji#for('small_blue_diamond')
  let g:gitgutter_sign_modified = emoji#for('small_orange_diamond')
  let g:gitgutter_sign_removed = emoji#for('small_red_triangle')
  let g:gitgutter_sign_modified_removed = emoji#for('collision')
endif

set number

nnoremap <leader>f :CtrlP<CR>
nnoremap <leader>m :CtrlPMixed<CR>
nnoremap <leader>r :CtrlPMRU<CR>

map <leader>t :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
:syntax on

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! CurrentlyPlaying()
  return system("~/.config/nvim/spotify.sh | tr -d '\n'")
endfunction


set tabstop=2

colorscheme snazzy
colorscheme nord

hi Normal guibg=NONE ctermbg=NONE
highlight VertSplit ctermbg=NONE guibg=NONE
highlight VertSplit ctermfg=NONE
highlight VertSplit cterm=NONE
highlight clear SignColumn

let g:startify_custom_header =
            \ 'startify#center(startify#fortune#cowsay())'

let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0

let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

let g:airline#extensions#tabline#enabled=1
