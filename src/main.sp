# PlymouthXP
# Plymouth theme to emulate the Windows XP boot sequences.
# 
# No copyrighted assets are distributed with this project.
# You must prepare the required assets yourself.
# This project includes a Python script to automate this process for you.
# See prepare_assets/README for details.
# 
# "Windows XP" is a registered trademark of Microsoft Corporation.
# The author(s) of this software are in no way affiliated with or endorsed by Microsoft Corporation,
# in any capacity. This project is a fan-made labor of love that sees NO PROFITS WHATSOEVER, donations or otherwise.

# TODO: main.sp should define plymouth callback functions that call
# functions defined in seperate script parts

Window.SetBackgroundColor(0, 0, 0);

# Define variables
sWidth = Window.GetWidth();
sHeight = Window.GetHeight();

sSprite = Sprite();
pSprite = Sprite();

iBase = Image("base.png");
iProgress = Image("progress.png");

bState = "fadein";
bOpacity = 0;
bFadeSteps = 15;

# Calculate scaling factor. We want to stretch the boot sequence
# to the screen. This requires scaling images & co-ordinates.

ScaleFactorX = sWidth / iBase.GetWidth();
ScaleFactorY = sHeight / iBase.GetHeight();

iBaseScaledWidth = iBase.GetWidth() * ScaleFactorX;
iBaseScaledHeight = iBase.GetHeight() * ScaleFactorY;

iProgressScaledWidth = iProgress.GetWidth() * ScaleFactorX;
iProgressScaledHeight = iProgress.GetHeight() * ScaleFactorY;

iBaseScaled = iBase.Scale(iBaseScaledWidth, iBaseScaledHeight);
iProgressScaled = iProgress.Scale(iProgressScaledWidth, iProgressScaledHeight);

sSprite.SetImage(iBaseScaled);
sSprite.SetOpacity(0);
sSprite.SetZ(1);

pSpriteOriginX = 234 * ScaleFactorX;
pSpriteReturnX = (234 + (18 * 8)) * ScaleFactorX;
pSpriteCurrentX = pSpriteOriginX;
pSpriteStepX = 8 * ScaleFactorX;
pSpriteY = 354 * ScaleFactorY;

pSprite.SetImage(iProgressScaled);
pSprite.SetOpacity(0);
pSprite.SetZ(0);
pSprite.SetX(pSpriteCurrentX);
pSprite.SetY(pSpriteY);

fun RefreshCallback() {
	
	if (Plymouth.GetMode() == "boot" || Plymouth.GetMode() == "resume") {
		
		# We're in the boot screen, but state are we in?
		if (bState == "fadein") {
			# Fade in, let's increment our opacity
			bOpacity += (1 / bFadeSteps);
			
			if (bOpacity >= 1) {
				bState = "progress";
				bOpacity = 1;
			}
			
			sSprite.SetOpacity(bOpacity);
		}
		if (bState == "progress") {
			# Progress, let's increment the position of the progress dots
			pSprite.SetOpacity(1);
			pSpriteCurrentX += pSpriteStepX;
			pSprite.SetX(pSpriteCurrentX);
			
			if (pSpriteCurrentX > pSpriteReturnX) {
				pSpriteCurrentX = pSpriteOriginX;
			}
		}
	}
}

Plymouth.SetRefreshRate(12);
Plymouth.SetRefreshFunction(RefreshCallback);