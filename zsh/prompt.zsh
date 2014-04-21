function parse_git_branch {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\/git:\1/'
}

function pair_info {
  local pairname=$(git config --get user.initials)
  if [[ ${pairname} == 'ch' ]]; then
    pairname=''
  else
    pairname=" ($pairname)"
  fi
  echo "$pairname"
}

function git_prompt_info {
  local ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ -n $ref ]]; then
    echo "%{$reset_color%}/%{$fg[blue]%}${ref#refs/heads/}"
  fi
}

function git_status {
  local ref=$(git symbolic-ref HEAD 2> /dev/null)
  local gitst="$(git status 2> /dev/null)"
  local pairname=$(git config --get user.initials)
  if [[ ${pairname} == 'ch' ]]; then
    pairname=''
  elif [[ ${pairname} == '' ]]; then
    pairname=''
  else
    pairname=" ($pairname)"
  fi

  if [[ -f .git/MERGE_HEAD ]]; then
    if [[ ${gitst} =~ "unmerged" ]]; then
      gitstatus=" %{$fg[red]%}unmerged%{$reset_color%}"
    else
      gitstatus=" %{$fg[green]%}merged%{$reset_color%}"
    fi
  elif [[ ${gitst} =~ "Changes to be committed" ]]; then
    gitstatus=" %{$fg[blue]%}!%{$reset_color%}"
  elif [[ ${gitst} =~ "use \"git add" ]]; then
    gitstatus=" %{$fg[red]%}!%{$reset_color%}"
  elif [[ -n `git checkout HEAD 2> /dev/null | grep ahead` ]]; then
    gitstatus=" %{$fg[yellow]%}*%{$reset_color%}"
  else
    gitstatus=''
  fi

  if [[ -n $ref ]]; then
    echo "%{$reset_color%}$gitstatus$pairname "
  fi
}

project_pwd() {
  # shortens the path that is deplayed and compacts the home, code and projects directory
  echo $PWD | sed -e "s/\/Users\/$USER/~/" -e "s/projects\/\([^\/]*\)/p\/\\1/" -e "s/code\/\([^\/]*\)/c\/\\1/"
}

rvm_info() {
  # shortens the rvm prompt output
  echo " $($rvm_bin_path/rvm-prompt)" | sed -e "s/ruby-\(.*\)-p[^@]*/m\\1/" -e "s/jruby-\(.*\)/j\\1/"
}

machine_prefix(){
  if [ -n "$SSH_CLIENT" ]; then
    echo "${PR_MAGENTA}%n${reset_color}/${PR_GREEN}%m"
  else
    echo ""
  fi
}
export PROMPT=$'$(machine_prefix)$(git_status)%{\e[0;%(?.32.31)m%}✝%{\e[0m%} '
export RPROMPT=$'%{\e[0;90m%}$(project_pwd)${PR_YELLOW}$(rvm_info)$(git_prompt_info)%{\e[0m%}'
