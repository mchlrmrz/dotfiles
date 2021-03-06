# OSX-only stuff. Abort if not OSX.
is_osx || return 1

# Exit if Homebrew is not installed.
[[ ! "$(type -P brew)" ]] && e_error "Brew casks need Homebrew to install." && return 1

# Ensure the cask keg and recipe are installed.
kegs=(caskroom/cask homebrew/versions caskroom/fonts homebrew/completions caskroom/versions)
brew_tap_kegs
# recipes=(brew-cask)
# brew_install_recipes

# Exit if, for some reason, cask is not installed.
# [[ ! "$(brew ls --versions brew-cask)" ]] && e_error "Brew-cask failed to install." && return 1

# Homebrew casks
casks=(
  # Applications
  # 1password-beta
  alfred
  arq
  bartender
  bettertouchtool
  cyberduck
  dash
  dropbox
  google-chrome-beta
  hazel
  iterm2-beta
  jdownloader
  keyboard-maestro
  kindle
  moom
  onyx
  sublime-text3
  textexpander
  the-unarchiver
  tower
  transmission
  vlc
  wd-my-cloud
  # Quicklook Plugins
  betterzipql
  qlcolorcode
  qlmarkdown
  qlprettypatch
  qlstephen
  quicklook-csv
  quicklook-json
  quicknfo
  webpquicklook
  # Fonts
  # font-dejavu-sans
  # font-droid-sans-mono
  # font-inconsolata
  # font-source-code-pro
)

# Install Homebrew casks.
casks=($(setdiff "${casks[*]}" "$(brew cask list 2>/dev/null)"))
if (( ${#casks[@]} > 0 )); then
  e_header "Installing Homebrew casks: ${casks[*]}"
  for cask in "${casks[@]}"; do
    brew cask install --appdir="/Applications" $cask
  done
  brew cask cleanup
fi
