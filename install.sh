#!/usr/bin/env bash

brews=(
  bash
  bat
  coreutils
  git
  grep
  node
  nvm
  python
  yarn
  zsh
  zsh-completions
  zsh-autosuggestions
  zsh-syntax-highlighting

  # Workaround for installing dockutil
  https://github.com/keith/homebrew/raw/ks-dockutil/Library/Formula/dockutil.rb
)

casks=(
  firefox
  firefox-developer-edition
  google-chrome
  hyper
  rectangle
  spotify
  visual-studio-code

  # Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
  qlcolorcode
  qlstephen
  qlmarkdown
  quicklook-json
  qlimagesize
)

npms=(
  diff-so-fancy
  nodemon
  now
  npm
  np
  pure-prompt
  wallace-cli
  yarn
)

set +e # Enables checking of commands
set -x # Print each command before it is executed

function prompt() {
  read -p "Hit Enter to $1 ..."
}

function install() {
  cmd=$1
  shift
  for pkg in $@;
  do
    exec="$cmd $pkg"
    echo "execute: $exec"
    if ${exec} ; then
      echo "installed $pkg"
    else
      echo "failed to execute: $exec"
    fi
  done
}

# Ask sudo access upfront
sudo -v

# Update Mac Software
sudo softwareupdate -i -a

# BREW
if test ! $(which brew); then
  prompt "install XCode"
  xcode-select --install

  prompt "install homebrew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  prompt "update homebrew"

  # Make sure we’re using the latest Homebrew.
  brew update

  # Upgrade any already-installed formulae.
  brew upgrade
fi

# Disable sending data to Brew
brew analytics off

# RUBY
echo "update ruby"

# Install RVM and Ruby 2.5.0
brew install gpg
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BD
curl -sSL https://get.rvm.io | bash -s stable --ruby=2.5.0
ruby -v
sudo gem update --system

# BREW PACKAGES
echo "install brew packages"
install 'brew install' ${brews[@]}

# BREW CASK PACKAGES
echo "install brew cask packages"
install 'brew cask install' ${casks[@]}

# SECONDARY PACKAGES
echo "install secondary packages"
install 'npm install --global' ${npms[@]}

# Remove outdated versions from the cellar.
echo "clean up"
brew cleanup
brew cask cleanup
gem cleanup

# Install OhMyZsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install ZSH autocompletions
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

# Setup Mac OS
echo "install Mac OS defaults"
sh macos.sh

# SETUP PATH
# http://sourabhbajaj.com/mac-setup/Homebrew/
# https://github.com/driesvints/dotfiles/blob/master/path.zsh
echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bash_profile

# CONFIGURE GIT
ln -sf $(pwd)/.gitconfig ~/.gitconfig
ln -sf $(pwd)/.gitignore_global ~/.gitignore_global

# SETUP ALIASES ETC
echo "symlink aliases and functions"
ln -sf $(pwd)/env.sh ~/env.sh

echo "symlink zshrc config"
ln -sf $(pwd)/.zshrc ~/.zshrc

echo "symlink hyper config"
ln -sf $(pwd)/.hyper.js ~/.hyper.js

echo "symlink gemrc"
ln -sf $(pwd)/.gemrc ~/.gemrc

echo "symlink .npmrc"
ls -sf $(pwd)/.npmrc ~/.npmrc

# Setup dock
dockutil --no-restart --remove all
dockutil --no-restart --add "/Applications/Firefox Developer Edition.app"
dockutil --no-restart --add "/Applications/Hyper.app"
dockutil --no-restart --add "/Applications/Visual Studio Code.app"
dockutil --no-restart --add "/Applications/Spotify.app"

killall Dock

# Set Wallpaper via wallpaper-cli
wallpaper https://images.unsplash.com/photo-1464011106587-1693fe42a668\?ixlib\=rb-0.3.5\&q\=85\&fm\=jpg\&crop\=entropy\&cs\=srgb\&s\=2565dd6bec95d75483a2ce69a35a989f

echo "Done! You may need to reboot your machine for all changes to take effect"
