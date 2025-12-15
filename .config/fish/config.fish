set fish_greeting ''
set EDITOR nvim

set FZF_DEFAULT_COMMAND 'rg --files'
set FZF_CTRL_T_COMMAND 'rg --files'
set -x ERL_AFLAGS '-kernel shell_history enabled'
set -x HOMEBREW_NO_AUTO_UPDATE '1'
set -x HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK '1'
# Something changed in Fish 4.1
set -x fish_term24bit 0

# set fish_user_paths "$HOME/.cargo/bin" $fish_user_paths
# set fish_user_paths "/Applications/Postgres.app/Contents/Versions/11/bin" $fish_user_paths


# gem_home
# source "/usr/local/share/gem_home/gem_home.sh"

# chruby
# source /usr/local/share/chruby/chruby.fish

# kiex
# test -s "/Users/mitchellhenke/.kiex/scripts/kiex.fish"; and source "/Users/mitchellhenke/.kiex/scripts/kiex.fish"
# set fish_user_paths "/usr/local/opt/python/libexec/bin" $fish_user_paths
