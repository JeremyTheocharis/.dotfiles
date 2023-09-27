try
 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => WhichKey
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <leader> :<c-u>WhichKey  ','<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Solarized
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax on
let g:solarized_termcolors=256
set t_Co=256
set background=dark
let g:solarized_termtrans=1
colorscheme solarized8
" hi Normal guibg=NONE ctermbg=NONE
"""""""""""""""""""""""""
" => Personal changes
""""""""""""""""""""""""""""""
:set number

" TIMESTAMP with F3"
nmap <F3> a<C-R>=strftime("%FT%T%z")<CR> 

" Markdown
let g:mkdx#settings = { 'map': { 'prefix': '<leader><leader>' } }

" Show Booksmarks on Startup
let NERDTreeShowBookmarks=1
let NERDTreeChDirMode=2

" https://stackoverflow.com/questions/2066590/automatically-quit-vim-if-nerdtree-is-last-and-only-buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" au VimEnter *  NERDTree

" FZF
nnoremap <silent> <C-f> :GFiles<CR>
nnoremap <silent> <Leader>f :Rg<CR>
nnoremap <silent> <Leader>fw :Rg <C-R><C-W><CR>

" Respect VIM colorscheme of FZF
function! s:update_fzf_colors()
  let rules =
  \ { 'fg':      [['Normal',       'fg']],
    \ 'bg':      [['Normal',       'bg']],
    \ 'hl':      [['Comment',      'fg']],
    \ 'fg+':     [['CursorColumn', 'fg'], ['Normal', 'fg']],
    \ 'bg+':     [['CursorColumn', 'bg']],
    \ 'hl+':     [['Statement',    'fg']],
    \ 'info':    [['PreProc',      'fg']],
    \ 'prompt':  [['Conditional',  'fg']],
    \ 'pointer': [['Exception',    'fg']],
    \ 'marker':  [['Keyword',      'fg']],
    \ 'spinner': [['Label',        'fg']],
    \ 'header':  [['Comment',      'fg']] }
  let cols = []
  for [name, pairs] in items(rules)
    for pair in pairs
      let code = synIDattr(synIDtrans(hlID(pair[0])), pair[1])
      if !empty(name) && code > 0
        call add(cols, name.':'.code)
        break
      endif
    endfor
  endfor
  let s:orig_fzf_default_opts = get(s:, 'orig_fzf_default_opts', $FZF_DEFAULT_OPTS)
  let $FZF_DEFAULT_OPTS = s:orig_fzf_default_opts .
        \ empty(cols) ? '' : (' --color='.join(cols, ','))
endfunction

augroup _fzf
  autocmd!
  autocmd ColorScheme * call <sid>update_fzf_colors()
augroup END

catch
endtry