export ZSH="$HOME/.oh-my-zsh"

zstyle ':omz:update' mode auto

ENABLE_CORRECTION="false"
HYPHEN_INSENSITIVE="true"

plugins=(
    git
    tmux
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

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "/Users/w1png/.bun/_bun" ] && source "/Users/w1png/.bun/_bun"

# go
export PATH=$PATH:$(go env GOPATH)/bin

# other PATH stuff
export PATH="$(brew --prefix)/opt/python@3.11/libexec/bin:$PATH"
export PATH="/Users/w1png/.local/bin:$PATH"
export PATH="/opt/homebrew/opt/gnu-getopt/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="/opt/homebrew/opt/make/libexec/gnubin:$PATH"
