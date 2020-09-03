# Kyzenred
A full KDE theme based on gamer aesthetics and modern minimalism (GTK themes and assets)

![Kyzenred Preview](https://github.com/MiiMii1205/kyzenred-plasma-look-and-feel/blob/master/contents/previews/fullscreenpreview.jpg?raw=true)

## Dependencies
- KDE >= 5
- Inkscape 
- Bash
- GTK2 Murrine engine

## Installation
Just put this repository in your `~/.themes/` directory (make a new one if it doesn't exist)

## Usage
To set your GTK+ theme you'll need to open up your KDE system manager and go to the [GNOME Application Style (GTK)](https://userbase.kde.org/System_Settings/GNOME_Application_Style_(GTK)) section.

## Updating the color scheme
At its core, Kyzenred comes with pre-rendered assets that matches it's official color scheme. That means that you can use Kyzenred as is.

However, Kyzenred was designed to handle (more or less) any KDE color scheme you'll throw at it.

To find out how to change your KDE color scheme, [click here](https://docs.kde.org/trunk5/en/kde-workspace/kcontrol/colors/index.html)!

### GTK3 
GTK3 almost fully support KDE color scheme out of the box (given you have a correctly configured KDE environment) aside for some applications and some graphical bugs (looking at you chrome)

To fully update your color scheme see the section below:

### GTK2
To use your new KDE color scheme in GTK2 you'll need to regenerate the GUI ressources.
Go to the theme's directory with a terminal and execute the `kyzenred-generate.sh` script in the `scripts` directory like so:
```bash
$ ./kyzenred-generate.sh
```
Regenerating GUI assets might take a while, so grab your g-fuel and enjoy yourself!

Remember to re-run this command every time you change your color scheme, otherwise you're in for a bumpy ride!
