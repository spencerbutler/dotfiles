#!/usr/bin/env bash
#
# Install these dotfiles.
# Spencer Butler <dev@tcos.us>

UNDO_STRING=RenamedByInstallDotfiles
CWD="$(pwd)"
ALL_DOTFILES=(
.vimrc
.bashrc
.profile
.bash_logout
.tmux.conf
.vim
.gitconfig
.git_template
.inputrc
.screenrc
.pylintrc
)

if [ ! -e "${CWD}/$(basename "$0")" ]
then 
    echo "Run this script from the dotfile repo directory."
    exit 1
fi

get_help() {
    cat << EOF
Install dotfiles ...
    -h          This help.
    -i file     Install the given dotfile.
    -a          Install all dotfiles.
    -r          Remove all installed dotfiles (by this script). TODO(spencer)
EOF
    exit 0
}
    
current_file_is_dir() {
    _current_file_is_dir="${HOME}/$1"
    retval=1
    [ -d "$_current_file_is_dir" ] && retval=0

    return "$retval"
}

dotfile_is_dir() {
    _dotfile_is_dir="$1"
    retval=1
    [ -d "$_dotfile_is_dir" ] && retval=0

    return "$retval"
}

current_file_exists() {
    _current_file_exists="${HOME}/$1"
    retval=1
    [ -e "$_current_file_exists" ] && retval=0

    return "$retval"
}

current_file_is_symlink() {
    _current_file_is_symlink="${HOME}/$1"
    retval=1
    [ -L "$_current_file_is_symlink" ] && retval=0

    return "$retval"
}

undo_file_exists() {
    _undo_file_exists="{HOME}/${1}-${UNDO_STRING}"
    retval=1
    [ -e "$_undo_file_exists" ] && retval=0

    return "$retval"
}

install_dotfile() {
    _install_dotfile="$1"

    if dotfile_is_dir "$_install_dotfile"
    then
        if current_file_is_dir "$_install_dotfile"
        then
            #echo "${HOME}/${_install_dotfile} exists, appending $UNDO_STRING to the name."
            #echo "XXX DIR EXISTS Installing $_install_dotfile"

            if current_file_is_dir "${_install_dotfile}-${UNDO_STRING}"
            then
                echo "Found an existing ${HOME}/${_install_dotfile}-${UNDO_STRING}"
                echo "Did not install a new $_install_dotfile"
                return 0
            else
                mv "${HOME}/${_install_dotfile}" "${HOME}/${_install_dotfile}-${UNDO_STRING}"
                cp -a "${CWD}/${_install_dotfile}" "${HOME}/"
                return 0
            fi
        else
            echo "Installing $_install_dotfile"
            cp -a "${CWD}/${_install_dotfile}" "${HOME}/"
            return 0
        fi
    fi

    if current_file_exists "$_install_dotfile"
    then
        if current_file_is_symlink "$_install_dotfile"
        then
            _install_dotfile_LINK=$(readlink "${HOME}/${_install_dotfile}")

            if [ "$_install_dotfile_LINK" = "${CWD}/${_install_dotfile}" ]
            then
                echo "$_install_dotfile is already installed by us."

            else
                echo "Removing existing symlink $_install_dotfile_LINK"
                echo "Installing $_install_dotfile"
                rm "${HOME}/${_install_dotfile}"
                ln -s "${CWD}/${_install_dotfile}" "${HOME}/${_install_dotfile}"
            fi
        else
            #echo "Installing new $_install_dotfile"
            #ln -s "${CWD}/$_install_dotfile" "${HOME}/$_install_dotfile"
            echo "Found existing $_install_dotfile -- appending $UNDO_STRING to the name."
            echo "Installing (replacement) new $_install_dotfile"
            mv "${HOME}/${_install_dotfile}" "${HOME}/${_install_dotfile}-${UNDO_STRING}"
            ln -s "${CWD}/${_install_dotfile}" "${HOME}/${_install_dotfile}"
        fi

    else
        echo "Installing new $_install_dotfile"
        ln -s "${CWD}/${_install_dotfile}" "${HOME}/${_install_dotfile}"
    fi
}

install_all_dotfiles() {
    for dotfile in "${ALL_DOTFILES[@]}"
    do
        install_dotfile "$dotfile"
    done
}

#[ "$#" -eq 0 ] && get_help
while getopts 'hi:ar' opts
do
    case "${opts}" in
        i)
            install_dotfile "${OPTARG}"
        ;;
        a)
            install_all_dotfiles
        ;;
        r)
            echo "This feature is not yet available"
            #remove_all_dotfiles
        ;;
        *)
            get_help
        ;;
    esac
done