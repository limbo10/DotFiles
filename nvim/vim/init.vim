call plug#begin()

" Neovim Startup Screen
Plug 'mhinz/vim-startify'

" For tags
Plug 'ludovicchabant/vim-gutentags'

"Delete surrouding function
Plug 'AndrewRadev/dsf.vim'

"Session Management with vim
Plug 'tpope/vim-obsession'

"Latex
Plug 'lervag/vimtex'
Plug 'xuhdev/vim-latex-live-preview'

"html
Plug 'mattn/emmet-vim'

" Tag and Bracket Matching
Plug 'frazrepo/vim-rainbow'
Plug 'leafOfTree/vim-matchtag'

" Cpp Formating
Plug 'folke/lsp-colors.nvim'
Plug 'sbdchd/neoformat'

"FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Tab Name Customisation
Plug 'gcmt/taboo.vim'

" Commenter
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'


"WilderMenu
Plug 'gelguy/wilder.nvim', { 'do': ':UpdateRemotePlugins' }

" Statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Indentation
Plug 'Yggdroot/indentLine'

" ColorScheme & Icons
Plug 'tanvirtin/monokai.nvim'
Plug 'morhetz/gruvbox'
Plug 'jacoborus/tender.vim'
Plug 'joshdick/onedark.vim'
Plug 'tomasiser/vim-code-dark'

" Icons
Plug 'ryanoasis/vim-devicons'

" HexCode Colors
Plug 'ap/vim-css-color'

"LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Repeat the last command
Plug 'tpope/vim-repeat'

" Navigation Helper
Plug 'easymotion/vim-easymotion'
Plug 'unblevable/quick-scope'

" Floating terminal
Plug 'voldikss/vim-floaterm'

"Swapping splits in nvim
Plug 'wesQ3/vim-windowswap'

" Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'

"Managing Whitesapces
Plug 'ntpeters/vim-better-whitespace'

"Multiple Cursor
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

"More Text Based Objects
Plug 'wellle/targets.vim'

"Surround Plugin
Plug 'tpope/vim-surround'

"Git
Plug 'tpope/vim-fugitive'

call plug#end()


"----------------- Vim Repeat -------------------
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

"---------------------------------------------------- FZF ----------------------------------------------------
" This is the default extra key bindings
let g:fzf_action = {
\ 'ctrl-t': 'tab split',
\ 'ctrl-s': 'split',
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
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.6, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'rounded' } }

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
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   "rg --column --line-number --no-heading --color=always --smart-case --glob '!.git/**' ".shellescape(<q-args>), 1,

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

"Taboo
"Remember tab name with session
set sessionoptions+=tabpages,globals

"Sessions
"Tell nvim to source the Session.vim file
au VimEnter Coding.vim :source %:p

"All the windows are automatically made the same size after splitting or closing a window
set equalalways

" Theme
" nvcode aurora palenight snazzy tender onedark nord gruvbox NeoSolarized
set termguicolors
colorscheme monokai_pro


" Devicons
" set guifont=DroidSansMono\ Nerd\ Font\11
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
let g:airline_theme = 'onedark'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#nerdtree_statusline = 0
let g:airline#extensions#whitespace#show_message = 0

" unicode symbols
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_alt_sep = ''


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
:nnoremap H :tabprevious<CR>
:nnoremap L :tabnext<CR>

" moving around in Split mode
 " Window bindings
nnoremap <C-l> <C-W><C-L>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-j> <C-W><C-J>
nnoremap <C-h> <C-W><C-H>

" terminal bindings
tmap <C-h> <C-\><C-N><C-h>
tmap <C-l> <C-\><C-N><C-l>
tmap <C-j> <C-\><C-N><C-j>
tmap <C-k> <C-\><C-N><C-k>

