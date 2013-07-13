package com.jumpGame.gameElements.platforms
{
	import com.jumpGame.gameElements.Platform;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	
	public class PlatformDrop extends Platform
	{
		private var isFalling:Boolean = false;
		private var fallVelocity:Number = 0;
		
		override protected function createPlatformArt():void
		{
			platformAnimation = new MovieClip(Assets.getSprite("AtlasTexturePlatforms").getTextures("PlatformDrop"), 12);
			starling.core.Starling.juggler.add(platformAnimation);
			platformAnimation.loop = false;
			this.addChild(platformAnimation);
		}
		
		override public function contact():void {
			super.contact();
			
			this.isFalling = true;
		}
		
		override public function update(timeDiff:Number):void {
			if (this.isFalling) {
				this.fallVelocity -= Constants.PlatformDropFallVelocity;
				this.gy += timeDiff * this.fallVelocity;
			}
			super.update(timeDiff);
		}
		
		override public function initialize(size:int):void {
			super.initialize(size);
			this.isFalling = false;
			this.fallVelocity = 0;
		}
	}
}