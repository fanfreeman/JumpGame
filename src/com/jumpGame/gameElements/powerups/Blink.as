package com.jumpGame.gameElements.powerups
{
	import com.jumpGame.gameElements.Hero;
	import com.jumpGame.level.Statics;
	import com.jumpGame.ui.HUD;
	
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	
	public class Blink extends GameObject
	{
		public var isActivated:Boolean = false;
		
		private var blastAnimation:MovieClip;
		private var magicCircleImage:Image;
		
		private var hero:Hero;
		private var hud:HUD;
		private var totalTeleports:uint;
		private var isAnimationActivated:Boolean;
		private var firstTeleportTime:int;
		
		public function Blink(hero:Hero, hud:HUD):void {
			this.hero = hero;
			this.hud = hud;
			this.createPowerupArt();
		}
		
		protected function createPowerupArt():void
		{
			magicCircleImage = new Image(Assets.getSprite("AtlasTexture2").getTexture("MagicCircle0000"));
			magicCircleImage.pivotX = Math.ceil(magicCircleImage.width / 2); // center image on registration point
			magicCircleImage.pivotY = Math.ceil(magicCircleImage.height / 2);
			magicCircleImage.visible = false;
			magicCircleImage.alpha = 0;
			this.addChild(magicCircleImage);
			
			blastAnimation = new MovieClip(Assets.getSprite("AtlasTexture2").getTextures("BlastCircle"), 20);
			blastAnimation.pivotX = Math.ceil(blastAnimation.width  / 2); // center art on registration point
			blastAnimation.pivotY = Math.ceil(blastAnimation.height / 2);
			blastAnimation.loop = false;
			blastAnimation.visible = false;
			this.addChild(blastAnimation);
		}
		
		public function activate():void {
			magicCircleImage.visible = true;
			this.totalTeleports = 0;
			Starling.juggler.tween(magicCircleImage, 1.5, {
				transition: Transitions.EASE_OUT,
				repeatCount: 2,
				reverse: true,
				alpha: 1.0
			});
			this.firstTeleportTime = Statics.gameTime + 2000;
			this.isActivated = true;
			this.isAnimationActivated = false;
			if (!Sounds.sfxMuted) Sounds.sndPowerup.play();
		}
		
		public function update(timeDiff:Number):void {
			if (!this.isActivated) return;
			
			this.magicCircleImage.rotation += 0.002 * timeDiff;
			this.blastAnimation.rotation += 0.002 * timeDiff;
			this.gx = this.hero.gx;
			this.gy = this.hero.gy;
			
			if (Statics.gameTime >= this.firstTeleportTime) {
				if (!this.isAnimationActivated) {
					if (!Sounds.sfxMuted) Sounds.sndBlink.play();
					
					Starling.juggler.add(blastAnimation);
					blastAnimation.fps = 20;
					blastAnimation.stop();
					blastAnimation.visible = true;
					blastAnimation.play();
					this.isAnimationActivated = true;
				}
				
				if (blastAnimation.isComplete) {
					if (this.totalTeleports < 12 + Statics.rankTeleportation * 2) { // teleport this many times
						if (!Sounds.sfxMuted) {
							if (this.totalTeleports < 8) Sounds.sndBlink.play();
							else Sounds.sndBlinkFast.play(); // play shorter blink sound
						}
						
						// teleport
						blastAnimation.fps += 10;
						blastAnimation.stop();
						blastAnimation.play();
						//this.hero.isDynamic = false;
						this.hero.dy = 0;
						this.hero.gx = Statics.nextPlatformX;
						this.hero.gy = Statics.nextPlatformY;
						
						this.totalTeleports++;
					} else { // end of all teleports
						magicCircleImage.visible = false;
						blastAnimation.visible = false;
						Starling.juggler.remove(blastAnimation);
						this.hero.dy = Constants.SuperBouncePower;
						Statics.particleJet.start(1);
						if (!Sounds.sfxMuted) Sounds.sndBoom.play();
						//this.hero.isDynamic = true;
						this.isActivated = false;
						
						// misc reset
						hud.clearPowerupReel();
						Statics.powerupsEnabled = true;
					}
				}
			}
		}
	}
}