package com.jumpGame.gameElements.contraptions
{
	import starling.display.MovieClip;
	
	public class PowerupBoxPurple extends PowerupBox
	{
		override protected function createArt():void
		{
			boxAnimation = new MovieClip(Assets.getSprite("AtlasTexturePlatforms").getTextures("BoxPurple"), 20);
			boxAnimation.pivotX = Math.ceil(boxAnimation.texture.width  / 2); // center art on registration point
			boxAnimation.pivotY = Math.ceil(boxAnimation.texture.height);
			this.addChild(boxAnimation);
			super.createArt();
		}
	}
}