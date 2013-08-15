package com.jumpGame.gameElements.platforms
{
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;

	public class Comet extends Star
	{
		private var scalingUp:Boolean = true;
		private var deactivationTime:int;
		
		override protected function createPlatformArt():void
		{
			platformImage = new Image(Assets.getSprite("AtlasTexturePlatforms").getTexture("Comet0000"));
			platformImage.pivotX = Math.ceil(platformImage.texture.width  / 2); // center art on registration point
			platformImage.pivotY = Math.ceil(platformImage.texture.height / 2);
			this.addChild(platformImage);
			
			platformAnimation = new MovieClip(Assets.getSprite("AtlasTexturePlatforms").getTextures("Sparkle"), 60);
			platformAnimation.pivotX = Math.ceil(platformAnimation.width  / 2); // center art on registration point
			platformAnimation.pivotY = Math.ceil(platformAnimation.height / 2);
			starling.core.Starling.juggler.add(platformAnimation);
			platformAnimation.loop = false;
			this.addChild(platformAnimation);
		}
		
		override public function getBouncePower():Number {
			return Constants.SuperBouncePower;
		}
		
		override public function update(timeDiff:Number):void {
			if (this.isKinematic) {
				this.dy -= Constants.Gravity * timeDiff;
				if (this.dy < Constants.MaxHeroFallVelocity) {
					this.dy = Constants.MaxHeroFallVelocity;
				}
			}
			this.gx += this.dx * timeDiff;
			this.gy += this.dy * timeDiff;
			
			if (scalingUp) {
				if (this.scaleX < 1.0) {
					this.scaleX += 0.001 * timeDiff;
					this.scaleY += 0.001 * timeDiff;
				}
				else this.scalingUp = false;
			} else { // scaling down
				if (this.scaleX > 0.8) {
					this.scaleX -= 0.001 * timeDiff;
					this.scaleY -= 0.001 * timeDiff;
				}
				else this.scalingUp = true;
			}
		}
	}
}