" Vim Configuration

" Install vim-plug if not already installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin('~/.vim/plugged')

" Distraction-free writing
Plug 'junegunn/goyo.vim'

call plug#end()

" Basic settings
syntax on
set number
set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent

" Goyo settings (optional customization)
" Toggle Goyo with <Leader>g
nnoremap <Leader>g :Goyo<CR>
