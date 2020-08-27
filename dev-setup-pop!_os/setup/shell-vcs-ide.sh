#!/usr/bin/env bash
# Setup all related shell, terminal, VCS and editor software

source ./functions/utils.sh && no-root

# Install JetBrains Toolbox: manage all available Jet Brains software
TOOLBOX_URL=$(curl --silent 'https://data.services.jetbrains.com//products/releases?code=TBA&latest=true&type=release' \
    -H 'Origin: https://www.jetbrains.com' \
    -H 'Accept-Encoding: gzip, deflate, br' \
    -H 'Accept-Language: en-US,en;q=0.8' \
    -H 'Accept: application/json, text/javascript, */*; q=0.01' \
    -H 'Referer: https://www.jetbrains.com/toolbox/download/' \
    -H 'Connection: keep-alive' \
    -H 'DNT: 1' \
    --compressed \
  | grep -Po '"linux":.*?[^\\]",' \
  | awk -F ':' '{print $3,":"$4}'| sed 's/[", ]//g')
install -d "$APP_IMAGE_FOLDER"
rm -rf "$APP_IMAGE_FOLDER/jetbrains-toolbox"
curl -sL "$TOOLBOX_URL" | tar xvz --directory="$APP_IMAGE_FOLDER" --strip-components=1
"$APP_IMAGE_FOLDER/jetbrains-toolbox"

PKGS=(
  zsh # Extended Bourne shell with a large number of improvements
  tmux # Terminal multiplexer
  tilix # Advanced and clean GTK3 tiling terminal emulator 
  vim # Highly configurable text editor
  git # Fast, scalable, distributed revision control system
  git-gui # A Tcl/Tk based graphical user interface to Git
  meld # Visual diff and merge tool
  code # TypeScript IDE from Microsoft
)
apt-install ${PKGS[@]}

PKGS=(
  com.github.lainsce.notejot # A stupidly-simple sticky notes application
)
flatpack-install ${PKGS[@]}

# Change the default shell to zsh
sudo chsh -s "/bin/zsh" "$USER"

# Install oh-my-zsh: framework for managing zsh configuration
rm -rf "$HOME/.oh-my-zsh"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh) --unattended"

# Generate a new SSH key pair for fast, easy and secure git authentication
# (do not override existing key pairs)
yes n | ssh-keygen -q -t rsa -N "" -f ~/.ssh/id_rsa || true

# Configure git globally
gecho "Setting global git configurations"
[ -z "$GIT_USER_NAME" ] && read -e -p "Enter your git username: " -i "$(whoami)" GIT_USER_NAME
[ -z "$GIT_USER_EMAIL" ] && read -e -p "Enter your git email: " GIT_USER_EMAIL
git config --global user.name "$GIT_USER_NAME"
git config --global user.email "$GIT_USER_EMAIL"
git config --global push.followTags true
git config --global credential.helper 'store --file ~/.my-git-credentials'

