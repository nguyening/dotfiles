"  ----------
"  General NeoVIM settings
"  ----------

let g:python_host_prog = expand('~/.pyenv/versions/neovim/bin/python')
let g:python3_host_prog = '/usr/bin/python3'
let &shell = 'bash --login'

"  ----------
"  General VIM settings
"  ----------

set encoding=utf-8
set confirm           " asks confirmation when read-only etc
set nobackup          " Disable backups
set swapfile          " Enable swaps, it's the responsible thing!
set dir=/tmp          " Put all swapfiles in /tmp to avoid polluting Git repos
set history=1000
set hidden            " enables hidden buffers (so we can move w/o saving)

set showmode          " show current mode
set showmatch         " jumps to next bracket
set showcmd           " Show command in the last line of the screen
set norelativenumber  " do not show relative line numbers
set nonumber          " do not show line numbers
set noruler             " show line and column numbers of the cursor
set nocursorline      " highlight the current line

set magic             " Use 'magic' patterns, i.e. extended regexes
set ignorecase        " Case insensitive searches
set incsearch         " Enable incremental search
set hlsearch          " Highlight searches
set gdefault          " Use 'g' flag by default with :s/foo/bar/

set splitbelow        " new spilt window below where you are
set splitright        " new vsplit windows right where you are

set smarttab          " smart tab (tabs for indentation, spaces for alignment)
set autoindent        " always set auto-indenting on
set copyindent        " copy the previous indentation on auto-indenting
set shiftround        " < and > commands for indention

set backspace=indent,eol,start " make backspace work like every other app

set mousemodel=popup  " Disable mouse selection entering the Visual mode

set lazyredraw

" Handle merge conflicts with vertical splits
set diffopt+=vertical

" Enable path/file expansion in colon-mode
set wildmode=list:longest
set wildchar=<TAB>

" Handle displaying whitespace
set list              " enable showing whitespace characters
set listchars=tab:\|·,trail:·,extends:>,precedes:<,nbsp:+

" Search and highlight trailing whitespace in green.
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$/

" Set up default text editing shift/tab behavior
set tabstop=4         " the width of a tab
set softtabstop=4     " the number of columns for a TAB
set shiftwidth=4      " the width of indents
set expandtab         " expand TABs to spaces

"  ----------
"  Key bindings
"  ----------

let mapleader="\<SPACE>"  " Map the leader key to SPACE

" Easier splits
nnoremap <Leader>- :sp<CR>
nnoremap <Leader><Bar> :vsp<CR>

" Easier splits navigation
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>
nnoremap <C-h> <C-W><C-H>

" Easier buffer navigation
nnoremap <Leader>j :bnext<CR>
nnoremap <Leader>k :bprevious<CR>

" Remap CTRL-SPACE to toggle between normal/insertion mode
noremap <C-SPACE> i
inoremap <C-SPACE> <Esc>

" Toggle auto-indent for the current file with F8
function! AutoIndentToggle()
	if &ai
		setlocal noautoindent nocindent nosmartindent indentexpr=
	else
		setl ai cin si inde<
	endif
endfunction
nnoremap <C-i> :call AutoIndentToggle()<CR>

" These work like * and g*, but do not move the cursor and always set hls.
:map <Leader>* :let @/ = '\<'.expand('<cword>').'\>'\|set hlsearch<C-M>
:map <Leader>g* :let @/ = expand('<cword>')\|set hlsearch<C-M><Paste>

" Double-tap Esc to go into Normal mode from Terminal
tnoremap <Esc><Esc> <C-\><C-n>

