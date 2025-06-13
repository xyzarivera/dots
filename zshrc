source "$XYZ_ZSH_CONFIG/xyz.zsh"

export DOCKER_HOST="unix://$HOME/.colima/docker.sock"

# pyenv 
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# nvm
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


# PATH
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"

# Created by `pipx` on 2025-05-22 02:42:48
export PATH="$PATH:/Users/xyza.rivera/.local/bin"

# Work
export PATH="$PATH:$HOME/krakenflex/ves/development/scripts/bin"

