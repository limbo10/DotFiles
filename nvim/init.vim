call plug#begin()
"FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'

" Tab Name Customisation
Plug 'gcmt/taboo.vim'

" Commenter
Plug 'preservim/nerdcommenter'

" Directory Tree
Plug 'preservim/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Statusline
Plug 'vim-airline/vim-airline'

" Indentation
Plug 'Yggdroot/indentLine'

" Color & Icons
Plug 'morhetz/gruvbox'
Plug 'arcticicestudio/nord'
Plug 'ryanoasis/vim-devicons'
Plug 'ap/vim-css-color'

"LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"ColorScheme
Plug 'christianchiarulli/nvcode-color-schemes.vim'

"Intergrating Tmux and Vim Functionality
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tmux-plugins/vim-tmux'

" Repeat the last command
Plug 'tpope/vim-repeat'

" Navigation Helper
Plug 'easymotion/vim-easymotion'

" Floating terminal
Plug 'voldikss/vim-floaterm'

" Startup Screen
Plug 'mhinz/vim-startify'

" Which key does what
Plug 'liuchengxu/vim-which-key'

"Swapping splits in nvim
Plug 'wesQ3/vim-windowswap'

" Show colors under the color code
Plug 'norcalli/nvim-colorizer.lua'

" Debugging
Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'

"Managing Whitesapces
Plug 'ntpeters/vim-better-whitespace'

"Multiple Cursor
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

call plug#end()


"----------------- Vim Repeat -------------------
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

"---------------------------------------------------- FZF ----------------------------------------------------
" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_buffers_jump = 1

map <leader>f :Files<CR>
map <leader>b :Buffers<CR>
nnoremap <leader>g :Rg<CR>
nnoremap <leader>t :Tags<CR>
nnoremap <leader>m :Marks<CR>

let g:fzf_tags_command = 'ctags -R'
" Border Color
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'rounded' } }

let $FZF_DEFAULT_OPTS = '--layout=default --inline-info'
let $FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git/**'"
"-g '!{node_modules,.git}'

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

"Get Files
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--inline-info']}), <bang>0)


" Get text in files with Rg
" command! -bang -nargs=* Rg
"   \ call fzf#vim#grep(
"   \   "rg --column --line-number --no-heading --color=always --smart-case --glob '!.git/**' ".shellescape(<q-args>), 1,

 " Make Ripgrep ONLY search file contents and not filenames
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --hidden --smart-case --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4.. -e'}, 'right:50%', '?'),
  \   <bang>0)

" Ripgrep advanced
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" Git grep
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)






"Terminal
"Use statusline
autocmd TermOpen * setlocal statusline=%{b:term_title}
"Exit Terminal Mode
tnoremap <Esc> <C-\><C-n>

"Taboo
"Remember tab name with session
set sessionoptions+=tabpages,globals

"Sessions
"Tell nvim to source the Session.vim file
au VimEnter Coding.vim :source %:p

"All the windows are automatically made the same size after splitting or closing a window
set equalalways

"Theme
set termguicolors
" colorscheme gruvbox

"Templates
if has("autocmd")
    augroup templates
        autocmd BufNewFile *.cpp 0r ~/.config/nvim/templates/competetive.cpp
    augroup END
endif


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
let g:airline_theme='gruvbox'
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
nnoremap <C-p> "+p
vnoremap <C-p> "+p
nnoremap <C-P> "+P
vnoremap <C-P> "+P

"Keybinding in Insert Mode
"Do not change the <Home> to <C-[> as it is the Esc key
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
nmap <C-S-j> <C-w>j
nmap <C-S-k> <C-w>k
nmap <C-S-l> <C-w>l
nmap <C-S-h> <C-w>h
tnoremap <C-S-h> <C-\><C-N><C-w>h
tnoremap <C-S-j> <C-\><C-N><C-w>j
tnoremap <C-S-k> <C-\><C-N><C-w>k
tnoremap <C-S-l> <C-\><C-N><C-w>l
inoremap <C-S-h> <C-\><C-N><C-w>h
inoremap <C-S-j> <C-\><C-N><C-w>j
inoremap <C-S-k> <C-\><C-N><C-w>k
inoremap <C-S-l> <C-\><C-N><C-w>l

"NeoVim
" set autoread | au CursorHold * checktime | call feedkeys("lh")
set autoread | au CursorHold * checktime

set modifiable
set path=.,,**

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

" Turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
au BufEnter * if &buftype == 'terminal' | :startinsert | endif

" Open terminal on ctrl+n
nnoremap <c-n> :FloatermNew<C-R>

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
let NERDTreeDirArrows = 1
let NERDTreeIgnore = ['\.pyc$', '__pycache__', '.git$']
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
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

