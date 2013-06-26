package com.jumpGame.gameElements.contraptions
{
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;

	public class Train extends GameObject implements IPoolable
	{
		private var headImage:Image = null;
		private var lookOutAnimation:MovieClip;
		
		private var _destroyed:Boolean = true; // required by interface
		
		public function initialize():void {
			if (headImage == null) createTrainArt();
			this.show();
		}
		
		protected function createTrainArt():void
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
		
		public function update(timeDiff:Number):void {
			this.gx += Constants.TrainVelocity * timeDiff;
			this.gy = this.gy;
		}
		
		/**
		 * hide artwork before returning to pool
		 */
		private function hide():void
		{
			if (headImage != null) headImage.visible = false;
		}
		
		/**
		 * show artwork after retrieved from pool
		 */
		private function show():void
		{
			if (this.headImage != null) this.headImage.visible = true;
		}
		
		// methods required by interface
		
		public function get destroyed():Boolean
		{
			return _destroyed;
		}
		
		public function renew():void
		{
			if (!_destroyed) { return; }
			_destroyed = false;
		}
		
		public function destroy():void
		{
			if (_destroyed) { return; }
			_destroyed = true;
			this.hide();
		}
	}
}