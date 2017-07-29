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
1](screenshots/2017-05-30-141559_1280x800_scrot.png)

![Generated theme 
2](screenshots/2017-05-30-152335_1280x800_scrot.png)

![Generated theme 
3](screenshots/2017-05-30-152745_1280x800_scrot.png)

![Generated theme 
4](screenshots/2017-05-30-144231_1280x800_scrot.png)

![Generated theme 
5](screenshots/2017-05-30-144647_1280x800_scrot.png)

![Generated theme 
6](screenshots/2017-05-30-145203_1280x800_scrot.png)

