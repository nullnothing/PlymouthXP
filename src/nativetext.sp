# nativetext.sp
# TODO define actual text region here with sprites (2d array? is it possible with plymouth?)
# also define convenience functions to print a line to our emulated "terminal" that calculates
# wrapping and line shuffling up etc automatically
# note to self: plymouth calls arrays "hashes" and they work more like lua tables than arrays
# also note to self: plymouth seems to provide no functions for string length..
# but String.CharAt returns empty when the end has been reached, so there's that.
# https://github.com/freedesktop/plymouth/blob/master/src/plugins/splash/script/script-lib-string.c#L54
