# Set name of the theme to load
#PROMPT='%(!.%{%F{yellow}%}.)$USER @ %{$fg[white]%}%M %{$fg_bold[red]%}➜ %{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'
ZSH_THEME="typewritten/typewritten"

# Customize prompt layout
export TYPEWRITTEN_PROMPT_LAYOUT="pure_verbose"
export TYPEWRITTEN_RELATIVE_PATH="home"
export TYPEWRITTEN_COLOR_MAPPINGS="primary:#81A1C1;secondary:#B48EAD;accent:yellow;info_neutral_1:#BF616A"

# Set PATH to include user's private bin if found
if [ -d "$HOME/.local/bin" ]; then
	PATH="$HOME/.local/bin:$PATH"
fi

# Set PATH to include cargo's bin if found
if [ -d "$HOME/.cargo/bin" ]; then
	PATH="$HOME/.cargo/bin:$PATH"
fi

# Declare Windows C and D directories
export HOMEC="/mnt/c/"
export HOMED="/mnt/d/"

# Declare Google drive
export HOMEG="/mnt/g/My Drive/"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# X11 forwarding
if [ -x "$(command -v tasklist.exe)" ] && (tasklist.exe | grep -q vcxsrv.exe); then
    export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0
    export LIBGL_ALWAYS_INDIRECT=1
fi

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

# added extra plugins
# these have to be downloaded from github and added to $ZSH_CUSTOM/plugins/
plugins+=(
    fast-syntax-highlighting
    zsh-aliases
    zsh-autosuggestions
    zsh-functions
    zsh-vi-mode
    zsh-autopair
)

# source bash script
source $ZSH/oh-my-zsh.sh

# User configuration
ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_UNDERLINE
ZVM_VI_INSERT_ESCAPE_BINDKEY=fj
zvm_after_init_commands+=("bindkey '^[[A' up-line-or-search" "bindkey '^[[B' down-line-or-search")

# Fix autopair plugin
zvm_after_init_commands+=(autopair-init)
AUTOPAIR_INIT_INHIBIT=1

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

# Activate `zsh-autopair`
# This confilcts with zsh-vi-mode; only one can be active at a time
autopair-init
