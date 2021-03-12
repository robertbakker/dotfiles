set nocompatible
set guioptions+=m
set tabstop=2
set shiftwidth=2
set expandtab
set ignorecase
set smartcase
set background=dark 
set clipboard+=unnamedplus

filetype plugin indent on
let g:netrw_liststyle = 3
let g:netrw_banner = 0
syntax enable

" Ensure vim splits the screen horizontally below the current window
set splitbelow

" -------------------------------------------------------------
"  LAYOUT
" -------------------------------------------------------------
" Show linenumbers
set number

" Beautiful line number gutter
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

" -------------------------------------------------------------
"  PLUGINS
" -------------------------------------------------------------
call plug#begin()

" Give each bracket it's own color
Plug 'luochen1990/rainbow'

" Vim color scheme reproduction of the official JetBrains IDE Darcula theme
Plug 'doums/darcula'

" Sensible defaults which everyone can agree on
Plug 'tpope/vim-sensible'

" Fuzzy file finding
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" PHP formatting
Plug 'stephpy/vim-php-cs-fixer'

" Show a status bar with useful information
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Hard mode
Plug 'takac/vim-hardtime'

" Add better Go support
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Close window without closing buffer
Plug 'rbgrouleff/bclose.vim'

" Show git difference in the 'gutter'
if has('nvim') || has('patch-8.0.902')
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif

" Git wrapper for Vim
Plug 'tpope/vim-fugitive'

" Comment stuff out
Plug 'tpope/vim-commentary'

" Language Server Protocol Client
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Tab Nine Autocomplete
Plug 'zxqfl/tabnine-vim'

" Show / highlight cursor line
Plug 'miyakogi/conoline.vim'

" Faster HTML typing
Plug 'mattn/emmet-vim'

call plug#end()

" -------------------------------------------------------------
"  COC CONFIGURATION 
" -------------------------------------------------------------
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> <F2> <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" -------------------------------------------------------------
" CONOLINE CONFIG 
" -------------------------------------------------------------
let g:conoline_auto_enable = 1

" -------------------------------------------------------------
"  AIRLINE CONFIG 
" -------------------------------------------------------------
" let g:airline_theme = 'ravenpower'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" -------------------------------------------------------------
"  COLOR SCHEME
" -------------------------------------------------------------
colorscheme darcula 
" This is only necessary if you use "set termguicolors".
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" fixes glitch? in colors when using vim with tmux
set background=dark
set t_Co=256

if (has("termguicolors"))
  set termguicolors
endif 

" -------------------------------------------------------------
"  RAINBOW CONFIG
" -------------------------------------------------------------
let g:rainbow_active = 1

" -------------------------------------------------------------
"  SIGNIFY CONFIG
" -------------------------------------------------------------
set updatetime=100

" -------------------------------------------------------------
"  KEY MAPPINGS 
" -------------------------------------------------------------

" CTRL+P to open files
nnoremap <C-p> :FZF<Enter>

" Leader L to format code
nnoremap <leader>l :Format<Enter>

" Turn off arrow keys
map         <Left>  <Nop>
imap        <Left>  <Nop>
map         <Right> <Nop>
imap        <Right> <Nop>
map         <Up>    <Nop>
imap        <Up>    <Nop>
map         <Down>  <Nop>
imap        <Down>  <Nop>

" Vim emmet TAB expansion
imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

" Escape terminal with ESC and properly close FZF (cancellation)
" https://github.com/junegunn/fzf.vim/issues/544
if has("nvim")
  au TermOpen * tnoremap <buffer> <Esc> <C-\><C-n>
  au FileType fzf tunmap <buffer> <Esc>
endif

" Comment out stuff
imap <C-_> <ESC>:Commentary<cr>
vmap <C-_> :Commentary<cr>
map <C-_> :Commentary<cr>

" -------------------------------------------------------------
"  CUSTOM COMMANDS
" -------------------------------------------------------------

" Close buffer without closing window
command! Bd bp|bd #

autocmd BufNewFile,BufRead *.hcl set filetype=hcl
autocmd BufNewFile,BufRead *.pkr.hcl set filetype=hcl

" HARD MODE ON
" let g:hardtime_default_on = 1

" Define W as write command because I keep accidentally typing it when doing :w
command! W :w

" No Ex mode plz
map q: <Nop>
nnoremap Q <nop>

" Manual trigger COC autocomplete
inoremap <silent><expr> <C-k> coc#refresh()
