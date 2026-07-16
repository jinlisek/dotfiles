#!/usr/bin/env bash

set -e

BLUE='\033[0m\033[34m'
NO_COLOR='\033[0m'

echo -e "${BLUE}Installing dotfiles${NO_COLOR}"

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo $DOTFILES_DIR

link_file() {
  local src="$1"
  local dest="$2"
  echo "${BLUE}Linking $src -> $dest${NO_COLOR}"

  if [ -L "$dest" ]; then
    echo -e "${BLUE}$dest link already exists, creating backup: $dest.bak${NO_COLOR}"
    rm "$dest"
  elif [ -e "$dest" ]; then
    echo -e "${BLUE}$dest already exists, creating backup: $dest.bak${NO_COLOR}"
    mv "$dest" "$dest.bak"
  fi

  ln -sf "$src" "$dest"
}

mkdir -p "$HOME/.config"

link_file "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

echo -e "${BLUE}Installing starship${NO_COLOR}"
mkdir -p "$HOME/.local/bin"
curl -sS https://starship.rs/install.sh | sh -s -- --version v1.26.0 --bin-dir "$HOME/.local/bin" -y
link_file "$DOTFILES_DIR/.config/starship.toml" "$HOME/.config/starship.toml"

echo -e "${BLUE}Finished installing starship${NO_COLOR}"

echo -e "${BLUE}Installing antidote${NO_COLOR}"

ANTIDOTE_DIR="${ZDOTDIR:-$HOME}/.antidote"
ANTIDOTE_REPO="https://github.com/mattmc3/antidote.git"
ANTIDOTE_TAG="v2.1.0"

if [[ -d "$ANTIDOTE_DIR/.git" ]]; then
  current_tag="$(git -C "$ANTIDOTE_DIR" describe --tags --exact-match 2>/dev/null || true)"
  if [[ "$current_tag" == "$ANTIDOTE_TAG" ]]; then
    echo -e "${BLUE}Antidote already at $ANTIDOTE_TAG, skipping${NO_COLOR}"
  else
    echo -e "${BLUE}Updating antidote to $ANTIDOTE_TAG${NO_COLOR}"
    git -C "$ANTIDOTE_DIR" fetch --depth=1 origin "refs/tags/${ANTIDOTE_TAG}:refs/tags/${ANTIDOTE_TAG}"
    git -C "$ANTIDOTE_DIR" checkout "$ANTIDOTE_TAG"
  fi
elif [[ -e "$ANTIDOTE_DIR" ]]; then
  echo -e "${BLUE}$ANTIDOTE_DIR exists but is not a git repo, backing up${NO_COLOR}"
  mv "$ANTIDOTE_DIR" "$ANTIDOTE_DIR.bak"
  git clone --depth=1 --branch "$ANTIDOTE_TAG" "$ANTIDOTE_REPO" "$ANTIDOTE_DIR"
else
  git clone --depth=1 --branch "$ANTIDOTE_TAG" "$ANTIDOTE_REPO" "$ANTIDOTE_DIR"
fi

link_file "$DOTFILES_DIR/.zsh_plugins.txt" "$HOME/.zsh_plugins.txt"

echo -e "${BLUE}Finished installing antidote${NO_COLOR}"

echo -e "${BLUE}Installing nvim${NO_COLOR}"
link_file "${DOTFILES_DIR}/.config/nvim" "$HOME/.config/nvim"

echo -e "${BLUE}Installing ghostty${NO_COLOR}"
link_file "${DOTFILES_DIR}/.config/ghostty" "$HOME/.config/ghostty"

echo -e "${BLUE}Finished installing dotfiles${NO_COLOR}"
