package com.jumpGame.gameElements.platforms
{
	import com.jumpGame.gameElements.Platform;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	
	public class Coin extends Platform
	{
		private var isKinematic:Boolean;
		
		override protected function createPlatformArt():void
		{
			platformAnimation = new MovieClip(Assets.getSprite("AtlasTexturePlatforms").getTextures("Coin"), 40);
			platformAnimation.pivotX = Math.ceil(platformAnimation.texture.width  / 2); // center art on registration point
			platformAnimation.pivotY = Math.ceil(platformAnimation.texture.height / 2);
			starling.core.Starling.juggler.add(platformAnimation);
			platformAnimation.loop = true;
			this.addChild(platformAnimation);
		}
		
		override public function initialize(size:int):void {
			this.isKinematic = false;
			this.dx = 0;
			this.dy = 0;
			this.canBounce = false;
			if (platformAnimation == null) createPlatformArt();
			this.show();
		}
		
		override public function touch():Boolean {
			if (!this.isTouched) {
				// play sound effect
				Sounds.sndBling.play();
				// remove coin
				this.visible = false;
				
				this.isTouched = true;
				
				return true;
			}
			
			return false;
		}
		
		override public function update(timeDiff:Number):void {
			if (this.isKinematic) {
				this.dy -= Constants.Gravity * timeDiff;
				if (this.dy < Constants.MaxHeroFallVelocity) {
//					this.dy = Constants.MaxHeroFallVelocity;
				}
			}
			super.update(timeDiff);
		}
		
		public function makeKinematic(bouncePower:Number):void {
			this.isKinematic = true;
			this.dy = Math.random() * bouncePower;
			this.dx = Math.random() * 0.4 - 0.2;
		}
	}
}