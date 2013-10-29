package com.jumpGame.gameElements.platforms
{
	import starling.display.Image;

	public class PlatformMobileBoost extends PlatformMobile
	{
		override protected function createPlatformArt():void {
			super.createPlatformArt();
			platformImage = new Image(Assets.getSprite("AtlasTexturePlatforms").getTexture("MobileTriangle0000"));
			platformImage.pivotX = Math.ceil(platformImage.width  / 2); // center art on registration point
			platformImage.pivotY = platformImage.height;
			this.addChild(platformImage);
		}
		
		override public function getBouncePower():Number {
			return Constants.BoostBouncePower;
		}
	}
}