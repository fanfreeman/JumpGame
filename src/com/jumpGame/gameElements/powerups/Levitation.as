package com.jumpGame.gameElements.powerups
{
	import com.jumpGame.gameElements.Hero;
	import com.jumpGame.ui.HUD;
	
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.Image;

	public class Levitation extends GameObject
	{
		public var isActivated:Boolean = false;
		
		private var hero:Hero;
		private var hud:HUD;
		private var nearCompletionTime:int; // star flashing powerup reel icon at this time
		private var completionTime:int;
		private var completionWarned:Boolean;
		private var heroD2y:Number;
		private var jetFired:Boolean;
		private var ringImage:Image;
		
		public function Levitation(hero:Hero, hud:HUD)
		{
			this.touchable = false;
			this.hero = hero;
			this.hud = hud;
			this.createPowerupArt();
		}
		
		protected function createPowerupArt():void
		{
			ringImage = new Image(Assets.getSprite("AtlasTexture2").getTexture("ProtectionBubble0000"));
			ringImage.pivotX = Math.ceil(ringImage.width / 2); // center image on registration point
			ringImage.pivotY = Math.ceil(ringImage.height / 2);
//			ringImage.scaleX = 0.6;
//			ringImage.scaleY = 0.6;
			this.addChild(ringImage);
			this.visible = false;
		}
		
		public function activate(isTutorial:Boolean = false):void {
			this.visible = true;
			Starling.juggler.tween(ringImage, 0.5, {
				transition: Transitions.LINEAR,
				alpha: 1
			});
			
			Starling.juggler.tween(ringImage, 0.5, {
				transition: Transitions.LINEAR,
				scaleX: 1.1,
				scaleY: 1.1,
				repeatCount: 0,
				reverse: true
			});
			
			this.isActivated = true;
			this.jetFired = false;
			this.completionWarned = false;
			
			if (isTutorial) {
				this.completionTime = Statics.gameTime + 80000; // duration
			} else {
				this.completionTime = Statics.gameTime + 5000 + Statics.rankSafety * 1000; // duration
				if (!Sounds.sfxMuted) Sounds.sndPowerup.play();
			}
			
			this.nearCompletionTime = this.completionTime - Constants.PowerupWarningDuration;
		}
		
		public function update(timeDiff:Number, sofHeight:Number):void {
			if (!this.isActivated) return;
			
			this.ringImage.rotation += 0.002 * timeDiff;
			this.gx = this.hero.gx;
			this.gy = this.hero.gy;

			if (this.hero.dy < -1 || (this.hero.gy - 250 < sofHeight)) {
				if (!this.jetFired) {
					// fire jet
					if (!Sounds.sfxMuted) Sounds.sndSwoosh.play();
					Statics.particleJet.start(1);
					this.heroD2y = 0;
					this.jetFired = true;
				}
			}
			
			if (this.jetFired) {
				if (this.hero.dy > 1.5) { // turn off jet
					this.jetFired = false;
				} else { // update jet
					this.heroD2y += 0.001 * timeDiff;
					this.hero.dy += this.heroD2y;
				}
			}
			
			// almost time up, begin powerup reel warning
			if (!this.completionWarned && Statics.gameTime > this.nearCompletionTime) {
				hud.completionWarning();
				this.completionWarned = true;
			}
			
			// time up, deactivate
			if (Statics.gameTime > this.completionTime) {
				Starling.juggler.tween(ringImage, 0.5, {
					transition: Transitions.LINEAR,
					alpha: 0,
					onComplete: cleanup
				});
				this.isActivated = false;
				
				// misc reset
				hud.clearPowerupReel();
				Statics.powerupsEnabled = true;
			}
		}
		
		private function cleanup():void {
			Starling.juggler.removeTweens(ringImage);
			this.visible = false;
		}
	}
}