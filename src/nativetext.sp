// PlymouthXP
// nativetext.sp
// TODO define actual text region here with sprites (2d array? is it possible with plymouth?)
// also define convenience functions to print a line to our emulated "terminal" that calculates
// wrapping and line shuffling up etc automatically
// note to self: plymouth calls arrays "hashes" and they work more like lua tables than arrays
// also note to self: plymouth seems to provide no functions for string length..
// but String.CharAt returns empty when the end has been reached, so there's that.
// https://github.com/freedesktop/plymouth/blob/master/src/plugins/splash/script/script-lib-string.c#L54

fun NativeTextNew() {
	local.self = [];
	
	self.Rows = 72; // Verified with GIMP. Leaves 32px on either side of the screen, nice!
	self.Columns = 22; // Same as above, copypasted a bunch of glyph cells. 32px surrounds the text.
	
	self.X = 32 * ScaleFactorX;
	self.Y = 79 * ScaleFactorY;
	
	// Initialize characters
	self.Characters = [];
	for (y=0; y < self.Columns; y++) {
		for (x=0; x < self.Rows; x++) {
			self.Characters[x][y] = Sprite(GetNativeGlyph("A"));
			self.Characters[x][y].SetX(self.X + (x * NativeGlyphWidth));
			self.Characters[x][y].SetY(self.Y + (y * NativeGlyphHeight));
			self.Characters[x][y].SetZ(1);
			self.Characters[x][y].SetOpacity(0);
		}
	}
	
	fun SetOpacity(self, opac) {
		for (y=0; y < self.Columns; y++) {
			for (x=0; x < self.Rows; x++) {
				self.Characters[x][y].SetOpacity(opac);
			}
		}
	}
	self.SetOpacity = SetOpacity;
	
	return self;
}
