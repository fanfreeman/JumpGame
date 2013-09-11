package com.jumpGame.gameElements.platforms
{
	import starling.display.Image;

	public class PlatformNormalBoost extends PlatformNormal
	{
		override protected function createPlatformArt():void {
			super.createPlatformArt();
			platformImage = new Image(Assets.getSprite("AtlasTexturePlatforms").getTexture("NormalTriangle0000"));
			platformImage.x = -5;
			platformImage.y = -4;
			this.addChild(platformImage);
		}
		
		override public function getBouncePower():Number {
			return Constants.BoostBouncePower;
		}
		
		override public function contact():void {
			if (!Sounds.sfxMuted) Sounds.sndBoostBounce.play();
			this.platformAnimation.stop();
			this.platformAnimation.play();
			
			this.gy = this.fixedGy - Constants.PlatformReactionBounce; // reaction bounce
		}
	}
}