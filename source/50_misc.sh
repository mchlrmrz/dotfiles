# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

export GREP_OPTIONS='--color=auto'

# Prevent less from clearing the screen while still showing colors.
export LESS=-XR

# Don’t clear the screen after quitting a manual page.
export MANPAGER='less -X';

# Set the terminal's title bar.
function titlebar() {
  echo -n $'\e]0;'"$*"$'\a'
}

# SSH auto-completion based on entries in known_hosts.
if [[ -e ~/.ssh/known_hosts ]]; then
  complete -o default -W "$(cat ~/.ssh/known_hosts | sed 's/[, ].*//' | sort | uniq | grep -v '[0-9]')" ssh scp sftp
fi

# Get OS X Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
alias update='brew update; brew upgrade --all; brew cleanup --force'

# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# `s` with no arguments opens the current directory in Sublime Text, otherwise
# opens the given location
function s() {
    if [ $# -eq 0 ]; then
        subl .;
    else
        subl "$@";
    fi;
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function tre() {
    tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec $SHELL -l"

# Show/hide LaunchBar dock icon
alias showlaunch="defaults write at.obdev.LaunchBar ShowDockIcon -bool true && killall LaunchBar && sleep 1 && open -a LaunchBar"
alias hidelaunch="defaults write at.obdev.LaunchBar ShowDockIcon -bool false && killall LaunchBar && sleep 1 && open -a LaunchBar"

# Brew aliases
alias bls="brew list"
alias bcls="brew cask list"
alias bs="brew search"
alias bcs="brew cask search"
alias binfo="brew info"
alias bcinfo="brew cask info"
alias binstall="brew install"
alias bcinstall="brew cask install"