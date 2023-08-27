" Plugins {{{
" Install vim-plug if not found
if (empty(glob('~/.vim/autoload/plug.vim')))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif
call plug#begin()
Plug 'tomtom/tcomment_vim'
Plug 'flazz/vim-colorschemes'
call plug#end()
" }}}
" Colors {{{
syntax on
filetype on
colorscheme PaperColor
set background=dark
" }}}
" Tabs & Indentation {{{
set tabstop=2		  " # of visual spaces per TAB
set shiftwidth=2	" # of spaces in a TAB
set expandtab		  " tabs are spaces
set autoindent
set smartindent
" }}}
" UI Config {{{
set number		    " line numbers
set showcmd		    " show command in bottom bar
set wildmenu		  " visual autocomplete for cmd menu
set lazyredraw		" redraw only when needed
set showmatch		  " highlight matching [{()}]
" autocomplete {}
inoremap {<CR> {<CR>}<ESC><UP>o
" Uncomment to automatically remove trailing whitespace
" (may be a bad idea)
" autocmd BufWritePre *.c,*.cc,*.cpp,*.py %s/\s\+$//ge
" }}}
" Searching {{{
set incsearch		  " incremental search
set hlsearch		  " highlight matches
set ignorecase
set smartcase
" }}}
" Folding {{{
set foldenable
set foldlevelstart=10
set foldmethod=indent
" }}}
" Windows {{{
set splitbelow    " split window below
set splitright    " split window right
" }}}
set history=10000

" Uncomment the following to have Vim jump to the last position when
" reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Preserve undo history across open/close (thanks wcf)
silent !mkdir ~/.vim/undodir > /dev/null 2>&1
set undofile
set undodir=~/.vim/undodir

" Delete undo files older than 90 days
let s:undos = split(globpath(&undodir, '*'), "\n")
call filter(s:undos, 'getftime(v:val) < localtime() - (60 * 60 * 24 * 90)')
call map(s:undos, 'delete(v:val)')

" Multipurpose Tab Key (courtesy of Gary Bernhardt)
" Indents if we're at the beginning of a line.
" Otherwise, does completion.
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>
