.PHONY: all zsh gpgbackup

all:

zsh:
	antibody bundle < zsh/.zsh_plugins.txt > zsh/.zsh_plugins.sh

gpgbackup:
	./gpgbackup.sh

clonetmuxressurect:
	git clone --depth=1 https://github.com/xorkevin/tmux-ressurect.git ~/.tmux/plugins/tmux-resurrect
