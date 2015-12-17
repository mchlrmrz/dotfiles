# OSX-only stuff. Abort if not OSX.
is_osx || return 1

# Download Anaconda installation script.
curl -o "$DOTFILES/conf/osx/Anaconda3-2.4.1-MacOSX-x86_64.sh" "https://3230d63b5fc54e62148e-c95ac804525aac4b6dba79b00b39d1d3.ssl.cf1.rackcdn.com/Anaconda3-2.4.1-MacOSX-x86_64.sh"

# Run installation script.
bash "$DOTFILES/conf/osx/Anaconda3-2.4.1-MacOSX-x86_64.sh"