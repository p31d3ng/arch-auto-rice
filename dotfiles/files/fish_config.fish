[ -f ~/.config/fish/alias_abbr.fish ] && . ~/.config/fish/alias_abbr.fish
set -x -U GOPATH $HOME/go
set -x -U PATH $PATH:$GOPATH/bin