call plug#begin('~/.vim/plugged')
  Plug 'tpope/vim-sensible'
  Plug 'ap/vim-css-color'
  Plug 'vim-syntastic/syntastic'
  Plug 'mattn/emmet-vim'
  Plug '2072/PHP-Indenting-for-VIm'
  Plug 'vim-scripts/phpfolding.vim'
call plug#end()
syntax on
colorscheme delek
set hlsearch incsearch
set formatoptions+=nj
set mouse-=a
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

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
let g:user_emmet_leader_key=','                                                                                                                                                                                    
let php_folding=0
let g:user_emmet_mode='a' 
let g:PHP_outdentphpescape = 0
"let mapleader = ","
let mapleader="\<Space>"
" double <space> to clear highligt matches
nnoremap <silent> <Leader><Space> :nohlsearch<CR>

" stop giving me carpal tunnel vim!
" replaces ctrl-w hjkl with ctrl-hjkl in split windows
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
"ctrl+n for new tab
nmap <C-i> :tabnew<CR>
" ctrl+l/h to switch tabs
nmap <C-n> :tabn<CR>
nmap <C-p> :tabp<CR>

" fold that shit up!
set foldmethod=syntax
set foldcolumn=1
set foldlevelstart=99
map <F5> <Esc>:EnableFastPHPFolds<Cr>
map <F6> <Esc>:EnablePHPFolds<Cr>
map <F7> <Esc>:DisablePHPFolds<Cr>

let g:user_emmet_settings = {
  \  'php' : {
  \    'extends' : 'html',
  \    'filters' : 'c',
  \  },
  \  'xml' : {
  \    'extends' : 'html',
  \  },
  \  'haml' : {
  \    'extends' : 'html',
  \  },
  \}
