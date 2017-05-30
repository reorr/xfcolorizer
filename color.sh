#!/bin/bash
directory=$HOME'/.themes/xfcolorize/'

last_window_color=354283
last_ancent_color=D997AE
last_ancent2_color=76A9C9

new_window_color=$1
new_ancent_color=$2
new_ancent2_color=$3

INKSCAPE=/usr/bin/inkscape
SVG="$directory"gtk-2.0/assets_fix.svg
LISTFILE="$directory"gtk-2.0/assets.txt
SRC_FILE="$directory"gtk-3.0/assets_fix.svg
ASSETS_DIR="$directory"gtk-3.0/assets
ASSETS_DIR20="$directory"gtk-3.20/assets
ASSETS_DIR22="$directory"gtk-3.22/assets
INDEX="$directory"gtk-3.0/assets.txt
WM_LIST="$directory"xfwm4/list.txt
RM_ASSETS_GTK_3="$directory"gtk-3.0/rm_assets.txt
RM_ASSETS_GTK_2="$directory"gtk-2.0/rm_assets.txt

echo Changing window color
find "$directory"xfwm4/ -type f -exec sed -i s/"$last_window_color"/"$new_window_color"/g {} \;

echo Changing GTK ancent color
find "$directory"gtk-2.0/ -type f -exec sed -i s/"$last_window_color"/"$new_window_color"/g {} \;
sed -i s/"$last_window_color"/"$new_window_color"/g "$directory"gnome-shell/gnome-shell.css
sed -i s/"$last_ancent_color"/"$new_ancent_color"/g "$directory"gtk-3.0/gtk.css
sed -i s/"$last_ancent_color"/"$new_ancent_color"/g "$directory"gtk-3.20/gtk.css
sed -i s/"$last_ancent_color"/"$new_ancent_color"/g "$directory"gtk-3.22/gtk.css
sed -i s/"$last_window_color"/"$new_window_color"/g "$directory"gtk-3.0/gtk.css
sed -i s/"$last_window_color"/"$new_window_color"/g "$directory"gtk-3.20/gtk.css
sed -i s/"$last_window_color"/"$new_window_color"/g "$directory"gtk-3.22/gtk.css
sed -i s/"$last_ancent_color"/"$new_ancent_color"/g "$directory"gtk-2.0/assets_fix.svg
sed -i s/"$last_ancent_color"/"$new_ancent_color"/g "$directory"gtk-2.0/3rd-party.rc
sed -i s/"$last_ancent_color"/"$new_ancent_color"/g "$directory"gtk-3.0/assets_fix.svg

echo Changing termite background color
sed -i s/"$last_window_color"/"$new_window_color"/g "$HOME"/.config/termite/config

echo Changing wishker menu color
sed -i s/"$last_window_color"/"$new_window_color"/g "$HOME"/.gtkrc-2.0.mine
sed -i s/"$last_ancent_color"/"$new_ancent_color"/g "$HOME"/.gtkrc-2.0.mine

echo Changing notification color
find "$directory"xfce-notify-4.0/ -type f -exec sed -i s/"$last_window_color"/"$new_window_color"/g {} \;
find "$directory"xfce-notify-4.0/ -type f -exec sed -i s/"$last_ancent_color"/"$new_ancent_color"/g {} \;
find "$directory"xfce-notify-4.0/ -type f -exec sed -i s/"$last_ancent2_color"/"$new_ancent2_color"/g {} \;

for wmwm in `cat $WM_LIST`
do
	sed -i s/"$last_window_color"/"$new_window_color"/g "$directory"xfwm4/$wmwm
done

sed -i s/"$last_window_color"/"$new_window_color"/g color.sh
sed -i s/"$last_ancent_color"/"$new_ancent_color"/g color.sh
sed -i s/"$last_ancent2_color"/"$new_ancent2_color"/g color.sh

echo Rendering assets
for assets_del in `cat $RM_ASSETS_GTK_3`
do
	rm "$ASSETS_DIR"/"$assets_del".png
	rm "$ASSETS_DIR"/"$assets_del"@2.png
	rm "$ASSETS_DIR20"/"$assets_del".png
	rm "$ASSETS_DIR20"/"$assets_del"@2.png
	rm "$ASSETS_DIR22"/"$assets_del".png
	rm "$ASSETS_DIR22"/"$assets_del"@2.png
done

for del_assets in `cat $RM_ASSETS_GTK_2`
do
	rm "$directory"gtk-2.0/$del_assets.png
done

for filename in `cat $LISTFILE`
do
	DIR=`echo $filename | cut -f1 -d '/'`
    echo Rendering "$directory"gtk-2.0/"$filename".png
	ID=`echo $filename | tr '/' '_'`
	$INKSCAPE $SVG --export-id=$ID -e "$directory"gtk-2.0/"$filename".png &>/dev/null
	#fi
done

rm -rf "$ASSETS_DIR20"/*
rm -rf "$ASSETS_DIR22"/*

for i in `cat $INDEX`
do 
    echo Rendering $ASSETS_DIR/$i.png
    $INKSCAPE --export-id=$i \
              --export-id-only \
              --export-png=$ASSETS_DIR/$i.png $SRC_FILE &>/dev/null #\
    echo Rendering $ASSETS_DIR/$i@2.png
    $INKSCAPE --export-id=$i \
              --export-dpi=180 \
              --export-id-only \
              --export-png=$ASSETS_DIR/$i@2.png $SRC_FILE &>/dev/null #\
done

cp "$ASSETS_DIR"/* "$ASSETS_DIR20"/
cp "$ASSETS_DIR"/* "$ASSETS_DIR22"/

echo Appliying theme
xfconf-query -c xfwm4 -p /general/theme -s "adwaita"
xfconf-query -c xfwm4 -p /general/theme -s "xfcolorize"
xfconf-query -c xsettings -p /Net/ThemeName -s "adwaita"
xfconf-query -c xsettings -p /Net/ThemeName -s "xfcolorize"
xfconf-query -c xfce4-notifyd -p /theme -s "xfcolorize"

echo Restarting panel
xfce4-panel -r  &> /dev/null