#! /bin/bash

ASSETS_DIR="../assets/gtk2"

if [ "$1" = "--clean" ]; then
     rm -rf $ASSETS_DIR;
     echo Assets cleaned!
fi

echo "Generating new Kyzenred GUI elements based on the current KDE color ($( kreadconfig5 --key "ColorScheme" --group "General" --file "$HOME/.config/kdeglobals"))"
./kyzenred-recolor.sh
./kyzenred-render.sh
./kyzenred-gtkrc-generator.sh
echo "Done!"
