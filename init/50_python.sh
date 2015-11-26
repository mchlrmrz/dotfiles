# Initialize Virtualenvwrapper.
source $DOTFILES/source/50_python.sh

# OSX-only stuff. Abort if not OSX.
is_osx || return 1

# Exit if Homebrew is not installed.
[[ ! "$(type -P brew)" ]] && e_error "Python needs Homebrew to install." && return 1

# Removed user's cached credentials
sudo -K

# Exit if, for some reason, cask is not installed.
[[ ! "$(brew ls --versions brew-cask)" ]] && e_error "Brew-cask failed to install." && return 1

# Exit if Pip is not installed.
[[ ! "$(type -P pip)" ]] && e_error "Python needs Pip  to setup environment." && return 1

# Upgrade some tools
# e_header "Updating Pip and Setuptools."
# pip install --upgrade setuptools
# pip install --upgrade pip

# Exit if Pip3 is not installed.
[[ ! "$(type -P pip3)" ]] && e_error "Python needs Pip  to setup environment." && return 1

# Upgrade some more tools
pip3 install --upgrade setuptools
pip3 install --upgrade pip

# Install virtual environments globally
# pip install virtualenv
# pip install virtualenvwrapper
pip3 install virtualenv
pip3 install virtualenvwrapper

export WORKON_HOME=~/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3

# e_header "Setting up py2-data virtual environment."

# Create a Python2 data environment
# mkvirtualenv py2-data
# workon py2-data

# Install Python data modules
# pip install numpy
# pip install scipy
# pip install matplotlib
# pip install pandas
# pip install sympy
# pip install nose
# pip install unittest2
# pip install seaborn
# pip install scikit-learn
# pip install "ipython[all]"
# pip install bokeh
# pip install Flask
# pip install sqlalchemy
# pip install mysql-python

e_header "Setting up py3-data virtual environment."

# Create a Python3 data environment
mkvirtualenv --python=/usr/local/bin/python3 py3-data
workon py3-data

# Install Python data modules
pip install numpy
pip install scipy
pip install matplotlib
pip install pandas
pip install sympy
pip install nose
pip install unittest2
pip install seaborn
pip install scikit-learn
pip install "ipython[all]"
pip install bokeh
pip install Flask
pip install sqlalchemy
pip install mysqlclient