" nmap <C-S-j> <C-w>j
" nmap <C-S-k> <C-w>k
" nmap <C-S-l> <C-w>l
" nmap <C-S-h> <C-w>h
" tnoremap <C-S-h> <C-\><C-N><C-w>h
" tnoremap <C-S-j> <C-\><C-N><C-w>j
" tnoremap <C-S-k> <C-\><C-N><C-w>k
" tnoremap <C-S-l> <C-\><C-N><C-w>l
" inoremap <C-S-h> <C-\><C-N><C-w>h
" inoremap <C-S-j> <C-\><C-N><C-w>j
" inoremap <C-S-k> <C-\><C-N><C-w>k
" inoremap <C-S-l> <C-\><C-N><C-w>l

"NeoVim
" set autoread | au CursorHold * silent! checktime | call feedkeys("lh")
" set autoread | au CursorHold * silent! checktime
" This is causing error in Ex Mode
set modifiable
set path=.,,**

set foldmethod=indent
set foldcolumn=0

set mouse=a                                        "Increase mouse functionality
set clipboard+=unnamedplus

set encoding=UTF-8                                  "Specially for Devicons

syntax on
filetype plugin on
set filetype

"Wrap line at 100 character and beautify
set wrap
set linebreak

"if you want to move cursor where there is no space
set virtualedit=all

set shiftwidth=4
set smartindent
set expandtab                                       "Use space instead of tabs
set tabstop=4                                       "tab length in space
set softtabstop=4

set numberwidth=1
set relativenumber                                  "Show relative line number
set cursorline

set ignorecase
set smartcase

set noshowmode                                      "hide bar showing mode of operation
set nohlsearch                                      "remove highlight after searching

set splitright                                      "open new split panes to right and below
set splitbelow


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

"CoC Mapping
" nnoremap <silent> K :call <SID>show_documentation()<CR>
nmap <F2> <Plug>(coc-references)
inoremap <silent><expr> <c-space> coc#refresh()


"Coc Snippets
" Use <C-l> for trigger snippet expand.
imap <leader><C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <leader><C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <leader><C-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"






"Indent Line
let g:indentLine_char = '┊'   " ['|', '¦', '┆', '┊']
let g:indentLine_first_char = '┊'
let g:indentLine_showFirstIndentLevel = 1



" NerdTree
" Don't open Nerd Tree when opening a saved session
autocmd StdinReadPre * let s:std_in=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Uncommenting this will prevent startify to load.
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") && v:this_session == "" | NERDTree | endif

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
" hi Normal guibg=None ctermbg=None



" NeoSolarized
" Default value is "normal", Setting this option to "high" or "low" does use the
" same Solarized palette but simply shifts some values up or down in order to
" expand or compress the tonal range displayed.
let g:neosolarized_contrast = "high"

" Special characters such as trailing whitespace, tabs, newlines, when displayed
" using ":set list" can be set to one of three levels depending on your needs.
" Default value is "normal". Provide "high" and "low" options.
let g:neosolarized_visibility = "high"

" I make vertSplitBar a transparent background color. If you like the origin
" solarized vertSplitBar style more, set this value to 0.
let g:neosolarized_vertSplitBgTrans = 1

" If you wish to enable/disable NeoSolarized from displaying bold, underlined
" or italicized" typefaces, simply assign 1 or 0 to the appropriate variable.
" Default values:
let g:neosolarized_bold = 1
let g:neosolarized_underline = 1
let g:neosolarized_italic = 1

" Used to enable/disable "bold as bright" in Neovim terminal. If colors of bold
" text output by commands like `ls` aren't what you expect, you might want to
" try disabling this option. Default value:
let g:neosolarized_termBoldAsBright = 1

"Directories
set undofile
set undodir=~/.config/nvim/.undo



" Quick Scope
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

highlight QuickScopePrimary guifg=#00C7DF gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg=#AFFF5F gui=underline ctermfg=155 cterm=underline

let g:qs_max_chars=150


" Multi Cursor
let g:VM_mouse_mappings = 1
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-a>'           " replace C-n
let g:VM_maps['Find Subword Under'] = '<C-a>'           " replace visual C-n

let g:VM_maps["Select All"]                  = '\\A'
let g:VM_maps["Start Regex Search"]          = '\\/'
let g:VM_maps["Add Cursor Down"]             = '<C-Down>'
let g:VM_maps["Add Cursor Up"]               = '<C-Up>'
let g:VM_maps["Add Cursor At Pos"]           = '\\\'

