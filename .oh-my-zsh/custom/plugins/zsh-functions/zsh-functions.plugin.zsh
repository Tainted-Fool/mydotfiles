# Update kali
function apt-updater {
    sudo apt-get update &&
    sudo apt-get dist-upgrade -Vy &&
    sudo apt-get autoremove -y &&
    sudo apt-get autoclean &&
    sudo apt-get clean &&
}

# Update pip
function pip-updater {
    python -m pip install --upgrade pip
}

# Change directories and view the content at the same time
function cl() {
    DIR="$*";  
        # If no DIR given, go home
        if [ $# -lt 1 ]; then
            DIR=$HOME;
        fi;
    builtin cd "${DIR}" && \
    # Use your preferred ls command
        ls -F --color=auto
}

# Make directory and move into it
function mcd { # Make directory and move into it
    mkdir -p $1
    cd $1
}

# Create md5sum of a string
function md5() {
    echo -n $1 | md5sum | awk '{print $1}'
}

# Create sha256sum of a string
function sha256() {
    echo -n $1 | sha256sum | awk '{print $1}'
}

# Create sha1sum of a string
function sha1() {
    echo -n $1 | sha1sum | awk '{print $1}'
}

# Decode base64 of a string
function base64d() {
    echo -n $1 | base64 -d
}

# Encode base64 of a string
function base64e() {
    echo -n $1 | base64
}

# Find alias in these two folders below
function aliasf() {
    sudo grep -roI "^alias $1" /etc/ /home/kali/
}

# Find alias in every folder
function aliasfe() {
    sudo grep -roI "^alias $1" / --exclude-dir={sys,proc,srv,media,tmp,sbin,bin,boot,mnt,recovery,run,backups,var}
}

# Check arguments passed
function checkargs() {
    echo "$1"
}

# Open Obsidian notebook in VS Code in home directory
function notes() {
    # Create a variable for notebook directory
    DIR=$HOME/Notebook
    # Check if directory exist; if not, create dir and clone notebook
    if [ ! -d $DIR ]; then
        mkdir $DIR
        git clone https://github.com/Tainted-Fool/ObsidianNotebook $DIR
    fi

    code $DIR
}

function fuzz() {
    find . -type f | fzy
}
