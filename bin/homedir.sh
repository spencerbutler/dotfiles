#!/bin/sh
# Spencer Butler <github@tcos.us>
# fix up dot files, and shit

DF_ARCHIVE="${HOME}/.dotfiles-archive"
DF_DEST="${HOME}/.dotfiles"
DF_REPO="https://github.com/spencerbutler/dotfiles.git"

DOTFILES=".bashrc
.bash_profile
.bash_logout
.vimrc
.tmux.conf
.gitconfig
.screenrc
.vim
"

[ -d $DF_ARCHIVE ] || mkdir $DF_ARCHIVE

archive() {
    local file=$1
    local islink="$(readlink $file)"
    local HERE="$PWD"
    cd $HOME

    if [ -n "$islink" ]; then
        echo "==> Removing SymLink $file => $islink"
        rm $file
    elif [ -f "$file" -o -d "$file" ]; then
        echo "==> Archiving $file => ${DF_ARCHIVE}/${file}"
        mv $file ${DF_ARCHIVE}/
    else
        echo "==> $file doesn't exist"
    fi
    cd $HERE
}

install_file() {
    local file="$1"
    local HERE="$PWD"
    cd $HOME

    if [ -d "${DF_DEST}/${file}" -a "$file" = '.vim' ]; then
        echo "=> Copying $file directory..."
        cp -av ${DF_DEST}/${file} $file/
    else
        ln -s ${DF_DEST}/${file} .
    fi

    cd $HERE
}


if [ ! -d "$DF_DEST" ]; then
    cd $HOME
    git clone $DF_REPO  $DF_DEST || { echo "Could not clone $DF_REPO"; exit 1; }
else
    cd $DF_DEST
    git pull
fi

for dotfile in $DOTFILES; do
    archive $dotfile
    install_file $dotfile
done

. ${HOME}/.bashrc
echo .
echo ..
echo ...
echo ....
echo "Your dotfile environment is ready to go!"

