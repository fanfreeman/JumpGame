package com.jumpGame.gameElements.contraptions
{
	import starling.display.MovieClip;
	
	public class PowerupBoxGreen extends PowerupBox
	{
		override protected function createArt():void
		{
			boxAnimation = new MovieClip(Statics.assets.getTextures("BoxGreen"), 20);
			boxAnimation.pivotX = Math.ceil(boxAnimation.texture.width  / 2); // center art on registration point
			boxAnimation.pivotY = Math.ceil(boxAnimation.texture.height);
			this.addChild(boxAnimation);
			super.createArt();
		}
	}
}