# Add this at the top to measure oh-my-zsh startup time
# zmodload zsh/zprof

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

# X11 forwarding - slows down oh-my-zsh startup
# if [ -x "$(command -v tasklist.exe)" ] && (tasklist.exe | grep -q vcxsrv.exe); then
#     export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0
#     export LIBGL_ALWAYS_INDIRECT=1
# fi

# Install oh-my-zsh plugins
# Check if directory exist; if not, create dir and clone repo
DIR=$ZSH/custom/plugins/zsh-syntax-highlighting
if [ ! -d $DIR ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting $DIR
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
    fzf
    encode64
    extract
    history
    git
    urltools
    # vi-mode # switch to zsh-vi-mode
    web-search
    # z # switch to zoxide
)

# added extra plugins
# these have to be downloaded from github and added to $ZSH_CUSTOM/plugins/
plugins+=(
    # fast-syntax-highlighting # this is slow
    autoupdate
    zsh-syntax-highlighting
    zsh-aliases
    zsh-autosuggestions
    zsh-functions
    zsh-vi-mode
    zsh-autopair
)

# source oh-my-zsh script
source $ZSH/oh-my-zsh.sh

# Vi-mode configuration
# VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true # redraw prompt when switching modes
# VI_MODE_SET_CURSOR=true # change cursor style when switching modes
# VI_MODE_CURSOR_NORMAL=1 # blinking block
# VI_MODE_CURSOR_INSERT=3 # blinking underline

# Zsh-vi-mode configuration
ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_UNDERLINE
# ZVM_VI_INSERT_ESCAPE_BINDKEY=fj
ZVM_VI_INSERT_ESCAPE_BINDKEY=jj

# Fix up and down arrow keys in zsh-vi-mode
zvm_after_init_commands+=("bindkey '^[[A' up-line-or-search" "bindkey '^[[B' down-line-or-search")

# Fix autopair plugin
zvm_after_init_commands+=(autopair-init)
AUTOPAIR_INIT_INHIBIT=1

# Fix fzf keybinds CTRL+t and CTRL+r - use ~/.fzf/install
zvm_after_init_commands+=("[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh")

# Fzf and fdfind configuration
export FZF_DEFAULT_COMMAND="fdfind --type=f --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'batcat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_COMMAND="fdfind --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
_fzf_compgen_path() {
  fdfind --type=f --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fdfind --type=d --hidden --exclude .git . "$1"
}

# Setup file previews with bat and directory previews with eza
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview "eza --tree --color=always {} | head -200" "$@" ;;
    export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
    ssh)          fzf --preview "dig {}"                   "$@" ;;
    *)            fzf --preview "batcat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}

# Set fzf color layout
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:#d0d0d0,fg+:#d0d0d0,bg:#121212,bg+:#262626
  --color=hl:#c19d5e,hl+:#f72c11,info:#afaf87,marker:#f72c11
  --color=prompt:#7936a9,spinner:#c19d5e,pointer:#705d76,header:#1e42c6
  --color=border:#262626,label:#aeaeae,query:#d9d9d9
  --border="rounded" --border-label="" --preview-window="border-rounded" --prompt="> "
  --marker=">" --pointer="◆" --separator="─" --scrollbar="│"
  --layout="reverse" --info="right"'

# Better `cd`
eval "$(zoxide init zsh)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$("/opt/anaconda3/bin/conda" "shell.zsh" "hook" 2> /dev/null)"
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

# Add this at the bot to measure oh-my-zsh startup time
# zprof
