package com.jumpGame.gameElements.platforms
{
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;

	public class StarMini extends Star
	{
		override protected function createPlatformArt():void
		{
			platformImage = new Image(Assets.getSprite("AtlasTexturePlatforms").getTexture("Star360000"));
			platformImage.pivotX = Math.ceil(platformImage.texture.width  / 2); // center art on registration point
			platformImage.pivotY = Math.ceil(platformImage.texture.height / 2);
			this.addChild(platformImage);
			
			platformAnimation = new MovieClip(Assets.getSprite("AtlasTexturePlatforms").getTextures("Sparkle"), 60);
			platformAnimation.pivotX = Math.ceil(platformAnimation.width  / 2); // center art on registration point
			platformAnimation.pivotY = Math.ceil(platformAnimation.height / 2);
			starling.core.Starling.juggler.add(platformAnimation);
			platformAnimation.loop = false;
			this.addChild(platformAnimation);
		}
		
		override public function getBouncePower():Number {
			return Constants.BoostBouncePower;
		}
	}
}