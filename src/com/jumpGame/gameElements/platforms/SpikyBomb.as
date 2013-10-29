package com.jumpGame.gameElements.platforms
{
	import com.jumpGame.gameElements.Platform;
	import com.jumpGame.level.Statics;
	
	import starling.core.Starling;
	import starling.display.MovieClip;

	public class SpikyBomb extends Platform
	{
//		private var spikyBombAnimation:MovieClip;
		//		private var isWarning:Boolean;
		//		private var dropTime:int;
		
		override protected function createPlatformArt():void
		{
			platformAnimation = new MovieClip(Assets.getSprite("AtlasTexture5").getTextures("ObstacleSpiky"), 20);
			platformAnimation.pivotX = Math.ceil(platformAnimation.width  / 2); // center art on registration point
			platformAnimation.pivotY = Math.ceil(platformAnimation.height / 2);
			starling.core.Starling.juggler.add(platformAnimation);
			this.addChild(platformAnimation);
			
			bounceAnimation = new MovieClip(Assets.getSprite("AtlasTexture5").getTextures("Explosion"), 40);
			bounceAnimation.pivotX = Math.ceil(bounceAnimation.width  / 2); // center art on registration point
			bounceAnimation.pivotY = Math.ceil(bounceAnimation.height / 2);
			bounceAnimation.loop = false;
			bounceAnimation.visible = false;
			this.addChild(bounceAnimation);
			
			// warning animation
			//			platformAnimation = new MovieClip(Assets.getSprite("AtlasTexture2").getTextures("Warning0000"), 40);
			//			platformAnimation.pivotX = Math.ceil(platformAnimation.width / 2); // set reg point to top center
			//			platformAnimation.y = Math.ceil(platformImage.texture.height / 2);
		}
		
		override public function initialize(gx, gy, size:int, args = null):void {
			//			this.isWarning = false;
			this.gx = gx;
			this.gy = gy;
			this.extenderStatus = 0;
			this.extenderParent = null;
			this.isTouched = false;
			this.dx = 0;
			this.dy = 0;
			this.canBounce = false;
			if (platformAnimation == null) createPlatformArt();
			this.show();
		}
		
		override public function touch():Boolean {
			if (!this.isTouched) {
				
				// play sound effect
				if (!Sounds.sfxMuted) Sounds.sndBoom.play();
				
				// explosion animation
				platformAnimation.visible = false;
				bounceAnimation.visible = true;
				Starling.juggler.add(this.bounceAnimation);
				bounceAnimation.play();
				
				// reset camera target
				Statics.cameraTargetModifierY = 0;
				
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
//			this.dy -= Constants.Gravity * timeDiff;
//			if (this.dy < Constants.MaxHeroFallVelocity) {
//				this.dy = Constants.MaxHeroFallVelocity;
//			}
			
			this.gx += this.dx * timeDiff;
			this.gy += this.dy * timeDiff;
			this.platformAnimation.rotation += Math.PI / 72;
			//			}
		}
	}
}