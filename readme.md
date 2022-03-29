# Notes
## Xshell
- set terminal to xterm-256color
- enable true color (tools->options->advanced)
- enable "Treat ambiguously sized charachters as wide"
## tmux
- set default-terminal "tmux-256color"
  - setting it to tmux-256color breaks in FreeBSD

## nvim
- nvim links to ~/.config/nvim
### FreeBSD
- the bash installer points to a 404 pkg
	- use pkg install yarn node16
- set `set expandtab` in vimrc after adding coc-nvim
  - it started adding hardtabs for some fucked up reason
