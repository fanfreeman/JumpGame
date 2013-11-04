package com.jumpGame.gameElements.platforms
{
	import com.jumpGame.gameElements.Platform;
	
	import starling.core.Starling;
	import starling.display.MovieClip;

	public class PlatformNormal extends Platform
	{
		override protected function createPlatformArt():void
		{
			platformAnimation = new MovieClip(Assets.getSprite("AtlasTexturePlatforms").getTextures("PlatformNormalIdle"), 30);
			platformAnimation.pivotX = Math.ceil(platformAnimation.width  / 2); // center art on registration point
			platformAnimation.pivotY = Math.ceil(platformAnimation.height / 2);
			starling.core.Starling.juggler.add(platformAnimation);
//			platformAnimation.loop = false;
			this.addChild(platformAnimation);
			
			bounceAnimation = new MovieClip(Assets.getSprite("AtlasTexturePlatforms").getTextures("PlatformNormalBounce"), 15);
			bounceAnimation.pivotX = Math.ceil(bounceAnimation.width  / 2); // center art on registration point
			bounceAnimation.pivotY = Math.ceil(bounceAnimation.height / 2);
			Starling.juggler.add(this.bounceAnimation);
			bounceAnimation.stop();
			bounceAnimation.loop = false;
			bounceAnimation.visible = false;
			this.addChild(bounceAnimation);
		}
	}
}