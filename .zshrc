
# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Powerlevel10k
zinit ice depth"1"
zinit light romkatv/powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# PATH
export PATH="/home/cachyosbtw/.flutter/flutter/bin:$PATH"
export PATH="$PATH:/home/xuanyu/.local/bin"

# NVM lazy load
export NVM_DIR="$HOME/.nvm"
nvm() {
  unset -f nvm node npm npx yarn pnpm
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  nvm "$@"
}
node() { nvm; node "$@"; }
npm()  { nvm; npm  "$@"; }
npx()  { nvm; npx  "$@"; }
yarn() { nvm; yarn "$@"; }
pnpm() { nvm; pnpm "$@"; }

# Plugins (autosuggestions sync, rest deferred)
zinit light zsh-users/zsh-autosuggestions

zinit ice wait"0" lucid
zinit light zdharma-continuum/fast-syntax-highlighting

zinit ice wait"0" lucid
zinit light zsh-users/zsh-completions

zinit ice wait"0" lucid
zinit light Aloxaf/fzf-tab

zinit ice wait"0" lucid; zinit snippet OMZP::git
zinit ice wait"0" lucid; zinit snippet OMZP::command-not-found

# Completions (cached, rebuilds once per day)
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi
zinit cdreplay -q

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups hist_save_no_dups hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
alias c='clear'
alias fix-comp='rm -f ~/.zcompdump*; compinit'

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"

. "$HOME/.local/bin/env"
