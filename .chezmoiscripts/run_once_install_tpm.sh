#!/bin/sh

tpm_dir="$HOME/.tmux/plugins/tpm"

if [ ! -d "${tpm_dir}" ]; then
	echo "installing Tmux Package Manager (TPM)"
	git clone https://github.com/tmux-plugins/tpm ${tpm_dir}
fi
