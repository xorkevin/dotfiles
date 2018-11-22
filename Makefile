.PHONY: all zsh

all:

zsh:
	antibody bundle < zsh/.zsh_plugins.txt > zsh/.zsh_plugins.sh
