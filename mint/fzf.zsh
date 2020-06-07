# Setup fzf
# ---------
if [[ ! "$PATH" == */home/ken/.cache/dein/repos/github.com/junegunn/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/ken/.cache/dein/repos/github.com/junegunn/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/ken/.cache/dein/repos/github.com/junegunn/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/ken/.cache/dein/repos/github.com/junegunn/fzf/shell/key-bindings.zsh"


[ -f ~/dotfiles/fzf_custom.zsh ] && source ~/dotfiles/fzf_custom.zsh
