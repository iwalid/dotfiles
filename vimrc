" Pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
execute pathogen#helptags()

" Then we begin the fun
syntax on
set mouse=a               " enable mouse support
set nocompatible          " disable compatibility with vi
set encoding=utf-8        " set encoding
set number                " show line numbers
set hidden                " hide buffers instead of closing them
filetype plugin indent on " identation

set synmaxcol=800         " don't try to highlight long lines
set ruler                 " show the cursor position all the time
set cursorline            " highlight current line of the cursor
set showcmd               " show partial commands below the status line
set shell=bash            " avoids munging PATH under zsh
let g:is_bash=1           " default shell syntax
set history=200           " remember more Ex commands
set scrolloff=3           " have some context around the current line always on screen

" Auto-reload buffers when file changed on disk
set autoread

" Disable swap files; systems don't crash that often these days
set updatecount=0
set nobackup
set noswapfile

" Make Vim able to edit crontab files again.
set backupskip=/tmp/*,/private/tmp/*"

" Whitespace
set tabstop=2                      " a tab is two spaces
set shiftwidth=2                   " an autoindent (with <<) is two spaces
set expandtab                      " use spaces, not tabs
set backspace=indent,eol,start     " backspace through everything in insert mode
autocmd BufWritePre * :%s/\s\+$//e " automatically remove whitespace upon save

" Show 80 characters marker
set colorcolumn=80

" Setting leader to comma
:let mapleader = ","

" Shortcuts
map <Leader>= yypVr=
map <Leader>- yypVr-
map <Leader>s :sort<CR>

" Disable arrow keys (get used to hjkl)
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Searching
set hlsearch                       " highlight matches
set incsearch                      " incremental searching
set ignorecase                     " searches are case insensitive...
set smartcase                      " ... unless they contain at least one capital letter
set gdefault                       " have :s///g flag by default on

" Time out on key codes but not mappings.
" Basically this makes terminal Vim work sanely.
set notimeout
set ttimeout
set ttimeoutlen=100

function! s:setupWrapping()
  set wrap
  set wrapmargin=2
  set textwidth=80
endfunction

augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!

  " Avoid showing trailing whitespace when in insert mode
  au InsertEnter * :set listchars-=trail:•
  au InsertLeave * :set listchars+=trail:•

  " Some file types use real tabs
  au FileType {make,gitconfig} set noexpandtab

  " Make sure all markdown files have the correct filetype set and setup wrapping
  au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setf markdown | call s:setupWrapping()

  " Treat JSON files like JavaScript
  au BufNewFile,BufRead *.json setf javascript

  " https://github.com/sstephenson/bats
  au BufNewFile,BufRead *.bats setf sh

  au BufNewFile,BufRead *.rl setfiletype ragel

  " make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
  au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

  " Remember last location in file, but not for commit messages.
  " see :help last-position-jump
  au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g`\"" | endif

  " mark Jekyll YAML frontmatter as comment
  au BufNewFile,BufRead *.{md,markdown,html,xml} sy match Comment /\%^---\_.\{-}---$/

  " magic markers: enable using `H/S/J/C to jump back to
  " last HTML, stylesheet, JS or Ruby code buffer
  au BufLeave *.{erb,html}      exe "normal! mH"
  au BufLeave *.{css,scss,sass} exe "normal! mS"
  au BufLeave *.{js,coffee}     exe "normal! mJ"
  au BufLeave *.{rb}            exe "normal! mC"
augroup END

" clear the search buffer when hitting ,/
nmap <silent> <Leader>/ :nohlsearch<CR>

" toggle the current fold
:nnoremap <Space> za

" yank to system clipboard
map <leader>y "*y

" paste lines from unnamed register and fix indentation
nmap <leader>p pV`]=
nmap <leader>P PV`]=

" <Tab> indents if at the beginning of a line; otherwise does completion
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

" ignore Rubinius, Sass cache files
set wildignore+=tmp/**,*.rbc,.rbx,*.scssc,*.sassc
" ignore Bundler standalone/vendor installs & gems
set wildignore+=bundle/**,vendor/bundle/**,vendor/cache/**,vendor/gems/**
set wildignore+=node_modules/**
" ignoring uneditable stuff
set wildignore=*.swp,*.bak,*.pyc,*.jar,*.gif,*.png,*.jpg
" settings ignores for NERDTree
let NERDTreeIgnore = ['\.pyc$']

" toggle between last open buffers
nnoremap <leader><leader> <c-^>

command! GdiffInTab tabedit %|vsplit|Gdiff
nnoremap <leader>d :GdiffInTab<cr>
nnoremap <leader>D :tabclose<cr>

" NERDTree mapping
autocmd vimenter * if !argc() | NERDTree | endif
set laststatus=2
map <C-n> :NERDTreeToggle<CR>

" Close vim if NERDTree is the last thing standing
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Adding django snippets (for SnipMate)
autocmd FileType python set ft=python.django
autocmd FileType html set ft=htmldjango.html

" Colors
:set t_Co=256
:set background=dark
:color railscasts
:set guifont=Monaco\ for\ Powerline:h13

" Airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