let g:VM_maps["Visual Regex"]                = '\\/'
let g:VM_maps["Visual All"]                  = '\\A'
let g:VM_maps["Visual Add"]                  = '\\a'
let g:VM_maps["Visual Find"]                 = '\\f'
let g:VM_maps["Visual Cursors"]              = '\\c'

let g:VM_maps["Select Cursor Down"]          = '<M-C-Down>'
let g:VM_maps["Select Cursor Up"]            = '<M-C-Up>'


let g:VM_maps["Erase Regions"]               = '\\gr'

let g:VM_maps["Mouse Cursor"]                = '<C-LeftMouse>'
let g:VM_maps["Mouse Word"]                  = '<C-RightMouse>'
let g:VM_maps["Mouse Column"]                = '<M-C-RightMouse>'

let g:VM_maps["Find Next"]                   = ']'
let g:VM_maps["Find Prev"]                   = '['
let g:VM_maps["Goto Next"]                   = '}'
let g:VM_maps["Goto Prev"]                   = '{'
let g:VM_maps["Seek Next"]                   = '<C-f>'
let g:VM_maps["Seek Prev"]                   = '<C-b>'
let g:VM_maps["Skip Region"]                 = 'q'
let g:VM_maps["Remove Region"]               = 'Q'
let g:VM_maps["Invert Direction"]            = 'o'
let g:VM_maps["Find Operator"]               = "m"
let g:VM_maps["Surround"]                    = 'S'
let g:VM_maps["Replace Pattern"]             = 'R'

let g:VM_maps["Tools Menu"]                  = '\\`'
let g:VM_maps["Show Registers"]              = '\\"'
let g:VM_maps["Case Setting"]                = '\\c'
let g:VM_maps["Toggle Whole Word"]           = '\\w'
let g:VM_maps["Transpose"]                   = '\\t'
let g:VM_maps["Align"]                       = '\\a'
let g:VM_maps["Duplicate"]                   = '\\d'
let g:VM_maps["Rewrite Last Search"]         = '\\r'
let g:VM_maps["Merge Regions"]               = '\\m'
let g:VM_maps["Split Regions"]               = '\\s'
let g:VM_maps["Remove Last Region"]          = '\\q'
let g:VM_maps["Visual Subtract"]             = '\\s'
let g:VM_maps["Case Conversion Menu"]        = '\\C'
let g:VM_maps["Search Menu"]                 = '\\S'

let g:VM_maps["Run Normal"]                  = '\\z'
let g:VM_maps["Run Last Normal"]             = '\\Z'
let g:VM_maps["Run Visual"]                  = '\\v'
let g:VM_maps["Run Last Visual"]             = '\\V'
let g:VM_maps["Run Ex"]                      = '\\x'
let g:VM_maps["Run Last Ex"]                 = '\\X'
let g:VM_maps["Run Macro"]                   = '\\@'
let g:VM_maps["Align Char"]                  = '\\<'
let g:VM_maps["Align Regex"]                 = '\\>'
let g:VM_maps["Numbers"]                     = '\\n'
let g:VM_maps["Numbers Append"]              = '\\N'
let g:VM_maps["Zero Numbers"]                = '\\0n'
let g:VM_maps["Zero Numbers Append"]         = '\\0N'
let g:VM_maps["Shrink"]                      = "\\-"
let g:VM_maps["Enlarge"]                     = "\\+"

let g:VM_maps["Toggle Block"]                = '\\<BS>'
let g:VM_maps["Toggle Single Region"]        = '\\<CR>'
let g:VM_maps["Toggle Multiline"]            = '\\M'

" Floaterm
" Turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
au BufEnter * if &buftype == 'terminal' | :startinsert | endif

" Configuration example
nnoremap   <leader>tc :FloatermNew<CR>
nnoremap   <leader>tp :FloatermPrev<CR>
nnoremap   <leader>tn :FloatermNext<CR>
nnoremap   <leader>tt :FloatermToggle<CR>



"Open Help vertically
autocmd! BufEnter * if &ft ==# 'help' | wincmd L | endif


