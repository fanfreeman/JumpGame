package com.jumpGame.gameElements.contraptions
{
	import starling.display.MovieClip;
	
	public class PowerupBoxBlue extends PowerupBox
	{
		override protected function createArt():void
		{
			boxAnimation = new MovieClip(Statics.assets.getTextures("BoxBlue"), 20);
			boxAnimation.pivotX = Math.ceil(boxAnimation.texture.width  / 2); // center art on registration point
			boxAnimation.pivotY = Math.ceil(boxAnimation.texture.height);
			this.addChild(boxAnimation);
			super.createArt();
		}
	}
}