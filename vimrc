" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Dec 17
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
" set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		    " show the cursor position all the time
set showcmd		    " display incomplete commands
set incsearch		" do incremental searching
" set ignorecase      " ignore case in searches
" set spell           " spell checking on

set number
set expandtab
set tabstop=4
set shiftwidth=4
set background=dark

" Tags file
set tags=./tags

" Set text encoding to UTF-8 by default
set encoding=utf-8

" Status line
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L] 
set laststatus=2 

" Always show tabs line
set showtabline=2

" Windows resize
nnoremap <C-H> :vertical resize -5<cr>
nnoremap <C-K> :resize +5<cr>
nnoremap <C-J> :resize -5<cr>
nnoremap <C-L> :vertical resize +5<cr>

" Tabs navigation
nnoremap <C-p>  :tabnext<CR>
nnoremap <C-o>  :tabprev<CR>
nnoremap <C-n>  :tabnew<CR>

" Space to fold/unfold
nnoremap <space> za

" Toggle NerdTREE with F2
nnoremap <silent> <F2> :NERDTreeToggle<CR>

" Toggle Taglist with F3
nnoremap <silent> <F3> :TlistToggle<CR>

" Toggle MRU with F4
nnoremap <silent> <F4> :MRU<CR>

" Toggle buffers with F5
nnoremap <F5> :buffers<CR>:buffer<Space>

" Set color schema
color desert

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
set syntax=on
set hlsearch

autocmd BufNewFile,BufRead *.cgi set syntax=perl
autocmd BufNewFile,BufRead *.tt  set syntax=html

" Set tab label to filename only
set tabline=%!MyTabLine()

function MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    " select the highlighting
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T' 

    " the label is made by MyTabLabel()
    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'

  " right-align the label to close the current tab page
  if tabpagenr('$') > 1 
    let s .= '%=%#TabLine#%999Xclose'
  endif

  return s
endfunction

function MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let label =  bufname(buflist[winnr - 1]) 
  return fnamemodify(label, ":t") 
endfunction

" Always set autoindenting on
set autoindent

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" --- Per-project config
command Pmeetapp :set noexpandtab

" --- NERDTree

let NERDTreeShowHidden = 1

" --- TagList

" open tags panel on the right
let Tlist_Use_Right_Window = 1

" Pathogen
execute pathogen#infect()
call pathogen#helptags()

" Vdebug
let g:vdebug_options = {}
let g:vdebug_options["port"] = 9000
let g:vdebug_options["break_on_open"]=0

" CtrlP
let g:ctrlp_map = '<F6>'

" Vuejs
autocmd BufNewFile,BufRead *.vue set filetype=html "When opening or creating a .vue file set the filetype to HTML for proper rendering

" Ale
let g:ale_perl_perlcritic_showrules = 1

" Gitblame
nnoremap <Leader>gb :Gblame<CR>
