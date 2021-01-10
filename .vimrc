" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
silent! call plug#begin("~/.vim/plugged")
  Plug 'tpope/vim-sensible'
  Plug 'ap/vim-css-color'
  Plug 'vim-syntastic/syntastic'
  Plug '2072/PHP-Indenting-for-VIm'
  Plug 'vim-scripts/phpfolding.vim'
call plug#end()
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
set statusline=%a\ %y\ %p%%\ %f\ %l\:%c\ \%=%q\ LINES:CUR\ %L\:%n\

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
let php_folding=0
let g:PHP_outdentphpescape = 0
let mapleader="\<Space>"
" double <space> to clear highligt matches
nnoremap <silent> <Leader><Space> :nohlsearch<CR>

" stop giving me carpal tunnel vim!
" replaces ctrl-w hjkl with ctrl-hjkl in split windows
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
"ctrl+i for new tab
nmap <C-i> :tabnew<CR>
" ctrl+n/p to switch tabs
nmap <C-n> :tabn<CR>
nmap <C-p> :tabp<CR>

" fold that shit up!
" but not by default...
let g:DisableAutoPHPFolding = 1
set foldmethod=syntax
set foldcolumn=1
set foldlevelstart=99
map <F5> <Esc>:EnableFastPHPFolds<Cr>
map <F6> <Esc>:EnablePHPFolds<Cr>
map <F7> <Esc>:DisablePHPFolds<Cr>

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Elegant set paste
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" figure out what is highlighting that annoying thing you hate
nm <silent> <F1> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name")
    \ . '> trans<' . synIDattr(synID(line("."),col("."),0),"name")
    \ . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")
    \ . ">"<CR>
