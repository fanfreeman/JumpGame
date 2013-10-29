package com.jumpGame.gameElements.powerups
{
	import com.jumpGame.gameElements.Hero;
	import com.jumpGame.gameElements.Transfiguration;
	import com.jumpGame.level.Statics;
	import com.jumpGame.ui.HUD;
	
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.MovieClip;

	public class MasterDapan extends GameObject
	{
		private var hero:Hero;
		private var transfiguration:Transfiguration;
		private var runAnimation:MovieClip;
		private var jumpAnimation:MovieClip;
		private var nextLaunchTime:int;
		private var launchInterval:Number;
		private var isDynamicDisabled:Boolean;
//		private var incrementalHeroDy:Number;
//		private var shouldSnapToRightBorder:Boolean;
		private var isControlDisabled:Boolean; // temporarily take away control from player after jumping
		
		public var isActivated:Boolean = false;
		private var nearCompletionTime:int;
		private var completionTime:int;
		private var completionWarned:Boolean;
		
		public function MasterDapan(hero:Hero, transfiguration:Transfiguration)
		{
			this.hero = hero;
			this.transfiguration = transfiguration;
			this.createPowerupArt();
		}
		
		protected function createPowerupArt():void
		{
			runAnimation = new MovieClip(Assets.getSprite("AtlasTexture2").getTextures("TransfigAnimCatRun"), 20);
			runAnimation.pivotX = Math.ceil(runAnimation.texture.width  / 2); // center art on registration point
			runAnimation.pivotY = Math.ceil(runAnimation.texture.height / 2);
//			runAnimation.stop();
			runAnimation.visible = false;
			this.addChild(runAnimation);
			
			jumpAnimation = new MovieClip(Assets.getSprite("AtlasTexture2").getTextures("TransfigAnimCatJump"), 60);
			jumpAnimation.pivotX = Math.ceil(jumpAnimation.texture.width  / 2); // center art on registration point
			jumpAnimation.pivotY = Math.ceil(jumpAnimation.texture.height / 2);
			jumpAnimation.loop = false;
			jumpAnimation.stop();
			jumpAnimation.visible = false;
			jumpAnimation.alpha = 0;
			this.addChild(jumpAnimation);
		}
		
		public function activate():void {
			if (!Sounds.sfxMuted) Sounds.sndPowerup.play();
			this.isActivated = true;
			
			// transfiguration animation
			this.transfiguration.displayActivation(Constants.PowerupMasterDapan);
			
			this.gx = this.hero.gx;
			this.gy = this.hero.gy;
			this.launchInterval = 1000;
//			Statics.particleJet.start();
//			Statics.particleCharge.start();
			Statics.particleBounce.emitterX = this.x;
			Statics.particleBounce.emitterY = (this.y + this.bounds.bottom) / 2;
			Statics.particleBounce.start();
			Statics.particleCharge.emitterX = this.x;
			Statics.particleCharge.emitterY = this.y;
			Statics.particleCharge.start(1);
			
			// disable hero falldown due to gravity
//			hero.isDynamic = false;
			this.isDynamicDisabled = false;
//			hero.dy = 0.5;
			
			hero.visible = false;
			starling.core.Starling.juggler.add(runAnimation);
			starling.core.Starling.juggler.add(jumpAnimation);
//			jumpAnimation.visible = true;
//			jumpAnimation.play();
			this.prepareShow();
			
			// move hero
			//			if (this.hero.dy < 1.5 && Statics.gameTime > this.hero.controlRestoreTime) this.hero.dy = 0;
//			this.incrementalHeroDy = 0;
			
//			var targetLeft:int = -Statics.stageWidth / 2 + 35; // position of left screen border
//			var targetRight:int = Statics.stageWidth / 2 - 35; // position of right screen border
//			Starling.juggler.tween(hero, 1, {
//				transition: Transitions.EASE_OUT_BOUNCE,
//				gx: targetRight
//			});
			Starling.juggler.delayCall(prepareMove, 2);
			
			// brief push upward
			if (this.hero.dy < 2) {
				this.hero.dy = 2;
			}
//			Statics.particleJet.start(0.1);
			
			// move camera target up
			Statics.cameraTargetModifierY = 250;
			
			this.completionWarned = false;
			this.completionTime = Statics.gameTime + 20000;
			this.nearCompletionTime = this.completionTime - Constants.PowerupWarningDuration;
			
			// schedule first obstacle
			this.nextLaunchTime = Statics.gameTime + 2000;
		}
		
		private function arrivingOnRight():void {
			if (this.isActivated) {
				this.jumpAnimation.stop();
				this.jumpAnimation.visible = false;
				this.runAnimation.visible = true;
				this.scaleX = 1;
			}
		}
		
		private function arrivingOnLeft():void {
			if (this.isActivated) {
				this.jumpAnimation.stop();
				this.jumpAnimation.visible = false;
				this.runAnimation.visible = true;
				this.scaleX = -1;
			}
		}
		
		public function update(timeDiff:Number):Boolean {
			if (!this.isActivated) return false;
			
			this.hero.dx = 0;
			this.gx = this.hero.gx;
			this.gy = this.hero.gy;
			Statics.particleBounce.emitterX = this.x;
			Statics.particleBounce.emitterY = (this.y + this.bounds.bottom) / 2;
//			this.snapToBorder(timeDiff);
//			if (this.hero.gx > 100) this.arrivingOnRight();
//			else if (this.hero.gx < -100) this.arrivingOnLeft();
//			this.hero.dy = 0.5 + this.incrementalHeroDy;
			
			if (this.hero.dy < 0.4 && !this.isDynamicDisabled) { // stop falling due to gravity once slowed down
				this.hero.isDynamic = false;
				this.isDynamicDisabled = true;
			}
			
			// almost time up, begin powerup reel warning
			if (!this.completionWarned && Statics.gameTime > this.nearCompletionTime) {
				HUD.completionWarning();
				this.completionWarned = true;
			}
			
			// time up, deactivate
			if (Statics.gameTime > this.completionTime) {
				this.deactivate();
			}
			
			// launch obstacle
			if (Statics.gameTime > this.nextLaunchTime) {
				this.nextLaunchTime = int(Statics.gameTime + launchInterval); // schedule next launch time
//				if (launchInterval > 50) launchInterval -= 50;
				this.hero.dy += 0.05;
				return true;
			}
			
			return false;
		}
		
		public function deactivate():void {
			this.isActivated = false;
			
//			Statics.particleJet.stop();
//			Statics.particleCharge.stop();
			Statics.particleBounce.stop();
			hero.visible = true;
			runAnimation.stop();
			runAnimation.visible = false;
			starling.core.Starling.juggler.remove(runAnimation);
			jumpAnimation.stop();
			jumpAnimation.visible = false;
			jumpAnimation.alpha = 0;
			starling.core.Starling.juggler.remove(jumpAnimation);
			
			// restore hero falldown due to gravity
			this.hero.isDynamic = true;
			
			// reset camera target
			Statics.cameraTargetModifierY = 0;
			
			// move hero back to center
			if (this.hero.gx < 0) this.hero.dx = 0.9;
			else this.hero.dx = -0.9;
			
			// misc reset
			HUD.clearPowerupReel();
			Statics.powerupsEnabled = true;
			
			// brief push upward
			if (this.hero.dy < 2.5) {
				this.hero.dy = 2.5;
			}
			Statics.particleJet.start(0.1);
			
			// set invincibility time
			Statics.invincibilityExpirationTime = Statics.gameTime + 1000;
			
			// transfiguration deactivation effect
			this.transfiguration.displayDeactivation();
		}
		
//		public function snapToBorder(timeDiff:Number):void {
//			var targetRight:int = Statics.stageWidth / 2 - 20; // position of right screen border
//			var targetLeft:int = -Statics.stageWidth / 2 + 20; // position of left screen border
//			var easingFactor:Number;
//			var d2x:Number = 0.0;
//			
//			if (shouldSnapToRightBorder) { // snap to right border of screen
//				easingFactor = (300 - Math.abs(this.hero.gx - targetRight) / 10);
//				if (targetRight > this.hero.gx || targetRight < this.hero.gx) {
//					d2x = ((targetRight - this.hero.gx) - this.hero.dx * easingFactor) / (0.5 * easingFactor * easingFactor);
//				}
//				else {
//					d2x = -this.hero.dx / easingFactor;
//				}
//				//d2y *= this.timeDiffControlled * 0.001;
//				this.hero.dx += d2x * timeDiff;
//			} else { // snap to left border of screen
//				easingFactor = (300 - Math.abs(this.hero.gx - targetLeft) / 10);
//				if (targetLeft < this.hero.gx || targetLeft > this.hero.gx) { // move platform down
//					d2x = ((targetLeft - this.hero.gx) - this.hero.dx * easingFactor) / (0.5 * easingFactor * easingFactor);
//				}
//				else {
//					d2x = -this.hero.dx / easingFactor;
//				}
//				//d2y *= this.timeDiffControlled * 0.001;
//				this.hero.dx += d2x * timeDiff;
//			}
//		}
		
		public function snapToLeft():void {
			if (!isControlDisabled && this.isActivated) {
				isControlDisabled = true;
				Statics.particleCharge.start(0.5);
				runAnimation.visible = false;
				jumpAnimation.visible = true;
				jumpAnimation.play();
				
				var targetLeft:int = -Statics.stageWidth / 2 + 35; // position of left screen border
				Starling.juggler.tween(hero, 0.8, {
					transition: Transitions.EASE_OUT_IN,
					gx: targetLeft,
					onComplete: function():void { arrivingOnLeft(); isControlDisabled = false; }
				});
			}
		}
		
		public function snapToRight():void {
			if (!isControlDisabled && this.isActivated) {
				isControlDisabled = true;
				Statics.particleCharge.start(0.5);
				runAnimation.visible = false;
				jumpAnimation.visible = true;
				jumpAnimation.play();
				
				var targetRight:int = Statics.stageWidth / 2 - 35; // position of right screen border
				Starling.juggler.tween(hero, 0.8, {
					transition: Transitions.EASE_OUT_IN,
					gx: targetRight,
					onComplete: function():void { arrivingOnRight(); isControlDisabled = false; }
				});
			}
		}
		
		/** 
		 * On activation, show jump animation
		 */
		private function prepareShow():void {
			isControlDisabled = true;
			runAnimation.visible = false;
			jumpAnimation.visible = true;
			jumpAnimation.play();
			Starling.juggler.tween(jumpAnimation, 1, {
				transition: Transitions.LINEAR,
				alpha: 1
			});
		}
		
		/**
		 * On activation, move to right border after transfiguration transition animation
		 */
		private function prepareMove():void {
			var targetRight:int = Statics.stageWidth / 2 - 35; // position of right screen border
			Starling.juggler.tween(hero, 1, {
				transition: Transitions.EASE_OUT_IN,
				gx: targetRight,
				onComplete: function():void { arrivingOnRight(); isControlDisabled = false; }
			});
		}
	}
}