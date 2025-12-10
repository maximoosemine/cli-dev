export EDITOR=nvim
alias vim='nvim'
alias vi='nvim'

export LESS="$LESS -c"

alias fzfg="git ls-files -m | fzf"

GIT_BRANCH_FORMAT='%(refname:short)%(if)%(upstream:short)%(then) %(color:red)(%(if:equals=)%(upstream:track,nobracket)%(then)= %(end)%(upstream:short))%(color:reset)%(end) %(color:green)(%(committerdate:relative))%(color:reset) %(color:blue)<%(authorname)>%(color:reset)'

alias gb="git branch --sort=-committerdate --format='$GIT_BRANCH_FORMAT'"
alias gba="git branch -a --sort=-commiterdate --format='$GIT_BRANCH_FORMAT'"
alias gbu="git branch --sort=-committerdate --format='$GIT_BRANCH_FORMAT' --color=always | grep --color=never \"<$(git config user.name)>\" | less"

alias gdto="git difftool"
alias gmto="git mergetool"

export COLORTERM=truecolor

# Keeps zsh from CDing without cd
unsetopt AUTO_CD

# Makes content top align in less
export LESS="$LESS -c"

# Fixes unreadable files (with recommended color scheme)
export LS_COLORS="${LS_COLORS}tw=1;34:ow=1;34:"

# Make it easier to get back into the same tmux session
alias desktop='tmux attach-session -t ssh_tmux || tmux new-session -s ssh_tmux'

# Jump right into a tmux session
if [[ $- =~ i ]] && [[ -z "$TMUX" ]] && [[ -n "$SSH_TTY" ]]; then
  tmux attach-session -t ssh_tmux || tmux new-session -s ssh_tmux
fi
