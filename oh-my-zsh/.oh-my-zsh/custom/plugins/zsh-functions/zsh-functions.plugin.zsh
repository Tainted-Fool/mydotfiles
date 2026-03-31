# Update kali
# function apt-updater {
#     sudo apt-get update &&
#     sudo apt-get dist-upgrade -Vy &&
#     sudo apt-get autoremove -y &&
#     sudo apt-get autoclean &&
#     sudo apt-get clean &&
# }

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
function mcd {
    mkdir -p $1
    cd $1
}

# Create md5sum of a string
function md5() {
    echo -n $1 | md5sum | awk '{print $1}'
}

# Check md5sum agianst a string
function md5check() {
  printf '%s %s\n' "$1" "$2" | md5sum --check
}

# Create sha256sum of a string
function sha256() {
    echo -n $1 | sha256sum | awk '{print $1}'
}

# Check sha256 agianst a string
function sha256check() {
  printf '%s %s\n' "$1" "$2" | sha256sum --check
}

# Create sha1sum of a string
function sha1() {
    echo -n $1 | sha1sum | awk '{print $1}'
}

# Check sha1 agianst a string
function sha1check() {
  printf '%s %s\n' "$1" "$2" | sha1sum --check
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

# Check startup time of shell
function timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 5); do time $shell -i -c exit; done
}

# Decompile python bytecode to python2/3 source code
function decompyler() {
  docker run --rm -v ~/repos/CaptureTheFlag/ncl:/data decompyler "/data/gym/$1"
}

# Print ascii table
# awk 'BEGIN {for(i=32;i<127;i++)printf("%d=%c ",i,i);print}'
function getascii() {
  awk 'BEGIN {for(i=32;i<127;i++)printf "%3d 0x%02x %c\n",i,i,i}'
}

# Do binary math
bitmath() {
    local mode="d"
    local expr

    case "$1" in
        -d|-x|-b|-o)
            mode="${1#-}"
            shift
            ;;
    esac

    expr="$*"
    local result=$(( expr ))

    case "$mode" in
        d) printf '%d\n' "$result" ;;
        x) printf '0x%x\n' "$result" ;;
        o) printf '0%o\n' "$result" ;;
        b)
            local bin=""
            local n=$result
            if (( n == 0 )); then
                echo 0
                return
            fi
            while (( n > 0 )); do
                bin="$(( n & 1 ))$bin"
                n=$(( n >> 1 ))
            done
            echo "$bin"
            ;;
    esac
}

# Open Obsidian notebook in VS Code in home directory
# function notes() {
#     # Create a variable for notebook directory
#     DIR=$HOME/Notebook
#     # Check if directory exist; if not, create dir and clone notebook
#     if [ ! -d $DIR ]; then
#         mkdir $DIR
#         git clone https://github.com/Tainted-Fool/ObsidianNotebook $DIR
#     fi
#
#     code $DIR
# }
