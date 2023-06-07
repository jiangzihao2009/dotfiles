""""""""""""""""""""""""""""""
" FZF
""""""""""""""""""""""""""""""
let g:fzf_history_dir = g:vim_temp_dir_root."fzf-history"
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

let $FZF_DEFAULT_OPTS = '--layout=reverse --bind "ctrl-/:toggle-preview,ctrl-d:page-down,ctrl-u:page-up,ctrl-p:up,ctrl-n:down"'

if has("patch-8.2.191") || has("nvim")
  let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9} }
else
  let g:fzf_layout = { 'window': 'enew' }
endif
let g:fzf_preview_window = ['right,50%,<70(down,50%)', 'ctrl-/']

" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
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

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --hidden --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

function FilesOrGFiles()
  if system('git rev-parse --is-inside-work-tree 2>/dev/null') =~ 'true'
    execute 'GFiles'
  else
    execute 'Files'
  endif
endfunction

nmap <c-g><c-f> :execute FilesOrGFiles()<cr>
nmap <c-g><c-p> :Files <c-r>=expand("%:p:h")<cr>/<cr>
"J for jump
nmap <c-g><c-j> :Buffers<cr>
nmap <c-g><c-r> :Rg<space>
nmap <c-g><c-t> :BTags<cr>
nmap <c-g><c-g><c-t> :Tags<cr>
nmap <c-g><c-m> :Marks<cr>
nmap <c-g><c-h> :History<cr>
nmap <c-g>/ :History/<cr>
nmap <c-g>; :History:<cr>
" L for log
nmap <c-g><c-g><c-l> :BCommits<cr>
nmap <c-g><c-l> :Commits<cr>
nmap <c-g>m :Maps<cr>

" Insert mode completion
imap <c-g><c-w> <plug>(fzf-complete-word)
imap <c-g><c-p> <plug>(fzf-complete-path)
imap <expr> <c-g><c-f> fzf#vim#complete#path('rg --files')
imap <c-g><c-l> <plug>(fzf-complete-line)

""""""""""""""""""""""""
" Color scheme
""""""""""""""""""""""""
" color dracula
" hi Normal ctermbg=None
colorscheme snazzy
hi CursorLine cterm=underline

""""""""""""""""""""""""
" Nerd Tree
""""""""""""""""""""""""
let NERDTreeShowHidden=0
map <leader>n :NERDTreeToggle<cr>
map <leader><leader>n :NERDTreeFind<cr>

"""""""""""""""""""
" Lightline
"""""""""""""""""""
let g:lightline = {
\     'colorscheme': 'snazzy',
\     'active': {
\       'left': [['mode', 'paste'], ['gitbranch', 'readonly', 'relativepath', 'current_tag', 'modified']],
\       'right': [['linter'], ['lineinfo'], ['filetype']],
\     },
\     'tabline': {'left': [['buffers']], 'right': []},
\     'component': {
\         'lineinfo': '%l:%v %p%%',
\         'current_tag': '%{tagbar#currenttag("%s", "", "f")}',
\     },
\     'component_function': {
\         'gitbranch': 'FugitiveHead',
\     },
\     'component_expand': {'buffers': 'lightline#bufferline#buffers'},
\     'component_type': {'buffers': 'tabsel'},
\ }

let g:lightline#bufferline#show_number = 1
let g:lightline#bufferline#number_separator = '.'
let g:lightline#bufferline#filename_modifier = ':t'

"""""""""""""""""""
" Undo tree
"""""""""""""""""""
nnoremap <leader>u :UndotreeToggle<cr>

"""""""""""""""""""
" togglecursor
"""""""""""""""""""
let g:togglecursor_default="blinking_block"
let g:togglecursor_insert="blinking_line"
let g:togglecursor_leave="blinking_block"
let g:togglecursor_replace="blinking_block"

"""""""""""""""""""
" Tagbar
"""""""""""""""""""
nmap <F8> :TagbarToggle<CR>
let g:tagbar_sort = 0

"""""""""""""""""""
" vim-rooter
"""""""""""""""""""
let g:rooter_silent_chdir = 0
let g:rooter_patterns = [".git", "WORKSPACE", "Makefile"]

"""""""""""""""""""
" vim-oscyank
"""""""""""""""""""
" Copy to system clipboard.
vnoremap <leader>y :OSCYankVisual<CR>
let g:oscyank_term = 'default'

"""""""""""""""""""
" vim-floaterm
"""""""""""""""""""
let g:floaterm_keymap_toggle = '<C-T>'
let g:floaterm_opener = 'edit'
let g:floaterm_width = 0.9
let g:floaterm_height = 0.9
command! Ranger FloatermNew ranger

"""""""""""""""""""
" vim-tmux-navigator
"""""""""""""""""""
" Disable tmux navigator when zooming the Vim pane
" let g:tmux_navigator_disable_when_zoomed = 1

let g:tmux_navigator_no_mappings = 1
noremap <silent> <C-M-H> :<C-U>TmuxNavigateLeft<cr>
noremap <silent> <C-M-J> :<C-U>TmuxNavigateDown<cr>
noremap <silent> <C-M-K> :<C-U>TmuxNavigateUp<cr>
noremap <silent> <C-M-L> :<C-U>TmuxNavigateRight<cr>
