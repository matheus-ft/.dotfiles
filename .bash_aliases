# Ubuntu's bashrc automatically looks for a .bash_aliases file
# but Fedora's one looks for a .bashrc.d/ directory
# so this way I can have a distro agnostic bash config
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            source "$rc"
        fi
    done
fi