"AutoCommands
augroup templates_cpp
    autocmd BufNewFile *.cpp 0r ~/.config/nvim/templates/competetive.cpp
augroup END

augroup templates_java
    autocmd BufNewFile *.java 0r ~/.config/nvim/templates/Base.java
augroup END

augroup templates_js
    autocmd BufNewFile,BufRead *.js :setlocal shiftwidth=2
    autocmd BufNewFile,BufRead *.js :setlocal tabstop=2
    autocmd BufNewFile,BufRead *.js :setlocal nowrap
    autocmd BufNewFile,BufRead *.json :setlocal shiftwidth=2
    autocmd BufNewFile,BufRead *.json :setlocal tabstop=2
    autocmd BufNewFile,BufRead *.json :setlocal nowrap
augroup END

augroup templates_js
    autocmd BufNewFile,BufRead *.ts :setlocal shiftwidth=2
    autocmd BufNewFile,BufRead *.ts :setlocal tabstop=2
    autocmd BufNewFile,BufRead *.ts :setlocal nowrap
augroup END

augroup templates_html
    autocmd BufNewFile *.html 0r ~/.config/nvim/templates/htmlBoilerPlate.html
    autocmd BufNewFile,BufRead *.html :setlocal shiftwidth=2
    autocmd BufNewFile,BufRead *.html :setlocal tabstop=2
augroup END

augroup concealLevel
    autocmd BufNewFile,BufRead,BufEnter *.json :setlocal conceallevel=0
    autocmd BufNewFile,BufRead,BufEnter *.tex  :setlocal conceallevel=0
    autocmd BufNewFile,BufRead *.tex  :LLPStartPreview
augroup END

augroup css
    autocmd BufNewFile,BufRead *.css :setlocal shiftwidth=2
augroup END

" Sort CSS content Alphabetically and then jump back to the current cusor
" position
command! -bar SortCSSRulesAlphabetially g#\({\n\)\@<=#.,/}/sort
command! JumpBack exe "normal! \<c-o>"
command! CSS SortCSSRulesAlphabetially|JumpBack
augroup SortedCSSContent
    autocmd BufWritePre *.css CSS
augroup END

"Go to next line with the same indent as the previous one
function! IndentIgnoringBlanks(child)
  let lnum = v:lnum
  while v:lnum > 1 && getline(v:lnum-1) == ""
    normal k
    let v:lnum = v:lnum - 1
  endwhile
  if a:child == ""
    if ! &l:autoindent
      return 0
    elseif &l:cindent
      return cindent(v:lnum)
    endif
  else
    exec "let indent=".a:child
    if indent != -1
      return indent
    endif
  endif
  if v:lnum == lnum && lnum != 1
    return -1
  endif
  let next = nextnonblank(lnum)
  if next == lnum
    return -1
  endif
  if next != 0 && next-lnum <= lnum-v:lnum
    return indent(next)
  else
    return indent(v:lnum-1)
  endif
endfunction
command! -bar IndentIgnoringBlanks
            \ if match(&l:indentexpr,'IndentIgnoringBlanks') == -1 |
            \   if &l:indentexpr == '' |
            \     let b:blanks_indentkeys = &l:indentkeys |
            \     if &l:cindent |
            \       let &l:indentkeys = &l:cinkeys |
            \     else |
            \       setlocal indentkeys=!^F,o,O |
            \     endif |
            \   endif |
            \   let b:blanks_indentexpr = &l:indentexpr |
            \   let &l:indentexpr = "IndentIgnoringBlanks('".
            \   substitute(&l:indentexpr,"'","''","g")."')" |
            \ endif
command! -bar IndentNormally
            \ if exists('b:blanks_indentexpr') |
            \   let &l:indentexpr = b:blanks_indentexpr |
            \ endif |
            \ if exists('b:blanks_indentkeys') |
            \   let &l:indentkeys = b:blanks_indentkeys |
            \ endif
augroup IndentIgnoringBlanks
  au!
  au FileType * IndentIgnoringBlanks
augroup END


"WilderMenu
call wilder#enable_cmdline_enter()
set wildcharm=<c-space>
" only / and ? are enabled by default