" yank + pbcopy
" function! PbCopyYank(type, ...) abort
"     let is_visual = get(a:, 0,0 )
"     let sel_save = &selection
"     let &selection = "inclusive"
"     let reg_save = @@
" 
"     " actually yank it
"     if is_visual
"         echo "visual"
"         exe "normal! gvy"
"     elseif a:type == 'line'
"         exe "normal! '[V']y"
"     else
"         exe "normal! `[v`]y"
"     endif
" 
"     call system('ssh local pbcopy -', @0)
" 
" 	let &selection = sel_save
" endfunction
" 
" nnoremap <silent> <Plug>(pb-copy-yank) :set opfunc=PbCopyYank<CR>g@
" xnoremap <silent> <Plug>(pb-copy-yank) :<C-u>call PbCopyYank(visualmode(), 1)<CR>
" onoremap <silent> <Plug>(pb-copy-yank) g@
" map y <Plug>(pb-copy-yank)

"  ----------
"  Plugins - :PlugInstall to install
"  ----------
"
call plug#begin('~/.config/nvim/plugged')
	" fzf is a fuzzy file finder, faster than Ctrl-P
	Plug 'junegunn/fzf'
	Plug 'junegunn/fzf.vim'

	Plug 'itchyny/lightline.vim'

	" fugitive adds git functionality as commands
	Plug 'tpope/vim-fugitive'

	" signify shows a git diff in the sign column
	Plug 'mhinz/vim-signify'

	" indentLine adds indentation markers for spaces
	Plug 'Yggdroot/indentLine'

	" vim-puppet adds formatting based on Puppetlabs' style guide
	Plug 'rodjek/vim-puppet'

	" vim-commentary adds commenting via 'gc'
	Plug 'tpope/vim-commentary'

	" pgsql.vim adds syntax highlighting for PostgreSQL
	Plug 'exu/pgsql.vim'

	" vim-bbye adds intelligent buffer deletion
	Plug 'moll/vim-bbye'

	" vim-markdown adds better syntax highlighting support for markdown
	Plug 'tpope/vim-markdown'

	" vim-unimpaired adds mappings for toggling options + ex commands
	Plug 'tpope/vim-unimpaired'

	" auto-pairs handles insertion/deletion of braces, parens, and
	" quotes in pairs
	Plug 'jiangmiao/auto-pairs'

	" python-mode adds a variety of nice tools for writing python in vim
	Plug 'python-mode/python-mode'

	" vim-sneak adds a two-character 'f' motion
	Plug 'justinmk/vim-sneak'

	" vim-javascript adds nice tools for writing javascript in vim
	Plug 'pangloss/vim-javascript'

	" FastFold improves performance when using folds
	Plug 'Konfekt/FastFold'

	" vim-repeat adds '.' for plugins
	Plug 'tpope/vim-repeat'

	" vim-yaml-folds adds folding for YAML/RAML/EYAML & SaltStack SLS
	Plug 'digitalrounin/vim-yaml-folds'

	" vim-go adds golang support
	Plug 'fatih/vim-go'

	" async completion framework
	Plug 'roxma/nvim-yarp'
	Plug 'ncm2/ncm2'
	Plug 'ncm2/ncm2-bufword'
	Plug 'ncm2/ncm2-path'
	Plug 'ncm2/ncm2-jedi'
	Plug 'ncm2/ncm2-pyclang'
	Plug 'ncm2/ncm2-tern'

	" base16 theme colors
	Plug 'chriskempson/base16-vim'
call plug#end()  " end plugin loading and setup


"  ----------
"  Plugin settings
"  ----------

" lightline
let g:lightline = {
    \ 'colorscheme': 'Tomorrow',
    \ 'tab': {
        \ 'active': [ 'tabnum', 'filename' ],
        \ 'inactive': [ 'tabnum', 'filename' ],
    \},
    \ 'active': {
        \ 'right': [ ],
        \ 'left': [ [ 'mode' ], [ 'filename' ] ],
    \},
    \ 'component_function': {
    \   'fugitive': 'LightlineFugitive'
    \ }
\}
set noshowmode  " mode is already in lightline

" base16
colorscheme base16-tomorrow

" fzf
nnoremap <C-P> :FZF<CR>
nnoremap <Leader>b :Buffers<Cr>

