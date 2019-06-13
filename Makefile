.PHONY: all zsh gpgbackup

all:

zsh:
	antibody bundle < zsh/.zsh_plugins.txt > zsh/.zsh_plugins.sh

gpgbackup:
	./gpgbackup.sh
