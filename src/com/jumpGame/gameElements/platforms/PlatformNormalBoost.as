package com.jumpGame.gameElements.platforms
{
	import starling.display.Image;

	public class PlatformNormalBoost extends PlatformNormal
	{
		override protected function createPlatformArt():void {
			super.createPlatformArt();
			platformImage = new Image(Assets.getSprite("AtlasTexturePlatforms").getTexture("NormalTriangle"));
			this.addChild(platformImage);
		}
		
		override public function getBouncePower():Number {
			return Constants.BoostBouncePower;
		}
	}
}