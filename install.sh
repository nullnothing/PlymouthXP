# IMPORTANT: This install script has only been tested on Arch Linux.
# Installation procedure may vary from distribution-to-distribution.

rm -rf /usr/share/plymouth/themes/PlymouthXP
cp -r $(pwd) /usr/share/plymouth/themes/PlymouthXP
plymouth-set-default-theme -R PlymouthXP
