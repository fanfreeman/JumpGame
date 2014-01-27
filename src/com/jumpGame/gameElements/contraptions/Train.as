package com.jumpGame.gameElements.contraptions
{
	import com.jumpGame.gameElements.Contraption;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;

	public class Train extends Contraption implements IPoolable
	{
		public var isLaunched:Boolean;
		
		protected var headImage:Image = null;
		protected var lookOutAnimation:MovieClip;
		protected var launchTime:int;
		
		override public function initialize():void {
//			if (headImage == null) {
//				createArt();
//			}
			this.lookOutAnimation.visible = true;
			this.show();
			this.launchTime = Statics.gameTime + 2600 + int(Math.ceil(Math.random() * 500));
			this.isLaunched = false;
		}
		
		override protected function createArt():void
		{
			// train art
			headImage = new Image(Statics.assets.getTexture("TrainHead0000"));
			headImage.pivotY = Math.ceil(headImage.height / 2); // center y
			this.addChild(headImage);
			
			// look out animation
			lookOutAnimation = new MovieClip(Statics.assets.getTextures("Lookout"), 40);
			lookOutAnimation.pivotX = lookOutAnimation.width;
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
				this.gx += Constants.TrainVelocity * timeDiff;
			}
			this.gy = this.gy;
		}
	}
}