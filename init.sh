alias ns="nix-shell"
alias nb="nix build"
alias v="nvim"
alias vs="nvim -c 'FzfLua grep_project'"
alias e="emacs -nw"

alias dkr='docker'
alias dkrc='docker-compose'
alias docker='sudo docker'
alias rg='rg --no-ignore-vcs'
alias emc='emacsclient -c'
alias emct='emacsclient -c -nw'
alias gith='git --git-dir=$HOME/.git2/ --work-tree=$HOME'
alias githh='git --git-dir=/home/chris/chrishomeold/home/chris/.git2 --work-tree=/home/chris/chrishomeold/home/chris/'
alias tree='exa --tree'
alias cat='bat --plain --paging=never'
alias tmp='cd ~/temp/wiptemp; dirInt="$(($(ls -1tr | sort -n | tail -n 1) +1))"; mkdir $dirInt && cd $dirInt;'
alias tmps='cd $(fd . ~/temp/wiptemp/ -d 1 | alcSortPath date | tail -n 10 | tac | fzf --height 40% --preview "exa -l --group-directories-first --sort=extension {}")'

fileCount()
{
  fd --type f "$1" | wc -l
}

dirCount()
{
  fd --type d "$1" | wc -l
}


ksd()
{
    ot=$( (echo "pods"; echo "services"; echo "ingresses") | fzf --height 10)
    x=$(kubectl get "$ot" -o json | jq -r '.items[] .metadata.name' | fzf --height 10)
    set -x
    kubectl describe "$ot" "$x"
    set +x
}

ksl()
{
    x=$(kubectl get pods -o json | jq -r '.items[] .metadata.name' | fzf --height 10)
    set -x
    kubectl logs "$x"
    set +x
}

ksg()
{
    ot=$( (echo "pods"; echo "services"; echo "ingresses") | fzf --height 10);
    x=$(kubectl get "$ot" -o json | jq -r '.items[] .metadata.name' | fzf --height 10)
    set -x
    kubectl get "$ot" "$x"
    set +x
}

ksgy()
{
    ot=$( (echo "pods"; echo "services"; echo "ingresses") | fzf --height 10);
    x=$(kubectl get "$ot" -o json | jq -r '.items[] .metadata.name' | fzf --height 10)
    set -x
    kubectl get "$ot" -o yaml "$x"
    set +x
}

gda()
{
  clear -x;
  echo "--Diff--";
  git diff --stat;
  printf '—%.0s' {1..$COLUMNS};

  echo "--Branches--";
  git branch;
  printf '—%.0s' {1..$COLUMNS};
  echo "--Log--"; git log --oneline -5; printf '—%.0s' {1..$COLUMNS};
}

dirInfo()
{
  echo -n "Files count: " 
  fileCount

  echo -n "Dir count: " 
  dirCount
}
