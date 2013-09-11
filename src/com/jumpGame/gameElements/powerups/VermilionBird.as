package com.jumpGame.gameElements.powerups
{
	import com.jumpGame.gameElements.Hero;
	import com.jumpGame.gameElements.Transfiguration;
	import com.jumpGame.level.Statics;
	import com.jumpGame.ui.HUD;
	
	import starling.core.Starling;
	import starling.display.MovieClip;

	public class VermilionBird extends GameObject
	{
		private var hero:Hero;
		private var transfiguration:Transfiguration;
		private var flightAnimation:MovieClip;
		private var glideAnimation:MovieClip;
		
		public var isActivated:Boolean = false;
		private var nearCompletionTime:int;
		private var completionTime:int;
		private var completionWarned:Boolean;
		
		public function VermilionBird(hero:Hero, transfiguration:Transfiguration)
		{
			this.hero = hero;
			this.transfiguration = transfiguration;
			this.createPowerupArt();
		}
		
		protected function createPowerupArt():void
		{
			flightAnimation = new MovieClip(Assets.getSprite("AtlasTexture2").getTextures("TransfigAnimVermilionFlight"), 40);
			flightAnimation.pivotX = Math.ceil(flightAnimation.texture.width  / 2); // center art on registration point
			flightAnimation.pivotY = Math.ceil(flightAnimation.texture.height / 2);
			flightAnimation.stop();
			flightAnimation.visible = false;
			flightAnimation.loop = false;
			this.addChild(flightAnimation);
			
			glideAnimation = new MovieClip(Assets.getSprite("AtlasTexture2").getTextures("TransfigAnimVermilionGlide"), 40);
			glideAnimation.pivotX = Math.ceil(glideAnimation.texture.width  / 2); // center art on registration point
			glideAnimation.pivotY = Math.ceil(glideAnimation.texture.height / 2);
			glideAnimation.stop();
			glideAnimation.visible = false;
			glideAnimation.loop = false;
			this.addChild(glideAnimation);
		}
		
		public function activate():void {
			if (!Sounds.sfxMuted) Sounds.sndPowerup.play();
			
			// transfiguration animation
			this.transfiguration.displayActivation(this.hero, Constants.PowerupVermilionBird);
			
			this.gx = this.hero.gx;
			this.gy = this.hero.gy;
			
			hero.visible = false;
			starling.core.Starling.juggler.add(glideAnimation);
			glideAnimation.visible = true;
			glideAnimation.stop();
			glideAnimation.play();
			starling.core.Starling.juggler.add(flightAnimation);
//			flightAnimation.visible = true;
			
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
			
			if (this.flightAnimation.isComplete) {
				flightAnimation.stop();
				this.flightAnimation.visible = false;
				this.glideAnimation.visible = true;
				this.glideAnimation.stop();
				this.glideAnimation.play();
			}
			
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
			hero.visible = true;
			flightAnimation.visible = false;
			glideAnimation.visible = false;
			starling.core.Starling.juggler.remove(flightAnimation);
			starling.core.Starling.juggler.remove(glideAnimation);
			this.isActivated = false;
			
			// misc reset
			HUD.clearPowerupReel();
			Statics.powerupsEnabled = true;
			
			this.transfiguration.displayDeactivation(this.hero);
		}
		
		public function beatWings():void {
			glideAnimation.visible = false;
			flightAnimation.visible = true;
			flightAnimation.play();
		}
	}
}