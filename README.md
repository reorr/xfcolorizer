----------

xfcolorizer
===========

automatic tool to colorize gtk theme, xfwm theme and whisker-menu from 
choosen image for xfce desktop environtment, build from python and bash 
language.

Requirements
-------
 - inkscape
 - python3
 - colorthief
You can install colorthief using ``pip install colorthief`` command.

Usage
-----
Fist copy all content from dotfiles folder to your home folder.
To generate and apply theme and set wallpaper use:

> $ python xfcolorizer.py -i /path/to/your/image/file

This process will take long or shot time depending your computer specs to 
render assets file for gtk theme.

You also can use your chosen color for window border and panel with:

> $ python xfcolorizer.py -i /path/to/your/image/file -w "input_hex_color"

Example
-------
This is the example screenshot image of generated theme

![Generated theme 
1](https://github.com/reorr/xfcolorizer/raw/master/screenshot/2017-02-11-133008_1280x800_scrot.png)

![Generated theme 
2](https://github.com/reorr/xfcolorizer/raw/master/screenshot/2017-02-11-134751_1280x800_scrot.png)

