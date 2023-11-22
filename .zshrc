[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"

export ZSH="$HOME/.oh-my-zsh"

HYPHEN_INSENSITIVE="true"
zstyle ':omz:update' mode auto

ENABLE_CORRECTION="false"

COMPLETION_WAITING_DOTS="true"

plugins=(
    git
    python 
    catimg
    jsontools
)

unsetopt correct_all

source $ZSH/oh-my-zsh.sh

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# misc
alias vim="nvim"
alias py="python"
alias git_undo="git reset --soft HEAD~1"
alias alpaca="./Users/w1png/dev/alpaca.cpp/chat"

export PATH="/usr/local/share/dotnet:$PATH"
export PATH="$(brew --prefix)/opt/python@3.11/libexec/bin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

ulimit -n 10240

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
export PATH="/opt/homebrew/opt/gnu-getopt/bin:$PATH"
