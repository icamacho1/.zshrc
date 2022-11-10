# For navigation
if [ -x $(which exa) ]; then
  alias la="exa -lahF --color=always --icons --sort=size --group-directories-first"
  alias ls="exa -lhF --color=always --icons --sort=size --group-directories-first"
else
  alias la="ls -lahF --color=always --sort=size --group-directories-first"
  alias ls="ls -lhF --color=always --sort=size --group-directories-first"
fi


# Git aliases:
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gst="git status"
alias gck="git checkout"
alias gls="git branch -a"
alias gb="git branch"
alias venv="python3 -m venv .venv && source .venv/bin/activate && python3 -m pip install --upgrade pip"
alias vim="lvim"

# Processes:
alias psa="ps auxf"

# Ports:
alias ports="lsof -i -P | grep LISTEN"

# Alias for bat:
if [ -x $(which bat) ]; then
  alias cat="bat"
fi

# Edit my config:
alias econf="vim ~/.zshrc && source ~/.zshrc"

# Custom docker functions:
dkill () {
  if [ ! -z "$1" ]; then
    image_id=`docker ps | grep ${1} | awk '{print $1}'`
    [[ -z $image_id ]] && echo "No image id found, exitting..."
    docker kill $image_id
    return 0
  fi
  docker ps | for image in $(grep -v "iker" | grep -Eo '^[a-zA-Z0-9]{12}'); do docker kill $image; done
}

dlog () {
  docker exec -it -u root ${1} bash
}

drmi () {
  for image_id in $(docker image ls | grep "<none>" | awk '{print $3}'); do
    docker image rmi $image_id --force
  done
}

alias dps="docker ps"
alias dls="docker image ls"

# Docker compose:
alias dkc="docker-compose"

# Launch my custom ubuntu image:
ilaunch () {
  bash -c "cd ~/.config/ubuntu_daemon; docker-compose up -d"
}
  
# Adding to path:
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/go/bin/
export PATH=$PATH:$HOME/.emacs.d/bin
export PATH=$PATH:$HOME/.rvm/bin/

# Make alacritty not case sensitive:
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
autoload -Uz compinit && compinit

# Rust path:
source $HOME/.cargo/env

# Starship init:
eval "$(starship init zsh)"

# Init personal stuff if exists:
[[ -f $HOME/.zshrc_personal ]] && source $HOME/.zshrc_personal
