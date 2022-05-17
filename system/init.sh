# Fzf setup
if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
fi

# Fzf auto-completion
[[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2> /dev/null

# Fzf key bindings
source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"

# Zoxide setup
eval "$(zoxide init zsh)"