# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

HYPHEN_INSENSITIVE="true"
zstyle ':omz:update' mode auto

ENABLE_CORRECTION="true"

COMPLETION_WAITING_DOTS="true"

plugins=(
    git
    python 
    catimg
    zsh-autosuggestions
    jsontools
)

source $ZSH/oh-my-zsh.sh

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# misc
alias vim="nvim"
alias py="python3.10"
alias git_undo="git reset --soft HEAD~1"
alias cat="bat"
alias neofetch="neofetch --off"

export PATH=~/.npm-global/bin:/usr/bin:/usr/condabin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin
PATH=/home/w1png/.npm-global/bin:/usr/bin:/usr/condabin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:~/.config/rofi/scripts

export PATH=$PATH:/home/w1png/.spicetify
export PATH=$PATH:/home/w1png/.local/bin

# oh-my-posh
eval "$(oh-my-posh init zsh --config ~/omp_themes/bubblesline.omp.json)"
