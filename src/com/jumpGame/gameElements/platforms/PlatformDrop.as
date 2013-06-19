package com.jumpGame.gameElements.platforms
{
	import com.jumpGame.gameElements.Platform;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	
	public class PlatformDrop extends Platform
	{
		private var isFalling:Boolean = false;
		private var fallVelocity:Number = 0;
		
		public function PlatformDrop(size:int)
		{
			super(size);
		}
		
		override protected function createPlatformArt():void
		{
			var platformArt:MovieClip = new MovieClip(Assets.getSprite("AtlasTexturePlatforms").getTextures("PlatformDrop"), 12);
			platformArt.scaleX = this.size / Constants.PlatformMaxSize;
			platformArt.scaleY = this.size / Constants.PlatformMaxSize;
			platformArt.x = Math.ceil(-platformArt.width/2); // center art on registration point
			platformArt.y = Math.ceil(-platformArt.height/2);
			starling.core.Starling.juggler.add(platformArt);
			platformArt.loop = false;
			this.addChild(platformArt);
			this.animations.push(platformArt);
		}
		
		override public function contact():void {
			super.contact();
			
			this.isFalling = true;
		}
		
		override public function update(timeDiff:Number):void {
			if (this.isFalling) {
				this.fallVelocity -= Constants.PlatformDropFallVelocity;
				this.gy += timeDiff * this.fallVelocity;
			} else {
				this.gy = this.gy;
			}
		}
	}
}