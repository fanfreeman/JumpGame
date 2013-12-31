package com.jumpGame.gameElements.platforms
{
	import com.jumpGame.gameElements.Platform;
	
	import starling.display.Image;
	
	public class Coin extends Platform
	{
		// properties for revolving around center
		private var distanceFromCenter:Number;
		private var revolveVelocity:Number;
		private var revolveClockwise:Boolean;
		private var revolveAngle:Number;
		private var fixedX:Number;
		private var fixedY:Number;
		protected var rotationSpeed:Number = Math.PI / 10;
		
		private var isKinematic:Boolean;
		public var isAcquired:Boolean;
		public var yVelocity:Number;
		
		override protected function createPlatformArt():void
		{
			platformImage = new Image(Statics.assets.getTexture("CoinGold0000"));
			platformImage.pivotX = Math.ceil(platformImage.texture.width  / 2); // center art on registration point
			platformImage.pivotY = Math.ceil(platformImage.texture.height / 2);
			this.addChild(platformImage);
		}
		
		override public function initialize(gx, gy, size:int, args = null):void {
			this.gx = gx;
			this.gy = gy;
			this.isKinematic = false;
			this.isAcquired = false;
			this.dx = 0;
			this.dy = 0;
			this.canBounce = false;
			this.isTouched = false;
			if (platformImage == null) createPlatformArt();
			this.show();
			
			// revolving coin
			if (args != null) {
				if (args[0]) { // coin has horizontal velocity
					this.dx = args[0];
				}
				if (args[1]) { // coin has vertical velocity
					this.dy = args[1];
				}
				if (args[2]) { // coin should revolve around center
					distanceFromCenter = args[2];
					revolveAngle = 0;
					fixedX = gx;
					fixedY = gy;
					
					if (args[3] != undefined) revolveVelocity = args[3]; // custom revolve velocity
					else revolveVelocity = 5 * Math.PI / 180;
					
					if (args[4] == false) {
						revolveClockwise = false; // custom revolve direction
					} else revolveClockwise = true;
					
					if (args[5] != undefined) { // custom starting angle
						revolveAngle = args[5];
					}
				} else {
					distanceFromCenter = 0;
				}
			}
		}
		
		override public function touch():Boolean {
			if (!this.isTouched) {
				// play sound effect
				if (!Sounds.sfxMuted) Statics.assets.playSound("SND_BLING_HIGH");
				this.isTouched = true;
				return true;
			}
			return false;
		}
		
		override public function update(timeDiff:Number):void {
			if (this.isKinematic && !this.isAcquired) { // do not apply gravity if acquired
				this.dy -= Constants.Gravity * timeDiff;
//				if (this.dy < Constants.MaxHeroFallVelocity) {
//					this.dy = Constants.MaxHeroFallVelocity;
//				}
			}
//			super.update(timeDiff);
			this.gx += this.dx * timeDiff;
			this.gy += this.dy * timeDiff;
			this.platformImage.rotation += this.rotationSpeed;
			
			// check if coin should revolve around center
			if (distanceFromCenter > 0 && this.dx == 0) {
				this.gx = fixedX + distanceFromCenter * Math.cos(revolveAngle);
				this.gy = fixedY + distanceFromCenter * Math.sin(revolveAngle);
				if (revolveClockwise) revolveAngle -= revolveVelocity * timeDiff * 0.06;
				else revolveAngle += revolveVelocity * timeDiff * 0.06;
			}
		}
		
		public function makeKinematic(bouncePower:Number):void {
			this.isKinematic = true;
			this.dy = Math.random() * bouncePower;
			this.dx = Math.random() * 0.4 - 0.2;
		}
		
		public function getValue():uint {
			return 3;
		}
	}
}