package com.jumpGame.gameElements.powerups
{
	import com.jumpGame.gameElements.Hero;
	import com.jumpGame.gameElements.Transfiguration;
	import com.jumpGame.ui.HUD;
	
	import starling.core.Starling;
	import starling.display.MovieClip;

	public class QueenNagini extends GameObject
	{
		private var hero:Hero;
		private var transfiguration:Transfiguration;
		private var flightAnimation:MovieClip;
		private var blastAnimation:MovieClip;
		private var blastAnimation2:MovieClip;
		private var pendingLeft:Boolean = false;
		private var pendingRight:Boolean = false;
		
		public var isActivated:Boolean = false;
		private var nearCompletionTime:int;
		private var completionTime:int;
		private var completionWarned:Boolean;
		
		public function QueenNagini(hero:Hero, transfiguration:Transfiguration)
		{
			this.hero = hero;
			this.transfiguration = transfiguration;
			this.createPowerupArt();
		}
		
		protected function createPowerupArt():void
		{
			flightAnimation = new MovieClip(Assets.getSprite("AtlasTexture2").getTextures("TransfigAnimRocketFlight"), 40);
			flightAnimation.pivotX = Math.ceil(flightAnimation.texture.width  / 2); // center art on registration point
			flightAnimation.pivotY = Math.ceil(flightAnimation.texture.height / 2);
			flightAnimation.stop();
			flightAnimation.visible = false;
			flightAnimation.loop = false;
			this.addChild(flightAnimation);
			
			blastAnimation = new MovieClip(Assets.getSprite("AtlasTexture2").getTextures("BlastCircle"), 40);
			blastAnimation.pivotX = Math.ceil(blastAnimation.width  / 2); // center art on registration point
			blastAnimation.pivotY = Math.ceil(blastAnimation.height / 2);
			blastAnimation.loop = false;
			blastAnimation.visible = false;
			this.addChild(blastAnimation);
			
			blastAnimation2 = new MovieClip(Assets.getSprite("AtlasTexture4").getTextures("Blast"), 40);
			blastAnimation2.pivotX = Math.ceil(blastAnimation2.width  / 2); // center art on registration point
			blastAnimation2.pivotY = Math.ceil(blastAnimation2.height / 2);
			blastAnimation2.scaleX = 2;
			blastAnimation2.scaleY = 2;
			blastAnimation2.loop = false;
			blastAnimation2.visible = false;
			this.addChild(blastAnimation2);
		}
		
		public function activate():void {
			if (!Sounds.sfxMuted) Sounds.sndPowerup.play();
			
			// transfiguration animation
			this.transfiguration.displayActivation(this.hero, Constants.PowerupQueenNagini);
			
			this.hero.gx = 0;
			this.gx = this.hero.gx;
			this.gy = this.hero.gy;
			Statics.particleJet.start();
			
			hero.visible = false;
			starling.core.Starling.juggler.add(flightAnimation);
			flightAnimation.visible = true;
			flightAnimation.play();
			
			blastAnimation.stop();
			blastAnimation.visible = true;
			starling.core.Starling.juggler.add(blastAnimation);
			
			blastAnimation2.stop();
			blastAnimation2.visible = true;
			starling.core.Starling.juggler.add(blastAnimation2);
			
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
			
			// move hero
			if (blastAnimation.isComplete) {
				if (pendingLeft) {
					this.hero.gx -= 150;
					pendingLeft = false;
					
					blastAnimation2.stop();
					blastAnimation2.play();
				}
				if (pendingRight) {
					this.hero.gx += 150;
					pendingRight = false;
					
					blastAnimation2.stop();
					blastAnimation2.play();
				}
			}
			
			// keep hero on screen
			if (this.hero.gx < -300) this.hero.gx = -300;
			if (this.hero.gx > 300) this.hero.gx = 300;
			
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
			flightAnimation.visible = false;
			starling.core.Starling.juggler.remove(flightAnimation);
			
			blastAnimation.visible = false;
			starling.core.Starling.juggler.remove(blastAnimation);
			
			blastAnimation2.visible = false;
			starling.core.Starling.juggler.remove(blastAnimation2);
			
			this.isActivated = false;
			
			// misc reset
			HUD.clearPowerupReel();
			Statics.powerupsEnabled = true;
			
			this.transfiguration.displayDeactivation(this.hero);
		}
		
		public function blinkLeft():void {
			blastAnimation.stop();
			blastAnimation.play();
			pendingLeft = true;
		}
		
		public function blinkRight():void {
			blastAnimation.stop();
			blastAnimation.play();
			pendingRight = true;
		}
	}
}