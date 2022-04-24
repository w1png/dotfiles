# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
# ZSH_THEME="oxide"

plugins=(
  git
  python
  archlinux
  zsh-autosuggestions
  zsh-syntax-highlighting
  web-search
  copypath
  copyfile
  jsontools
  sudo
  
)

source $ZSH/oh-my-zsh.sh

# /usr/bin/setxkbmap -option "caps:swapescape"

# Aliases
# misc
alias vim="nvim"
alias py="python3.10"
alias git_undo="git reset --soft HEAD~1"
alias neofetch="neofetch --ascii_distro arch_small"
alias less="bat"
alias cat="bat"
alias printcolors="[for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh"
alias snaketerm="sssnake -f -S -s 15"

# dnf stuff
alias dnfin="sudo dnf install"
alias dnfs="dnf search"
alias dnfup="sudo dnf update && sudo dnf upgrade"
alias dnfrem="sudo dnf remove"

# Pacman
alias pacup="sudo pacman -Syu"
alias pacclean="sudo pacman -Sc && sudo pacman -Qtdq | sudo pacman -Rns -"


# Path
export CPATH=$CPATH:/usr/include/gtk-3.0
export CPATH=$CPATH:/usr/include/glib-2.0/
export CPATH=$CPATH:/lib64/glib-2.0/include/
export CPATH=$CPATH:/usr/include/pango-1.0/
export CPATH=$CPATH:/usr/lib64/gtk-3.0/3.0.0/
export CPATH=$CPATH:/usr/include/atk-1.0/
export CPATH=$CPATH:/usr/include/cairo/
export CPATH=$CPATH:/home/w1png/.local/bin
export TOKEN="1402095464:AAE_eV-VVjA-vw7k4AxppRcbGSPtg68gaOg"
export PYTHONDONTWRITEBYTECODE=1

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
