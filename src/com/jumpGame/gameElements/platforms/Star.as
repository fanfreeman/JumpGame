package com.jumpGame.gameElements.platforms
{
	import com.jumpGame.gameElements.Platform;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	
	// gy, gx, "Star", size, dx, dy, distanceFromCenter, revolveVelocity, revolveClockwise, startingAngle
	public class Star extends Platform
	{
		// properties for revolving around center
		private var distanceFromCenter:Number;
		private var revolveVelocity:Number;
		private var revolveClockwise:Boolean;
		private var revolveAngle:Number;
		private var fixedX:Number;
		private var fixedY:Number;
		
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
			platformAnimation.stop();
			platformAnimation.loop = false;
			starling.core.Starling.juggler.add(platformAnimation);
			this.addChild(platformAnimation);
		}
		
		override public function initialize(gx, gy, size:int, args = null):void {
			this.gx = gx;
			this.gy = gy;
			this.extenderStatus = 0;
			this.extenderParent = null;
			this.isTouched = false;
			this.isKinematic = false;
			this.dx = 0;
			this.dy = 0;
			this.canBounce = false;
			if (platformImage == null) createPlatformArt();
			this.platformImage.visible = true;
			platformAnimation.stop();
			this.show();
			
			// extra args
			if (args != null) {
				if (args[0]) { // star has horizontal velocity
					this.dx = args[0];
				}
				if (args[1]) { // star has vertical velocity
					this.dy = args[1];
				}
				if (args[2] != undefined) { // star should revolve around center
					distanceFromCenter = args[2];
					revolveAngle = 0;
					fixedX = gx;
					fixedY = gy;
					
					if (args[3] != undefined) revolveVelocity = args[3]; // custom revolve velocity
					else revolveVelocity = 5 * Math.PI / 180;
					
					if (args[4] == false) {
						revolveClockwise = false; // custom revolve direction
					} else revolveClockwise = true;
					
					if (args[5] != undefined) { // custom starting angle
						revolveAngle = args[5];
					}
				} else {
					distanceFromCenter = 0;
				}
			}
		}
		
		override public function getBouncePower():Number {
			return Constants.BoostBouncePower;
		}
		
		override public function touch():Boolean {
			if (!this.isTouched) {
				
				// play sound effect
				if (!Sounds.sfxMuted) Sounds.playNextNote();
				
				// remove coin
				//this.visible = false;
				this.platformImage.visible = false;
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
			
			// check if star should revolve around center
			if (distanceFromCenter > 0 && this.dx == 0) {
				this.gx = fixedX + distanceFromCenter * Math.cos(revolveAngle);
				this.gy = fixedY + distanceFromCenter * Math.sin(revolveAngle);
				if (revolveClockwise) revolveAngle -= revolveVelocity;
				else revolveAngle += revolveVelocity;
			}
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