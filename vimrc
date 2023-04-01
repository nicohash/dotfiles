" Turn syntax highlighting on.
syntax on
" Add numbers to each line on the left-hand side.
set number
" Highlight cursor line underneath the cursor horizontally.
set cursorline


" Use space characters instead of tabs.
set expandtab
" Set tab width to 4 columns.
set tabstop=4
" Do not wrap lines.
set nowrap
" Set the commands to save in history to 1000.
set history=1000
" Set colors for colorscheme
set termguicolors

" Add vim plugin manager
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Install plugins
call plug#begin()
Plug 'overcache/NeoSolarized'
call plug#end()

" Set colorscheme
colorscheme NeoSolarized