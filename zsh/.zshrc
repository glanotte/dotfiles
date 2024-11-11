. ~/.zsh/config
. ~/.zsh/aliases
. ~/.zsh/colors.zsh
. ~/.zsh/completion
. ~/.zsh/prompt.zsh
. ~/.zsh/zsh_hooks.zsh

# added support for zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)
# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && .  ~/.localrc

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export PATH="$PATH:/Users/glanotte/.local/bin"
