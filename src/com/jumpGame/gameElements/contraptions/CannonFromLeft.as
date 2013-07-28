package com.jumpGame.gameElements.contraptions
{
	import com.jumpGame.level.Statics;
	
	import starling.display.Image;

	public class CannonFromLeft extends Cannon
	{
		override protected function markActivated():void {
			Statics.isLeftCannonActive = true;
		}
		
		override protected function createArt():void
		{
			cannonOffImage = new Image(Assets.getSprite("AtlasTexturePlatforms").getTexture("CannonOff0000"));
			cannonOffImage.pivotX = Math.ceil(cannonOffImage.width / 2); // center x
			cannonOffImage.pivotY = Math.ceil(cannonOffImage.height / 2); // center y
			cannonOffImage.scaleX = -1;
			this.addChild(cannonOffImage);
			
			cannonOnImage = new Image(Assets.getSprite("AtlasTexturePlatforms").getTexture("CannonOn0000"));
			cannonOnImage.pivotX = Math.ceil(cannonOnImage.width / 2); // center x
			cannonOnImage.pivotY = Math.ceil(cannonOnImage.height / 2); // center y
			cannonOnImage.scaleX = -1;
			cannonOnImage.visible = false;
			this.addChild(cannonOnImage);
		}
		
		override protected function hide():void
		{
			this.visible = false;
			Statics.isLeftCannonActive = false;
		}
	}
}