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
    echo " ${PR_YELLOW} %{$reset_color%}${PR_BLUE}${ref#refs/heads/}"
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
      gitstatus=" ${PR_RED}unmerged%{$reset_color%}"
    else
      gitstatus=" ${PR_GREEN}merged%{$reset_color%}"
    fi
  elif [[ ${gitst} =~ "Changes to be committed" ]]; then
    gitstatus=" ${PR_BLUE}!%{$reset_color%}"
  elif [[ ${gitst} =~ "use \"git add" ]]; then
    gitstatus=" ${PR_RED}!%{$reset_color%}"
  elif [[ -n `git checkout HEAD 2> /dev/null | grep ahead` ]]; then
    gitstatus=" ${PR_YELLOW}*%{$reset_color%}"
  else
    gitstatus=''
  fi

  if [[ -n $ref ]]; then
    echo "%{$reset_color%}$gitstatus$pairname "
  fi
}

project_pwd() {
  # shortens the path that is deplayed and compacts the home, code and projects directory
  # echo $PWD | sed -e "s/\/Users\/$USER/~/" -e "s/projects\/\([^\/]*\)/p\/\\1/" -e "s/code\/\([^\/]*\)/c\/\\1/"
  echo "%3~"
}

truncated_pwd() {
  n=$1 # n = number of directories to show in full (n = 3, /a/b/c/dee/ee/eff)
  path=`collapse_pwd`

  # split our path on /
  dirs=("${(s:/:)path}")
  dirs_length=$#dirs

  if [[ $dirs_length -ge $n ]]; then
    # we have more dirs than we want to show in full, so compact those down
    ((max=dirs_length - n))
    for (( i = 1; i <= $max; i++ )); do
      step="$dirs[$i]"
      if [[ -z $step ]]; then
        continue
      fi
      if [[ $step =~ "^\." ]]; then
        dirs[$i]=$step[0,2] #make .mydir => .m
      else
        dirs[$i]=$step[0,1] # make mydir => m
      fi

    done
  fi

  echo ${(j:/:)dirs}
}

collapse_pwd() {
  echo $(pwd | sed -e "s,^$HOME,~,")
}

machine_prefix(){
  if [ -n "$SSH_CLIENT" ]; then
    echo "${PR_MAGENTA}%n${reset_color}/${PR_GREEN}%m"
  else
    echo ""
  fi
}
export PROMPT=$'$(machine_prefix)$(git_status)%{\e[0;%(?.32.31)m%}⟹ %{\e[0m%} '
export RPROMPT=$'%{\e[0;90m%}$(truncated_pwd 2)${PR_YELLOW}$(git_prompt_info)%{\e[0m%}'
