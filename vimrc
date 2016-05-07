" .vimrc config
"
" Focused on Ubuntu and GVim.
"
" Vundle used for module management.
"
"
" Written/compiled 2013 by Ken Hampson, hampsonk+github@gmail.com


" Facts
let os = substitute(system('uname'), "\n", "", "")

" Vundle incantation
" filetype on
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

Plugin 'gmarik/vundle'

" Functions
function! s:setupWrapping()
  set wrap
  set linebreak
  set textwidth=72
  set nolist
endfunction


" Basics
set nocompatible	" Use vim, no vi defaults
set encoding=utf-8	" Set default encoding to UTF-8
set ffs=unix,dos,mac	" Use Unix as the standard file type
set noswapfile
set nowb
set history=1000
set backup                  " Backups are nice ...
set backupdir=~/.vim/back

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","


if has('persistent_undo')
  set undofile              " So is persistent undo ...
  set undolevels=1000       " Maximum number of changes that can be undone
  set undoreload=10000      " Maximum number lines to save for undo on a buffer reload
  set undodir=~/.vim/undo
endif

" UI
set background=dark
set number                      " Show line numbers
set ruler                       " Show line and column number
set shortmess+=filmnrxoOtT      " Abbrev. of messages (avoids 'hit enter')
set cursorline                  " highlight the current line (this can slow things down quite a bit); changing this requires a restart of gvim to take effect - reloading the .vimrc isn't enough
set showmatch			        " Show matching brackets when text indicator is over them
set mat=2			            " How many tenths of a second to blink when matching brackets
set cmdheight=2			        " Height of the command bar
set lazyredraw			        " Don't redraw while executing macros (good performance config)

set list                          " Show invisible characters
set listchars=""                  " Reset the listchars
set listchars=tab:\ \             " a tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.            " show trailing spaces as dots
set listchars+=extends:>          " The character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen
set listchars+=precedes:<         " The character to show in the last column when wrap is
                                  " off and the line continues beyond the left of the screen

set colorcolumn=160             " Draw a vertical line down the screen at this column to mark the max line width


" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500


" GUI customization
set guicursor=a:blinkon0 " Shut off the blinking cursor
"set guioptions-=T	"remove toolbar
"set guioptions-=L
"set guioptions=-l	" Remove Menu toolbar

if has("gui_running")
    set guioptions-=T                       " Remove Toolbar.  Currently only affects Win32, GTK+, Motif, Photon and Athena GUIs
    set guioptions+=e                       " Add tab pages when indicated with 'showtabline'
    set t_Co=256                            " Make Vim use 256 colors
    set guitablabel=%M\ %t

  if has("autocmd")
    " Automatically resize splits when resizing MacVim window
    autocmd VimResized * wincmd =
  endif
else
    autocmd VimEnter * :colors torte        " Torte seems to work better visually in a greater variety of terminals.
endif


if os == "Darwin"
  set guifont=Inconsolata\ for\ Powerline:h13
else
    set guifont=Ubuntu\ Mono\ for\ Powerline\ 12
    " set guifont=Ubuntu\ Mono\ for\ Powerline\ 14
endif


" Search
set hlsearch          " highlight matches
set incsearch         " incremental searching
set ignorecase        " searches are case insensitive...
set smartcase         " ... unless they contain at least one capital letter


" Editing/Formatting
set backspace=indent,eol,start		" Configure backspace so it acts more intuitively

" nnoremap <leader>fef :normal! gg=G``<CR> " Format the entire file

" upper/lower word
nmap <leader>u mQviwU`Q
nmap <leader>l mQviwu`Q

" upper/lower first char of word
nmap <leader>U mQgewvU`Q
nmap <leader>L mQgewvu`Q

