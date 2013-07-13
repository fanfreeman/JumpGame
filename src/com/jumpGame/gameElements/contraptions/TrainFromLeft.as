package com.jumpGame.gameElements.contraptions
{
	import com.jumpGame.level.Statics;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;

	public class TrainFromLeft extends Train
	{
		override protected function createArt():void
		{
			headImage = new Image(Assets.getSprite("AtlasTexturePlatforms").getTexture("TrainHead0000"));
			headImage.scaleX = -1;
			headImage.pivotY = Math.ceil(headImage.height / 2); // center y
			this.addChild(headImage);
		}
		
		override protected function createLookOutAnimation():void
		{
			lookOutAnimation = new MovieClip(Assets.getSprite("AtlasTexturePlatforms").getTextures("Lookout"), 40);
			lookOutAnimation.pivotY = lookOutAnimation.height;
			this.addChild(lookOutAnimation);
			Starling.juggler.add(lookOutAnimation);
		}
		
		override public function update(timeDiff:Number):void {
			if (!this.isLaunched) {
				if (Statics.gameTime > this.launchTime) {
					this.lookOutAnimation.visible = false;
					Sounds.sndTrain.play();
					this.isLaunched = true;
				}
			} else {
				this.gx -= Constants.TrainVelocity * timeDiff;
			}
			this.gy = this.gy;
		}
	}
}