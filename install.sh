#!/usr/bin/env bash

# Script from https://www.gitpod.io/docs/configure/user-settings/dotfiles to copy home_files into home folder

current_dir="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"
dotfiles_source="${current_dir}/home_files"

while read -r file; do

    relative_file_path="${file#"${dotfiles_source}"/}"
    target_file="${HOME}/${relative_file_path}"
    target_dir="${target_file%/*}"

    if test ! -d "${target_dir}"; then
        mkdir -p "${target_dir}"
    fi

    printf 'Installing dotfiles symlink %s\n' "${target_file}"
    ln -sf "${file}" "${target_file}"

done < <(find "${dotfiles_source}" -type f)


# Step 2: Install neovim
cd $(mktemp -d)

URL="https://github.com/neovim/neovim/releases/latest/download/nvim.appimage"
if test -n "$NEOVIM_VERSION"
then
    URL="https://github.com/neovim/neovim/releases/download/$NEOVIM_VERSION/nvim.appimage"
fi

curl -LO "$URL"
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract >/dev/null
mkdir -p /home/gitpod/.local/bin
ln -s $(pwd)/squashfs-root/AppRun /home/gitpod/.local/bin/nvim

# Step 3: set vim command to neovim
echo 'alias vim="nvim"' >> ~/.bashrc
echo 'alias oldvim="\vim"' >> ~/.bashrc

# Step 4: Install and activate neovim plugins
mkdir -p ~/.config/nvim/autoload
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Create init.vim file for neovim configuration
echo "call plug#begin('~/.config/nvim/plugged')" >> ~/.config/nvim/init.vim

echo "Plug 'preservim/nerdtree'" >> ~/.config/nvim/init.vim
echo "Plug 'altercation/vim-colors-solarized'" >> ~/.config/nvim/init.vim
echo "Plug 'lifepillar/vim-solarized8'" >> ~/.config/nvim/init.vim
echo "Plug 'plasticboy/vim-markdown'" >> ~/.config/nvim/init.vim
echo "Plug 'itchyny/lightline.vim'" >> ~/.config/nvim/init.vim
echo "Plug 'jiangmiao/auto-pairs'" >> ~/.config/nvim/init.vim
echo "Plug 'tpope/vim-commentary'" >> ~/.config/nvim/init.vim
echo "Plug 'SidOfc/mkdx'" >> ~/.config/nvim/init.vim
echo "Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }" >> ~/.config/nvim/init.vim
echo "Plug 'josa42/vim-lightline-coc'" >> ~/.config/nvim/init.vim
echo "Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }" >> ~/.config/nvim/init.vim
echo "Plug 'liuchengxu/vim-which-key'" >> ~/.config/nvim/init.vim
echo "Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }" >> ~/.config/nvim/init.vim

echo "call plug#end()" >> ~/.config/nvim/init.vim

# Install the plugins
nvim +PlugInstall +qall

echo "Neovim and plugins are installed."

# Step 5: Apply custom vim configs from ~/.config/nvim/custom.vim in neovim
echo "source ~/.config/nvim/custom.vim" >> ~/.config/nvim/init.vim
echo "source ~/.config/nvim/template.vim" >> ~/.config/nvim/init.vim
echo "source ~/.config/nvim/set_tabline.vim" >> ~/.config/nvim/init.vim

# Step 6: Install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all