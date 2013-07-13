package com.jumpGame.gameElements.contraptions
{
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	
	public class PowerupBoxBlue extends PowerupBox
	{
		override protected function createArt():void
		{
			boxAnimation = new MovieClip(Assets.getSprite("AtlasTexturePlatforms").getTextures("BoxBlue"), 20);
			boxAnimation.pivotX = Math.ceil(boxAnimation.texture.width  / 2); // center art on registration point
			boxAnimation.pivotY = Math.ceil(boxAnimation.texture.height);
			starling.core.Starling.juggler.add(boxAnimation);
			this.addChild(boxAnimation);
		}
	}
}