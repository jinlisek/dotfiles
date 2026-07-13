#!/usr/bin/env bash

set -e # Przerwij przy błędzie

# Kolory dla lepszej czytelności
GREEN='\033[0m\033[32m'
BLUE='\033[0m\033[34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Installing dotfiles${NC}"

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo $DOTFILES_DIR

link_file() {
    local src="$1"
    local dest="$2"
    echo "${BLUE}Linking $src -> $dest${NC}"

    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
        echo -e "${BLUE}$dest already exists, creating backup: $dest.bak${NC}"
        mv "$dest" "$dest.bak"
    fi

    ln -sf "$src" "$dest"
}

mkdir -p "$HOME/.config"

link_file "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

echo -e "${BLUE}Installing starship${NC}"
mkdir -p "$HOME/.local/bin"
curl -sS https://starship.rs/install.sh | sh -s -- --version v1.26.0 --bin-dir "$HOME/.local/bin" -y

echo -e "${BLUE}Installing antidote${NC}"
git clone --depth=1 --branch v2.1.0 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-$HOME}/.antidote
link_file "$DOTFILES_DIR/.zsh_plugins.txt" "$HOME/.zsh_plugins.txt"
link_file "$DOTFILES_DIR/starship.toml" "$HOME/.config/starship.toml"

echo -e "${GREEN}Finished installing dotfiles${NC}"
