" hSATAC's vimrc
" Ash Wu (aka. cAt) <hsatac@gmail.com>
" Fork me on GITHUB  https://github.com/hSATAC/vimrc

" read https://github.com/hSATAC/vimrc/blob/master/README.md for more info


" For pathogen.vim: auto load all plugins in .vim/bundle
"

let g:python_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

if has("nvim")
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  let base16colorspace=256
endif

execute pathogen#infect()

"---------------------------------------------------------------------------
" ENCODING SETTINGS
"---------------------------------------------------------------------------

set encoding=utf-8
set fileencodings=utf-8,chinese,latin-1
set fileencoding=utf-8
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" General Settings

set nocompatible    " not compatible with the old-fashion vi mode
set bs=2            " allow backspacing over everything in insert mode
set history=50      " keep 50 lines of command line history
set ruler           " show the cursor position all the time
set autoread        " auto read when file is changed from outside
set nu              " display line number
set ts=4            " tabstop 4
set wak=no          " disable GUI alt menu
set noswapfile
set list listchars=tab:»·,trail:·

set shell=/bin/bash

filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

retab " this will cause all existing tabs to be expanded


" auto reload vimrc when editing it
autocmd! bufwritepost .vimrc source ~/.vimrc


syntax on       " syntax highlight
set hlsearch        " search highlighting

if has("gui_running")   " GUI color and font settings
    if has("gui_gtk2")
        set guifont=Bitstream\ Vera\ Sans\ Mono\ 13
    else
        set guifont=Bitstream_Vera_Sans_Mono:h13
    endif
    set t_Co=256          " 256 color mode
    set cursorline        " highlight current line
    colors hybrid
    set background=dark
else
    " terminal color settings
    colors gruvbox
    set background=dark
endif

set clipboard=unnamed   " yank to the system register (*) by default
set showmatch       " Cursor shows matching ) and }
set showmode        " Show current mode
set wildchar=<TAB>  " start wild expansion in the command line using <TAB>
set wildmenu            " wild char completion menu

" ignore these files while expanding wild chars
set wildignore=*.o,*.class,*.pyc

set autoindent      " auto indentation
set incsearch       " incremental search
set nobackup        " no *~ backup files
set copyindent      " copy the previous indentation on autoindenting
set ignorecase      " ignore case when searching
set smartcase       " ignore case if search pattern is all lowercase,case-sensitive otherwise
set smarttab        " insert tabs on the start of a line according to context

