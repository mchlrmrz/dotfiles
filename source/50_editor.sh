# Editing

if [[ ! "$SSH_TTY" ]] && is_osx; then
  export EDITOR='subl'
else
  export EDITOR='nano'
fi

export VISUAL="$EDITOR"
alias q="$EDITOR"
alias qd="q $DOTFILES"
