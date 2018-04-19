"  ----------
"  General NeoVIM settings
"  ----------

let g:python_host_prog = expand('~/.pyenv/versions/neovim/bin/python')

"  ----------
"  General VIM settings
"  ----------

set encoding=utf-8
set confirm           " asks confirmation when read-only etc
set nobackup          " No swaps or backups
set noswapfile
set history=1000
set hidden            " enables hidden buffers (so we can move w/o saving)

set showmode          " show current mode
set showmatch         " jumps to next bracket
set showcmd           " Show command in the last line of the screen
set number            " show line numbers
set ruler             " show line and column numbers of the cursor
set cursorline        " highlight the current line

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
set mouse=a           " But I need mouse=a for scolling to work in tmux

" Enable path/file expansion in colon-mode
set wildmode=list:longest
set wildchar=<TAB>

" Handle displaying whitespace
set list              " enable showing whitespace characters
set listchars=tab:\|·,trail:·,extends:>,precedes:<,nbsp:+

" Search and highlight trailing whitespace in green.
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$/

" Highlight the 73rd, 80th column and all columns past 100
let &colorcolumn="73,80,".join(range(100,999),",")

" Set up default text editing shift/tab behavior
set tabstop=4         " the width of a tab
set softtabstop=4     " the number of columns for a TAB
set shiftwidth=4      " the width of indents
set expandtab         " expand TABs to spaces

" XXX: turning off lazyredraw to fix splits for tmux
" https://github.com/neovim/neovim/issues/4884
set nolazyredraw

"  ----------
"  Key bindings
"  ----------

let mapleader="\<SPACE>"  " Map the leader key to SPACE

" Faster commands with semi-colon instead of colon
nmap ; :

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

" Trim trailing whitespace with F5
function! TrimWhitespace()
	let l:save = winsaveview()
	%s/\s\+$//e
	call winrestview(l:save)
endfunction
nnoremap <F5> :call TrimWhitespace()<CR>

" Toggle auto-indent for the current file with F8
function! AutoIndentToggle()
	if &ai
		setlocal noautoindent nocindent nosmartindent indentexpr=
	else
		setl ai cin si inde<
	endif
endfunction
nnoremap <F8> :call AutoIndentToggle()<CR>

" Use Q to intelligently close a window (if there are multiple windows into the
" same buffer) or kill the buffer entirely if it's the last window
function! CloseWindowOrKillBuffer()
	let number_of_windows_to_this_buffer = len(filter(range(1, winnr('$')), "winbufnr(v:val) == bufnr('%')"))

	" We should never bdelete a nerd tree
	if matchstr(expand("%"), 'NERD') == 'NERD'
		wincmd c
		return
	endif

	if number_of_windows_to_this_buffer > 1
		wincmd c
	else
		:Bdelete
	endif
endfunction
nnoremap <silent> Q :call CloseWindowOrKillBuffer()<CR>

"  ----------
"  Plugins - :PlugInstall to install
"  ----------
"
call plug#begin('~/.config/nvim/plugged')
	" base16 color theme
	Plug 'chriskempson/base16-vim'

	" focus-events fixes FocusGained/Lost in tmux
	Plug 'tmux-plugins/vim-tmux-focus-events'

	" fzf is a fuzzy file finder, faster than Ctrl-P
	Plug 'junegunn/fzf'

	" airline is a better status line
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'

	" neomake is an async code linting tool
	Plug 'neomake/neomake'

	" fugitive adds git functionality as commands
	Plug 'tpope/vim-fugitive'

	" gitgutter shows a git diff in the sign column
	Plug 'airblade/vim-gitgutter'

	" delimitMate provides insert mode auto-complete for quotes, parens,
	" backets, et cetera.
	Plug 'Raimondi/delimitMate'

	" indentLine adds indentation markers for spaces
	Plug 'Yggdroot/indentLine'

	" wstrip removes trailing whitespace from only 'git diff'd lines
	Plug 'tweekmonster/wstrip.vim'

	" vim-puppet adds formatting based on Puppetlabs' style guide
	Plug 'rodjek/vim-puppet'

	" vim-commentary adds commenting via 'gc'
	Plug 'tpope/vim-commentary'

	" YouCompleteMe adds a language-agnostic code-completion engine
	Plug 'Valloric/YouCompleteMe'

	" vim-easymotion adds faster navigation via motions
	Plug 'easymotion/vim-easymotion'

	" vim-coverage adds integration with coveragepy
	Plug 'google/vim-maktaba'
	Plug 'google/vim-coverage'
	Plug 'google/vim-glaive'

	" pgsql.vim adds syntax highlighting for PostgreSQL
	Plug 'exu/pgsql.vim'

	" vim-bbye adds intelligent buffer deletion
	Plug 'moll/vim-bbye'

	" vlide.vim adds interactive presentations
	Plug 'javier-lopez/vlide.vim'

	" vim-markdown adds better syntax highlighting support for markdown
	Plug 'tpope/vim-markdown'

