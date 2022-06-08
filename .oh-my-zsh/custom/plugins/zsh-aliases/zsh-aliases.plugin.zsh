# Runs aircrack on current wireless adapter
alias hackwifi='aircrack-ng wlan0'

# List files and directories
#alias ls='ls --color=always -rthla'
# -r = reverse; order the list so recently modify show at the bottom
# -t = output modification time; newest first
# -h = human-readable format
# -l = long listing format
# -a = list all files

# List all file and directories
#alias lt='ls --human-readable --size -1 -S --classify'

# List files and directories
#alias left='ls -t -1'

# Count how many files are in current directory
alias count='find . -type f | wc -l'

# Shows mount command in human readable format
alias mnt="mount | awk -F' ' '{ printf \"%s\t%s\n\",\$1,\$3; }' | column -t | egrep ^/dev/ | sort"

# Mount Google drive
alias mountg="sudo mount -t drvfs G: /mnt/g"

# Moves files to trash can
# Need to create trash can folder first by deleteing a file
alias tcn='mv --force -t ~/.local/share/Trash '

# Find files in our current directory
alias fhere='find . -name '

# List disk file system
alias df='df -Tha --total'

# List disk usage
alias du='du -ach | sort -h'

# List stroage and memory info
alias free='free -mlt'

# List processing table
alias ps='ps auxf'

# Search processing table
alias psg='ps aux | grep -v grep | grep -i -e VSZ -e'

# Create parent directory
alias mkdir='mkdir -pv'

# Download files from the internet with the continue switch
alias wget='wget -c'

# Outputs current IP address
alias myip='curl http://ipecho.net/plain; echo'

# Default ping to 5
alias ping='ping -c 5 '

# List all ports up
alias ports='netstat -tulanp'

# Logs into TryHackMe VPN
#alias openvpn='sudo openvpn /mnt/hgfs/VM\ Shared/TaintedFool.ovpn'

# Runs ssh2john.py which converts RSA keys into hash files
alias ssh2john='python /usr/share/john/ssh2john.py '

# Runs SQLMap.py which runs SQL Injections
# alias sqlmap='python /home/kali/Github/sqlpmap-dev/sqlmap.py '

# Moves to VM_Shared directory
#alias vmshared='cd /mnt/hgfs/VM_Shared/'

# Interact with our dotfile repository
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

# Allows you to do a recursive git pull
alias multipull='find . -mindepth 1 -maxdepth 1 -type d -print -exec git -C {} pull \;'

# Open Windows file explorer
alias start='explorer.exe '

# Shorthand batcat
alias bat="batcat "

# Colorize cat
alias cat="batcat -pp --paging=never --style='plain' --theme=TwoDark "

# Shorthand remmina
alias rdp="remmina"

# Edit alias file
alias aalias='vim ~/.oh-my-zsh/custom/plugins/zsh-aliases/zsh-aliases.plugin.zsh'

# Edit functions file
alias falias='vim ~/.oh-my-zsh/custom/plugins/zsh-functions/zsh-functions.plugin.zsh'

# Edit zshrc file
alias vimzsh="vim ~/.zshrc"

# Edit vimrc file
alias vimrc="vim ~/.vim/vimrc"

# Source zsh file
alias srczsh="source ~/.zshrc"

# Add alias to 'colorls' and 'exa' if found on machine
if [ -x "$(command -v colorls)" ]; then
	alias ls="colorls"
	alias la="colorls -al"
fi

if [ -x "$(command -v exa)" ]; then
  alias ls="exa"
	alias la="exa --long --all --group"
fi
