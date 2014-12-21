. ~/.zsh/config
. ~/.zsh/aliases
. ~/.zsh/colors.zsh
. ~/.zsh/completion
. ~/.zsh/prompt.zsh
. ~/.zsh/zsh_hooks.zsh

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
# added support for zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)
# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && .  ~/.localrc
if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
  . "$HOME/.rvm/scripts/rvm"
  PATH=$PATH:$HOME/.rvm/bin
elif [[ -s "/usr/local/rvm/scripts/rvm" ]]; then
  . "/usr/local/rvm/scripts/rvm"
  PATH=$PATH:/usr/local/rvm/bin
fi
