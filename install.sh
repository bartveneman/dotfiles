#!/usr/bin/env bash

brews=(
  bash
  battery
  bat
  coreutils
  git
  grep
  hr
  mas
  node
  nvm
  python
  trash
  yarn
  zsh
  zsh-completions
  zsh-autosuggestions
  zsh-syntax-highlighting

  # Workaround for installing dockutil
  https://github.com/keith/homebrew/raw/ks-dockutil/Library/Formula/dockutil.rb
)

casks=(
  caffeine
  firefox
  firefox-developer-edition
  font-inconsolata-for-powerline
  google-chrome
  hyper
  imageoptim
  opera
  slack
  spectacle
  spotify
  visual-studio-code

  # Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
  qlcolorcode
  qlstephen
  qlmarkdown
  quicklook-json
  qlimagesize
)

gems=(
  bundle
  jekyll
)

npms=(
  diff-so-fancy
  gromit-cli
  now
  npm
  pure-prompt
  wallace-cli
  wallpaper-cli
  yarn
)

vscode=(
  ms-vscode.atom-keybindings
  formulahendry.auto-close-tag
  formulahendry.auto-rename-tag
  coenraads.bracket-pair-colorizer
  wesbos.theme-cobalt2
  mikestead.dotenv
  samverschueren.linter-xo
  esbenp.prettier-vscode
  wayou.vscode-todo-highlight
  wakatime.vscode-wakatime
)

fonts=(
  font-fira-mono-for-powerline
  font-inconsolata-for-powerline
  font-source-code-pro-for-powerline
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

# Mac App Store apps
echo "Installing Mac App Store Apps"
echo "Type your App Store email, followed by [ENTER]"
read APP_STORE_EMAIL
echo "You typed $APP_STORE_EMAIL, signing in"
mas signin $APP_STORE_EMAIL
mas install 1206020918 # Battery Indicator (1.2.0)

# BREW CASK PACKAGES
echo "install brew cask packages"
install 'brew cask install' ${casks[@]}

# BREW CASK FONTS
brew tap caskroom/fonts
install 'brew cask install' ${fonts[@]}

# SECONDARY PACKAGES
echo "install secondary packages"
install 'gem install' ${gems[@]}
install 'npm install --global' ${npms[@]}
install 'code --install-extension' ${vscode[@]}

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
# http://sourabhbajaj.com/mac-setup/Git/gitignore.html
curl https://raw.githubusercontent.com/github/gitignore/master/Global/macOS.gitignore -o ~/.gitignore
ln -sf $(pwd)/.gitconfig ~/.gitconfig

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
