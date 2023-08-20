.PHONY: all zsh gpgbackup

all:

zsh:
	antibody bundle < zsh/.zsh_plugins.txt > zsh/.zsh_plugins.sh

gpgbackup:
	./gpgbackup.sh

clonenvimpacker:
	git clone --depth=1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

clonetmuxressurect:
	git clone --depth=1 https://github.com/xorkevin/tmux-ressurect.git ~/.tmux/plugins/tmux-resurrect

cloneantidote:
	git clone --depth=1 https://github.com/mattmc3/antidote.git ~/.antidote