" signify
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '-'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '~'
let g:signify_sign_changedelete      = '~'
highlight SignColumn ctermbg=black
highlight DiffAdd    cterm=none ctermbg=black ctermfg=2
highlight DiffDelete cterm=none ctermbg=black ctermfg=1
highlight DiffChange cterm=none ctermbg=black ctermfg=3

" indentLine
let g:indentLine_faster = 1               " fix performance issue w/ long lines

" wstrip
let g:wstrip_auto = 1

" vim-markdown
let g:markdown_fenced_languages = ['python', 'go', 'yaml']
let g:markdown_syntax_conceal = 0

" vlide.vim
let g:vlide_next = 'n'
let g:vlide_previous = 'p'
let g:vlide_statusline = 'Press <n> or <p> to continue'

" unimpaired
nnoremap coh :<C-R>=eval(&hls) ? (v:hlsearch ? 'noh' : 'set nohls') : 'set hls'<CR><CR>

" python-mode
let g:pymode = 1
let g:pymode_motion = 1
let g:pymode_indent = 1
let g:pymode_folding = 0
let g:pymode_doc_bind = 'K'
let g:pymode_virtualenv = 1

let g:pymode_warnings = 0
let g:pymode_trim_whitespaces = 0
let g:pymode_options = 0
let g:pymode_options_colorcolumn = 0
let g:pymode_run = 0
let g:python_breakpoint = 0
let g:pymode_lint = 0
let g:pymode_lint_on_write = 0
let g:pymode_lint_message = 0
let g:pymode_rope = 0
let g:pymode_rope_regenerate_on_write = 0
let g:pymode_rope_completion = 0
let g:pymode_rope_complete_on_dot = 0
let g:pymode_rope_completion_bind = ''
let g:pymode_syntax = 0
let g:pymode_syntax_all = 0
let g:pymode_syntax_slow_sync = 0

" FastFold
let g:fastfold_savehook = 1
let g:python_folding = 1
" let g:fastfold_fold_command_suffixes = ['x', 'X', 'a', 'A', 'o', 'O', 'c', 'C']

" vim-bbye
nnoremap <Leader>q :Bwipeout<CR>

" ncm2
let g:ncm2_pyclang#library_path = '/usr/lib/llvm-3.8/lib'
let $NVIM_PYTHON_LOG_FILE="/tmp/nvim_log"
let $NVIM_PYTHON_LOG_LEVEL="DEBUG"

au BufEnter * call ncm2#enable_for_buffer()
autocmd Filetype c,cpp nnoremap <buffer> gd :<c-u>call ncm2_pyclang#goto_declaration()<cr>
set completeopt=noinsert,menuone,noselect
inoremap <expr> <C-j> (pumvisible() ? "\<C-n>" : "\<C-j>")
inoremap <expr> <C-k> (pumvisible() ? "\<C-p>" : "\<C-k>")

"  ----------
"  File-specific settings
"  ----------

autocmd Filetype javascript setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype python setlocal ts=4 sts=4 sw=4 et
autocmd Filetype puppet setlocal ts=2 sts=2 sw=2 et
autocmd Filetype yaml setlocal ts=2 sts=2 sw=2 et syntax=off
autocmd Filetype sql setlocal ts=4 sts=4 sw=4 et syntax=pgsql
autocmd Filetype vim setlocal ts=4 sts=4 sw=4 noet
autocmd Filetype groovy setlocal ts=2 sts=2 sw=2 et
autocmd Filetype go setlocal ts=4 sts=4 sw=4 noet foldmethod=syntax
autocmd Filetype sh setlocal ts=2 sts=2 sw=2 et
au Filetype c,cpp setlocal cinoptions=+4,(4:0 sw=8 ts=8 sts=8 noet cindent
au BufNewFile,BufRead *.groovy setf groovy
au BufNewFile,BufRead *Jenkinsfile* setf groovy
au BufNewFile,BufRead *.vim setf noet
au BufNewFile,BufRead *.go setf go
au BufRead /tmp/psql.edit.* setlocal syntax=pgsql

augroup qf
	autocmd!
	autocmd FileType qf set nobuflisted
augroup END
