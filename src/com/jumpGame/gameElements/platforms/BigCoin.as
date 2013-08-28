package com.jumpGame.gameElements.platforms
{
	import starling.core.Starling;
	import starling.display.MovieClip;

	public class BigCoin extends Coin
	{
		override protected function createPlatformArt():void
		{
			platformAnimation = new MovieClip(Assets.getSprite("AtlasTexturePlatforms").getTextures("BigCoinSpin"), 40);
			platformAnimation.pivotX = Math.ceil(platformAnimation.texture.width  / 2); // center art on registration point
			platformAnimation.pivotY = Math.ceil(platformAnimation.texture.height / 2);
			starling.core.Starling.juggler.add(platformAnimation);
			this.addChild(platformAnimation);
		}
	}
}