recho() { echo -e "\e[1m\e[31m$1\e[0m"; }
gecho() { echo -e "\e[1m\e[32m$1\e[0m"; }
becho() { echo -e "\e[1m\e[34m$1\e[0m"; }

no-root() {
  [ "$EUID" -eq 0 ] && echo "Please don't run $0 as root..." && exit 1
}

# $1: repo name
git-read-latest-release() {
  echo `curl --silent "https://api.github.com/repos/$1/releases/latest" | \
    grep -Po '"tag_name": "\K.*?(?=")'`
}

# $1: repo name
# $2: folder to clone to
git-clone-latest-release() {
  rm -rf $2 && LATEST_RELEASE=`git-read-latest-release $1` && \
  git clone -b $LATEST_RELEASE --single-branch "https://github.com/$1" $2
}

# $1: repo name
# $2: folder to unpack to
git-download-latest-release() {
  rm -rf $2 && mkdir -p $2 && LATEST_RELEASE=`git-read-latest-release $1` && \
  REPO="https://github.com/$1/archive/$LATEST_RELEASE.tar.gz" && \
  echo "Downloading from $REPO, unpacking to $2" && \
  wget -q -O - $REPO | tar xz -C $2
}

# $1: directory to add to path
add-to-path() {
  # Only add if not in $PATH already
  [[ ":$PATH:" == *":$1:"* ]] && return 0
  echo "export PATH=\"$1:$PATH\"" >> $HOME/.profile && \
  source $HOME/.profile
}

# $1: variable name
# $2: variable value
export-var() {
  # Only export if not already defined
  [[ "$(eval echo "\$$1")" == "$2" ]] && return 0
  echo "export $1=\"$2\"" >> $HOME/.profile && \
  source $HOME/.profile
}

# $1: App/script name
# $2: App/script path
add-to-startup() {
  AUTO_START_DIR="$HOME/.config/autostart"
  AUTO_START_PATH="$AUTO_START_DIR/$1.desktop"
  mkdir -p "$AUTO_START_DIR" && \
  echo "
[Desktop Entry]
Type=Application
X-GNOME-Autostart-enabled=true
Name=$1
Exec=$2
" > "$AUTO_START_PATH" && \
  echo "[$1] added to $AUTO_START_PATH"
}