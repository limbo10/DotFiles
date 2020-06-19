call plug#begin()
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'Yggdroot/indentLine'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'ap/vim-css-color'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'morhetz/gruvbox'
call plug#end()
 

" :imap <S-CR> <Esc>o
" :imap <C-CR> <Esc>O

"Theme
set termguicolors
colorscheme gruvbox

"Devicons
set guifont=DroidSansMono\ Nerd\ Font\11
let g:airline_powerline_fonts = 1
let g:NERDTreeHighlightFolders = 1
let g:NERDTreeHighlightFoldersFullName = 1
let g:DevIconsEnableFoldersOpenClose = 1

let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['html'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['js'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['json'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['jsx'] = 'ﰆ'
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['md'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['vim'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['yaml'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['yml'] = ''

let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.*vimrc.*'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.gitignore'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['package.json'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['package.lock.json'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['node_modules'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['webpack\.'] = 'ﰩ'



"Airline
let g:airline_theme='dark'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#bufferline#enabled = 1
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''



"Key Binding
"copy to clipboard
vnoremap <C-c> "+y
nnoremap <C-c> "+yg
nnoremap <C-c> "+y
nnoremap <C-c> "+yy

"Paste from Clipboard
nnoremap <C-p> "+P
vnoremap <C-p> "+P
nnoremap <C-P> "+P
vnoremap <C-P> "+P

"My Keybinding in Insert Mode
"integration ** Do not change the <Home> to <C-[> as it is the Esc key
nnoremap Y y$
:imap <A-[> <Esc>^i
:imap <A-]> <End>
:imap <A-h> <Left>
:imap <A-j> <Down>
:imap <A-k> <Up>
:imap <A-l> <Right>

:imap <A-Backspace> <Del>
:map <A-g> <Esc>

" moving around in Split mode
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nmap <C-h> <C-w>h


"NeoVim
set foldmethod=indent
set foldcolumn=1

set mouse=a                                        "Increase mouse functionality
set clipboard+=unnamedplus

set encoding=UTF-8                                  "Specially for Devicons

syntax enable
filetype plugin on
set filetype  

"Wrap line at 100 character and beautify
set wrap
set linebreak

"if you want to move cursor where there is no space
"set virtualedit=all 

set shiftwidth=4
set smartindent
set expandtab                                       "Use space instead of tabs
set tabstop=4                                       "tab length in space
set softtabstop=4

set relativenumber                                  "Show relative line number
set cursorline

set ignorecase                                      
set smartcase

set noshowmode                                      "hide bar showing mode of operation
set nohlsearch                                      "remove highlight after searching

set splitright                                      "open new split panes to right and below
set splitbelow

"turn terminal to normal mode with escape 
tnoremap <Esc> <C-\><C-n>
au BufEnter * if &buftype == 'terminal' | :startinsert | endif

" open terminal on ctrl+n
function! OpenTerminal()
  split term://bash
  resize 10
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>



"CoC
set hidden
set updatetime=300
set signcolumn=yes

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json']

"Mapping
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
nnoremap <silent> K :call <SID>show_documentation()<CR>
nmap <F2> <Plug>(coc-references)
inoremap <silent><expr> <c-space> coc#refresh()


"Indent Line 
let g:indentLine_char = '┊'   " ['|', '¦', '┆', '┊']
let g:indentLine_first_char = '┊'
let g:indentLine_showFirstIndentLeve = 1



" NerdTree
" Don't open Nerd Tree when opening a saved session
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") && v:this_session == "" | NERDTree | endif

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let NERDTreeShowHidden = 1
let NERDTreeMinimalUI = 1
let NERDTreeIgnore = ['\.pyc$', '__pycache__', '.git$']
let g:NERDTreeDirArrowExpandable = ' '
let g:NERDTreeDirArrowCollapsible = ' '
" Mapping
map <C-\> :NERDTreeToggle<CR>



"Nerd Commenter
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDTrimTrailingWhitespace = 1



" NerdTree Highlight
" Highlight full name not only icons
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1

" Highlight folder with exact match
let g:NERDTreeHighlightFolders = 1 "enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 "highlights the folder name

" If experiencing lag while scrolling
let g:NERDTreeLimitedSyntax = 1


"Set Background Transparent
hi Normal guibg=None ctermbg=None

