[ -f ~/.config/fish/alias_abbr.fish ] && . ~/.config/fish/alias_abbr.fish
set -x -U GOPATH $HOME/go
set -x PATH $PATH $GOPATH/bin