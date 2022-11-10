# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
# Path to ASDF version manager
export ASDF_DIR=$HOME/.asdf
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="half-life"

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

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git rust sudo docker docker-compose fzf tmux)

source $ZSH/oh-my-zsh.sh

# User configuration

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# ALIAS

# Dotfiles
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

# VIM
alias \vim="vim"
alias \nvim="nvim"
alias vim="lvide"
alias nvim="lvide"
alias lvim="lvide"
alias v="lvide"

# Wireguard
alias wgu="sudo wg-quick up"
alias wgd="wg-quick down" 

# Git
alias ga="git add ."
alias gac="git add . && git commit -m"
alias gc="git commit"
alias gcm="git commit -m"

# Scripts


. $ASDF_DIR/asdf.sh

# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit
