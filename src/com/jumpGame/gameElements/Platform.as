package com.jumpGame.gameElements
{
	import com.jumpGame.level.Statics;
	
	import starling.display.Image;
	import starling.display.MovieClip;
	
	public class Platform extends GameObject implements IPoolable
	{
		public var isTouched:Boolean = false;
		protected var size:int;
		protected var platformAnimation:MovieClip = null;
		protected var platformImage:Image = null;
		
		private var _destroyed:Boolean = true; // required by interface
		
		public function initialize(size:int):void {
			this.size = size;
			if (platformAnimation == null && platformImage == null) createPlatformArt();
			this.rescale();
			this.show();
		}
		
		protected function rescale():void {
			if (platformAnimation != null) {
				platformAnimation.scaleX = this.size / Constants.PlatformMaxSize;
				platformAnimation.scaleY = this.size / Constants.PlatformMaxSize;
				platformAnimation.pivotX = Math.ceil(platformAnimation.texture.width  / 2); // center art on registration point
				platformAnimation.pivotY = Math.ceil(platformAnimation.texture.height / 2);
			}
			
			if (platformImage != null) {
				platformImage.scaleX = this.size / Constants.PlatformMaxSize;
				platformImage.scaleY = this.size / Constants.PlatformMaxSize;
				platformImage.pivotX = Math.ceil(platformImage.width / 2); // center art on registration point
				platformImage.pivotY = Math.ceil(platformImage.height / 2);
			}
		}
		
		protected function createPlatformArt():void{}
		
		public function touch():void {
			this.isTouched = true;
		}
		
		public function contact():void {
			// play sound effect
			if (Statics.gameMode == Constants.ModeNormal) {
				var temp:Number = Math.random() * 3;
				if (temp < 1) {
					Sounds.sndBounce1.play();
				} else if (temp >= 1 && temp < 2) {
					Sounds.sndBounce2.play();
				} else if (temp >= 2 && temp < 3) {
					Sounds.sndBounce3.play();
				}
			}
			
			this.platformAnimation.stop();
			this.platformAnimation.play();
		}
		
		public function getBouncePower():Number {
			return Constants.NormalBouncePower;
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
			if (this.platformAnimation != null) this.platformAnimation.visible = false;
			if (this.platformImage != null) this.platformImage.visible = false;
			//Starling.juggler.remove(this.platformAnimation);
		}
		
		/**
		 * show artwork after retrieved from pool
		 */
		private function show():void
		{
			if (this.platformAnimation != null) this.platformAnimation.visible = true;
			if (this.platformImage != null) this.platformImage.visible = true;
		}
		
		override public function get width():Number
		{
			return this.platformAnimation.texture.width;
		}
		
		override public function get height():Number
		{
			return this.platformAnimation.texture.height;
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
			
			this.isTouched = false;
		}
		
		public function destroy():void
		{
			if (_destroyed) { return; }
			_destroyed = true;
			this.hide();
		}
	}
}