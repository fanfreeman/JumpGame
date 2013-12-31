package com.jumpGame.gameElements.contraptions
{
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;

	public class TrainFromLeft extends Train
	{
		override protected function createArt():void
		{
			headImage = new Image(Statics.assets.getTexture("TrainHead0000"));
			headImage.scaleX = -1;
			headImage.pivotY = Math.ceil(headImage.height / 2); // center y
			this.addChild(headImage);
		}
		
		override protected function createLookOutAnimation():void
		{
			lookOutAnimation = new MovieClip(Statics.assets.getTextures("Lookout"), 40);
			lookOutAnimation.pivotY = lookOutAnimation.height;
			this.addChild(lookOutAnimation);
			Starling.juggler.add(lookOutAnimation);
		}
		
		override public function update(timeDiff:Number):void {
			if (!this.isLaunched) {
				if (Statics.gameTime > this.launchTime) {
					this.lookOutAnimation.visible = false;
					if (!Sounds.sfxMuted) Statics.assets.playSound("SND_TRAIN");
					this.isLaunched = true;
				}
			} else {
				this.gx -= Constants.TrainVelocity * timeDiff;
			}
			this.gy = this.gy;
		}
	}
}