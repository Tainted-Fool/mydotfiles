# runs aircrack on current wireless adapter
alias hackwifi='aircrack-ng wlan0'

# list files and directories
#alias ls='ls --color=always -rthla'
# -r = reverse; order the list so recently modify show at the bottom
# -t = output modification time; newest first
# -h = human-readable format
# -l = long listing format
# -a = list all files

# list all file and directories
#alias lt='ls --human-readable --size -1 -S --classify'

# list files and directories
#alias left='ls -t -1'

# count how many files are in current directory
alias count="find . -type f | wc -l"

# shows mount command in human readable format
alias mnt="mount | awk -F' ' '{ printf \"%s\t%s\n\",\$1,\$3; }' | column -t | egrep ^/dev/ | sort"

# mount Google drive
alias mountg="sudo mount -t drvfs G: /mnt/g"

# moves files to trash can
# need to create trash can folder first by deleteing a file
alias tcn="mv --force -t ~/.local/share/Trash "

# find files in our current directory
alias fhere="find . -name "

# list disk file system
alias df="df -Tha --total"

# list disk usage
alias du="du -ach | sort -h"

# list stroage and memory info
alias free="free -mlt"

# list processing table
alias ps="ps auxf"

# search processing table
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"

# create parent directory
alias mkdir="mkdir -pv"

# download files from the internet with the continue switch
alias wget="wget -c"

# outputs current IP address
alias myip="curl http://ipecho.net/plain; echo"

# default ping to 5
alias ping="ping -c 5 "

# list all ports up
alias ports="netstat -tulanp"

# logs into TryHackMe VPN
#alias openvpn='sudo openvpn /mnt/hgfs/VM\ Shared/TaintedFool.ovpn'

# runs ssh2john.py which converts RSA keys into hash files
alias ssh2john="python /usr/share/john/ssh2john.py "

# runs SQLMap.py which runs SQL Injections
# alias sqlmap='python /home/kali/Github/sqlpmap-dev/sqlmap.py '

# moves to VM_Shared directory
#alias vmshared='cd /mnt/hgfs/VM_Shared/'

# interact with our dotfile repository
alias dit="cd ~/.dotfiles && git status"
# alias dit="cd ~/.dotfiles && git $@"
# alias dit="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

# allows you to do a recursive git pull
alias multipull="find . -mindepth 1 -maxdepth 1 -type d -print -exec git -C {} pull \;"

# open Windows file explorer
alias start="/mnt/c/Windows/explorer.exe "

# open vscode from Windows - sudo apt purge code-oss
alias code="/mnt/c/tools/vscode/bin/code "

# shorthand batcat
# alias bat="batcat "

# colorize cat
# view a list of themes `bat --list-themes | fzf --preview="bat --theme={} --color=always /path/to/file`
# alias cat="batcat -pp --paging=never --style='plain' --theme=TwoDark "
alias cat="bat -pp --paging=never --style='plain' " # add BAT_THEME in .zshrc

# shorthand remmina
alias rdp="remmina"

# edit alias file
alias editali="nvim ~/.oh-my-zsh/custom/plugins/zsh-aliases/zsh-aliases.plugin.zsh"

# edit functions file
alias editfun="nvim ~/.oh-my-zsh/custom/plugins/zsh-functions/zsh-functions.plugin.zsh"

# edit zshrc file
alias editzsh="nvim ~/.zshrc"

# edit vimrc file
alias editvim="nvim ~/.vim/vimrc"

# edit nvim file
alias editnvim="nvim ~/.config/nvim/init.lua"

# edit tmux file
alias edittmux="nvim ~/.config/tmux/tmux.conf"

# source zsh file
alias src="source ~/.zshrc"

# add alias to 'fzf'
# alias fuzz="fzf"

# add alias to 'fdfind'
# alias fd="fdfind"

# add alias to 'eza' if found on machine
if [ -x "$(command -v eza)" ]; then
  alias ls="eza"
  alias la="eza --long --all --group"
fi

# add alias to 'zoxide' if found on machine
if [ -x "$(command -v zoxide)" ]; then
  alias cd="z"
fi
