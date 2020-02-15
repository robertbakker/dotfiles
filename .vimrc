set nocompatible

set tabstop=2
set shiftwidth=2
set expandtab

syntax on

" Ensure vim splits the screen horizontally below the current window
set splitbelow

" Show linenumbers
set number

" Beautiful line number gutter
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

" -------------------------------------------------------------
"  PLUGINS
" -------------------------------------------------------------
call plug#begin()
" Sensible defaults which everyone can agree on
Plug 'tpope/vim-sensible'

" Fuzzy file finding
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Automatically create matching brackets
Plug 'jiangmiao/auto-pairs'

" Show a status bar with useful information
Plug 'vim-airline/vim-airline'

" Add ranger file exploring
Plug 'francoiscabrol/ranger.vim'

" Close window without closing buffer
Plug 'rbgrouleff/bclose.vim'

" Show git difference in the 'gutter'
Plug 'airblade/vim-gitgutter'

call plug#end()

" -------------------------------------------------------------
"  KEY MAPPINGS 
" -------------------------------------------------------------
" CTRL+P to open files
nnoremap <C-p> :FZF<Enter>
