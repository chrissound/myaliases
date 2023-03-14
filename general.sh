alias md="mkdir"
alias mf="touch"

alias vim="nvim"
alias vv="\\vim"
alias emacsp="emacsclient -t"
#alias mg='emacsclient -nw -c --eval '"'"'(progn (let ((display-buffer-alist `(("^\\*magit: " display-buffer-same-window) ,display-buffer-alist))) (magit-status)) (delete-other-windows))'"' "
alias mg='setTerminalTitleToCmd magit; emacsclient -nw -c --eval '"'"'(progn (let ((display-buffer-alist `(("^\\*magit: " display-buffer-same-window) ,display-buffer-alist))) (magit-status)) (delete-other-windows))'"' "

alias l="ll"
alias ll="exa -l --group-directories-first --sort=extension"
alias lln="exa -l --group-directories-first --sort=name"
alias llnr="exa -l --group-directories-first --sort=name --reverse"
alias lt="exa -l --group-directories-first --sort=modified"
alias ltr="exa -l --group-directories-first --sort=modified --reverse"

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
alias ptlo="pitanga log --first=10 --group-by 1d"
alias ptrrr="pitanga amend --restart"
alias cutsf="sed -e 's/^ *//' | tr -s ' ' | cut -d ' ' -f"
pts () {
  echo "$#"
  if [[ "$#" = 0 ]]; then
    pitanga start "$(cat tasks.txt | fzf)" ""
  else
    pitanga start "$(cat tasks.txt | fzf)" "$@"
  fi
};
alias ptsp="pitanga stop"
ptr () {
  pitanga resume --accept-suggestion="$(pitanga resume --suggestions | tac | fzf)"
}
alias ptrl="pitanga resume" 
alias sss="systemctl suspend" 
alias sssh="systemctl hibernate" 


openFzfDirectoryHistoryNonRecursive() {
    RBUFFER=$(moscoviumorange --path=$PWD --limit 999999 --json |  jq -r '.[] | .[1]' | tac | awk '!seen[$0]++' | \
	                fzf --height 40% \
--bind 'ctrl-y:execute-silent(echo -n {} | xclip)+abort'
    )

    zle redisplay
	  zle end-of-line;
	  zle accept-line;
}

openFzfDirectoryHistory() {
    RBUFFER=$(moscoviumorange --path-prefix=$PWD --limit 999999 --json |  jq -r '.[] | .[1]' | tac | \
	            fzf --height 40% \
                     	--bind 'ctrl-y:execute-silent(echo -n {} | xclip)+abort'
    )

  zle redisplay
	zle end-of-line;
	zle accept-line;
}

chpwd() {
    addToProjectile &
    ll
}

p () {
  cd "$(tac ~/.config/projectilecli/dirs.txt | fzf)"
}

addToProjectile() {
  if git rev-parse --show-toplevel > /dev/null; then
    echo "$(git rev-parse --show-toplevel)" >> ~/.config/projectilecli/dirs.txt
    tac ~/.config/projectilecli/dirs.txt | awk '!seen[$0]++' | tac > ~/.config/projectilecli/dirs.txt.new
    cp ~/.config/projectilecli/dirs.txt.new ~/.config/projectilecli/dirs.txt

  fi
}

cdUpAbcxyz() {
  BUFFER="cd ../"


  zle redisplay
	zle end-of-line;
	zle accept-line;
}

mpc() {
  moscoviumorange --path-contains="$1"
}

mcc() {
  moscoviumorange --command-contains="$1"
}

mprcc() {
  moscoviumorange --path-contains="$PWD" --command-contains="$1"
}
 

initProjectTemplateHaskell () {
  rsync -av --progress  ~/Projects/TungstenLimaGooseberry/HaskellNixCabalStarter/ . \
    --exclude .git \
    --exclude README.md \
    --exclude dist-newstyle \
    --exclude dist-newstyle2
  git_initAndCommitInitial
}

function wrl () { readlink -f "$(which $1)" ; }

function confirm {
    while true; do
        read -k 1 "abc?Confirm y/n?"
        case $abc in
            [Yy]*) return 0  ;;
            [Nn]*) echo "Aborted" ; return  1 ;;
        esac
    done
}

function printc () {
  if [ -S ~/.config/moscoviumOrange/monitor.soc ]; then
      #$(jq -n --arg command "$1" --arg path "$PWD" '{"command":$command, "path":$path}' | "$(echo 'readlink -f $(which nc)' | nix run nixpkgs.netcat)" -N -U ~/.config/moscoviumOrange/monitor.soc &)

      #$(jq -n --arg command "$1" --arg path "$PWD" '{"command":$command, "path":$path}' \
      #  | "$ncPath" -N -U ~/.config/moscoviumOrange/monitor.soc &)
      $(jq -n --arg command "$1" --arg path "$PWD" '{"command":$command, "path":$path}' | nix-shell -p netcat --run "nc -N -U ~/.config/moscoviumOrange/monitor.soc") &| ;
  else
      echo "Failed to log command to moscoviumorange" > /dev/stderr
  fi
}
