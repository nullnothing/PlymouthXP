#!/bin/bash

# .sp extension = "script part"
# basically, we're breaking PlymouthXP into several parts
# for ease of development

SCRIPT_PARTS_DIR="./src"
FILES="boot.sp native.sp nativetext.sp main.sp"
OUTPUT="PlymouthXP.script"

cd $SCRIPT_PARTS_DIR
cat $FILES > ../$OUTPUT

echo "Done compilation"
