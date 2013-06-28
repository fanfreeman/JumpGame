package com.jumpGame.gameElements.contraptions
{
	import com.jumpGame.gameElements.Contraption;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;

	public class Train extends Contraption implements IPoolable
	{
		private var headImage:Image = null;
		private var lookOutAnimation:MovieClip;
		
		private var _destroyed:Boolean = true; // required by interface
		
		override public function initialize():void {
			if (headImage == null) createArt();
			this.show();
		}
		
		protected function createArt():void
		{
			headImage = new Image(Assets.getSprite("AtlasTexturePlatforms").getTexture("TrainHead"));
			headImage.pivotY = Math.ceil(headImage.height / 2); // center y
			this.addChild(headImage);
		}
		
		private function createLookOutAnimation():void
		{
			lookOutAnimation = new MovieClip(Assets.getAtlas().getTextures("watchOut_"), 10);
			this.addChild(lookOutAnimation);
			Starling.juggler.add(lookOutAnimation);
		}
		
		override public function update(timeDiff:Number):void {
			this.gx += Constants.TrainVelocity * timeDiff;
			this.gy = this.gy;
		}
	}
}