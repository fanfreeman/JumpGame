package com.jumpGame.gameElements.contraptions
{
	import com.jumpGame.gameElements.Contraption;
	import com.jumpGame.level.Statics;
	
	import starling.display.Image;

	public class Witch extends Contraption implements IPoolable
	{
		private var witchImage:Image = null;
		private var nextFireTime:int;
		
		override public function initialize():void {
			// create art
			if (witchImage == null) {
				createArt();
			}
			
			// reset properties
			this.nextFireTime = Statics.gameTime;
			
			this.show();
		}
		
		protected function createArt():void
		{
			witchImage = new Image(Assets.getSprite("AtlasTexturePlatforms").getTexture("Witch0000"));
			witchImage.pivotX = Math.ceil(witchImage.width / 2); // center x
			witchImage.pivotY = Math.ceil(witchImage.height / 2); // center y
			this.addChild(witchImage);
		}
		
		override public function update(timeDiff:Number):void {
			this.gx += Constants.TrainVelocity * timeDiff;
			this.gy += 0;
		}
		
		public function checkFiring():uint {
			// check if should fire
			if (Statics.gameTime > this.nextFireTime) {
				this.nextFireTime = Statics.gameTime + 100; // firing interval
				return 1; // fire
			}
			
			return 0;
		}
	}
}