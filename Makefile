.PHONY: all

all:

.PHONY: clonenvimlazy clonetmuxresurrect cloneantidote

clonenvimlazy:
	git clone --branch=stable https://github.com/folke/lazy.nvim ~/.local/share/nvim/lazy/lazy.nvim

clonetmuxresurrect:
	git clone --depth=1 https://github.com/tmux-plugins/tmux-resurrect ~/.local/share/tmux/plugins/tmux-resurrect

cloneantidote:
	git clone --depth=1 https://github.com/mattmc3/antidote.git ~/.antidote
