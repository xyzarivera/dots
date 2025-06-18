source "$XYZ_ZSH_CONFIG/xyz.zsh"

export DOCKER_HOST="unix://$HOME/.colima/docker.sock"

# pyenv 
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use # This loads nvm, without auto-using the default version


# PATH
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"

# Created by `pipx` on 2025-05-22 02:42:48
export PATH="$PATH:/Users/xyza.rivera/.local/bin"

# Work
export PATH="$PATH:$HOME/krakenflex/ves/development/scripts/bin"

