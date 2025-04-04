.PHONY: all

all:

.PHONY: clonenvimlazy clonetmuxressurect cloneantidote

clonenvimlazy:
	git clone --branch=stable https://github.com/folke/lazy.nvim ~/.local/share/nvim/lazy/lazy.nvim

clonetmuxressurect:
	git clone --depth=1 https://github.com/xorkevin/tmux-ressurect.git ~/.tmux/plugins/tmux-resurrect

cloneantidote:
	git clone --depth=1 https://github.com/mattmc3/antidote.git ~/.antidote
