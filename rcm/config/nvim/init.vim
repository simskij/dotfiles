set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugins
" ---

Plugin 'moll/vim-node'
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'fatih/vim-go'
Plugin 'airblade/vim-gitgutter'
Plugin 'junegunn/vim-emoji'
Plugin 'haya14busa/vim-keeppad'
Plugin 'scrooloose/nerdtree'
Plugin 'connorholyday/vim-snazzy'
Plugin 'arcticicestudio/nord-vim'
Plugin 'mhinz/vim-startify'
Plugin 'rhysd/git-messenger.vim'
Plugin 'prettier/prettier'
Plugin 'tpope/vim-fugitive'
Plugin 'kien/ctrlp.vim'
Plugin 'mattn/emmet-vim'
Plugin 'JamshedVesuna/vim-markdown-preview'

call vundle#end()
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


map <leader>t :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
:syntax on

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set tabstop=2

colorscheme snazzy
colorscheme nord

hi Normal guibg=NONE ctermbg=NONE
highlight VertSplit ctermbg=NONE
highlight VertSplit ctermfg=NONE
highlight VertSplit cterm=NONE

let g:startify_custom_header =
            \ 'startify#center(startify#fortune#cowsay())'

let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0
