#! /bin/bash

GTK2_SRC_FILE="../src/gtk2-assets.svg"
ASSETS_DIR="../assets/gtk2"
INDEX_SRC="./gtk2-assets.txt"
INDEX=""
INKSCAPE="$(command -v inkscape)"

inkver="$($INKSCAPE --version | awk '{print $2}' | cut -c 1-4)"
if [ "$inkver" = 0.91 ]; then
    non_scale_dpi=90
else
    non_scale_dpi=96
fi

render-non-scale() {
    ID=$(echo "$i" | tr '/' '_')
    $INKSCAPE --export-id="$ID" \
              --export-dpi="$non_scale_dpi" \
              --export-id-only \
              --export-type=png \
              --export-filename="$ASSETS_DIR/$i.png" $GTK2_SRC_FILE >/dev/null \
                                                        2>>../inkscape.log
}
render-scaled() {
    ID=$(echo "$i" | tr '/' '_' | tr -d "@$1" )
    $INKSCAPE --export-id="$ID" \
              --export-dpi="$(echo "$non_scale_dpi * $1" | bc -l)" \
              --export-id-only \
              --export-type=png \
              --export-filename="$ASSETS_DIR/$i.png" $GTK2_SRC_FILE >/dev/null \
                                                        2>>../inkscape.log
}

INDEX=$(<$INDEX_SRC)

for i in ${INDEX[@]}
do
    SUB_DIR=$(echo "$i" | cut -f1 -d '/')

    if [ '!' -d "$ASSETS_DIR/$SUB_DIR" ]; then
        mkdir -p "$ASSETS_DIR/$SUB_DIR"; 
    fi

    if [ -f "$ASSETS_DIR/$i.png" ] && [ $GTK2_SRC_FILE -ot "$ASSETS_DIR/$i.png" ]; then
        echo "$ASSETS_DIR/$i.png" exists.
    else

        if [ -f "$ASSETS_DIR/$i.png" ] && [ $GTK2_SRC_FILE -nt "$ASSETS_DIR/$i.png" ]; then
            echo Re-rendering "$ASSETS_DIR/$i.png"
            rm -f "$ASSETS_DIR/$i.png"
        else
            echo Rendering "$ASSETS_DIR/$i.png"
        fi
   
        echo "$i.png" >>../inkscape.log

        if echo "$i" | grep  -q "@[[:digit:]]\+"; then
            render-scaled "$(echo "$i" | grep "@[[:digit:]]\+" -o | grep "[[:digit:]]\+" -o)"
        else 
            render-non-scale
        fi

    fi

done

exit 0