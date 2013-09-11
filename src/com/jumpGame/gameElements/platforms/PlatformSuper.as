package com.jumpGame.gameElements.platforms
{
	import com.jumpGame.gameElements.Platform;
	import com.jumpGame.level.Statics;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	
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
			platformAnimation = new MovieClip(Assets.getSprite("AtlasTexturePlatforms").getTextures("PlatformSuper"), 12);
			starling.core.Starling.juggler.add(platformAnimation);
			platformAnimation.loop = false;
			this.addChild(platformAnimation);
		}
		
		override public function getBouncePower():Number {
			return Constants.SuperBouncePower;
		}
		
		override public function contact():void {
			if (!Sounds.sfxMuted) Sounds.sndBoom.play();
			this.platformAnimation.stop();
			this.platformAnimation.play();
			Statics.particleWind.start(1.0);
			Statics.cameraShake = 40;
		}
		
		override public function update(timeDiff:Number):void {
//			if (this.isKinematic) {
//				this.dy -= Constants.Gravity * timeDiff;
//			}
//			super.update(timeDiff);
			this.gx += this.dx * timeDiff;
			if (this.isPyromancy) this.gy += (this.dy + this.heroDy) * timeDiff;
			else this.gy += this.dy * timeDiff;
		}
	}
}