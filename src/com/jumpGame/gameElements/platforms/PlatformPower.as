package com.jumpGame.gameElements.platforms
{
	import com.jumpGame.gameElements.Platform;
	
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.MovieClip;
	
	public class PlatformPower extends Platform
	{
		override protected function createPlatformArt():void
		{
			platformAnimation = new MovieClip(Assets.getSprite("AtlasTexturePlatforms").getTextures("Bouncer"), 30);
			starling.core.Starling.juggler.add(platformAnimation);
//			platformAnimation.loop = false;
			this.addChild(platformAnimation);
		}
		
		override public function getBouncePower():Number {
			return Constants.PowerBouncePower;
		}
		
		override public function contact():void {
			if (!Sounds.sfxMuted) Sounds.sndBoostBounce.play();
//			this.platformAnimation.stop();
//			this.platformAnimation.play();
			Starling.juggler.tween(platformAnimation, 0.1, {
				transition: Transitions.LINEAR,
				repeatCount: 2,
				reverse: true,
				scaleX: 0.5,
				scaleY: 0.5
			});
		}
	}
}