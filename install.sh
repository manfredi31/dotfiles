#!/usr/bin/env bash

set -e

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "${BASEDIR}"

which brew || bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
/opt/homebrew/bin/brew bundle

defaults write -g KeyRepeat -int 1
defaults write -g InitialKeyRepeat -int 10
defaults write -g com.apple.trackpad.scaling -float 4.0

mkdir -p ~/Developer
touch ~/.hushlogin

mkdir -p ~/.config/fish
/bin/rm -f ~/.config/fish/config.fish
ln -sf "${BASEDIR}/config.fish" ~/.config/fish/config.fish

/bin/rm -f ~/.gitconfig
ln -sf "${BASEDIR}/.gitconfig" ~/.gitconfig

/bin/rm -f ~/.vimrc
ln -sf "${BASEDIR}/.vimrc" ~/.vimrc

if [ ! -f ~/.vim/autoload/plug.vim ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

vim +PlugInstall +qall 2>/dev/null || true

# Set Fish as default shell
if ! grep -q "/opt/homebrew/bin/fish" /etc/shells; then
    echo "/opt/homebrew/bin/fish" | sudo tee -a /etc/shells
fi
chsh -s /opt/homebrew/bin/fish
