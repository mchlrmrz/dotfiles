if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

# Add Anaconda3 to path
export PATH="/Users/$USER/anaconda3/bin:$PATH"

test -e ${HOME}/.iterm2_shell_integration.bash && source ${HOME}/.iterm2_shell_integration.bash
