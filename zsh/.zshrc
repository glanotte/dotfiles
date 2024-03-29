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
export PATH="/usr/local/opt/mariadb@10.1/bin:$PATH"

. /usr/local/opt/asdf/libexec/asdf.sh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"



source /Users/glanotte/.docker/init-zsh.sh || true # Added by Docker Desktop
