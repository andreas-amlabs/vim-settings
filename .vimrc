set packpath+=~/.vim/pack/.

set termencoding=latin1
set laststatus=2
set tabpagemax=30

"autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkgreen guibg=red
"set nocompatible
set bs=2 "set backspace to be able to delete previous characters"Enable line numbering, taking up 6 spaces
"set number
"" autocmd VimEnter * CCTreeLoadDB $AXIS_TOP_DIR/cscope.out
"
"let CSCOPE_DB = "/tmp/cscope.out"
"
function! LoadCscope()
  let db = findfile("cscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/cscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  endif
endfunction
au BufEnter /* call LoadCscope()

""if has("cscope")
    ""set csto=0
    ""set cst
    ""set nocsverb
    " add any database in current directory
    "if filereadable("/tmp/cscope.out")
    ""if filereadable("$AXIS_TOP_DIR/cscope.out")
    ""cs add $AXIS_TOP_DIR/cscope.out
    """ else add database pointed to by environment
    ""elseif $CSCOPE_DB != ""
    ""cs add $CSCOPE_DB
    ""endif
    ""set csverb
""endif

" jump to a function declaration
nmap <silent> <C-\> :cs find s <C-R>=expand("<cword>")<CR><CR>1<CR><CR>
" " show a list of where function is called
nmap <silent> <C-_> :cs find c <C-R>=expand("<cword>")<CR><CR>

"Turn off word wrapping
set wrap!

"Turn on smart indent
set smartindent
set tabstop=2 "set tab character to 4 characters
set expandtab "turn tabs into whitespace
set shiftwidth=2 "indent width for autoindent
"filetype indent on "indent depends on filetype
autocmd FileType sh set tabstop=8
autocmd FileType sh set noexpandtab
autocmd FileType fpp set tabstop=8
autocmd FileType fpp set noexpandtab

" CTI Imagine
autocmd FileType hh set tabstop=4
autocmd FileType cc set tabstop=4

"Shortcut to auto indent entire file
"nmap <F11> 1G=G
"imap <F11> <ESC>1G=Ga
set pastetoggle=<F1>

"Turn on incremental search with ignore case (except explicit caps)
set incsearch
set ignorecase
set smartcase
set ic
set cursorline

"Informative status line
"set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l/%L\ (%p%%)]

"Set color scheme
set t_Co=257
syntax enable
"autocmd Syntax * syn match ExtraWhitespace /\s\+$/

"Enable indent folding
"set foldenable
"set fdm=indent

"Set space to toggle a fold
"nnoremap <space> za

"Hide buffer when not in window (to prevent relogin with FTP edit)
"set bufhidden=hide

"Have 3 lines of offset (or buffer) when scrolling
"set scrolloff=3
set tags=tags;/

let Tlist_Ctags_Cmd = "/usr/bin/ctags"
let Tlist_WinWidth = 50
map <F2> <Plug>Cvsdiffv
map <F4> :TlistToggle<cr>
"map <F8> :!/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

set viminfo='10,\"100,:20,%,n~/.viminfo

set wildmenu
set wildmode=list:longest,full

map [I :cs find c <C-r><C-w><CR>
set csto=1

augroup vimrcEx
au!
" For all text files set 'textwidth' to 78 characters.
"autocmd FileType text setlocal textwidth=78

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   exe "normal g`\"" |
\ endif
augroup END


set completeopt=longest,menu,preview
filetype plugin on
set ofu=syntaxcomplete#Complete
"set mouse=a
"map <C-t><home> :tabe .<cr>
"map <C-t><end> :tabc<cr>
"map <C-t><up> :tabr<cr>
"map <C-t><down> :tabl<cr>
"map <C-t><left> :tabp<cr>
"map <C-t><right> :tabn<cr>
map <A-n> :tabe .<cr>
map <A-x> :tabc<cr>
map <A-k> :tabr<cr>
map <A-j> :tabl<cr>
map <A-h> :tabp<cr>
map <A-l> :tabn<cr>
map <C-n> :tabe .<cr>
map <C-q> :tabc<cr>
map <C-k> :tabr<cr>
map <C-j> :tabl<cr>
map <C-h> :tabp<cr>
map <C-l> :tabn<cr>
set lazyredraw
set ttimeoutlen=100

" Alt-right/left to navigate forward/backward in the tags stack
"map <A-h> <C-T>
"map <A-l> <C-]>
"map <M-Left> <C-T>
"map <M-Right> <C-]>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

map <C-@> :set hls!<bar>set hls?<cr>
map <F6> :cprevious<cr>
map <F7> :cnext<cr>
map <F8> : call Compile()<CR>
func! Compile()
  exec "w"
  exec "ninja -C b test"
endfunc

set hlsearch
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
set viminfo^=h

set clipboard+=unnamed
set synmaxcol=400

let g:vim_markdown_folding_disabled=1
set nofoldenable


set undodir=~/.vim/undodir
set undofile
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set undoreload=20000      " use
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep
set nobackup
set noswapfile

function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction

vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>

nmap n nzz
nmap N Nzz
" Press i to enter insert mode, and ii to exit.
:imap ii <Esc>

" http://vim.wikia.com/wiki/Faster_loading_of_large_files
" Protect large files from sourcing and other overhead.
" Files become read only
if !exists("my_auto_commands_loaded")
  let my_auto_commands_loaded = 1
  " Large files are > 10M
  " Set options:
  " eventignore+=FileType (no syntax highlighting etc
  " assumes FileType always on)
  " noswapfile (save copy of file)
  " bufhidden=unload (save memory when other file is viewed)
  " buftype=nowritefile (is read-only)
  " undolevels=-1 (no undo possible)
  let g:LargeFile = 1024 * 1024 * 10
  augroup LargeFile
    autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f) > g:LargeFile | set eventignore+=FileType | setlocal noswapfile bufhidden=unload undolevels=-1 | else | set eventignore-=FileType | endif
    augroup END
  endif

let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
"highlight YcmErrorSection ctermfg=160 ctermbg=51
"autocmd ColorScheme * highlight YcmErrorSection ctermfg=160 ctermbg=51
map <F%> :tabdo e!<CR>

let NERDTreeShowHidden=1

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