call plug#end()  " end plugin loading and setup

"  ----------
"  Plugin settings
"  ----------

" base16
colorscheme base16-eighties

if filereadable(expand("~/.vimrc_background"))
	let base16colorspace=256
	source ~/.vimrc_background
endif

" Airline
let g:airline#extensions#tabline#enabled = 2
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts = 1
let g:airline_theme='base16_eighties'
let g:airline#extensions#branch#enabled = 0         " disable branch display in status
let g:airline#extensions#hunks#enabled = 0          " disable diff stats in status
let g:airline#extensions#virtualenv#enabled = 1     " show active virtualenv in status

" Neomake
let g:neomake_python_flake8_maker = { 'exe': expand('~/.pyenv/versions/neovim/bin/flake8') }
let g:neomake_python_enabled_makers = ['flake8']
let g:neomake_sh_enabled_makers = []
let g:neomake_java_enabled_makers = []
let g:neomake_open_list = 2
autocmd BufWritePost * Neomake           " run NeoMake on save
" autocmd BufWritePost,BufEnter * Neomake  " run NeoMake on save and open
nnoremap <Leader>o :lopen<CR>            " open the loclist with +o
nnoremap <Leader>c :lclose<CR>           " close the loclist with +c
nnoremap <Leader>n :lnext<CR>            " jump to the next location with +n
nnoremap <Leader>p :lprev<CR>            " jump to the prev location with +p

" fzf
nnoremap <C-P> :FZF<CR>

" gitgutter
let g:gitgutter_sign_removed_first_line = '^_'

" indentLine
let g:indentLine_faster = 1               " fix performance issue w/ long lines

" wstrip
let g:wstrip_auto = 1

" YouCompleteMe
let g:ycm_path_to_python_interpreter = expand('~/.pyenv/versions/neovim/bin/python')
let g:ycm_autoclose_preview_window_after_insertion = 1

" vim-markdown
let g:markdown_fenced_languages = ['python']
let g:markdown_syntax_conceal = 0

" vlide.vim
let g:vlide_next = 'n'
let g:vlide_previous = 'p'
let g:vlide_statusline = 'Press <n> or <p> to continue'

"  ----------
"  File-specific settings
"  ----------

autocmd Filetype javascript setlocal ts=4 sts=4 sw=4 noexpandtab
autocmd Filetype python setlocal ts=4 sts=4 sw=4 et
autocmd Filetype puppet setlocal ts=2 sts=2 sw=2 et
autocmd Filetype yaml setlocal ts=2 sts=2 sw=2 et syntax=off
autocmd Filetype sql setlocal ts=4 sts=4 sw=4 et syntax=pgsql
au BufNewFile,BufRead *.groovy setf groovy
au BufNewFile,BufRead Jenkinsfile setf groovy
au BufNewFile,BufRead *.vim setf noet

augroup qf
	autocmd!
	autocmd FileType qf set nobuflisted
augroup END
