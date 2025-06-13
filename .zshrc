export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.bun/bin:$PATH
export PATH=$HOME/.mix/escripts:$PATH
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export CARGO_HOME=$HOME/.cargo/

export VAULT_ADDR=https://vault.helloprima.com:8200

export PROJECTS_HOME=~/Documents/Prima

# You may need to manually set your language environment
export LANG=en_US.UTF-8

zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="mm/dd/yyyy"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='hx'
else
  export EDITOR='hx'
fi

ZSH_THEME="half-life"

plugins=(git rust sudo docker docker-compose fzf)

source $ZSH/oh-my-zsh.sh


if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

autoload -Uz compinit
compinit

# ALIAS
alias v="nvim"
alias dsa="docker stop $(docker ps -qa)"
alias dra="docker rm $(docker ps -qa)"
alias gdba="git branch | grep -v "master" | xargs git branch -D"

alias vault-login="vault login -method=oidc -path=okta --no-print"


eval "$(/home/victor-martinez/.local/bin/mise activate zsh)"
eval "$(zellij setup --generate-auto-start zsh)"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

[ -f "/home/victor-martinez/.ghcup/env" ] && . "/home/victor-martinez/.ghcup/env" # ghcup-env

source <(jj util completion zsh)