" disable sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" TAB setting{
set expandtab        "replace <TAB> with spaces
set softtabstop=4
set shiftwidth=4

au FileType Makefile set noexpandtab
"}

" status line {
set laststatus=2
set statusline=\ %{HasPaste()}%<%-15.25(%f%)%m%r%h\ %w\ \
set statusline+=\ \ \ [%{&ff}/%Y]
set statusline+=\ \ \ %<%20.30(%{hostname()}:%{CurDir()}%)\
set statusline+=%=%-10.(%l,%c%V%)\ %p%%/%L

function! CurDir()
    let curdir = substitute(getcwd(), $HOME, "~", "")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return '[PASTE]'
    else
        return ''
    endif
endfunction

"}

" Remove trailing white spaces
function StripTrailingWhitespace()
  if !&binary && &filetype != 'diff'
    normal mz
    normal Hmy
    %s/\s\+$//e
    normal 'yz<CR>
    normal `z
  endif
endfunction

" C/C++ specific settings
autocmd FileType c,cpp,cc  set cindent comments=sr:/*,mb:*,el:*/,:// cino=>s,e0,n0,f0,{0,}0,^-1s,:0,=s,g0,h1s,p2,t0,+2,(2,)20,*30


" Python
"autocmd BufNewFile,BufRead *.py set ts=2 sts=2 sw=2 noet

" Ruby
autocmd FileType ruby,eruby,yaml set softtabstop=2 shiftwidth=2 tabstop=2
autocmd BufNewFile,BufRead *.eyaml set filetype=yaml
autocmd BufNewFile,BufRead *.cap set filetype=ruby

" Go
"au FileType go au BufWritePre <buffer> GoFmt
"au FileType go
    "\ set ts=2 | " Set tabs to 2 spaces
    "\ set noexpandtab
    "\ set shiftwidth=2
    "\ set softtabstop=2

" Nginx
au BufRead,BufNewFile */nginx/*.conf set ft=nginx

"Restore cursor to file position in previous editing session
"set viminfo='10,\"100,:20,%,n~/.viminfo
"set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

    " Alias Q, W to q, w. ref: http://usevim.com/2013/05/01/not-an-editor-command/
    command! -bang -range=% -complete=file -nargs=* W <line1>,<line2>write<bang> <args>

    command! -bang Q quit<bang>

    "---------------------------------------------------------------------------
    " Tip #382: Search for <cword> and replace with input() in all open buffers
    "---------------------------------------------------------------------------
    fun! Replace()
        let s:word = input("Replace " . expand('<cword>') . " with:")
        :exe 'bufdo! %s/\<' . expand('<cword>') . '\>/' . s:word . '/ge'
        :unlet! s:word
    endfun

    " Highlight trailing whitespaces
    highlight ExtraWhitespace ctermbg=red guibg=red
    match ExtraWhitespace /\s\+$/
    autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
    autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
    autocmd InsertLeave * match ExtraWhitespace /\s\+$/
    autocmd BufWinLeave * call clearmatches()


    "---------------------------------------------------------------------------
    " USEFUL SHORTCUTS
    "---------------------------------------------------------------------------
    " set leader to ,
    let mapleader=","
    let g:mapleader=","


    "replace the current word in all opened buffers
    "map <leader>r :call Replace()<CR>

    " --- move around splits {
    " move to and maximize the below split
    map <C-J> <C-W>j<C-W>_
    " move to and maximize the above split
    map <C-K> <C-W>k<C-W>_
    " move to and maximize the left split
    nmap <c-h> <c-w>h<c-w><bar>
    " move to and maximize the right split
    nmap <c-l> <c-w>l<c-w><bar>
    set wmw=0                     " set the min width of a window to 0 so we can maximize others
    set wmh=0                     " set the min height of a window to 0 so we can maximize others
    " }

    " move around tabs. conflict with the original screen top/bottom
    " comment them out if you want the original H/L
    " go to prev tab
    map <S-H> gT
    " go to next tab
    map <S-L> gt
    map <C-Tab> gt

    " new tab
    map <C-t><C-t> :tabnew<CR>
    " close tab
    map <C-t><C-w> :tabclose<CR>

    if(has("gui_running") && !has("mac")) " gvim win 32 and gvim linux
        map ÷ :tabclose<CR>
    endif
    if(has("gui_macvim") && !has("gui_running")) " macvim console
        map w :tabclose<CR>
    endif

    " ,/ turn off search highlighting
    nmap <leader>/ :set hlsearch! hlsearch?<CR>

    " Bash like keys for the command line
    cnoremap <C-A>      <Home>
    cnoremap <C-E>      <End>
    cnoremap <C-K>      <C-U>

    " ,p toggles paste mode
    nmap <leader>p :set paste!<BAR>set paste?<CR>

    " allow multiple indentation/deindentation in visual mode
    vnoremap < <gv
    vnoremap > >gv

    " :cd. change working directory to that of the current file
    cmap cd. lcd %:p:h

    " Writing Restructured Text (Sphinx Documentation) {
    " Ctrl-u 1:    underline Parts w/ #'s
    noremap  <C-u>1 yyPVr#yyjp
    inoremap <C-u>1 <esc>yyPVr#yyjpA
    " Ctrl-u 2:    underline Chapters w/ *'s
    noremap  <C-u>2 yyPVr*yyjp
    inoremap <C-u>2 <esc>yyPVr*yyjpA
    " Ctrl-u 3:    underline Section Level 1 w/ ='s
    noremap  <C-u>3 yypVr=
    inoremap <C-u>3 <esc>yypVr=A
    " Ctrl-u 4:    underline Section Level 2 w/ -'s
    noremap  <C-u>4 yypVr-
    inoremap <C-u>4 <esc>yypVr-A
    " Ctrl-u 5:    underline Section Level 3 w/ ^'s
    noremap  <C-u>5 yypVr^
    inoremap <C-u>5 <esc>yypVr^A
    "}

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " RENAME CURRENT FILE
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    function! RenameFile()
        let old_name = expand('%')
        let new_name = input('New file name: ', expand('%'), 'file')
        if new_name != '' && new_name != old_name
            exec ':saveas ' . new_name
            exec ':silent !rm ' . old_name
            redraw!
        endif
    endfunction
    map <leader>n :call RenameFile()<cr>

    "---------------------------------------------------------------------------
    " PROGRAMMING SHORTCUTS
    "---------------------------------------------------------------------------

    " switch between file
    nnoremap <leader><leader> <c-^>

    " ,g generates the header guard
    map <leader>g :call IncludeGuard()<CR>
    fun! IncludeGuard()
        let basename = substitute(bufname(""), '.*/', '', '')
        let guard = '_' . substitute(toupper(basename), '\.', '_', "H")
        call append(0, "#ifndef " . guard)
        call append(1, "#define " . guard)
        call append( line("$"), "#endif // for #ifndef " . guard)
    endfun



    " enable omni completion. (ctrl-x ctrl-o)
    set cot=menuone,preview
    autocmd insertleave * if pumvisible() == 0|pclose|endif
    autocmd filetype html,markdown setlocal omnifunc=htmlcomplete#Completetags
    autocmd filetype javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd filetype python setlocal omnifunc=pythoncomplete#Complete
    autocmd filetype xml setlocal omnifunc=xmlcomplete#completetags
    autocmd filetype css set omnifunc=csscomplete#CompleteCSS
    autocmd filetype c set omnifunc=ccomplete#Complete
    autocmd filetype java set omnifunc=javacomplete#Complete
    autocmd filetype php set omnifunc=phpcomplete#CompletePHP
    autocmd FileType ruby set omnifunc=rubycomplete#Complete

    " use syntax complete if nothing else available
    if has("autocmd") && exists("+omnifunc")
        autocmd Filetype *
                    \   if &omnifunc == "" |
                    \       setlocal omnifunc=syntaxcomplete#Complete |
                    \   endif
    endif


    " make CSS omnicompletion work for SASS and SCSS
    autocmd BufNewFile,BufRead *.scss             set ft=scss.css
    autocmd BufNewFile,BufRead *.sass             set ft=sass.css

    " Don't override register when pasting
function! RestoreRegister()
    let @" = s:restore_reg
    if &clipboard == "unnamed"
        let @* = s:restore_reg
    endif
    return ''
endfunction

function! s:Repl()
    let s:restore_reg = @"
    return "p@=RestoreRegister()\<cr>"
endfunction

" NB: this supports "rp that replaces the selection by the contents of @r
vnoremap <silent> <expr> p <sid>Repl()

"---------------------------------------------------------------------------
" PLUGIN SETTINGS
"---------------------------------------------------------------------------

" --- AutoClose - Inserts matching bracket, paren, brace or quote
" fixed the arrow key problems caused by AutoClose
"IF !HAS("GUI_RUNNING")
"set term=linux
"set t_k1=[11~
"set t_k2=[11~
"set t_k3=[11~
"set t_k4=[11~
""imap oa <esc>ki
""imap ob <esc>ji
""imap oc <esc>li
""imap od <esc>hi

"nmap oa k
"nmap ob j
"nmap oc l
"nmap od h

"set <home>=[h
"set <end>=[f

"if $term =~ 'xterm'
"set <f1>=op
"set <f2>=oq
"set <f3>=or
"set <f4>=os
"set <home>=oh
"set <end>=of
"endif
"if $term =~ 'screen'
"set <f1>=op
"set <f2>=oq
"set <f3>=or
"set <f4>=os
"endif
"endif

" --- vim-diff-enhanced
" autocmd VimEnter * CustomDiff histogram

" --- ctrlp
map <leader>f :CtrlPMixed<CR>

let g:ctrlp_regexp = 1
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_prompt_mappings = { 'PrtAdd(".*")': ['<space>'] }
"let g:ctrlp_user_command = {
"\ 'types': {
"\ 1: ['.git', 'cd %s && git ls-files -c -o'],
"\ 2: ['.hg', 'hg --cwd %s locate -I .'],
"\ },
"\ 'fallback': 'find %s -type f'
"\ }

" --- taglist
nmap <silent><F8> :TlistToggle<CR>
imap <silent><F8> <C-o>:TlistToggle<CR>
let Tlist_Use_SingleClick = 1
let Tlist_Use_Right_Window = 1
let Tlist_Show_One_File = 1
let tlist_php_settings = 'php;c:class;d:constant;f:function'
" --- tagbar
nnoremap <silent><F7> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

" --- nerdtree
let NERDTreeShowHidden=1
let g:nerdtree_tabs_open_on_gui_startup=0
nnoremap <silent><F5> :NERDTreeMirrorToggle<CR>

" --- Buffergator
let g:buffergator_viewport_split_policy = "b"
let g:buffergator_suppress_keymaps="1"
let g:buffergator_autodismiss_on_select=1
let g:buffergator_split_size=12
let g:buffergator_autoupdate=1
map <leader>b :BuffergatorToggle<cr>

" --- syntastic
let g:syntastic_puppet_checkers=['puppetlint']
let g:syntastic_shell = "/bin/bash"

" --- gitgutter
highlight clear SignColumn
let g:gitgutter_enabled = 1

" --- copy to osx clipboard
map <F6> :w !pbcopy<CR><CR>

" --- Switch.vim
nnoremap - :Switch<cr>

" --- SingleCompile
nmap <F9> :SCCompile<cr>
nmap <F10> :SCCompileRun<cr>

" --- VimRails

let g:rails_projections = {
      \ "app/presenters/*.rb": { "command": "presenters" },
      \ "app/observers/*.rb": { "command": "observers" },
      \ "app/services/*.rb": { "command": "services" },
      \ "app/extras/form_object/*.rb": {"command": "forms"},
      \ "app/forms/*.rb": {"command": "forms"},
      \ "app/extras/service/*.rb": {"command": ["services", "forms", "models"]},
      \ "app/extras/view_object/*.rb": {"command": "views"},
      \ "app/models/fields/*.rb": {"command": "fields"},
      \ "app/models/fields_data/*.rb": {"command": "fields"},
      \ "app/models/concerns/*.rb": {"command": ["models", "cerns"]},
      \ "app/models/reports/*.rb": {"command": "reports"},
      \ "spec/factories/*.rb": {"command": "factories"},
      \ "spec/factories/fields/*.rb": {"command": "factories"},
      \ "spec/features/*.rb": {"command": "features"},
      \ "spec/support/*.rb": {"command": "supports"},
      \ "lib/tasks/*.rake": {"alternate": ["spec/lib/tasks/%s.rake_spec.rb"]},
      \ "app/assets/javascripts/*.js.coffee": {"alternate": ["spec/javascripts/%s_spec.js.coffee"]},
      \ "spec/javascripts/*_spec.js.coffee": {"alternate": ["app/assets/javascripts/%s.js.coffee"]}
      \ }

" Open/Create related spec/file
function! s:CreateRelated()
  let related = s:GetRelatedFile(expand('%'))
  call s:Open(related)
endfunction

" Return the related filename
function! s:GetRelatedFile(file)
    if match(a:file, '_spec\.rb$') != -1
        return substitute(substitute(a:file, "_spec.rb$", ".rb", ""), '^spec/', 'app/', '')
    else
        return substitute(substitute(a:file, ".rb$", "_spec.rb", ""), '^app/', 'spec/', '')
    endif
endfunction

" Open the related file in a vsplit
function! s:Open(file)
    exec('split ' . a:file)
endfunction

" Register a new command `AC` for open/create a
" related file
command! AC :call <SID>CreateRelated()

" --- dash.vim

function! SearchDash()
    let s:browser = "/usr/bin/open"
    let s:wordUnderCursor = expand("<cword>")
    let s:url = "dash://".s:wordUnderCursor
    let s:cmd ="silent ! " . s:browser . " " . s:url
    execute s:cmd
    redraw!
endfunction
map <leader>h :call SearchDash()<CR>

" --- vim-turbux
let g:no_turbux_mappings = 1
au Filetype ruby
    \ map <leader>t <Plug>SendTestToTmux |
    \ map <leader>r <Plug>SendFocusedTestToTmux |
    \ let g:turbux_command_rspec  = 'zeus rspec'        " default: rspec

au FileType go map <leader>t :Tmux go test<CR>

" --- vim-multiple-cursors
let g:multi_cursor_exit_from_insert_mode = 0

" --- align.vim

    " For Ruby hash
    command! -range AlignHash execute "<line1>,<line2>Align! P01 : =>"

" --- vim-indent-guide
let g:indent_guides_start_level = 2
"let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_color_change_percent = 5
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=235
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=235

" --- vim-airline
set ttimeoutlen=50
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_powerline_fonts = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#syntastic#enabled = 0
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#csv#enabled = 0
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#virtualenv#enabled = 1

let g:airline_theme_patch_func = 'AirlineThemePatch'
function! AirlineThemePatch(palette)
    if g:airline_theme == 'wombat'
        for colors in values(a:palette.inactive)
            let colors[3] = 235
        endfor
    endif
endfunction

" --- easymotion
hi EasyMotionTarget ctermbg=none ctermfg=green
hi EasyMotionShade  ctermbg=none ctermfg=blue

" --- Startify
let g:startify_change_to_vcs_root = 1
let g:startify_custom_header = [
\ '                                          _',
\ '             |\___/|                      \\',
\ '             )     (    |\_/|              ||',
\ '            =\     /=   )a a `,_.-""""-.  //',
\ '              )===(    =\Y_= /          \//',
\ '             /     \     `"`\       /    /',
\ '             |     |         |    \ |   /',
\ '            /       \         \   /- \  \',
\ '            \       /         || |  // /`',
\ '     _/\_/\_/\_   _/_/\_/\_/\_((_|\((_//\_/\_/\_/\_',
\ '',
\ '',
\ ]

" --- snippet

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

""" SuperTab like snippets behavior.
imap <expr><TAB>
 \ pumvisible() ? "\<C-n>" :
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

""" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
