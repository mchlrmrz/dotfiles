# Where the magic happens.
export DOTFILES=~/.dotfiles

# Add binaries into the path
PATH=$DOTFILES/bin:$PATH
export PATH

# If Anaconda exists, add it to PATH
# [[ -d "/Users/$USER/.anaconda3/bin" ]] && PATH="/Users/$USER/.anaconda3/bin:$PATH" && export PATH

# Maintain single Bash history file
export PROMPT_COMMAND="history -a; history -n"

# Activate awscli completions
if [[ "$(type -P aws_completer)" ]]; then
  complete -C aws_completer aws
fi

# Source Google Cloud SDK completions
if [ -f '/opt/homebrew-cask/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc' ]; then
    source '/opt/homebrew-cask/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc'
fi

# Source all files in "source"
function src() {
  local file
  if [[ "$1" ]]; then
    source "$DOTFILES/source/$1.sh"
  else
    for file in $DOTFILES/source/*; do
      source "$file"
    done
  fi
}

# Run dotfiles script, then source.
function dotfiles() {
  $DOTFILES/bin/dotfiles "$@" && src
}

src
