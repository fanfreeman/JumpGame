package com.jumpGame.gameElements.platforms
{
	import starling.display.Image;

	public class PlatformNormalBoost extends PlatformNormal
	{
		override protected function createPlatformArt():void {
			super.createPlatformArt();
			platformImage = new Image(Statics.assets.getTexture("NormalTriangle0000"));
			platformImage.pivotX = Math.ceil(platformImage.width  / 2); // center art on registration point
			platformImage.pivotY = Math.ceil(platformImage.height * 2 / 3);
			this.addChild(platformImage);
		}
		
		override public function getBouncePower():Number {
			return Constants.BoostBouncePower;
		}
	}
}