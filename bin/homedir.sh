#!/bin/sh
# Spencer Butler <github@tcos.us>
# fix up dot files, and shit

DF_ARCHIVE="${HOME}/.dotfiles-archive"
DF_DEST="${HOME}/.dotfiles"
DF_REPO="https://github.com/spencerbutler/dotfiles.git"

DOTFILES=".bashrc
.bash_logout
.profile
.vimrc
.tmux.conf
.gitconfig
.screenrc
.vim
nvim
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
    # you should add a check for if ~/.config/$file is a symlink and if it points here
    # TODOtolazy
    elif [ "$file" = "nvim" -a -d "${HOME}/.config/$file" ]; then
        echo "==> Archiving ${HOME}/.config/$file => ${DF_ARCHIVE}/${file}"
        mv ${HOME}/.config/$file ${DF_ARCHIVE}/
    elif [ -f "$file" -o -d "$file" ]; then
        echo "==> Archiving $file => ${DF_ARCHIVE}/${file}"
        mv $file ${DF_ARCHIVE}/
    else
        echo "III==> $file doesn't exist"
    fi
    cd $HERE
}

install_file() {
    local file="$1"
    local HERE="$PWD"
    cd $HOME

    if [ -d "${DF_DEST}/${file}" -a "$file" = '.vim' ]; then
        echo "=> Copying ${DF_DEST}/${file} => $file..."
        cp -av ${DF_DEST}/${file} $file/
    elif [ -d "${DF_DEST}/${file}" -a "$file" = 'nvim' ]; then
        if [ -d "${HOME}/.config" ]; then
          echo "=> Copying ${DF_DEST}/${file} => ${HOME}/.config/$file..."
          ln -s ${DF_DEST}/${file} ${HOME}/.config/$file
        fi
    else
        echo "=> Linking ${DF_DEST}/${file} => $file..."
        ln -s ${DF_DEST}/${file} .
    fi

    cd $HERE
}


if [ ! -d "$DF_DEST" ]; then
    cd $HOME
    echo "==> Cloning $DF_REPO ..."
    git clone $DF_REPO  $DF_DEST || { echo "XXX=> Could not clone $DF_REPO"; exit 1; }
else
    cd $DF_DEST
    echo "==> Pulling $DF_REPO ..."
    git pull
fi

for dotfile in $DOTFILES; do
    archive $dotfile
    install_file $dotfile
done

bash -c '. ~/.bashrc'
echo .
echo ..
echo ...
echo ....
echo "Your dotfile environment is ready to go!"

