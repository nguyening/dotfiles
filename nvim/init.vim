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
set dir=~/.vim//      " Put all swapfiles in homedir to avoid polluting Git repos
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

	" vim-markdown adds better syntax highlighting support for markdown
	Plug 'tpope/vim-markdown'

	" vim-unimpaired adds mappings for toggling options + ex commands
	Plug 'tpope/vim-unimpaired'

	" python-mode adds a variety of nice tools for writing python in vim
	Plug 'python-mode/python-mode'

	" vim-sneak adds a two-character 'f' motion
	Plug 'justinmk/vim-sneak'

	" FastFold improves performance when using folds
	Plug 'Konfekt/FastFold'

	" vim-repeat adds '.' for plugins
	Plug 'tpope/vim-repeat'

	" vim-go adds golang support
	Plug 'fatih/vim-go'

	" base16 theme colors
	Plug 'chriskempson/base16-vim'

	" Use coc.nvim as Language Server Protocol client
	Plug 'neoclide/coc.nvim', {'branch': 'release'}

	" Show LSP/tag information in a sidebar
	Plug 'liuchengxu/vista.vim'
call plug#end()  " end plugin loading and setup


"  ----------
"  Plugin settings
"  ----------

" vista
let g:vista_default_executive = 'coc'
let g:vista_icon_indent = ["▸ ", ""]
let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 0
let g:vista_keep_fzf_colors = 1

nnoremap <Leader>c :Vista finder coc<Cr>

" coc
let g:coc_node_path = '~/.config/nvm/versions/node/v12.14.0/bin/node' " I want older node by default

" Having longer updatetime (default is 4000ms = s) 
" leads to noticeable delays and poor UX
set updatetime=300

" Don't pass messages to |ins-completion-menu|
set shortmess+=c

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap format format selected regoin
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim', 'help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" ncm2
" let g:ncm2_pyclang#library_path = '/usr/lib/llvm-3.8/lib'
" let $NVIM_PYTHON_LOG_FILE="/tmp/nvim_log"
" let $NVIM_PYTHON_LOG_LEVEL="DEBUG"
" 
" au BufEnter * call ncm2#enable_for_buffer()
" autocmd Filetype c,cpp nnoremap <buffer> gd :<c-u>call ncm2_pyclang#goto_declaration()<cr>
" set completeopt=noinsert,menuone,noselect
" inoremap <expr> <C-j> (pumvisible() ? "\<C-n>" : "\<C-j>")
" inoremap <expr> <C-k> (pumvisible() ? "\<C-p>" : "\<C-k>")

" lightline
let g:lightline = {
    \ 'colorscheme': 'Tomorrow',
    \ 'tab': {
        \ 'active': [ 'tabnum', 'filename' ],
        \ 'inactive': [ 'tabnum', 'filename' ],
    \},
    \ 'active': {
        \ 'right': [ ],
        \ 'left': [ [ 'mode' ], [ 'relativepath' ] ],
    \},
    \ 'component_function': {
    \   'fugitive': 'LightlineFugitive'
    \ }
\}
set noshowmode  " mode is already in lightline

" base16
colorscheme base16-grayscale-light
set termguicolors

" fzf
nnoremap <C-P> :FZF<CR>
nnoremap <Leader>b :Buffers<Cr>
let g:fzf_colors = {
    \ 'bg': ['bg', 'Title'],
    \ 'bg+': ['bg', 'CursorLineNr'],
    \ 'fg+': ['fg', 'CursorLineNr'],
    \ 'hl': ['bg', 'TermCursor'],
    \ 'hl+': ['bg', 'TermCursor'],
    \ 'gutter': ['bg', 'ErrorMsg'],
    \ 'border': ['bg', 'TermCursor'],
    \ 'prompt': ['fg', 'ErrorMsg']
\}

" signify
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '-'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '~'
let g:signify_sign_changedelete      = '~'
highlight SignColumn ctermbg=white
highlight DiffAdd    cterm=none ctermbg=white ctermfg=2
highlight DiffDelete cterm=none ctermbg=white ctermfg=1
highlight DiffChange cterm=none ctermbg=white ctermfg=3

" indentLine
let g:indentLine_faster = 1               " fix performance issue w/ long lines

" wstrip
let g:wstrip_auto = 1

" vim-markdown
let g:markdown_fenced_languages = ['python', 'go', 'yaml']
let g:markdown_syntax_conceal = 0

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
let g:pymode_breakpoint = 0
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
