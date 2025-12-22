export ZSH="$HOME/.oh-my-zsh"

zstyle ':omz:update' mode auto

ENABLE_CORRECTION="false"
HYPHEN_INSENSITIVE="true"

plugins=(
    git
)

export ZSH_THEME="awesomepanda"

export ZSH_TMUX_AUTOSTART=true
export ZSH_TMUX_DEFAULT_SESSION_NAME="home"
export ZSH_TMUX_FIXTERM=true

unsetopt correct_all
source $ZSH/oh-my-zsh.sh

export EDITOR="nvim"
export MANPAGER="nvim +Man!"
export MANROFFOPT="-c"

# misc
alias vim="nvim"
alias git_undo="git reset --soft HEAD~1"
alias ls="eza --icons"
alias ll="eza --icons -la"
alias lt="eza --icons -l --tree"
alias cd="z"

export GPG_TTY=$(tty)

eval "$(zoxide init zsh)"

export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

XDG_RUNTIME_DIR="/tmp/$(id -u)-runtime-dir"
mkdir -pm 0700 "$XDG_RUNTIME_DIR"
export XDG_RUNTIME_DIR
