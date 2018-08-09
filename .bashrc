# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac


# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias c='clear'
alias q='exit'
alias dt='cd ~/Desktop'
alias dl='cd ~/Downloads'
alias init=' sudo apt install ffmpeg npm python-dev python3-dev testdisk net-tools unrar unity compiz qemu-kvm curl samba system-config-samba gdebi mysql-workbench policycoreutils lsb-core postgresql-10 gimp compizconfig-settings-manager  zfsutils-linux sendmail ruby vim git vlc xclip okular synaptic tmux python3-pip lxd blender fish chromium-browser libncurses5-dev libcurses-ocaml-dev nginx-full && sudo npm install n -g && sudo n latest'
alias ppainit='sudo add-apt-repository ppa:gezakovacs/ppa && sudo apt-get update'
alias pbcopy="xclip -sel clip"
alias copysshkey="cat ~/.ssh/id_rsa.pub | xclip -i"
alias pwr="sudo shutdown -P 0"
alias rst="sudo shutdown -r 0"
alias u="sudo apt-get update"
alias src="source ~/.bashrc"

pushconfigs(){
	pushd . && cd && git commit -am "`date`" && git push configs master  && popd
}

setupsendmail(){
cat /etc/hosts | sed 's/^127.0.0.1\slocalhost/& noraa-HP-Pavilion-Laptop-15-cc1xx/' > /tmp/sendmail && sudo mv /tmp/sendmail /etc/hosts && sudo sendmailconfig
}

clonevim(){
	git clone https://github.com/vim/vim.git ~/vim 
}

ivim(){
	pushd . && cd ~/vim/src && make distclean && ./configure --enable-python3interp && make && sudo make install && popd
}

configit(){
	git config --global user.email "aaronyan2001@gmail.com"
	git config --global user.name  "aaron"
}
initgit(){
	git remote add configs git@github.com:9G1IC/configs.git
}

igitlabrunner(){
	curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | sudo bash &&
	sudo apt-get update &&
	sudo apt-get install gitlab-runner
}

igitlab(){
	curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.deb.sh | sudo bash &&
	sudo apt install  redis libpq-dev postgresql-contrib &&
	sudo EXTERNAL_URL="http://gitlab.com" apt-get install gitlab-ee &&
	sudo apt install gitlab-cli 
}	

ytdl(){
	sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
	sudo chmod a+rx /usr/local/bin/youtube-dl
}

vundle(){
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
}

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

setxkbmap -option caps:swapescape

export PATH=$PATH:$HOME/.local/bin/:/usr/local/android-studio/bin:/usr/local/jdk-10.0.1/bin/:/usr/local/gradle-4.8.1/bin/
export -f ytdl
export -f vundle
export -f igitlab
export -f igitlabrunner
export -f setupsendmail
export -f pushconfigs
export -f initgit
export -f ivim
export -f clonevim
export -f configit
