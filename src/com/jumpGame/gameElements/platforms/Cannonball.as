package com.jumpGame.gameElements.platforms
{
	import com.jumpGame.gameElements.Platform;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;

//	import starling.display.MovieClip;
	
	public class Cannonball extends Platform
	{
		public var isVertical:Boolean;
		
//		private var isWarning:Boolean;
//		private var dropTime:int;
		
		override protected function createPlatformArt():void
		{
			platformImage = new Image(Assets.getSprite("AtlasTexturePlatforms").getTexture("Cannonball0000"));
			platformImage.pivotX = Math.ceil(platformImage.texture.width / 2); // center art on registration point
			platformImage.pivotY = Math.ceil(platformImage.texture.height / 2);
			this.addChild(platformImage);
			
			bounceAnimation = new MovieClip(Assets.getSprite("AtlasTexturePlatforms").getTextures("PulseRed"), 40);
			bounceAnimation.pivotX = Math.ceil(bounceAnimation.texture.width  / 2); // center art on registration point
			bounceAnimation.pivotY = Math.ceil(bounceAnimation.texture.height / 2);
			bounceAnimation.loop = false;
			bounceAnimation.visible = false;
//			platformAnimation.stop();
			this.addChild(bounceAnimation);
			
			// warning animation
//			platformAnimation = new MovieClip(Assets.getSprite("AtlasTexture2").getTextures("Warning"), 40);
//			platformAnimation.pivotX = Math.ceil(platformAnimation.width / 2); // set reg point to top center
//			platformAnimation.y = Math.ceil(platformImage.texture.height / 2);
		}
		
		override public function initialize(gx, gy, size:int, args = null):void {
//			this.isWarning = false;
			this.gx = gx;
			this.gy = gy;
			this.isVertical = false;
			this.extenderStatus = 0;
			this.extenderParent = null;
			this.isTouched = false;
			this.dx = 0;
			this.dy = 0;
			this.canBounce = false;
			if (platformImage == null) createPlatformArt();
			this.platformImage.visible = true;
//			this.platformAnimation.visible = false;
			this.show();
		}
		
		override public function touch():Boolean {
			if (!this.isTouched) {
				
				// play sound effect
				if (!Sounds.sfxMuted) Sounds.sndCannonballHit.play();
				
				// explosion animation
				platformImage.visible = false;
				bounceAnimation.visible = true;
				Starling.juggler.add(bounceAnimation);
				bounceAnimation.play();
				
				this.isTouched = true;
				
				return true;
			}
			
			return false;
		}
		
		override public function update(timeDiff:Number):void {
//			if (isWarning) {
//				if (Statics.gameTime > this.dropTime) {
//					isWarning = false;
//					this.removeChild(platformAnimation);
//					Starling.juggler.remove(platformAnimation);
//				} else {
//					this.gy = Camera.gy + Constants.StageHeight / 2 + platformImage.texture.height / 2;
//				}
//			} else {
				this.dy -= Constants.Gravity * timeDiff;
				if (this.dy < Constants.MaxObjectFallVelocity) {
					this.dy = Constants.MaxObjectFallVelocity;
				}
				
				this.gx += this.dx * timeDiff;
				this.gy += this.dy * timeDiff;
				this.platformImage.rotation += Math.PI / 36;
//			}
		}
		
		public function makeKinematicWithDx(dx:Number):void {
			this.dx = dx;
		}
		
		public function setVertical():void {
//			this.addChild(platformAnimation);
//			Starling.juggler.add(platformAnimation);
//			platformAnimation.visible = true;
//			platformAnimation.play();
//			
//			this.isWarning = true;
//			this.dropTime = Statics.gameTime + 1000; // launch in three seconds
			this.isVertical = true;
		}
		
//		override public function get height():Number
//		{
//			if (platformImage) return platformImage.texture.height;
//			else return NaN;
//		}
	}
}