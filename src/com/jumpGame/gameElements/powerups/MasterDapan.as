package com.jumpGame.gameElements.powerups
{
	import com.jumpGame.gameElements.Hero;
	import com.jumpGame.gameElements.Transfiguration;
	import com.jumpGame.level.Statics;
	import com.jumpGame.ui.HUD;
	
	import starling.core.Starling;
	import starling.display.MovieClip;

	public class MasterDapan extends GameObject
	{
		private var hero:Hero;
		private var transfiguration:Transfiguration;
		private var runAnimation:MovieClip;
		private var shouldSnapToRightBorder:Boolean;
		
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
			runAnimation.stop();
			runAnimation.visible = false;
			this.addChild(runAnimation);
		}
		
		public function activate():void {
			if (!Sounds.sfxMuted) Sounds.sndPowerup.play();
			
			// transfiguration animation
			this.transfiguration.displayActivation(this.hero, Constants.PowerupMasterDapan);
			
			this.gx = this.hero.gx;
			this.gy = this.hero.gy;
			Statics.particleJet.start();
			
			hero.visible = false;
			starling.core.Starling.juggler.add(runAnimation);
			runAnimation.visible = true;
			runAnimation.play();
			
			shouldSnapToRightBorder = true;
			
			// brief push upward
			if (this.hero.dy < 1.5) {
				this.hero.dy = 1.5;
				Statics.particleJet.start(0.1);
			}
			
			this.isActivated = true;
			this.completionWarned = false;
			this.completionTime = Statics.gameTime + 20000;
			this.nearCompletionTime = this.completionTime - Constants.PowerupWarningDuration;
		}
		
		public function update(timeDiff:Number):Boolean {
			if (!this.isActivated) return false;
			
			this.gx = this.hero.gx;
			this.gy = this.hero.gy;
			this.snapToBorder(timeDiff);
			if (this.hero.gx > 0) this.scaleX = 1;
			else this.scaleX = -1;
			
			// almost time up, begin powerup reel warning
			if (!this.completionWarned && Statics.gameTime > this.nearCompletionTime) {
				HUD.completionWarning();
				this.completionWarned = true;
			}
			
			// time up, deactivate
			if (Statics.gameTime > this.completionTime) {
				// brief push upward
				if (this.hero.dy < 1.5) {
					this.hero.dy = 1.5;
					Statics.particleJet.start(0.1);
				}
				
				this.deactivate();
			}
			
			return false;
		}
		
		public function deactivate():void {
			Statics.particleJet.stop();
			hero.visible = true;
			runAnimation.visible = false;
			starling.core.Starling.juggler.remove(runAnimation);
			this.isActivated = false;
			
			// misc reset
			HUD.clearPowerupReel();
			Statics.powerupsEnabled = true;
			
			this.transfiguration.displayDeactivation(this.hero);
		}
		
		public function snapToBorder(timeDiff:Number):void {
			var targetRight:int = Statics.stageWidth / 2 - 20; // position of right screen border
			var targetLeft:int = -Statics.stageWidth / 2 + 20; // position of left screen border
			var easingFactor:Number;
			var d2x:Number = 0.0;
			
			if (shouldSnapToRightBorder) { // snap to right border of screen
				easingFactor = (300 - Math.abs(this.hero.gx - targetRight) / 10);
				if (targetRight > this.hero.gx || targetRight < this.hero.gx) {
					d2x = ((targetRight - this.hero.gx) - this.hero.dx * easingFactor) / (0.5 * easingFactor * easingFactor);
				}
				else {
					d2x = -this.hero.dx / easingFactor;
				}
				//d2y *= this.timeDiffControlled * 0.001;
				this.hero.dx += d2x * timeDiff;
			} else { // snap to left border of screen
				easingFactor = (300 - Math.abs(this.hero.gx - targetLeft) / 10);
				if (targetLeft < this.hero.gx || targetLeft > this.hero.gx) { // move platform down
					d2x = ((targetLeft - this.hero.gx) - this.hero.dx * easingFactor) / (0.5 * easingFactor * easingFactor);
				}
				else {
					d2x = -this.hero.dx / easingFactor;
				}
				//d2y *= this.timeDiffControlled * 0.001;
				this.hero.dx += d2x * timeDiff;
			}
		}
		
		public function snapToLeft():void {
			shouldSnapToRightBorder = false;
		}
		
		public function snapToRight():void {
			shouldSnapToRightBorder = true;
		}
	}
}