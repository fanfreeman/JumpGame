package com.jumpGame.gameElements.platforms
{
	import com.jumpGame.gameElements.Platform;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	
	public class PlatformMobile extends Platform
	{
		private var fixedX:Number = 0.0;
		private var maxPosChange:Number = 200;
		private var posChangeSpeed:Number = 0.15;
		private var isMovingRight:Boolean = true;
		
		override protected function createPlatformArt():void
		{
			platformAnimation = new MovieClip(Assets.getSprite("AtlasTexturePlatforms").getTextures("PlatformMobile"), 12);
			starling.core.Starling.juggler.add(platformAnimation);
			platformAnimation.loop = false;
			this.addChild(platformAnimation);
		}
		
		public override function update(timeDiff:Number):void {
			this.updatePositionX(timeDiff);
			this.gy = this.gy;
		}
		
		public function updatePositionX(timeDiff:Number):void {
			if (this.isMovingRight) {
				if (this.gx < this.fixedX + this.maxPosChange) {
					this.gx += this.posChangeSpeed * timeDiff;
				} else {
					this.isMovingRight = false;
				}
			} else { // moving left
				if (this.gx > this.fixedX - this.maxPosChange) {
					this.gx -= this.posChangeSpeed * timeDiff;
				} else {
					this.isMovingRight = true;
				}
			}
		}
	}
}