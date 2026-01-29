#!/usr/bin/env bash

set -e

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "${BASEDIR}"

which brew || bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
/opt/homebrew/bin/brew bundle

# npm global packages
npm install -g @anthropic-ai/claude-code
npm install -g @openai/codex

defaults write -g KeyRepeat -int 1
defaults write -g InitialKeyRepeat -int 10
defaults write -g com.apple.trackpad.scaling -float 4.0

mkdir -p ~/Developer
touch ~/.hushlogin

# Fish
mkdir -p ~/.config/fish/conf.d
/bin/rm -f ~/.config/fish/config.fish
ln -sf "${BASEDIR}/config.fish" ~/.config/fish/config.fish
/bin/rm -f ~/.config/fish/conf.d/fish_frozen_theme.fish
ln -sf "${BASEDIR}/config/fish/conf.d/fish_frozen_theme.fish" ~/.config/fish/conf.d/fish_frozen_theme.fish

# Starship
/bin/rm -f ~/.config/starship.toml
ln -sf "${BASEDIR}/config/starship.toml" ~/.config/starship.toml

# Git
/bin/rm -f ~/.gitconfig
ln -sf "${BASEDIR}/.gitconfig" ~/.gitconfig

# Vim
/bin/rm -f ~/.vimrc
ln -sf "${BASEDIR}/.vimrc" ~/.vimrc

if [ ! -f ~/.vim/autoload/plug.vim ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

vim +PlugInstall +qall 2>/dev/null || true

# iTerm2 - import preferences
plutil -convert binary1 -o ~/Library/Preferences/com.googlecode.iterm2.plist "${BASEDIR}/config/iterm2.plist"

# Raycast - import settings manually:
#   Raycast > Settings > Advanced > Import
#   See raycast.txt for extensions and hotkeys

# Set Fish as default shell
if ! grep -q "/opt/homebrew/bin/fish" /etc/shells; then
    echo "/opt/homebrew/bin/fish" | sudo tee -a /etc/shells
fi
chsh -s /opt/homebrew/bin/fish
