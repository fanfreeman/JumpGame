package com.jumpGame.gameElements
{
	import com.jumpGame.level.Statics;
	
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.core.Starling;
	
	public class Platform extends GameObject implements IPoolable
	{
		public var dx:Number;
		public var dy:Number;
		
		public var isTouched:Boolean = false;
		public var canBounce:Boolean = true;
		protected var size:int;
		protected var platformAnimation:MovieClip = null;
		protected var platformImage:Image = null;
		
		private var _destroyed:Boolean = true; // required by interface
		
		public function initialize(size:int):void {
			this.dx = 0;
			this.dy = 0;
			this.isTouched = false;
			if (platformAnimation == null && platformImage == null) createPlatformArt();
			if (size == 0) this.size = 4;
			else this.size = size;
			this.rescale();
			this.show();
		}
		
		protected function rescale():void {
			if (platformAnimation != null) {
				platformAnimation.scaleX = this.size / Constants.PlatformMaxSize;
				platformAnimation.scaleY = 4 / Constants.PlatformMaxSize;
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
		
		// can only touch once each contact
		// return true is touch is real
		public function touch():Boolean {
			if (!this.isTouched) {
				this.isTouched = true;
				
				return true;
			}
			
			return false;
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
			
			if (this.platformAnimation != null) {
				this.platformAnimation.stop();
				this.platformAnimation.play();
			}
		}
		
		public function getBouncePower():Number {
			return Constants.NormalBouncePower;
		}
		
		public function update(timeDiff:Number):void {
			// not multiplying by timeDiff here because that's already done in acceleration calculations in main loop
			if (this.dx > Constants.PlatformMobileMaxVelocityX) this.dx = Constants.PlatformMobileMaxVelocityX;
			else if (this.dx < -Constants.PlatformMobileMaxVelocityX) this.dx = -Constants.PlatformMobileMaxVelocityX;
			this.gx += this.dx * timeDiff;
			this.gy += this.dy * timeDiff;
		}
		
		/**
		 * hide artwork before returning to pool
		 */
		protected function hide():void
		{
//			if (this.platformAnimation != null) this.platformAnimation.visible = false;
//			if (this.platformImage != null) this.platformImage.visible = false;
			//Starling.juggler.remove(this.platformAnimation);
			if (this.platformAnimation != null) Starling.juggler.remove(this.platformAnimation);
			this.visible = false;
		}
		
		/**
		 * show artwork after retrieved from pool
		 */
		protected function show():void
		{
//			if (this.platformAnimation != null) this.platformAnimation.visible = true;
//			if (this.platformImage != null) this.platformImage.visible = true;
			if (this.platformAnimation != null) Starling.juggler.add(this.platformAnimation);
			this.visible = true;
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
		}
		
		public function destroy():void
		{
			if (_destroyed) { return; }
			_destroyed = true;
			this.hide();
		}
	}
}