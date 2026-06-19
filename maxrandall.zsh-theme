# Based on the oh-my-zsh lukerandall theme.

setopt promptsubst
zmodload zsh/datetime
autoload -Uz add-zsh-hook

local return_code="%(?..%{$fg_bold[red]%}%? ↵%{$reset_color%})"

function my_git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  GIT_STATUS=$(git_prompt_status)
  [[ -n $GIT_STATUS ]] && GIT_STATUS=" $GIT_STATUS"
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$GIT_STATUS$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

# Collapse one path segment to an initialism, keeping digit runs whole.
function _collapse_seg() {
  local seg=$1 out="" prev="" ch i
  for (( i=1; i<=${#seg}; i++ )); do
    ch=${seg[i]}
    if [[ $ch == [0-9] ]]; then
      out+=$ch
    elif [[ $ch == [-_\ ] ]]; then
      :
    elif [[ -z $prev || $prev == [-_\ 0-9] ]]; then
      out+=$ch
    elif [[ $ch == [A-Z] && $prev == [a-z] ]]; then
      out+=$ch
    fi
    prev=$ch
  done
  echo $out
}

# Collapse every segment of the current directory.
function _collapse_path() {
  local p=${(%):-%~} lead="" part
  [[ $p == /* ]] && lead="/"
  local -a parts new
  parts=(${(s:/:)p})
  for part in $parts; do
    [[ $part == "~"* ]] && new+=$part || new+=$(_collapse_seg $part)
  done
  echo "${lead}${(j:/:)new}"
}

# Time the last command; expose duration only if it ran longer than 2s.
function _theme_preexec() { _cmd_start=$EPOCHREALTIME }
function _theme_precmd() {
  _cmd_elapsed=""
  if [[ -n $_cmd_start ]]; then
    local e=$(( EPOCHREALTIME - _cmd_start ))
    (( e > 2 )) && _cmd_elapsed=$(printf '%.1fs' $e)
    unset _cmd_start
  fi
}
add-zsh-hook preexec _theme_preexec
add-zsh-hook precmd _theme_precmd

PROMPT='%{$fg_bold[blue]%}$(_collapse_path)%{$reset_color%} $(my_git_prompt_info)%{$reset_color%}%B»%b '
RPROMPT='$(vi_mode_prompt_info) %{$fg_bold[red]%}${_cmd_elapsed}%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=") %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%%"
ZSH_THEME_GIT_PROMPT_ADDED="+"
ZSH_THEME_GIT_PROMPT_MODIFIED="*"
ZSH_THEME_GIT_PROMPT_RENAMED="~"
ZSH_THEME_GIT_PROMPT_DELETED="!"
ZSH_THEME_GIT_PROMPT_UNMERGED="?"
