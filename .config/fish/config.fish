set fish_greeting ''
set EDITOR nvim

set FZF_DEFAULT_COMMAND 'ag -g ""'
set FZF_CTRL_T_COMMAND 'ag -g ""'
set -x ERL_AFLAGS '-kernel shell_history enabled'

set fish_user_paths "$HOME/.cargo/bin" $fish_user_paths
set fish_user_paths "/Applications/Postgres.app/Contents/Versions/11/bin" $fish_user_paths

# gem_home
# source "/usr/local/share/gem_home/gem_home.sh"

# chruby
source /usr/local/share/chruby/chruby.fish

# kiex
test -s "$HOME/.kiex/scripts/kiex.fish"; and source "$HOME/.kiex/scripts/kiex.fish"
set fish_user_paths "/usr/local/opt/python/libexec/bin" $fish_user_paths

