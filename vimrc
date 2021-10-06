
""""""""""""""""""""""""""""""
" => Loading plugins
""""""""""""""""""""""""""""""
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

call plug#begin()

" Template
Plug 'preservim/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'altercation/vim-colors-solarized'
Plug 'lifepillar/vim-solarized8'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'chr4/nginx.vim'
Plug 'rust-lang/rust.vim'
Plug 'leafgarland/typescript-vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

" Custom
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'tpope/vim-rhubarb'
Plug 'lervag/vimtex'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'pappasam/coc-jedi', { 'do': 'yarn install --frozen-lockfile && yarn build' }
Plug 'josa42/vim-lightline-coc'
Plug 'SidOfc/mkdx'
" Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'mustache/vim-mustache-handlebars'
Plug 'liuchengxu/vim-which-key'

" On-demand lazy load
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

call plug#end()

source ~/.vim/coc-default.vim
source ~/.vim/set_tabline.vim
source ~/.vim/template.vim


try
 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => WhichKey
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <leader> :<c-u>WhichKey  ','<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Solarized
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax on
" let g:solarized_termcolors=256
set t_Co=256
set background=dark
colorscheme solarized8
hi Normal guibg=NONE ctermbg=NONE
"""""""""""""""""""""""""
" => Personal changes
""""""""""""""""""""""""""""""
:set number

" TIMESTAMP with F3"
nmap <F3> a<C-R>=strftime("%FT%T%z")<CR> 

" Quickly open a markdown buffer for scribble
let g:vimwiki = "/mnt/c/Users/JeremyTheocharis/OneDrive - UMH Systems GmbH/vimwiki"
command! -nargs=1 NewWiki :execute ":e" vimwiki . strftime("%FT%T%z") . "-<args>.md"
map <leader>x :NewWiki 

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
