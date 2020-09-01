#! /bin/sh

GTK2_SRC_FILE="../gtk-2.0/gtkrc"
TEMPLATE_FILE="./gtkrctemplate"

if [ -e $TEMPLATE_FILE ]; then

    echo Generating standard GTK 2.0 colors...

    TEMPLATE=$(
        < $TEMPLATE_FILE ./kyzenred-gtk-color-edit.sh "ForegroundNormal" "Colors:View" "text" |
        ./kyzenred-gtk-color-edit.sh "BackgroundNormal" "Colors:View" "base" |
        ./kyzenred-gtk-color-edit.sh "ForegroundNormal" "Colors:Window" "foreground" |
        ./kyzenred-gtk-color-edit.sh "BackgroundNormal" "Colors:Window" "background" |
        ./kyzenred-gtk-color-edit.sh "BackgroundNormal" "Colors:Selection" "selected-background" |
        ./kyzenred-gtk-color-edit.sh "ForegroundNormal" "Colors:Selection" "selected-text" |
        ./kyzenred-gtk-color-edit.sh "ForegroundNormal" "Colors:Button" "button-text" |
        ./kyzenred-gtk-color-edit.sh "DecorationFocus" "Colors:Button" "button-active" |
        ./kyzenred-gtk-color-edit.sh "ForegroundLink" "Colors:Window" "link" |
        ./kyzenred-gtk-color-edit.sh "ForegroundVisited" "Colors:Window" "link-visited" |
        ./kyzenred-gtk-color-edit.sh "BackgroundAlternate" "Colors:View" "base-color-alt" |
        ./kyzenred-gtk-color-edit.sh "DecorationHover" "Colors:Button" "button-hover"
    )

    echo Generating disabled GTK 2.0 colors...

   TEMPLATE=$(echo "$TEMPLATE" |
        ./kyzenred-gtk-color-edit-effects.sh "ForegroundNormal" "Colors:View" "text-disabled" d |
        ./kyzenred-gtk-color-edit-effects.sh "ForegroundNormal" "Colors:Window" "foreground-disabled" d |
        ./kyzenred-gtk-color-edit-effects.sh "BackgroundNormal" "Colors:View" "base-disabled" d |
        ./kyzenred-gtk-color-edit-effects.sh "BackgroundNormal" "Colors:Window" "background-disabled" d |
        ./kyzenred-gtk-color-edit-effects.sh "ForegroundNormal" "Colors:Button" "button-text-disabled" d 
    )

    echo Generating mixed GTK 2.0 colors...

   TEMPLATE=$(echo "$TEMPLATE" |
        ./kyzenred-gtk-color-edit-mix.sh "BackgroundNormal" "Colors:Window" "ForegroundNormal" "Colors:Window" "0.2" "inactive-tab-borders" |
        ./kyzenred-gtk-color-edit-mix.sh "BackgroundNormal" "Colors:Window" "ForegroundNormal" "Colors:Window" "0.25" "inactive-tab"
    )

    echo Generating timestamps...

    TIMESTAMP=$(printf '%-20s#\n' "$(date +"%D %T")");
    TEMPLATE=$(echo "$TEMPLATE" | sed -e "s|{{timestamp}}|$TIMESTAMP|gi");

    echo "$TEMPLATE" > $GTK2_SRC_FILE;

    echo GTKRC file generated!
    
else
    
    >&2 echo gtkrctemplate was not found. Stopped...
    exit 1
    
fi