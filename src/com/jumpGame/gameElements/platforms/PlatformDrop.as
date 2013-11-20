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
			platformAnimation = new MovieClip(Assets.getSprite("AtlasTexturePlatforms").getTextures("PlatformDropIdle"), 30);
			platformAnimation.pivotX = Math.ceil(platformAnimation.width  / 2); // center art on registration point
			platformAnimation.pivotY = Math.ceil(platformAnimation.height / 2);
			starling.core.Starling.juggler.add(platformAnimation);
//			platformAnimation.loop = false;
			this.addChild(platformAnimation);
			
			bounceAnimation = new MovieClip(Assets.getSprite("AtlasTexturePlatforms").getTextures("PlatformDropBounce"), 15);
			bounceAnimation.pivotX = Math.ceil(bounceAnimation.width  / 2); // center art on registration point
			bounceAnimation.pivotY = Math.ceil(bounceAnimation.height / 2);
			Starling.juggler.add(this.bounceAnimation);
			bounceAnimation.stop();
			bounceAnimation.loop = false;
			bounceAnimation.visible = false;
			this.addChild(bounceAnimation);
		}
		
		override public function contact():void {
			if (!Sounds.sfxMuted) Sounds.sndCrumble.play();
//			
//			this.platformAnimation.stop();
//			this.platformAnimation.play();
			super.contact();
			this.isFalling = true;
		}
		
		override public function update(timeDiff:Number):void {
			if (this.isFalling) {
				this.fallVelocity -= Constants.PlatformDropFallVelocity;
				this.gy += timeDiff * this.fallVelocity;
			}
			this.gx += this.dx * timeDiff;
			this.gy += this.dy * timeDiff;
		}
		
		override public function initialize(gx, gy, size:int, args = null):void {
			this.gx = gx;
			this.gy = gy;
			super.initialize(gx, gy, size);
			this.isFalling = false;
			this.fallVelocity = 0;
			
			// extra args
			if (args != null) {
				if (args[0]) { // star has horizontal velocity
					this.dx = args[0];
				}
				if (args[1]) { // star has vertical velocity
					this.dy = args[1];
				}
			}
		}
	}
}