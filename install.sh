rm -rf /usr/share/plymouth/themes/PlymouthXP
cp -r $(pwd) /usr/share/plymouth/themes/PlymouthXP
plymouth-set-default-theme -R PlymouthXP
