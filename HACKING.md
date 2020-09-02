 # Kyzenred Hacking

So you want to extend the theme, yes? First up, let's talk about what you'll need

first, you need to know that Kyzenred is a pure SVG theme. This means that if you want to change things you'll need to know how SVGs works, along with good HTML and CSS knowledge.

Thankfully, there's [w3school](). With their little SVG reference you'll be ready in no time to edit the theme!


## Generating

Unlike KDE, Kyzenred uses explicit bash scripts to recolor a SVG file. To regenerate the SVG, just run the `kyzenred-generate.sh` script in the `scripts` directory like so:
```bash
$ ./kyzenred-generate.sh
```
SVG regeneration has two steps:
1. Recoloring the SVG file
2. Re-rendering the SVG files

## Recoloring

Kyzenred is a dynamically colored theme. This means that its components are dynamically recolored based on the current color scheme.

Most SVGs (excepts for GTK3) uses a system similar to KDE's plasma theme recoloring. In essence, at render time a special CSS stylesheet is inserted into the SVG file.

This stylesheet contains special CSS classes with color scheme specific colors. 

Each of these classes can be used on an SVG element to give them unique colors.

If you want to know more about it, I sugest you take a look at KDE's plasma theming guide. There's also in this repository the `src/recolor.css` file that contains the stylesheet template to be inserted.

The theme uses a simple `sed` to fill out a template with the current color scheme's color.

## Re-rendering
To fully support GTK2, the `kyzenred-generate.sh` script also render some PNG files to be used by GTK2 while rendering components.

These assets will be generated in the `assets/gtk2` directory. The `assets/gtk2` is further seperated into many sub-directories, each containing differents GTK2 assets.

To know where each `.png` files goes, a special file (`scripts/gtk2-assets.txt`) is used. These contains a list of `.png` file names. Should you need to add a new `.png` file this is where it happens.

Once it's rendering time, the system will look into this file and render the SVG element with a specific ID in the `src/gtk2-assets.svg` file. To get that ID, we simply take their coresponding line in the `scripts/gtk2-assets.txt` file and replace the `/` with a `_`.

For example, if in `scripts/gtk2-assets.txt` there's a line like this:
```
Buttons/button
```

Then the script will render `assets/gtk2/Buttons/button.png` with the SVG element with the id `Buttons_button`.

To render an element at a diferent scale, simply add another line in the `scripts/gtk2-assets.txt` file and append a "@" followed by any whole number. For example, there's a line in `scripts/gtk2-assets.txt` that looks like this:
```
TitleBar/close@2
```
Then the script will render `assets/gtk2/TitleBar/close@2.png` with the SVG element with the id `TitleBar_close` at 2x the original scale.

## GTKRC

Once the SVGs are rendered, the script then generate a new `.gtkrc` file according to the current KDE color scheme. 

This uses a similar process to SVG recoloring, except that rather that generating a stylesheet the script generate a `.gtkrc` file.

To put it simply, we just update most of GTK2's colors to the current's color scheme. 