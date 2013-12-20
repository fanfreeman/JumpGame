package com.jumpGame.gameElements.platforms
{
	import starling.display.Image;

	public class CoinSilver extends Coin
	{
		override protected function createPlatformArt():void
		{
			platformImage = new Image(Assets.getSprite("AtlasTexturePlatforms").getTexture("CoinSilver0000"));
			platformImage.pivotX = Math.ceil(platformImage.texture.width  / 2); // center art on registration point
			platformImage.pivotY = Math.ceil(platformImage.texture.height / 2);
			this.addChild(platformImage);
		}
		
		override public function touch():Boolean {
			if (!this.isTouched) {
				// play sound effect
				if (!Sounds.sfxMuted) Sounds.sndBlingMid.play();
				this.isTouched = true;
				return true;
			}
			return false;
		}
		
		override public function getValue():uint {
			return 2;
		}
	}
}