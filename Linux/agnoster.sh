#!/bin/bash
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/g' ~/.zshrc

echo "# key bindings" >> /.zshrc
echo "bindkey "\e[1~" beginning-of-line" >> /.zshrc
echo "bindkey "\e[4~" end-of-line" >> /.zshrc
echo "bindkey "\e[5~" beginning-of-history" >> /.zshrc
echo "bindkey "\e[6~" end-of-history" >> /.zshrc
echo "bindkey "\e[3~" delete-char" >> /.zshrc
echo "bindkey "\e[2~" quoted-insert" >> /.zshrc
echo "bindkey "\e[5C" forward-word" >> /.zshrc
echo "bindkey "\eOc" emacs-forward-word" >> /.zshrc
echo "bindkey "\e[5D" backward-word" >> /.zshrc
echo "bindkey "\eOd" emacs-backward-word" >> /.zshrc
echo "bindkey "\ee[C" forward-word" >> /.zshrc
echo "bindkey "\ee[D" backward-word" >> /.zshrc
echo "bindkey "^H" backward-delete-word" >> /.zshrc
echo "# for rxvt" >> /.zshrc
echo "bindkey "\e[8~" end-of-line" >> /.zshrc
echo "bindkey "\e[7~" beginning-of-line" >> /.zshrc
echo "# for non RH/Debian xterm, can't hurt for RH/DEbian xterm" >> /.zshrc
echo "bindkey "\eOH" beginning-of-line" >> /.zshrc
echo "bindkey "\eOF" end-of-line" >> /.zshrc
echo "# for freebsd console" >> /.zshrc
echo "bindkey "\e[H" beginning-of-line" >> /.zshrc
echo "bindkey "\e[F" end-of-line" >> /.zshrc
echo "# completion in the middle of a line" >> /.zshrc
echo "bindkey '^i' expand-or-complete-prefix" >> /.zshrc