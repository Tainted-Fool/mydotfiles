# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# Auto load Typewritten theme for oh-my-zsh
# fpath+=$ZSH_CUSTOM/themes/typewritten
# autoload -U promptinit; promptinit
# prompt typewritten

# Customize prompt layout
export TYPEWRITTEN_PROMPT_LAYOUT="pure_verbose"
export TYPEWRITTEN_RELATIVE_PATH="home"

# Set PATH to include user's private bin if found
if [ -d "$HOME/.local/bin" ]; then
	PATH="$HOME/.local/bin:$PATH"
fi

# Declare Windows C and D directories
export HOMEC="/mnt/c/"
export HOMED="/mnt/d/"

# Declare Google drive
export HOMEG="/mnt/g/My Drive/"

# Declare Anaconda path
# export ANACONDA="/opt/anaconda3"
# export PATH=$PATH:/opt/anaconda3/bin

# Customize prompt colors
# name=primary 	section=The current directory and git branch. default=magenta
# name=secondary 	section=The prompt symbol. default=blue
# name=accent 	section=The arrow, the host-user connector, the virtual env, and the right prompt prefix. default=default
# name=notice 	section=The symbol when user is root default=yellow
# name=info_negative 	section=The symbol when there is an error, the return error code, and the git status deleted symbol. default=red
# name=info_positive 	section=The git status staged symbol. default=green
# name=info_neutral_1 	section=The host, the user, and the git status stash and modified symbols. default=yellow
# name=info_neutral_2 	section=The git status new, diverged, ahead and behind symbols default=blue
# name=info_special 	section=The git status renamed and unmerged symbols. default=cyan
export TYPEWRITTEN_COLOR_MAPPINGS="primary:#81A1C1;secondary:#B48EAD;accent:yellow;info_neutral_1:#BF616A"

# Key bindings

# Add to .zshrc, beofre this plugin in loaded:
# Use `jj` instead of ESC to switch from INSERT mode to NORMAL mode - for the VIM-MODE plugin
VIM_MODE_VICMD_KEY='fj'

# Edit VIM-MODE plugin to swtich to INSERT mode from NORMAL mode
#bindkey -M vicmd '^J' vi-insert
#vim-mode-bindkey       vicmd -- vi-insert                          '^J'

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/kali/.oh-my-zsh"

# X11 forwarding
if tasklist.exe | grep -q vcxsrv.exe; then
  export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0
  export LIBGL_ALWAYS_INDIRECT=1
fi

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="typewritten/typewritten"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	colored-man-pages
	compleat 
	copybuffer 
	copyfile 
	copypath 
	encode64 
	extract 
	history 
	git 
	urltools 
	web-search 
	z
)

# added extra plugins - these have to be downloaded from github and added to $ZSH_CUSTOM/plugins/
plugins+=(
	zsh-aliases
  zsh-autopair
	zsh-autosuggestions 
	zsh-functions
	zsh-syntax-highlighting 
	zsh-vim-mode 
)

source $ZSH/oh-my-zsh.sh

# Activate `zsh-autopair`
autopair-init

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

