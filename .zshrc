source "${0:a:h}/.bashrc"
# Unsets some aliases from .bashrc
alias grep="grep"
alias rg="rg"

export EDITOR=nvim
alias vim='nvim'
alias vi='nvim'

export LESS="$LESS -c"

alias fzfg="git ls-files -m | fzf"

GIT_BRANCH_FORMAT='%(refname:short)%(if)%(upstream:short)%(then) %(color:red)(%(if:equals=)%(upstream:track,nobracket)%(then)= %(end)%(upstream:short))%(color:reset)%(end) %(color:green)(%(committerdate:relative))%(color:reset) %(color:blue)<%(authorname)>%(color:reset)'

alias gb="git branch --sort=-committerdate --format='$GIT_BRANCH_FORMAT'"
alias gba="git branch -a --sort=-committerdate --format='$GIT_BRANCH_FORMAT'"
alias gbu="git branch --sort=-committerdate --format='$GIT_BRANCH_FORMAT' --color=always | grep --color=never \"<$(git config user.name)>\" | less"

alias gdto="git difftool"
alias gmto="git mergetool"

alias pandoc-annotate="pandoc --embed-resources -s --css ~/cli-dev/annotate.css"

alias c="copilot --allow-tool 'shell(frg)' --deny-tool 'grep' --deny-tool 'shell(rg)' --allow-tool 'edit'"

export COLORTERM=truecolor

# Keeps zsh from CDing without cd
unsetopt AUTO_CD

# Makes content top align in less
export LESS="$LESS -c"

# Fixes unreadable files (with recommended color scheme)
export PRIORITY_STYLES="tw=1;34:ow=1;34:"
export LS_COLORS="${LS_COLORS}${PRIORITY_STYLES}"
zstyle ':completion:*' list-colors ${(s.:.)PRIORITY_STYLES} ${(s.:.)LS_COLORS} # For some reason `zstyle` prioritizes in the opposite order

# Make it easier to get back into the same tmux session
alias desktop='tmux attach-session -t ssh_tmux || tmux new-session -s ssh_tmux'

# Jump right into a tmux session
if [[ $- =~ i ]] && [[ -z "$TMUX" ]] && [[ -n "$SSH_TTY" ]]; then
  tmux attach-session -t ssh_tmux || tmux new-session -s ssh_tmux
fi
