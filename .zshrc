HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt append_history
setopt share_history
setopt hist_ignore_dups

# Completion
autoload -Uz compinit
compinit

bindkey -e

alias ll="ls -lah"
alias la="ls -A"
alias l="ls -CF"

alias lg="lazygit"

# Better defaults
export EDITOR=nvim
export VISUAL=nvim
export PATH=$HOME/.local/bin/:$HOME/.cargo/bin/:$HOME/.devcontainers/bin:$PATH

eval "$(starship init zsh)"


# Inicjalizacja Antidote
source $HOME/.antidote/antidote.zsh

# Ścieżka do listy wtyczek i wygenerowanego skryptu
ZSH_PLUGINS_TXT="$HOME/.zsh_plugins.txt"
ZSH_PLUGINS_ZSH="$HOME/.zsh_plugins.zsh"

# Kompiluj wtyczki, jeśli lista się zmieniła, a następnie je załaduj
if [[ ! -f "$ZSH_PLUGINS_ZSH" || "$ZSH_PLUGINS_TXT" -nt "$ZSH_PLUGINS_ZSH" ]]; then
  antidote bundle < "$ZSH_PLUGINS_TXT" > "$ZSH_PLUGINS_ZSH"
fi
source "$ZSH_PLUGINS_ZSH"

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi


