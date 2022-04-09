set nocompatible
filetype off

call plug#begin()

Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/vim-emoji'
Plug 'scrooloose/nerdtree'
Plug 'connorholyday/vim-snazzy'
Plug 'arcticicestudio/nord-vim'

call plug#end()


set tabstop=2

colorscheme snazzy
colorscheme nord

hi Normal guibg=NONE ctermbg=NONE
highlight VertSplit ctermbg=NONE guibg=NONE
highlight VertSplit ctermfg=NONE
highlight VertSplit cterm=NONE
highlight clear SignColumn


let mapleader = ";"

set mouse=a
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab


" Emojis
" ---

if emoji#available()
  let g:gitgutter_sign_added = emoji#for('small_blue_diamond')
  let g:gitgutter_sign_modified = emoji#for('small_orange_diamond')
  let g:gitgutter_sign_removed = emoji#for('small_red_triangle')
  let g:gitgutter_sign_modified_removed = emoji#for('collision')
endif

" Remappings
" ---

inoremap ;; <Esc>
nnoremap <silent> <Space> :NERDTreeToggle<CR>
