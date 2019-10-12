#source ~/dotfiles/fzf/key-bindings.zsh
#source ~/dotfiles/zsh/zce.zsh/zce.zsh
#bindkey "" zce
#source /usr/share/fzf/completion.zsh
#source /home/chris/dotfiles/.oh-my-zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export TERM=xterm-256color

alias md="mkdir"
alias mf="touch"

alias vim="nvim"
alias emacsp="emacsclient -t"
alias l="ll"
alias ll="exa -l --group-directories-first --sort=extension"
alias r='ranger --choosedir=/tmp/.rangerdir; LASTDIR=`cat /tmp/.rangerdir`; cd "$LASTDIR"'
alias grep="rg"
alias docker="sudo docker"
alias docker-compose="sudo docker-compose"
alias fp="clipboard_copyPath"
#pitanga
alias ptet="$EDITOR tasks.txt"
alias ptel="$EDITOR log.json"
alias ptll="pitanga log | less -R"
alias ptl="pitanga log --first=3 "
pts () {
  echo "$#"
  if [[ "$#" = 0 ]]; then
    pitanga start "$(cat tasks.txt | fzf)" ""
  else
    pitanga start "$(cat tasks.txt | fzf)" "$@"
  fi
};
alias ptsp="pitanga stop"
ptr () { pitanga resume --accept-suggestion="$(pitanga resume --suggestions | tac | fzf)" }
alias ptrl="pitanga resume" 

beepboop () {
  if [ -z "$IGNORE_HIST_CHRIS" ] || return 0
  echo -n "$1" >> .directory_history
}

openFzfDirectoryHistory() {
  # Sort by frequency
  RBUFFER=$(cat .directory_history | sort | uniq -c | sort -rn | sed -e 's/\s*[0-9]*\s*//' | \
	  fzf --height 40% \
           	--bind 'ctrl-y:execute-silent(echo -n {} | xclip)+abort'
  )

  zle redisplay
	zle end-of-line;
	zle accept-line;
}

zle     -N   openFzfDirectoryHistory
bindkey '^P' openFzfDirectoryHistory
add-zsh-hook zshaddhistory beepboop

openFzfDirectoryHistoryUnsorted() {
  # Sort by frequency
  RBUFFER=$(cat .directory_history | uniq -c | fzf --height 40%)

  zle redisplay
	zle end-of-line;
	zle accept-line;
}

chpwd() {
    ll
}

cdUpAbcxyz() {
  RBUFFER="cd ../"

  zle redisplay
	zle end-of-line;
	zle accept-line;
}

zle     -N   cdUpAbcxyz
bindkey '^K' cdUpAbcxyz

__git_files () { 
    _wanted files expl 'local files' _files     
}

HISTSIZE=1000000

function printc () {
  (nohup ~/ScriptsVcs/addEntryToMoscoviumOrange.sh "$1" &) > /dev/null 2>&1
}

autoload -Uz  add-zsh-hook

add-zsh-hook preexec printc
