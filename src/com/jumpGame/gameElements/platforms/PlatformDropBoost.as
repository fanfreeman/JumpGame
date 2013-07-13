package com.jumpGame.gameElements.platforms
{
	import starling.display.Image;

	public class PlatformDropBoost extends PlatformDrop
	{
		override protected function createPlatformArt():void {
			super.createPlatformArt();
			platformImage = new Image(Assets.getSprite("AtlasTexturePlatforms").getTexture("DropTriangle0000"));
			platformImage.x = -5;
			platformImage.y = -4;
			this.addChild(platformImage);
		}
		
		override public function getBouncePower():Number {
			return Constants.BoostBouncePower;
		}
		
		override public function contact():void {
			Sounds.sndBoostBounce.play();
			this.platformAnimation.stop();
			this.platformAnimation.play();
		}
	}
}