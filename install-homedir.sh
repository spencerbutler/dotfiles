#!/bin/sh
# Spencer Butler <github@tcos.us>
# fix up dot files, and shit

DF_ARCHIVE="${HOME}/.dotfiles-archive"
DF_REPO="https://github.com/spencerbutler/dotfiles.git"

if ! type stow; then
  echo "Install stow or make symlinks"
  exit 1
fi

[ ! -d $DF_ARCHIVE ] && mkdir $DF_ARCHIVE
[ -f ~/.bashrc ] && mv ~/.bashrc $DF_ARCHIVE/
[ -f ~/.bash_login ] && mv ~/.bash_login $DF_ARCHIVE/
[ -f ~/.bash_profile ] && mv ~/.bash_profile $DF_ARCHIVE/
[ -d ~/.vim ] && mv ~/.vim $DF_ARCHIVE/
[ -f ~/.vimrc ] && mv ~/.vimrc $DF_ARCHIVE/
[ -f ~/.tmux.conf ] && mv ~/.tmux.conf $DF_ARCHIVE/
[ -d ~/.tmux ] && mv ~/.tmux $DF_ARCHIVE/
[ -f ~/.inputrc ] && mv ~/.inputrc $DF_ARCHIVE/
[ -d ~/.git ] && mv ~/.git $DF_ARCHIVE/
[ -f ~/.gitconfig ] && mv ~/.gitconfig $DF_ARCHIVE/
[ -d ~/.git_template ] && mv ~/.git_template $DF_ARCHIVE/
[ -f ~/.screenrc ] && mv ~/.screenrc $DF_ARCHIVE/

cd $HOME
git clone $DF_REPO  ~/.dotfiles || { echo "Could not clone $DF_REPO"; exit 1; }
cd ${HOME}/.dotfiles
stow -v bash
stow -v vim
stow -v tmux
stow -v inputrc
stow -v git
stow -v screen
cd $HOME
source ${HOME}/.bashrc
echo .
echo ..
echo ...
echo ....
echo "Your dotfile environment is ready to go!"

