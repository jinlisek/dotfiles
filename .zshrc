HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt append_history
setopt share_history
setopt hist_ignore_dups

bindkey -e

alias ll="ls -lah"
alias la="ls -A"
alias l="ls -CF"

alias lg="lazygit"

export EDITOR=nvim
export VISUAL=nvim
export PATH=$HOME/.local/bin/:$HOME/.cargo/bin/:$HOME/.devcontainers/bin/:/opt/nvim/bin/:$PATH

source $HOME/.antidote/antidote.zsh

# ZSH_PLUGINS_TXT="$HOME/.zsh_plugins.txt"
# ZSH_PLUGINS_ZSH="$HOME/.zsh_plugins.zsh"
#
# if [[ ! -f "$ZSH_PLUGINS_ZSH" || "$ZSH_PLUGINS_TXT" -nt "$ZSH_PLUGINS_ZSH" ]]; then
#   antidote bundle < "$ZSH_PLUGINS_TXT" > "$ZSH_PLUGINS_ZSH"
# fi
# source "$ZSH_PLUGINS_ZSH"

antidote load

if command -v starship > /dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

if command -v zoxide > /dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

if command -v task > /dev/null 2>&1; then
  eval "$(task --completion zsh)"
fi

zstyle ':plugin:ez-compinit' 'compstyle' 'zshzoo'
