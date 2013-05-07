#!/usr/bin/env bash
declare -A TARGETS
TARGETS[zlogin]=.zlogin
TARGETS[zlogout]=.zlogout
TARGETS[zpreztorc]=.zpreztorc
TARGETS[zprofile]=.zprofile
TARGETS[zshenv]=.zshenv
TARGETS[zshrc]=.zshrc

checkandlink () {
    SRC=$1
    DST=$2
    if [[ ! -h $DST || `readlink $DST` != $SRC ]]; then
        echo "--- Linking $DST to $SRC"
        rm -rf "$DST"
        ln -s "$SRC" "$DST"
    fi
}

checkandlink "$HOME/Code/prezto" "$HOME/.zprezto"
for DOTFILE in "${!TARGETS[@]}"; do
    SRC="$HOME/Code/prezto/runcoms/$DOTFILE"
    DST="$HOME/${TARGETS[$DOTFILE]}"
    checkandlink "$SRC" "$DST"
done
