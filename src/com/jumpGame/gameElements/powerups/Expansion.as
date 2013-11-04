package com.jumpGame.gameElements.powerups
{
	import com.jumpGame.gameElements.Hero;
	import com.jumpGame.gameElements.Transfiguration;
	import com.jumpGame.level.Statics;
	import com.jumpGame.ui.HUD;
	
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.MovieClip;

	/**
	 * This is actually Transfiguration: Jet Propulsion Broomstick
	 */
	public class Expansion extends GameObject
	{
		private var hero:Hero;
		private var transfiguration:Transfiguration;
//		private var chainsImage:Image;
//		private var propellerOffImage:Image;
//		private var propellerLeftImage:Image;
//		private var propellerRightImage:Image;
//		private var propellerBothImage:Image;
		private var flightAnimation:MovieClip;
		private var nextLaunchTime:int;
		private var launchInterval:Number;
		
		public var isActivated:Boolean = false;
		private var nearCompletionTime:int;
		private var completionTime:int;
		private var completionWarned:Boolean;
		
		public function Expansion(hero:Hero, transfiguration:Transfiguration)
		{
			this.hero = hero;
			this.transfiguration = transfiguration;
			this.createPowerupArt();
		}
		
		protected function createPowerupArt():void
		{
//			propellerOffImage = new Image(Assets.getSprite("AtlasTexture2").getTexture("ChainPropOff0000"));
//			propellerOffImage.pivotX = Math.ceil(propellerOffImage.width / 2); // center image on registration point
//			propellerOffImage.pivotY = Math.ceil(propellerOffImage.height / 2);
//			propellerOffImage.y = 60;
//			propellerOffImage.visible = false;
//			this.addChild(propellerOffImage);
//			
//			propellerLeftImage = new Image(Assets.getSprite("AtlasTexture2").getTexture("ChainPropLeft0000"));
//			propellerLeftImage.pivotX = Math.ceil(propellerLeftImage.width / 2); // center image on registration point
//			propellerLeftImage.pivotY = Math.ceil(propellerLeftImage.height / 2);
//			propellerLeftImage.y = 60;
//			propellerLeftImage.visible = false;
//			this.addChild(propellerLeftImage);
//			
//			propellerRightImage = new Image(Assets.getSprite("AtlasTexture2").getTexture("ChainPropRight0000"));
//			propellerRightImage.pivotX = Math.ceil(propellerRightImage.width / 2); // center image on registration point
//			propellerRightImage.pivotY = Math.ceil(propellerRightImage.height / 2);
//			propellerRightImage.y = 60;
//			propellerRightImage.visible = false;
//			this.addChild(propellerRightImage);
//			
//			propellerBothImage = new Image(Assets.getSprite("AtlasTexture2").getTexture("ChainPropBoth0000"));
//			propellerBothImage.pivotX = Math.ceil(propellerBothImage.width / 2); // center image on registration point
//			propellerBothImage.pivotY = Math.ceil(propellerBothImage.height / 2);
//			propellerBothImage.y = 60;
//			propellerBothImage.visible = false;
//			this.addChild(propellerBothImage);
//			
//			chainsImage = new Image(Assets.getSprite("AtlasTexture2").getTexture("Chains0000"));
//			chainsImage.pivotX = Math.ceil(chainsImage.width / 2); // center image on registration point
//			chainsImage.pivotY = Math.ceil(chainsImage.height / 2);
//			chainsImage.visible = false;
//			chainsImage.alpha = 0;
//			this.addChild(chainsImage);
			
			flightAnimation = new MovieClip(Assets.getSprite("AtlasTexture2").getTextures("TransfigAnimBroomFlight"), 20);
			flightAnimation.pivotX = Math.ceil(flightAnimation.texture.width  / 2); // center art on registration point
			flightAnimation.pivotY = Math.ceil(flightAnimation.texture.height / 2);
			flightAnimation.stop();
			flightAnimation.visible = false;
			flightAnimation.alpha = 0;
			this.addChild(flightAnimation);
		}
		
		public function activate():void {
			if (!Sounds.sfxMuted) Sounds.sndPowerup.play();
			
			// transfiguration animation
			this.transfiguration.displayActivation(Constants.PowerupExpansion);
			
			this.gx = this.hero.gx;
			this.gy = this.hero.gy;
			this.launchInterval = 150;
			
//			chainsImage.visible = true;
//			propellerOffImage.visible = true;
//			Starling.juggler.tween(chainsImage, 1.0, {
//				transition: Transitions.LINEAR,
//				alpha: 1
//			});
			
//			hero.visible = false;
			
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
			Statics.cameraTargetModifierY = 100;
			
			this.isActivated = true;
			this.completionWarned = false;
			this.completionTime = Statics.gameTime + 20000;
			this.nearCompletionTime = this.completionTime - Constants.PowerupWarningDuration;
			
			// schedule first obstacle
			this.nextLaunchTime = Statics.gameTime + 1000;
		}
		
		public function update(timeDiff:Number):Boolean {
			if (!this.isActivated) return false;
			
//			this.chainsImage.rotation += 0.004 * timeDiff;
			this.gx = this.hero.gx;
			this.gy = this.hero.gy;
			
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
				if (launchInterval > 75) launchInterval -= 1;
				return true;
			}
			
			return false;
		}
		
		public function deactivate():void {
			this.isActivated = false;
			
			// turn off transfiguration art
//			chainsImage.visible = false;
//			this.propellerOffImage.visible = false;
//			this.propellerLeftImage.visible = false;
//			this.propellerRightImage.visible = false;
//			this.propellerBothImage.visible = false;
			hero.visible = true;
			flightAnimation.visible = false;
			flightAnimation.alpha = 0;
			starling.core.Starling.juggler.remove(flightAnimation);
			
			// reset camera target
			Statics.cameraTargetModifierY = 0;
			
			// misc reset
			HUD.clearPowerupReel();
			Statics.powerupsEnabled = true;
			
			// brief push upward
			if (this.hero.dy < 2.5) {
				this.hero.dy = 2.5;
			}
			
			// set invincibility time
			Statics.invincibilityExpirationTime = Statics.gameTime + 1000;
			
			// transfiguration deactivation effect
			this.transfiguration.displayDeactivation();
		}
		
		/**
		 * Move broom up
		 */
		public function engineOn():void {
			if (this.hero.dy < 1) this.hero.dy += 0.05;
			
			Statics.particleBounce.emitterX = this.hero.x;
			Statics.particleBounce.emitterY = this.hero.bounds.bottom;
			if (!Statics.particleBounce.isEmitting) Statics.particleBounce.start();
		}
		
		/**
		 * Stop moving broom up
		 */
		public function engineOff():void {
			if (Statics.particleBounce.isEmitting) Statics.particleBounce.stop();
		}
		
//		public function updatePropellers(leftArrow:Boolean, rightArrow:Boolean):void {
//			this.propellerOffImage.visible = false;
//			this.propellerLeftImage.visible = false;
//			this.propellerRightImage.visible = false;
//			this.propellerBothImage.visible = false;
//			
//			if (leftArrow && rightArrow) {
//				this.propellerBothImage.visible = true;
//			}
//			else if (leftArrow) {
//				this.propellerRightImage.visible = true;
//			}
//			else if (rightArrow) {
//				this.propellerLeftImage.visible = true;
//			}
//			else {
//				this.propellerOffImage.visible = true;
//			}
//		}
	}
}