" swap two words
nmap <silent> gw :s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>`'

" if exists("g:enable_mvim_shift_arrow")
"   let macvim_hig_shift_movement = 1 " mvim shift-arrow-keys
" endif

set magic				    " For regular expressions turn magic on


" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()


Plugin 'Lokaltog/vim-easymotion'
Plugin 'mbbill/undotree'

Plugin 'terryma/vim-multiple-cursors'
let g:multi_cursor_use_default_mapping=0

" Default next mapping (<C-n>) conflicts with YankRing, so switching
let g:multi_cursor_next_key='<C-l>'
let g:multi_cursor_prev_key='<C-k>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" Default highlighting (see help :highlight and help :highlight-link)
highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
highlight link multiple_cursors_visual Visual


Plugin 'autowitch/hive.vim'
" for .hql files
au BufNewFile,BufRead *.hql set filetype=hive expandtab

" for .q files
au BufNewFile,BufRead *.q set filetype=hive expandtab


Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-repeat'
" Plugin 'matchit.zip'


" Tabbing, text and indent related
set expandtab		" use spaces instead of tabs
set smarttab
"set softtabstop=2
set shiftwidth=4	    " 1 tab == 4 spaces
set tabstop=4
set autoindent
set si			        "Smart indent
set pastetoggle=<F4>

Plugin 'autowitch/hive.vim'
" for .hql files
au BufNewFile,BufRead *.hql set filetype=hive expandtab

" for .q files
au BufNewFile,BufRead *.q set filetype=hive expandtab


Plugin 'nathanaelkane/vim-indent-guides'

" Auto-enable the indent guides plugin for Python files
autocmd vimenter * let g:indent_guides_enable_on_vim_startup = 1
"au BufReadPost *.py let g:indent_guides_enable_on_vim_startup = 1

"autocmd vimenter * :indentguidesenable

" In order to work with the desert colorscheme, need to turn off autocoloring
autocmd vimenter * let g:indent_guides_auto_colors = 0		" incl
"autocmd BufReadPost *.py let g:indent_guides_auto_colors = 0		" incl

" And manually set the colors
"hi IndentGuidesOdd  guibg=#404040
" this is a black-ish color: 212121
"hi IndentGuidesEven guibg=#404040

" Ratchet down the width of each marker
autocmd vimenter * let g:indent_guides_guide_size = 1
"autocmd BufReadPost *.py let g:indent_guides_guide_size = 1

" Don't start at the initial (left-most) level -- wait until we get at least 1 tab in
autocmd vimenter * let g:indent_guides_start_level = 1
"autocmd BufReadPost *.py let g:indent_guides_start_level = 1

autocmd vimenter * hi IndentGuidesEven guibg=#535353
"autocmd BufReadPost *.py hi IndentGuidesEven guibg=#535353
autocmd vimenter * hi IndentGuidesOdd guibg=#757575
"autocmd BufReadPost *.py hi IndentGuidesOdd guibg=#757575

" Now that we've setup the plugin, enable it
autocmd vimenter * :IndentGuidesEnable
"autocmd BufReadPost *.py :IndentGuidesEnable


" Linebreak on 500 characters
set lbr
set tw=500

" In order to work with the desert colorscheme, need to turn off autocoloring
" let g:indent_guides_auto_colors = 0

" Text wrapping
set nowrap
set textwidth=0
set wrapmargin=0

" Buffer/file management

" cd to the directory containing the file in the buffer
nmap <silent> <leader>cd :lcd %:h<CR>

" Create the directory containing the file in the buffer
nmap <silent> <leader>md :!mkdir -p %:p:h<CR>

Plugin 'vim-scripts/ZoomWin'
Plugin 'scrooloose/nerdtree'

set autoread			" Set to auto read when a file is changed from the outside

" Fast saving
nmap <leader>w :w!<cr>
set hid				    " A buffer becomes hidden when it is abandoned

Plugin 'rgarver/Kwbd.vim'
nnoremap <silent> ,d :<C-u>Kwbd<CR>

set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem,*.pyc
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*
set wildignore+=*/tmp/cache/assets/*/sprockets/*,*/tmp/cache/assets/*/sass/*
set wildignore+=*.swp,*~,._*
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too

" Clipboard
if os == "Linux"
  set clipboard=unnamedplus
elseif os == "Darwin"
  set clipboard=unnamed
endif

" Status bar and formatting
set laststatus=2                       " Always show the status line (otherwise vim-airline won't appear right away)
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l

" Plugin 'bling/vim-airline'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

Plugin 'edkolev/tmuxline.vim'


let g:airline_theme = 'powerlineish'
" let g:airline_theme = 'molokai'
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#tabline#enabled = 0
let g:airline_powerline_fonts = 1
let g:airline_detect_whitespace = 0


" Git
Plugin 'tpope/vim-fugitive'
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gp :Git push<CR>
nnoremap <silent> <leader>gr :Gread<CR>:GitGutter<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>:GitGutter<CR>
nnoremap <silent> <leader>ge :Gedit<CR>
nnoremap <silent> <leader>gg :GitGutterToggle<CR>
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>


" Code

Plugin 'scrooloose/syntastic'

" Syntastic settings
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
let g:syntastic_error_symbol='✗'
let g:syntastic_auto_loc_list=1         " the error window will be automatically opened when errors are detected, and closed when none are detected


" auto-complete for Python
" Plugin 'davidhalter/jedi-vim'

" combo auto-complete, which wraps jedi, among other things
Plugin 'Valloric/YouCompleteMe'

Plugin 'jmcantrell/vim-virtualenv'

let g:virtualenv_directory='~/workspace/virtualenvs'


" Plugin 'Shougo/neocomplete.vim'
" let g:acp_enableAtStartup = 0
" let g:neocomplete#enable_at_startup = 1
" let g:neocomplete#enable_smart_case = 1
" let g:neocomplete#enable_auto_delimiter = 1
" let g:neocomplete#max_list = 15
" let g:neocomplete#force_overwrite_completefunc = 1
" 
" autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
" autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
" autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
" autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
" autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
" 
" if !exists('g:neocomplete#sources#omni#input_patterns')
"   let g:neocomplete#sources#omni#input_patterns = {}
" endif
" 
" let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
" let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
" let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'



if executable('ctags')
  Plugin 'majutsushi/tagbar'
endif

" Pig syntax highlighting
Plugin 'motus/pig.vim'

" Finding files
Plugin 'kien/ctrlp.vim'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files --exclude-standard -co']


" Ack stuff
if executable('ack-grep')
  let g:ackprg="ack-grep -H --nocolor --nogroup --column"
   Plugin 'mileszs/ack.vim'
elseif executable('ack')
  Plugin 'mileszs/ack.vim'
elseif executable('ag')
  Plugin 'mileszs/ack.vim'
  let g:ackprg = 'ag --nogroup --nocolor --column --smart-case'
endif


" Colors
" Plugin 'rking/vim-detailed'
" Plugin 'chriskempson/vim-tomorrow-theme'
" colorscheme Tomorrow-Night-Bright
" autocmd BufEnter,BufNewFile {*.rb,Gemfile,Rakefile,Vagrantfile,Thorfile,Procfile,Guardfile,config.ru,*.rake} colorscheme detailed
" autocmd BufLeave {*.rb,Gemfile,Rakefile,Vagrantfile,Thorfile,Procfile,Guardfile,config.ru,*.rake} colorscheme Tomorrow-Night-Bright
" colorscheme ir_black
colorscheme desert

" Languages
" Plugin 'tpope/vim-rails'
" let g:rubycomplete_buffer_loading = 1
" let g:rubycomplete_classes_in_global = 1
" let g:rubycomplete_rails = 1

Plugin 'cakebaker/scss-syntax.vim'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'groenewege/vim-less'

Plugin 'amirh/HTML-AutoCloseTag'
Plugin 'tpope/vim-haml'
Plugin 'slim-template/vim-slim'

Plugin 'elzr/vim-json'
Plugin 'pangloss/vim-javascript'
Plugin 'kchmck/vim-coffee-script'
autocmd BufRead,BufNewFile {*.coffee,Cakefile} setf coffee
Plugin 'jQuery'

Plugin 'tfnico/vim-gradle'

" Plugin 'jnwhiteh/vim-golang'

Plugin 'tpope/vim-markdown'
autocmd BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setf markdown

Plugin 'luochen1990/rainbow'
let g:rainbow_active = 0        " :RainbowToggle


Plugin 'chrisbra/csv.vim'

"Shell
Plugin 'Shougo/vimshell.vim'


" LustyBuffer, LustyExplorer, LustyJuggler
Plugin 'sjbach/lusty'
"Plugin 'vim-scripts/LustyJuggler'
"Plugin 'vim-scripts/LustyExplorer'

" LustyJuggler settings
let g:LustyJugglerDefaultMappings = 1
" nmap <silent> <Leader>l :LustyJuggler<CR>
" nmap <silent> <Leader>k :LustyBufferExplorer<CR>


Plugin 'vim-scripts/mru.vim'
Plugin 'vim-scripts/YankRing.vim'

" All plugins above here
call vundle#end()


syntax enable		           	            " Turn on syntax highlighting allowing local overrides
au BufReadPost *.pgsql set syntax=sql		" Force .pgsql files to be syntax-highlighted as SQL files instead of plain text
au BufReadPost *.t set syntax=perl		    " Force .t files to be syntax-highlighted as Perl files instead of plain text

filetype plugin indent on

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,1000 bd!<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
" set viminfo^=%
" set viminfo=%

" Related to sessionman
" set viminfo='100,<500,s10,h,!,%
set viminfo='100,<500,s10,h,%

if has("gui_running")
	" autocmd VimEnter * SessionOpenLast
	" autocmd VimEnter * if argc() == 0 | SessionOpenLast | endif
endif



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vimgrep searching and cope displaying
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSelection('gv')<CR>

" Open vimgrep and put the cursor in the right position
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

" Vimgreps in the current file
map <leader><space> :vimgrep // <C-R>%<C-A><right><right><right><right><right><right><right><right><right>

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search with vimgrep, display your results in cope by doing:
"   <leader>cc
"
" To go to the next search result do:
"   <leader>n
"
" To go to the previous search results do:
"   <leader>p
"
map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>n :cn<cr>
map <leader>p :cp<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scripbble
map <leader>q :e ~/buffer<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

" ============

" From page: http://vim.wikia.com/wiki/Smart_mapping_for_tab_completion

function! Smart_TabComplete()
  let line = getline('.')                         " current line

  let substr = strpart(line, -1, col('.')+1)      " from the start of the current
                                                  " line to one character right
                                                  " of the cursor
  let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
  if (strlen(substr)==0)                          " nothing to match on empty string
    return "\<tab>"
  endif
  let has_period = match(substr, '\.') != -1      " position of period, if any
  let has_slash = match(substr, '\/') != -1       " position of slash, if any
  if (!has_period && !has_slash)
    return "\<C-X>\<C-P>"                         " existing text matching
  elseif ( has_slash )
    return "\<C-X>\<C-F>"                         " file matching
  else
    return "\<C-X>\<C-O>"                         " plugin matching
  endif
endfunction

" Map to ctrl+tab
inoremap <C-tab> <c-r>=Smart_TabComplete()<CR>

" Change the background color of the auto complete dropdown
" From: http://www.kentcowgill.org/blog/view/167
highlight Pmenu ctermfg=1 ctermbg=4 guibg=grey30

