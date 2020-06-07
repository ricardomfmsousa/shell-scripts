#!/usr/bin/env bash
# Setup all related shell, terminal, VCS and editor software

source ./functions/utils.sh && no-root

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
  com.jetbrains.IntelliJ-IDEA-Community # Java IDE from JetBrains
  com.jetbrains.IntelliJ-IDEA-Ultimate # Java IDE from JetBrains
)
flatpack-install ${PKGS[@]}

# Change the default shell to zsh
sudo chsh -s "/bin/zsh" "$USER"

# Install oh-my-zsh: framework for managing zsh configuration
rm -rf "$HOME/.oh-my-zsh"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh) --unattended"

# Generate a new SSH key pair for fast, easy and secure git authentication
yes y | ssh-keygen -q -t rsa -N "" -f ~/.ssh/id_rsa || true

# Configure git globally
gecho "Setting global git configurations"
read -e -p "Enter your git userame: " -i "$(whoami)" NAME
read -e -p "Enter your git email: " EMAIL
git config --global user.name "$NAME"
git config --global user.email "$EMAIL"
