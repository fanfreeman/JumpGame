package com.jumpGame.gameElements.platforms
{
	import com.jumpGame.gameElements.Platform;
	
	import starling.core.Starling;
	import starling.display.MovieClip;

	public dynamic class PlatformNormal extends Platform
	{
		public function PlatformNormal(size:int) {
			super(size);
		}
		
		override protected function createPlatformArt():void
		{
			var platformArt:MovieClip = new MovieClip(Assets.getSprite("AtlasTexturePlatforms").getTextures("PlatformNormal"), 12);
			platformArt.scaleX = this.size / Constants.PlatformMaxSize;
			platformArt.scaleY = this.size / Constants.PlatformMaxSize;
			platformArt.x = Math.ceil(-platformArt.width/2); // center art on registration point
			platformArt.y = Math.ceil(-platformArt.height/2);
			starling.core.Starling.juggler.add(platformArt);
			platformArt.loop = false;
			this.addChild(platformArt);
			this.animations.push(platformArt);
		}
	}
}