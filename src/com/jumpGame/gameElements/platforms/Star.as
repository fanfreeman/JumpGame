package com.jumpGame.gameElements.platforms
{
	import com.jumpGame.gameElements.Platform;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	
	public class Star extends Platform
	{
		protected var isKinematic:Boolean;
		
		override protected function createPlatformArt():void
		{
			platformImage = new Image(Assets.getSprite("AtlasTexturePlatforms").getTexture("Star720000"));
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
		
		override public function initialize(size:int):void {
			this.extenderStatus = 0;
			this.extenderParent = null;
			this.isTouched = false;
			this.isKinematic = false;
			this.dx = 0;
			this.dy = 0;
			this.canBounce = false;
			if (platformImage == null) createPlatformArt();
			this.platformImage.visible = true;
			this.show();
		}
		
		override public function getBouncePower():Number {
			return Constants.BoostBouncePower;
		}
		
		override public function touch():Boolean {
			if (!this.isTouched) {
				
				// play sound effect
				Sounds.playNextNote();
				
				// remove coin
				//this.visible = false;
				this.platformImage.visible = false;
				this.platformAnimation.stop();
				this.platformAnimation.play();
				
				this.isTouched = true;
				
				return true;
			}
			
			return false;
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
			this.platformImage.rotation += Math.PI / 72;
		}
		
		public function makeKinematic(bouncePower:Number):void {
			this.isKinematic = true;
			this.dy = Math.random() * bouncePower;
			this.dx = Math.random() * 0.4 - 0.2;
		}
		
		public function makeKinematicWithDx(dx:Number):void {
			this.isKinematic = true;
			this.dx = dx;
		}
	}
}