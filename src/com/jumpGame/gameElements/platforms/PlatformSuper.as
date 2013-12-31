package com.jumpGame.gameElements.platforms
{
	import com.jumpGame.gameElements.Platform;
	
	import starling.display.Image;
	
	public class PlatformSuper extends Platform
	{
		public var heroDy:Number;
		public var isPyromancy:Boolean;
		
		override public function initialize(gx, gy, size:int, args = null):void {
			this.isPyromancy = false;
			super.initialize(gx, gy, size);
		}
		
		override protected function createPlatformArt():void
		{
//			platformAnimation = new MovieClip(Assets.getSprite("AtlasTexturePlatforms").getTextures("PlatformSuper"), 12);
//			starling.core.Starling.juggler.add(platformAnimation);
//			platformAnimation.loop = false;
//			this.addChild(platformAnimation);
			
			platformImage = new Image(Statics.assets.getTexture("PlatformSuper0000"));
			platformImage.pivotX = Math.ceil(platformImage.width / 2); // center art on registration point
			platformImage.pivotY = Math.ceil(platformImage.height / 2);
			this.addChild(platformImage);
			this.platformWidth = platformImage.texture.width;
		}
		
		override public function getBouncePower():Number {
			return Constants.SuperBouncePower;
		}
		
		override public function contact():void {
			if (!Sounds.sfxMuted) Statics.assets.playSound("SND_BOOM");
			Statics.particleWind.start(1.0);
			Statics.cameraShake = 40;
		}
		
		override public function update(timeDiff:Number):void {
			this.gx += this.dx * timeDiff;
			if (this.isPyromancy) this.gy += (this.dy + this.heroDy) * timeDiff;
			else this.gy += this.dy * timeDiff;
		}
	}
}