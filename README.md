# go go go dotfiles!

`cd ~`
- Clone the repo:
`git clone https://github.com/spencerbutler/dotfiles.git`
- Enter the dotfiles directory
`cd dotfiles`
- If this is the first time cloning the repo, configure the submodules for vim
`git submodule update --init --recursive`
Later on, to update the modules for vim
`git submodule update --recursive --remote`
## Install the bash settings
`stow bash -t ~/`
## Install bash settings for the root user
`sudo stow bash -t /root`
## Install inputrc
`stow inputrc -t ~/`
Uninstall inputrc
`stow -D inputrc -t ~/`



## termcap-freebsd/.termcap
This file is changed from the distro version so it doesnt wipe out what was previously on the terminal before loading a full screen cli app
- https://forums.freebsd.org/threads/8726/#post-51511
- https://superuser.com/questions/715125/openssh-freebsd-screen-overwrite-when-closing-application
