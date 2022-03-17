" Base of init.vim from https://gist.github.com/rohitfarmer/68cdadeaeeb196e8a6ecdebdee6e76a5

let g:python3_host_prog="C:\\Users\\mlillstr\\AppData\\Local\\Programs\\Python\\Python38\\python.exe"

" Set a Local Leader
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = " "

call plug#begin(stdpath('data') . '/plugged')

Plug 'jalvesaq/Nvim-R', { 'branch': 'auto-list'}
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'preservim/nerdtree'
Plug 'Raimondi/delimitMate'
Plug 'patstockwell/vim-monokai-tasty'
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'gaalcaras/ncm-R', { 'branch': 'auto-list'}
Plug 'junegunn/vim-easy-align'
Plug 'machakann/vim-sandwich'
Plug 'sirver/UltiSnips'
Plug 'ncm2/ncm2-ultisnips'
Plug 'axvr/zepl.vim'
Plug 'Yggdroot/indentLine'
Plug 'mattn/emmet-vim'
Plug 'numirias/semshi'
Plug 'tpope/vim-fugitive'
Plug 'davidhalter/jedi-vim'
Plug 'michaeljsmith/vim-indent-object' 
call plug#end()

let $PATH = "c:\\Rtools\\usr\\bin;c:\\Rtools\\mingw64\\bin;" . $PATH

" automatically enter input mode when entering console
autocmd BufWinEnter,WinEnter term://* startinsert
tnoremap <Esc> <C-\><C-n> " easy escape from console insert

" move between splits
nnoremap <C-1> <C-w>k
tmap <C-1> <Esc><C-w>k
nnoremap <C-2> <C-w>j

" faster scrolling
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>

" remember folds between sessions
" au BufWinLeave * mkview
" au BufWinEnter * silent loadview

" dont accidentally lowercase visual selections
vmap u <Nop>

" Plugin Related Settings

" Don't let nvim-R do "<-" when typing "_"
let R_assign = 0

"ctrl enter runs selection
xmap <C-cr> <Plug>RSendSelection<cr>
nnoremap <C-cr> :call SendLineToR("down")<cr>0

" EASY ALIGN:
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" NCM2
autocmd BufEnter * call ncm2#enable_for_buffer()    " To enable ncm2 for all buffers.
set completeopt=noinsert,menuone,noselect           " :help Ncm2PopupOpen for more
                                                    " informatio

" ULTISNIPS
" let g:UltiSnipsExpandTrigger="<tab>" " Open snippets by tab
 " inoremap <tab> <C-x><C-o> " Open suggestions with tab

" Use <TAB> to select the popup menu:

function! Smart_TabComplete()
        if (pumvisible())
                return"\<C-n>"
        endif

        let line   = getline('.')
        let substr = strpart(line, -1, col('.')+1)
        let substr = matchstr(substr, "^[^ \t]*$")

        if (strlen(substr)==0)
                return"\<tab>"
        else
                return"\<C-x>\<C-o>"
        endif
endfunction

inoremap <expr> <Tab> Smart_TabComplete()
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" NERD Tree
nmap <leader>nn :NERDTreeToggle<CR>                  " Toggle NERD tree.

" gruvbox 
let g:gruvbox_contrast_light = 'soft'
let g:gruvbox_contrast_dark = 'soft'
colorscheme gruvbox                       " Enable gruvbox theme.

" LightLine.vim 
set laststatus=2              " To tell Vim we want to see the statusline.
let g:lightline = {
   \ 'colorscheme':'gruvbox',
   \ }

set hidden                    " To allow moving between buffers without saving

" General NVIM/VIM Settings

" Mouse Integration
set mouse=i                   " Enable mouse support in insert mode.

" Tabs & Navigation
map <leader>nt :tabnew<cr>    " To create a new tab.
map <leader>to :tabonly<cr>     " To close all other tabs (show only the current tab).
map <leader>tc :tabclose<cr>    " To close the current tab.
map <leader>tm :tabmove<cr>     " To move the current tab to next position.
map <leader>tn :tabn<cr>        " To swtich to next tab.
map <leader>tp :tabp<cr>        " To switch to previous tab.


" Line Numbers & Indentation
set backspace=indent,eol,start  " To make backscape work in all conditions.
set ma                          " To set mark a at current cursor location.
set number                      " To switch the line numbers on.
set relativenumber              " Line numbers relative to cursor 
set expandtab                   " To enter spaces when tab is pressed.
set smarttab                    " To use smart tabs.
set autoindent                  " To copy indentation from current line 
                                " when starting a new line.
set si                          " To switch on smart indentation.


" Search
set ignorecase                  " To ignore case when searching.
set smartcase                   " When searching try to be smart about cases.
set hlsearch                    " To highlight search results.
set incsearch                   " To make search act like search in modern browsers.
set magic                       " For regular expressions turn magic on.


" Brackets
set showmatch                   " To show matching brackets when text indicator 
                                " is over them.
set mat=2                       " How many tenths of a second to blink 
                                " when matching brackets.


" Errors
set noerrorbells                " No annoying sound on errors.


" Color & Fonts
syntax enable                   " Enable syntax highlighting.
set encoding=utf8                " Set utf8 as standard encoding and 
                                 " en_US as the standard language.

" Enable 256 colors palette in Gnome Terminal.
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif


" Files & Backup
set nobackup                     " Turn off backup.
set nowb                         " Don't backup before overwriting a file.
set noswapfile                   " Don't create a swap file.
set ffs=unix,dos,mac             " Use Unix as the standard file type.


" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" for Rust indentation etc:
filetype plugin indent on
syntax on

" R to indent in a more compact way
let r_indent_align_args = 0
autocmd FileType R setlocal shiftwidth=2 softtabstop=2 expandtab

"
" FOR PYTHON
"
" 

" For formatting indentation etc
au BufNewFile,BufRead *.py
    \ setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=80
    \ expandtab autoindent fileformat=unix


runtime zepl/contrib/python.vim

autocmd! FileType python let b:repl_config = {
        \   'cmd': 'python',
        \   'formatter': function('zepl#contrib#python#formatter')
        \ }

nnoremap <leader>d :b#\|bd #<cr>

" Stop semshi E> mark from tilting window 
set signcolumn=yes

" Colors for zmk keymap file
autocmd BufEnter *.keymap :set ft=dts 
