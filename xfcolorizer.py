#!/usr/bin/python
import argparse, subprocess, os
from colorthief import ColorThief

parser = argparse.ArgumentParser()
parser.add_argument('--image','-i', required=True, help='set image to wallpaper and generate palette from image', nargs='*')
parser.add_argument('--window','-w', help='set window color and panel color from given value (hex)', nargs='*')
args = parser.parse_args()
#img = (args.image[0])

def rgb_to_hex(rgb):
	return '%02x%02x%02x' % rgb

if args.image[0]:
	wallpaperpaper=(args.image[0])
	print ("Generating palette color")
	color_thief = ColorThief(args.image[0])
	#dominant_color = color_thief.get_color(quality=1)
	palette = color_thief.get_palette(color_count=2)
	hex_palette = list()
	for i in enumerate(palette):
		hex_palette.append(rgb_to_hex(palette[i[0]]).upper())
	if args.window:
		if args.window[0]:
			new_palette = list()
			new_palette.append((args.window[0]).upper())
			new_palette.append(hex_palette[1])
			new_palette.append(hex_palette[2])
			#print("Palette Color")
			if new_palette[0]==new_palette[1] or new_palette[0]==new_palette[2] or new_palette[1]==new_palette[2]:
				print("Color can't be same")
			else :
				init_file = open( 'wallpaper.sh', 'w' )
				init_file.writelines( [ '#!/bin/bash\n', 'wallpaper=' + args.image[0] + '&&'] )
				init_file.writelines( [ 'properties=$(xfconf-query ', '-c ', 'xfce4-desktop ', '-p ', '/backdrop ', '-l ', '| ', 'grep ', '-e ', '"screen.*/monitor.*image-path$" ', '-e ', '"screen.*/monitor.*/last-image$") ', '&& '])
				init_file.writelines( [ 'for ', 'property ', 'in ', '$properties; ', 'do ', 'xfconf-query ', '-c ', 'xfce4-desktop ', '-p ', '$property ', '-s ', '"$wallpaperpaper"; ', 'done'])
				init_file.close()
				subprocess.Popen( [ 'chmod', '+x', './color.sh' ] )
				subprocess.Popen( [ 'chmod', '+x', './wallpaper.sh' ] )
				output = subprocess.call(['./color.sh', new_palette[0], new_palette[1], new_palette[2]])
				output = subprocess.call("./wallpaper.sh")
	else:
		new_palette = list()
		new_palette = (hex_palette)
		if new_palette[0]==new_palette[1] or new_palette[0]==new_palette[2] or new_palette[1]==new_palette[2]:
			print("Color can't be same")
		else :
			#print(new_palette)
			init_file = open( 'wallpaper.sh', 'w' )
			init_file.writelines( [ '#!/bin/bash\n', 'wallpaper=' + args.image[0] + '&&'] )
			init_file.writelines( [ 'properties=$(xfconf-query ', '-c ', 'xfce4-desktop ', '-p ', '/backdrop ', '-l ', '| ', 'grep ', '-e ', '"screen.*/monitor.*image-path$" ', '-e ', '"screen.*/monitor.*/last-image$") ', '&& '])
			init_file.writelines( [ 'for ', 'property ', 'in ', '$properties; ', 'do ', 'xfconf-query ', '-c ', 'xfce4-desktop ', '-p ', '$property ', '-s ', '"$wallpaper"; ', 'done'])
			init_file.close()
			subprocess.Popen( [ 'chmod', '+x', './color.sh' ] )
			subprocess.Popen( [ 'chmod', '+x', './wallpaper.sh' ] )
			#print(new_palette)
			output = subprocess.call(['./color.sh', new_palette[0], new_palette[1], new_palette[2]])
			output = subprocess.call("./wallpaper.sh")