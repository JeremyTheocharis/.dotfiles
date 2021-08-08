
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

call plug#end()

source ~/.vim/coc-default.vim
source ~/.vim/set_tabline.vim
source ~/.vim/template.vim


try

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Solarized
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax on
let g:solarized_termcolors=16
set t_Co=16 
set background=dark
colorscheme solarized

""""""""""""""""""""""""""""""
" => Personal changes
""""""""""""""""""""""""""""""
:set number

" TIMESTAMP with F3"
nmap <F3> a<C-R>=strftime("%FT%T%z")<CR> 

" Quickly open a markdown buffer for scribble
let g:vimwiki = "/home/jeremy/OneDrive/vimwiki/"
command! -nargs=1 NewWiki :execute ":e" vimwiki . strftime("%FT%T%z") . "-<args>.md"
map <leader>x :NewWiki 

" Markdown
let g:mkdx#settings = { 'map': { 'prefix': '<leader><leader>' } }

" Show Booksmarks on Startup
let NERDTreeShowBookmarks=1
" au VimEnter *  NERDTree

" FZF

nnoremap <silent> <C-f> :GFiles<CR>
nnoremap <silent> <Leader>f :Rg<CR>


catch
endtry
