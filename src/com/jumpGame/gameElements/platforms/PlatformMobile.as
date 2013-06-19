package com.jumpGame.gameElements.platforms
{
	import com.jumpGame.gameElements.Platform;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	
	public class PlatformMobile extends Platform
	{
		private var fixedX:Number = 0.0;
		private var maxPosChange:Number;
		private var posChangeSpeed:Number
		private var isMovingRight:Boolean = true;
		
		public function PlatformMobile(size:int, maxPosChange:Number = 200, posChangeSpeed:Number = 0.15)
		{
			super(size);
			this.maxPosChange = maxPosChange;
			this.posChangeSpeed = posChangeSpeed;
		}
		
		override protected function createPlatformArt():void
		{
			var platformArt:MovieClip = new MovieClip(Assets.getSprite("AtlasTexturePlatforms").getTextures("PlatformMobile"), 12);
			platformArt.scaleX = this.size / Constants.PlatformMaxSize;
			platformArt.scaleY = this.size / Constants.PlatformMaxSize;
			platformArt.x = Math.ceil(-platformArt.width/2); // center art on registration point
			platformArt.y = Math.ceil(-platformArt.height/2);
			starling.core.Starling.juggler.add(platformArt);
			platformArt.loop = false;
			this.addChild(platformArt);
			this.animations.push(platformArt);
		}
		
		public override function update(timeDiff:Number):void {
			this.updatePositionX(timeDiff);
			this.gy = this.gy;
		}
		
		public function updatePositionX(timeDiff:Number):void {
			trace(this.fixedX);
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