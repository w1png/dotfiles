# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

HYPHEN_INSENSITIVE="true"
zstyle ':omz:update' mode auto

# ZSH_THEME="nicoulaj"
ZSH_THEME="powerlevel10k/powerlevel10k"

ENABLE_CORRECTION="false"

COMPLETION_WAITING_DOTS="true"

plugins=(
    git
    python 
    catimg
#    zsh-autosuggestions
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

export PATH="/usr/local/share/dotnet:$PATH"
export PATH="$(brew --prefix)/opt/python@3.11/libexec/bin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
export PATH="/opt/homebrew/opt/gnu-getopt/bin:$PATH"
