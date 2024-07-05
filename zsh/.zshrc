# Add this at the top to measure oh-my-zsh startup time
# zmodload zsh/zprof

# Set name of the theme to load
# PROMPT='%(!.%{%F{yellow}%}.)$USER @ %{$fg[white]%}%M %{$fg_bold[red]%}➜ %{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'
ZSH_THEME="typewritten/typewritten"

# Customize prompt layout
export TYPEWRITTEN_PROMPT_LAYOUT="pure_verbose"
export TYPEWRITTEN_RELATIVE_PATH="home"
export TYPEWRITTEN_COLOR_MAPPINGS="primary:#81A1C1;secondary:#B48EAD;accent:yellow;info_neutral_1:#BF616A"

# Declare Windows C and D directories
export HOMEC="/mnt/c/"
export HOMED="/mnt/d/"

# Declare Google drive
export HOMEG="/mnt/g/My Drive/"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set PATH to include user's private bin if found
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Set PATH to include cargo's bin if found
if [ -d "$HOME/.cargo/bin" ]; then
    PATH="$HOME/.cargo/bin:$PATH"
fi

# Install oh-my-zsh plugins
DIR="${ZSH}/custom/plugins"
declare -A REPOS=( # zsh
    [autoupdate]="https://github.com/TamCore/autoupdate-oh-my-zsh-plugins"
    [fzf-tab]="https://github.com/Aloxaf/fzf-tab"
    [zsh-autopair]="https://github.com/hlissner/zsh-autopair"
    [zsh-autosuggestions]="https://github.com/zsh-users/zsh-autosuggestions.git"
    [zsh-syntax-highlighting]="https://github.com/zsh-users/zsh-syntax-highlighting"
    [zsh-vi-mode]="https://github.com/jeffreytse/zsh-vi-mode"
)

# Loop through key/value pair
for key value in ${(kv)REPOS}
do
# Check if directory exist; if not, create dir and clone repo
    if [ ! -d "${DIR}/${key}" ]; then
        git clone "${REPOS[$key]}" "${DIR}/${key}"
    fi
done

# Standard plugins can be found in $ZSH/plugins/
plugins=(
    colored-man-pages # add color to man pages
    compleat # generate tab completion
    copybuffer # copy current text in command line to system clipboard ^O
    copyfile # copy contents of file to systemclip `copyfile <filename>`
    copypath # copy path or file name to systemclip `copypath [dir/file]`
    fzf # enable fuzzy auto-completion and keybinds
    encode64 # encode/decode base64 with `e64/d64` or file with `ef64`
    extract # extract the archive file you pass in `extract <filename>`
    history # add history alias h,hl,hs,hsi
    git # add git alias and functions
    urltools # encode/decode URL strings `urlencode <URL>`
    web-search # add alias for searching `google`, `bing`, `ddg`, yandex`
)

# Custom plugins can be found in $ZSH_CUSTOM/plugins/
plugins+=(
    autoupdate # update custom plugins
    # fzf-tab # replace completion menu with fzf (bugged)
    zsh-syntax-highlighting # highlights commands
    zsh-aliases # personal alias file
    zsh-autosuggestions # suggest commands as you type
    zsh-functions # personal functions file
    zsh-vi-mode # vim modes normal/visual
    zsh-autopair # create pairs for quotes/brackets
)

# source oh-my-zsh script
source $ZSH/oh-my-zsh.sh

# Zsh-vi-mode configuration
ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_UNDERLINE
ZVM_VI_INSERT_ESCAPE_BINDKEY=fj
# ZVM_VI_INSERT_ESCAPE_BINDKEY=jj

# Fzf and fdfind configuration
export FZF_DEFAULT_COMMAND="fdfind --type=f --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'batcat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_COMMAND="fdfind --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
_fzf_compgen_path() {
  fdfind --type=f --hidden --exclude .git . "$1" # [cmd] ** tab completion
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fdfind --type=d --hidden --exclude .git . "$1" # tab completion
}

# Setup file previews with bat and directory previews with eza with ^T and [cmd] ** tab
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
  --color=fg:#d0d0d0,fg+:#d0d0d0,bg:#282C34,bg+:#143652
  --color=hl:#c19d5e,hl+:#B388FF,info:#BF616A,marker:#f72c11
  --color=prompt:#B48EAD,spinner:#c19d5e,pointer:#81A1C1,header:#81A1C1
  --color=border:#d9d9d9,label:#aeaeae,query:#d9d9d9
  --border="rounded" --border-label="" --preview-window="border-rounded" --prompt="> "
  --marker=">" --pointer="◆" --separator="─" --scrollbar="│"
  --layout="reverse" --info="right"'

# Better `cd`
eval "$(zoxide init zsh)"

# bat theme - alternative to cat
export BAT_THEME=TwoDark

# Better history
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups

# Keybindings
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Fix up and down arrow keys in zsh-vi-mode
zvm_after_init_commands+=("bindkey '^[[A' up-line-or-search" "bindkey '^[[B' down-line-or-search")

# Fix autopair plugin
zvm_after_init_commands+=(autopair-init)
AUTOPAIR_INIT_INHIBIT=1

# Fix fzf keybinds CTRL+t and CTRL+r - use ~/.fzf/install
# ^R is to look through history
zvm_after_init_commands+=("[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh")

# disable sort when completing `git checkout`
# zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences here, fzf-tab will ignore them
# zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
# zstyle ':completion:*' menu no

# BUG: not loading with zsh-vi-mode
# fzf-tab completion configurations
# preview directory's content with eza when completing cd
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always $realpath'
# switch group using `<` and `>`
# zstyle ':fzf-tab:*' switch-group '<' '>'
# make use of popup feature in tmux
# zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

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
