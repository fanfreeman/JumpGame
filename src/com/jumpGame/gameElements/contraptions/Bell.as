package com.jumpGame.gameElements.contraptions
{
	import starling.display.Image;

	public class Bell extends GameObject implements IPoolable
	{
		private var bellImage:Image;
		private var _destroyed:Boolean = true; // required by interface
		
		public function initialize():void {
			if (bellImage == null) createBellArt();
			this.show();
		}
		
		protected function createBellArt():void
		{
			bellImage = new Image(Assets.getSprite("AtlasTexturePlatforms").getTexture("Bell"));
			bellImage.pivotX = Math.ceil(bellImage.width / 2); // center image on registration point
			bellImage.pivotY = Math.ceil(bellImage.height / 2);
			this.addChild(bellImage);
		}
		
		public function update(timeDiff:Number):void {
			this.gx = this.gx;
			this.gy = this.gy;
		}
		
		/**
		 * hide artwork before returning to pool
		 */
		private function hide():void
		{
			if (bellImage != null) bellImage.visible = false;
		}
		
		/**
		 * show artwork after retrieved from pool
		 */
		private function show():void
		{
			if (this.bellImage != null) this.bellImage.visible = true;
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