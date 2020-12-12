# Setup fzf
# ---------
if [[ ! "$PATH" == */home/dmfk/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/dmfk/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/dmfk/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/dmfk/.fzf/shell/key-bindings.zsh"
