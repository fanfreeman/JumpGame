package com.jumpGame.gameElements.platforms
{
	import com.jumpGame.gameElements.Platform;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	
	public class PlatformDrop extends Platform
	{
		protected var isFalling:Boolean = false;
		private var fallVelocity:Number = 0;
		
		override protected function createPlatformArt():void
		{
			platformAnimation = new MovieClip(Assets.getSprite("AtlasTexturePlatforms").getTextures("PlatformDrop"), 12);
			starling.core.Starling.juggler.add(platformAnimation);
			platformAnimation.loop = false;
			this.addChild(platformAnimation);
		}
		
		override public function contact():void {
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
			Sounds.sndBoostBounce.play();
			
			this.platformAnimation.stop();
			this.platformAnimation.play();
			
			this.isFalling = true;
		}
		
		override public function update(timeDiff:Number):void {
			if (this.isFalling) {
				this.fallVelocity -= Constants.PlatformDropFallVelocity;
				this.gy += timeDiff * this.fallVelocity;
			}
//			super.update(timeDiff);
			this.gx += this.dx * timeDiff;
			this.gy += this.dy * timeDiff;
		}
		
		override public function initialize(gx, gy, size:int, args = null):void {
			this.gx = gx;
			this.gy = gy;
			super.initialize(gx, gy, size);
			this.isFalling = false;
			this.fallVelocity = 0;
		}
	}
}