call wilder#set_option('modes', ['/', '?', ':'])

" 'border'            : 'single', 'double', 'rounded' or 'solid'
"                     : can also be a list of 8 characters,
"                     : see :h wilder#popupmenu_palette_theme() for more details
" 'max_height'        : max height of the palette
" 'min_height'        : set to the same as 'max_height' for a fixed height window
" 'prompt_position'   : 'top' or 'bottom' to set the location of the prompt
" 'reverse'           : set to 1 to reverse the order of the list
"                     : use in combination with 'prompt_position'
call wilder#set_option('renderer', wilder#popupmenu_renderer(wilder#popupmenu_palette_theme({
      \ 'border': 'rounded',
      \ 'max_height': '75%',
      \ 'min_height': '5%',
      \ 'prompt_position': 'top',
      \ 'reverse': 0,
      \ })))

""VimSpector
"" for normal mode - the word under the cursor
"nmap <Leader>di <Plug>VimspectorBalloonEval
"" for visual mode, the visually selected text
"xmap <Leader>di <Plug>VimspectorBalloonEval
"
"nmap <F5> <Plug>VimspectorContinue
"
""VSCode Mapping
"let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
"
"nmap <LocalLeader><F11> <Plug>VimspectorUpFrame
"nmap <LocalLeader><F12> <Plug>VimspectorDownFrame
"
"" VimSpector UI
"let g:vimspector_sidebar_width = 50
"let g:vimspector_bottombar_height = 10
"
"let g:vimspector_terminal_height = 10
"let g:vimspector_terminal_maxwidth = 75
"let g:vimspector_terminal_minwidth = 20
"
"let g:vimspector_code_minwidth = 90


" Vim-rainbow'
au FileType c,cpp,objc,objcpp call rainbow#load()
let g:rainbow_active = 1

let g:rainbow_active = 1

let g:rainbow_load_separately = [
    \ [ '*.tex' , [['(', ')'], ['\[', '\]']] ],
    \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
    \ ]
" let g:rainbow_load_separately = [
"     \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
"     \ [ '*.tex' , [['(', ')'], ['\[', '\]']] ],
"     \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
"     \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
"     \ ]

" let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick']
let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta']

" Color Highlight
autocmd CursorHold * silent! call CocActionAsync('highlight')


" Window Swaps
let g:windowswap_map_keys = 0 "prevent default bindings
nnoremap <silent> <leader>yw :call WindowSwap#MarkWindowSwap()<CR>
nnoremap <silent> <leader>pw :call WindowSwap#DoWindowSwap()<CR>
nnoremap <silent> <leader>ww :call WindowSwap#EasyWindowSwap()<CR>

" Vim Latex Live Preview
let g:livepreview_previewer = 'zathura'
let g:livepreview_cursorhold_recompile = 0

" Emmet for Html
" let g:user_emmet_mode='n'    "only enable normal mode functions.
" let g:user_emmet_mode='inv'  "enable all functions, which is equal to
let g:user_emmet_mode='a'    "enable all function in all mode.

let g:user_emmet_install_global = 0
autocmd FileType html,css,js,ts EmmetInstall

" Note that the trailing , still needs to be entered, so the new keymap would be <C-Y>,.
let g:user_emmet_leader_key='<C-Y>'


" Startify
let g:startify_session_before_save = [ 'silent! tabdo NERDTreeClose' ]
let g:startify_session_persistence = 1
let g:startify_custom_header =
      \ 'startify#center(startify#fortune#cowsay())'
let g:startify_change_to_dir = 1
let g:startify_bookmarks = [{'vi': '~/.config/nvim/init.vim'}, {'zs' : '~/.config/zsh/.zshrc'}, {'cp': '~/D/Programming/cpp/a.cpp'}]

if has('nvim')
  autocmd TabNewEntered * Startify
else
  autocmd VimEnter * let t:startify_new_tab = 1
  autocmd BufEnter *
        \ if !exists('t:startify_new_tab') && empty(expand('%')) |
        \   let t:startify_new_tab = 1 |
        \   Startify |
        \ endif
endif
