package com.jumpGame.gameElements.platforms
{
	import com.jumpGame.gameElements.Platform;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	
	public class PlatformPower extends Platform
	{
		override protected function createPlatformArt():void
		{
			platformAnimation = new MovieClip(Assets.getSprite("AtlasTexturePlatforms").getTextures("PlatformPower"), 12);
			starling.core.Starling.juggler.add(platformAnimation);
			platformAnimation.loop = false;
			this.addChild(platformAnimation);
		}
		
		override public function getBouncePower():Number {
			return Constants.PowerBouncePower;
		}
		
		override public function contact():void {
			if (!Sounds.sfxMuted) Sounds.sndBoostBounce.play();
			this.platformAnimation.stop();
			this.platformAnimation.play();
		}
	}
}