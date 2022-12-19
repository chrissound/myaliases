#source ~/dotfiles/fzf/key-bindings.zsh
#source ~/dotfiles/zsh/zce.zsh/zce.zsh
#bindkey "" zce
#source /usr/share/fzf/completion.zsh
#source /home/chris/dotfiles/.oh-my-zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export TERM=xterm-256color


zle     -N   openFzfDirectoryHistoryNonRecursive
bindkey '^P' openFzfDirectoryHistoryNonRecursive


zle     -N   openFzfDirectoryHistory
bindkey '^H' openFzfDirectoryHistory


zle     -N   cdUpAbcxyz
bindkey '^K' cdUpAbcxyz

__git_files () { 
    _wanted files expl 'local files' _files
}

HISTSIZE=1000000


autoload -Uz  add-zsh-hook

add-zsh-hook preexec printc

