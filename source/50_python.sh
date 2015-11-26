

# Initialize Virtualenvwrapper
export WORKON_HOME=~/.virtualenvs

if [[ -a /usr/local/bin/virtualenvwrapper.sh ]]; then
  source /usr/local/bin/virtualenvwrapper.sh
fi

# pip should only run if there is a virtualenv currently activated
export PIP_REQUIRE_VIRTUALENV=true

# set paths to python & directories
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
