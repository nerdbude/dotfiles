" NERDBUDE VIMRC CONFIGFILE
"
"########################
"## BASIC CONFIGS #######
"########################
"
set number		"linenumbers from the start
set history=100		"history is 100 entries
colo cyber23
filetype plugin on
"set cursorline
"set cursorcolumn
set encoding=utf-8
set ruler
syntax on

"########################
"## PLUGINS #############
"########################
"
"use pathogen for plugins

execute pathogen#infect()
call pathogen#infect()

"########################
"## STATUSLINE ##########
"########################
"
set laststatus=2
let g:lightline = {
	\ 'colorscheme': 'cyber23',
	\ }


"########################
"## NERDTree Config #####
"########################
"
let NERDTreeIgnore=['\.git$', '\.jpg$', '\.mp3$', '\.pdf$', '\.png$', '\.zip$', '\.jpeg$']

"########################
"## STARTIFY ############
"########################
"
let g:startify_custom_header = [
\ '	██╗   ██╗██╗███╗   ███╗',
\ '	██║   ██║██║████╗ ████║',
\ '	██║   ██║██║██╔████╔██║',
\ '	╚██╗ ██╔╝██║██║╚██╔╝██║',
\ '	 ╚████╔╝ ██║██║ ╚═╝ ██║',
\ '	  ╚═══╝  ╚═╝╚═╝     ╚═╝',
\ ]
let g:startify_lists = [
\ { 'type': 'files',	'header': ['    last modified:'] },
\ { 'type': 'bookmarks', 'header': ['    bookmarks:'] },
\ ]

let g:startify_bookmarks = [ {'w': '~/vimwiki/index.wiki'}, {'v': '~/.vimrc'}, {'x': '~/.xmonad/xmonad.hs'}, {'b': '~/.config/xmobar/xmobarrc0'}, {'o': '~/etc/nixos/configuration.nix'}]

" #######################
" ## KEYMAPPINGS ########
" #######################
"
nnoremap <F3> :NERDTreeToggle<cr>
