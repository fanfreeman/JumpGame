package com.jumpGame.gameElements
{
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	
	public class Platform extends GameObject implements IPoolable
	{
		public var dx:Number;
		public var dy:Number;
		
		public var isTouched:Boolean = false;
		public var canBounce:Boolean = true;
		public var size:int;
		
		public var extenderStatus:int; // 0: not extender; -1: left extender; 1: right extender
		public var extenderParent:Platform;
		
		public var fixedGy:Number;
		private var fixedDy:Number;
		protected var platformAnimation:MovieClip = null;
		protected var platformImage:Image = null;
		
		private var _destroyed:Boolean = true; // required by interface
		
		public function initialize(gx, gy, size:int, args = null):void {
			this.gx = gx;
			this.gy = gy;
			this.extenderStatus = 0;
			this.extenderParent = null;
			this.dx = 0;
			this.dy = 0;
			this.isTouched = false;
			if (platformAnimation == null && platformImage == null) createPlatformArt();
			if (size == 0) this.size = 4;
			else this.size = size;
			this.rescale();
			this.show();
			this.fixedGy = gy;
			this.fixedDy = 0;
			
			// extra args
			if (args != null) {
				if (args[0]) { // star has horizontal velocity
					this.dx = args[0];
				}
				if (args[1]) { // star has vertical velocity
					this.fixedDy = args[1];
				}
			}
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
//			if (Statics.gameMode == Constants.ModeNormal) {
//				var temp:Number = Math.random() * 3;
//				if (temp < 1) {
//					Sounds.sndBounce1.play();
//				} else if (temp >= 1 && temp < 2) {
//					Sounds.sndBounce2.play();
//				} else if (temp >= 2 && temp < 3) {
//					Sounds.sndBounce3.play();
//				}
//			}
			if (!Sounds.sfxMuted) Sounds.sndBoostBounce.play();
			
			this.platformAnimation.stop();
			this.platformAnimation.play();
			
			this.gy = this.fixedGy - Constants.PlatformReactionBounce; // reaction bounce
		}
		
		public function getBouncePower():Number {
			return Constants.NormalBouncePower;
		}
		
		public function update(timeDiff:Number):void {
			// reaction bounceback
			var cameraEasingFactorY:Number = 15 - Math.abs(this.fixedGy - this.gy) / 10;
			if (cameraEasingFactorY < 5) cameraEasingFactorY = 5;
			var d2y:Number = 0.0; // platform acceleration
			if (this.fixedGy > this.gy) { // move platform up
				d2y = ((this.fixedGy - this.gy) - this.dy * cameraEasingFactorY) / (0.5 * cameraEasingFactorY * cameraEasingFactorY);
			}
			else if (this.fixedGy < this.gy) { // move pltform down
				d2y = ((this.fixedGy - this.gy) - this.dy * cameraEasingFactorY) / (0.5 * cameraEasingFactorY * cameraEasingFactorY);
			}
			else { // bring platform to rest
				d2y = -this.dy / cameraEasingFactorY;
			}
			this.dy += d2y;
			
			// limit max velocity for platformMobile
//			if (this.dx > Constants.PlatformMobileMaxVelocityX) this.dx = Constants.PlatformMobileMaxVelocityX;
//			else if (this.dx < -Constants.PlatformMobileMaxVelocityX) this.dx = -Constants.PlatformMobileMaxVelocityX;
			
			this.gx += this.dx * timeDiff;
			this.gy += this.dy * timeDiff;
			
			this.fixedGy += this.fixedDy * timeDiff;
		}
		
		public function makeExtender(extenderParent, extenderStatus, targetGx):void {
			this.extenderStatus = extenderStatus;
			this.extenderParent = extenderParent;
			Starling.juggler.tween(this, 0.3, {
				transition: Transitions.EASE_OUT,
				gx: targetGx
			});
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
			return this.platformAnimation.width;
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