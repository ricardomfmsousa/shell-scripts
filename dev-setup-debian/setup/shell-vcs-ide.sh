#!/bin/bash
# Setup all related shell, terminal, VCS and editor software
source ../functions/utils.sh && no-root

APT=(
  zsh # Extended Bourne shell with a large number of improvements
  tmux # Terminal multiplexer
  tilix # Advanced GTK3 tiling terminal emulator 
  vim # Highly configurable text editor
  git # Fast, scalable, distributed revision control system
  git-gui # A Tcl/Tk based graphical user interface to Git
  meld # Visual diff and merge tool
) &&
apt-install ${APT[@]} &&

# Install snap available text editors/IDEs
SNAP=(
  code # TypeScript IDE from Microsoft
  android-studio # Official IDE for Google's Android operating system
  notepad-plus-plus # Good old M$ Windows notepad++ packed in a snap
  intellij-idea-community # Java IDE from JetBrains
) &&
snap-install ${SNAP[@]}
 

# Install oh-my-zsh: framework for managing zsh configuration
rm -rf "$HOME/.oh-my-zsh" &&
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh) --unattended" &&
export-var "SHELL" "/bin/zsh" &&

# Configure git globally
gecho "Setting global git configurations" &&
read -e -p "Enter your git userame: " -i "$(whoami)" NAME &&
read -e -p "Enter your git email: " EMAIL &&
git config --global merge.tool vscode &&
git config --global mergetool.vscode.cmd 'code --wait $MERGED' &&
git config --global diff.tool vscode &&
git config --global difftool.vscode.cmd 'code --wait --diff $LOCAL $REMOTE' &&
git config --global user.name "$NAME" &&
git config --global user.email "$EMAIL"