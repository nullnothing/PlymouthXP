#!/usr/bin/python3

# PlymouthXP
# 
# prepare_assets.py
# A utility to prepare the required assets for this project.
# See README for information.

import os, shutil
from distutils.spawn import find_executable
from PIL import Image, ImageDraw

def error(msg):
	print(msg)
	exit()

# Change working directory to script location
# Just to make sure everything goes smoothly.
path = os.path.realpath(__file__)
directory = os.path.dirname(path)
os.chdir(directory)

# Check for required programs
def check_program(prog):
	if find_executable(prog) == None:
		error("Required program %s not found!" % prog)

# We need mtpaint and wrestool.
# mtpaint is the *only* utility I could find that
# is able to correctly apply color to the extracted bitmaps..
# Luckily, it supports command-line scripting, which is neat!
check_program("mtpaint")
check_program("wrestool")

# Check for ntoskrnl.exe in working directory
if not os.path.isfile("ntoskrnl.exe"):
	error("ntoskrnl.exe not found! This file can be found in C:\\WINDOWS\\system32 from an XP installation.")

# Extract resources from ntoskrnl
if not os.path.isdir("ntoskrnl_out"):
	os.mkdir("ntoskrnl_out")

os.system("wrestool -x ntoskrnl.exe -t 2 -o ntoskrnl_out")

# Apply palette to extracted base & progress images
os.system("mtpaint --cmd -file/open=ntoskrnl_out/ntoskrnl.exe_2_1.bmp -palette/load=xp.gpl -file/save")
os.system("mtpaint --cmd -file/open=ntoskrnl_out/ntoskrnl.exe_2_8.bmp -palette/load=xp.gpl -file/save")

# Process colorized images

if not os.path.isdir("../images"):
	os.mkdir("../images")

# Base image: we need to clear the rectangle where the progress image will travel
main_image = Image.open("ntoskrnl_out/ntoskrnl.exe_2_1.bmp").convert("RGBA")
main_draw = ImageDraw.Draw(main_image)
main_draw.rectangle((259, 354, 376, 362), fill=(0, 0, 0, 0))
main_image.save("../images/base.png")

# Progress image: we need to add a 1px black (#000) border.
# This is because PlymouthXP emulates the scaling a modern monitor may
# apply to the XP boot screen. When the progress image is scaled, it must
# have that border so that the edges are fuzzy. If they weren't there, it
# would have hard edges -- not what we want.
progress_image = Image.open("ntoskrnl_out/ntoskrnl.exe_2_8.bmp").convert("RGBA")
progress_final_image = Image.new("RGBA", (24, 11), (0, 0, 0))
progress_final_image.paste(progress_image, (1, 1))
progress_final_image.save("../images/progress.png")

# All done. I'm omitting the cleanup step here, and leaving the choice to do so
# up to the end-user.
print("All done, assets have been prepared and placed in ../images.")
print("If you'd like, you can remove the ntoskrnl_out directory.")
