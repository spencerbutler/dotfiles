silent! call plug#begin("~/.vim/plugged")
  Plug 'tpope/vim-sensible'
  Plug 'ap/vim-css-color'
  Plug 'vim-syntastic/syntastic'
  Plug 'rodjek/vim-puppet'
  Plug 'vim-airline/vim-airline'
  Plug 'plasticboy/vim-markdown'
call plug#end()

colors ir_black
filetype plugin on
syntax on
set hlsearch incsearch
set tabstop=2
set shiftwidth=2
set softtabstop=2
set smarttab
set autoindent
set magic
set encoding=utf8
set expandtab
set smarttab
set noswapfile
set nobackup
set nowb
set splitbelow
set splitright
let g:netrw_silent=1
set magic
" This is required for powerline glyphs
set encoding=UTF8
" 256color terminal
set t_Co=256
set pastetoggle=<F2>
" enable mouse scolling/clicking in xterm
set mouse=ar mousemodel=extend
" tab complete path only up to the first match
set wildmode=longest,list,full
set wildmenu
" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_puppet_checkers = ['puppet', 'puppetlint']
let g:syntastic_puppet_puppetlint_args = '--no-80chars-check'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1
let g:syntastic_enable_signs=1
let g:airline_powerline_fonts=1
let g:vim_markdown_folding_disabled=1
let mapleader="\<Space>"
" Powerline in vim with vim-airline
let g:airline_powerline_fonts = 1

highlight RedundantWhitespace ctermbg=darkred guibg=darkred ctermfg=White guifg=White
match RedundantWhitespace /\s\+$\|\t/
highlight ColorColumn ctermbg=DarkGray guibg=DarkGray ctermfg=White guifg=Black
highlight link phpInterpSimpleError none


" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" highlight eyaml files as though they are regular yaml
au BufNewFile,BufRead *.eyaml set filetype=yaml

"""""""""""""
" REMAP
"""""""""""""
" stop giving me carpal tunnel vim!
" replaces ctrl-w hjkl with ctrl-hjkl in split windows
:nnoremap <C-j> <C-w><C-j>
:nnoremap <C-k> <C-w><C-k>
:nnoremap <C-l> <C-w><C-l>
:nnoremap <C-h> <C-w><C-h>
" double <space> to clear highligt matches
nnoremap <silent> <Leader><Space> :nohlsearch<CR>
"ctrl+i for new tab
:nmap <C-i> :tabnew<CR>
" ctrl+n/p to switch tabs
:nmap <C-n> :tabn<CR>
:nmap <C-p> :tabp<CR>
" ignore the case of files during tab completion while opening a file
if exists("&wildignorecase")
    set wildignorecase
endif

