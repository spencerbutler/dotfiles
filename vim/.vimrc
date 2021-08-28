silent! call plug#begin("~/.vim/plugged")
  Plug 'tpope/vim-sensible'
  Plug 'ap/vim-css-color'
  Plug 'vim-syntastic/syntastic'
  Plug '2072/PHP-Indenting-for-VIm'
  Plug 'rodjek/vim-puppet'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-syntastic/syntastic'
  Plug 'airblade/vim-gitgutter'
  Plug 'plasticboy/vim-markdown'
  Plug 'airblade/vim-gitgutter'
call plug#end()

colors ir_black
highlight link phpInterpSimpleError none
filetype plugin on
syntax on
colorscheme delek
set nocompatible
set hlsearch incsearch
set formatoptions+=nj
set mouse=a
set tabstop=2
set shiftwidth=2
set softtabstop=2
set smarttab
set autoindent
set magic
set encoding=utf8
set expandtab
set smarttab
set laststatus=2
set noswapfile
set nobackup
set nowb
set splitbelow
set splitright
set cmdheight=2
let g:netrw_silent=1
"this breaks with Xshell
"set statusline=%a\ %y\ %p%%\ %f\ %l\:%c\ \%=%q\ LINES:CUR\ %L\:%n\
set magic
" Maximum width of text that is being inserted.
set tw=0
" show tabs as characters. yuck
set list
set listchars=tab:>-
" This is required for powerline glyphs
set encoding=UTF8
" 256color terminal
set t_Co=256
set colorcolumn=80
set pastetoggle=<F2>
" enable mouse scolling/clicking in xterm
set mouse=ar mousemodel=extend
" tab complete path only up to the first match
set wildmode=longest,list,full
set wildmenu
" http://amix.dk/blog/post/19548
set undodir=~/.vim/undodir
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload
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
" If gitgutter makes us lag you can trade speed for accuracy
let g:gitgutter_realtime = 1000
let g:gitgutter_eager = 1000
"let g:gitgutter_enabled = 0
let g:gitgutter_updatetime = 1000
"To enable Just puppet-lint and disable the parser uncomment next line
"let g:syntastic_puppet_checkers=['puppetlint']
let mapleader="\<Space>"
" Powerline in vim with vim-airline
let g:airline_powerline_fonts = 1

highlight RedundantWhitespace ctermbg=darkred guibg=darkred ctermfg=White guifg=White
match RedundantWhitespace /\s\+$\|\t/
highlight ColorColumn ctermbg=DarkGray guibg=DarkGray ctermfg=White guifg=Black
highlight link phpInterpSimpleError none


" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
let mapleader="\<Space>"
" double <space> to clear highligt matches
nnoremap <silent> <Leader><Space> :nohlsearch<CR>


set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"""""""""""""
" REMAP
"""""""""""""
:map  <F9>  <Esc>:tabnew      <CR>
:map  <F10> <Esc>:tabclose    <CR>
:map  <F7> <Esc>:tabprevious <CR>
:map  <F8> <Esc>:tabnext     <CR>
:nmap <F9>  <Esc>:tabnew      <CR>
:nmap <F10> <Esc>:tabclose    <CR>
:nmap <F7> <Esc>:tabprevious <CR>
:nmap <F8> <Esc>:tabnext     <CR>
:imap <F9>  <Esc>:tabnew      <CR>
:imap <F10> <Esc>:tabclose    <CR>
:imap <F7> <Esc>:tabprevious <CR>
:imap <F8> <Esc>:tabnext     <CR>

" stop giving me carpal tunnel vim!
" replaces ctrl-w hjkl with ctrl-hjkl in split windows
:nnoremap <C-j> <C-w><C-j>
:nnoremap <C-k> <C-w><C-k>
:nnoremap <C-l> <C-w><C-l>
:nnoremap <C-h> <C-w><C-h>

" TODO Something is stealing this C-i. 
"ctrl+i for new tab
:nmap <C-i> :tabnew<CR>

" ctrl+n/p to switch tabs
:nmap <C-n> :tabn<CR>
:nmap <C-p> :tabp<CR>
" double <space> to clear highligt matches
:nnoremap <silent> <Leader><Space> :nohlsearch<CR>
" Elegant set paste
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" make shift+tab de-indent like on windows and notepad++
:nnoremap <TAB> >>
:nnoremap <S-TAB> <<
:vnoremap <TAB> >gv
:vnoremap <S-TAB> <gv

" enable xterm copying
:vmap <C-C> "+y

" ignore the case of files during tab completion while opening a file
if exists("&wildignorecase")
    set wildignorecase
endif

"au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
      \ if ! exists("g:leave_my_cursor_position_alone") |
      \     if line("'\"") > 0 && line ("'\"") <= line("$") |
      \         exe "normal! g'\"" |
      \     endif |
      \ endif

" highlight eyaml files as though they are regular yaml
au BufNewFile,BufRead *.eyaml set filetype=yaml

