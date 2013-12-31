package com.jumpGame.gameElements.powerups
{
	import com.jumpGame.gameElements.Hero;
	import com.jumpGame.gameElements.Transfiguration;
	import com.jumpGame.ui.HUD;
	
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.MovieClip;

	public class VermilionBird extends GameObject
	{
		private var hero:Hero;
		private var hud:HUD;
		private var transfiguration:Transfiguration;
		private var flightAnimation:MovieClip;
//		private var glideAnimation:MovieClip;
		private var nextLaunchTime:int;
		private var launchInterval:Number;
		
		public var isActivated:Boolean = false;
		private var nearCompletionTime:int;
		private var completionTime:int;
		private var completionWarned:Boolean;
		
		public function VermilionBird(hero:Hero, hud:HUD, transfiguration:Transfiguration)
		{
			this.touchable = false;
			this.hero = hero;
			this.hud = hud;
			this.transfiguration = transfiguration;
			this.createPowerupArt();
		}
		
		protected function createPowerupArt():void
		{
			flightAnimation = new MovieClip(Statics.assets.getTextures("TransfigAnimVermilionFlight"), 20);
			flightAnimation.pivotX = Math.ceil(flightAnimation.texture.width  / 2); // center art on registration point
			flightAnimation.pivotY = Math.ceil(flightAnimation.texture.height / 2);
			flightAnimation.stop();
			flightAnimation.visible = false;
			flightAnimation.alpha = 0;
			this.addChild(flightAnimation);
			
//			glideAnimation = new MovieClip(Assets.getSprite("AtlasTexture2").getTextures("TransfigAnimVermilionGlide"), 40);
//			glideAnimation.pivotX = Math.ceil(glideAnimation.texture.width  / 2); // center art on registration point
//			glideAnimation.pivotY = Math.ceil(glideAnimation.texture.height / 2);
//			glideAnimation.stop();
//			glideAnimation.visible = false;
//			glideAnimation.loop = false;
//			this.addChild(glideAnimation);
		}
		
		public function activate():void {
			if (!Sounds.sfxMuted) Statics.assets.playSound("SND_POWERUP");
			
			// transfiguration animation
			this.transfiguration.displayActivation(Constants.PowerupVermilionBird);
			
			this.gx = this.hero.gx;
			this.gy = this.hero.gy;
			this.launchInterval = 1000;
			
			hero.visible = false;
			
//			starling.core.Starling.juggler.add(glideAnimation);
//			glideAnimation.visible = true;
//			glideAnimation.stop();
//			glideAnimation.play();
			
			Statics.particleCharge.emitterX = this.x;
			Statics.particleCharge.emitterY = this.y;
			Statics.particleCharge.start(1);
			
			starling.core.Starling.juggler.add(flightAnimation);
			flightAnimation.visible = true;
			flightAnimation.play();
			
			Starling.juggler.tween(flightAnimation, 1, {
				transition: Transitions.LINEAR,
				alpha: 1
			});
			
			// brief push upward
			if (this.hero.dy < 1.5) {
				this.hero.dy = 1.5;
			}
			
			// move camera target up
			Statics.cameraTargetModifierY = 200;
			
			this.isActivated = true;
			this.completionWarned = false;
			this.completionTime = Statics.gameTime + 15000;
			this.nearCompletionTime = this.completionTime - Constants.PowerupWarningDuration;
			
			// schedule first obstacle
			this.nextLaunchTime = Statics.gameTime + 1000;
			
			hud.showMessage("Avoid the Bombs!", 3000);
		}
		
		public function update(timeDiff:Number):Boolean {
			if (!this.isActivated) return false;
			
			this.gx = this.hero.gx;
			this.gy = this.hero.gy;
			
//			if (this.flightAnimation.isComplete) {
//				flightAnimation.stop();
//				this.flightAnimation.visible = false;
//				this.glideAnimation.visible = true;
//				this.glideAnimation.stop();
//				this.glideAnimation.play();
//			}
			
			// almost time up, begin powerup reel warning
			if (!this.completionWarned && Statics.gameTime > this.nearCompletionTime) {
				hud.completionWarning();
				this.completionWarned = true;
			}
			
			// time up, deactivate
			if (Statics.gameTime > this.completionTime) {
				this.deactivate();
			}
			
			// launch obstacle
			if (Statics.gameTime > this.nextLaunchTime) {
				this.nextLaunchTime = int(Statics.gameTime + launchInterval); // schedule next launch time
				if (launchInterval > 200) launchInterval -= 40;
				return true;
			}
			
			return false;
		}
		
		public function deactivate():void {
			this.isActivated = false;
			
			hero.visible = true;
			flightAnimation.visible = false;
			flightAnimation.alpha = 0;
//			glideAnimation.visible = false;
			starling.core.Starling.juggler.remove(flightAnimation);
//			starling.core.Starling.juggler.remove(glideAnimation);
			
			// reset camera target
			Statics.cameraTargetModifierY = 0;
			
			// misc reset
			hud.clearPowerupReel();
			Statics.powerupsEnabled = true;
			
			// brief push upward
			if (this.hero.dy < 3.5) {
				this.hero.dy = 3.5;
				Statics.particleJet.start(0.5);
			}
			
			// set invincibility time
			Statics.invincibilityExpirationTime = Statics.gameTime + 1000;
			
			// transfiguration deactivation effect
			this.transfiguration.displayDeactivation();
		}
		
		public function beatWings():void {
//			glideAnimation.visible = false;
//			flightAnimation.visible = true;
			if (!Sounds.sfxMuted) Statics.assets.playSound("SND_WING_FLAP");
			
			flightAnimation.stop();
			flightAnimation.play();
			Statics.particleCharge.start(0.2);
			Statics.particleJet.start(0.1);
		}
	}
}