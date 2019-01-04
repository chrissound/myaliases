#source ~/dotfiles/fzf/key-bindings.zsh
#source ~/dotfiles/zsh/zce.zsh/zce.zsh
#bindkey "" zce
#source /usr/share/fzf/completion.zsh
#source /home/chris/dotfiles/.oh-my-zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export TERM=xterm-256color

alias vim="nvim"
alias emacsp="emacsclient -t"
alias l="ll"
alias ll="exa -l --group-directories-first --sort=extension"
alias r="ranger"
alias grep="rg"
alias docker="sudo docker"
alias docker-compose="sudo docker-compose"
alias fp="clipboard_copyPath"
alias ppl="pitangaLog | less"
alias ppr="pitangaResumeTask"

beepboop () {
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

chpwd() clear
chpwd() ll

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
