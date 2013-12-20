package com.jumpGame.gameElements.powerups
{
	import com.jumpGame.gameElements.Hero;
	import com.jumpGame.ui.HUD;
	
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.Image;

	public class Attraction extends GameObject
	{
		public var isActivated:Boolean;
		
		private var ring1Image:Image;
		private var ring2Image:Image;
		private var hero:Hero;
		private var hud:HUD;
		private var nearCompletionTime:int; // star flashing powerup reel icon at this time
		private var completionTime:int;
		private var completionWarned:Boolean;
		private var nextRing1AppearanceTime:int;
		private var nextRing2AppearanceTime:int;
		
		private var cometOn:Boolean;
		
		public function Attraction(hero:Hero, hud:HUD) {
			this.touchable = false;
			this.hero = hero;
			this.hud = hud;
			this.createPowerupArt();
			this.isActivated = false;
			this.cometOn = false;
		}
		
		protected function createPowerupArt():void
		{
			ring1Image = new Image(Statics.assets.getTexture("AttractionRing0000"));
			ring1Image.pivotX = Math.ceil(ring1Image.width / 2); // center image on registration point
			ring1Image.pivotY = Math.ceil(ring1Image.height / 2);
			ring1Image.visible = false;
			ring1Image.alpha = 0;
			this.addChild(ring1Image);
			
			ring2Image = new Image(Statics.assets.getTexture("AttractionRing0000"));
			ring2Image.pivotX = Math.ceil(ring2Image.width / 2); // center image on registration point
			ring2Image.pivotY = Math.ceil(ring2Image.height / 2);
			ring2Image.visible = false;
			ring2Image.alpha = 0;
			this.addChild(ring2Image);
		}
		
		public function activate(isForCometRun:Boolean = false):void {
			ring1Image.visible = true;
			ring2Image.visible = true;
			Starling.juggler.tween(ring1Image, 2.0, {
				transition: Transitions.LINEAR,
				alpha: 1,
				scaleX: 0,
				scaleY: 0
			});
			this.nextRing1AppearanceTime = Statics.gameTime + 2000;
			this.nextRing2AppearanceTime = Statics.gameTime + 1000;
			
			this.isActivated = true;
			Statics.powerupAttractionEnabled = true;
			this.completionWarned = false;
			
			this.cometOn = isForCometRun;
			if (!isForCometRun) {
				if (!Sounds.sfxMuted) Sounds.sndPowerup.play();
				this.completionTime = Statics.gameTime + 5000 + Statics.rankAttraction * 1000;
				this.nearCompletionTime = this.completionTime - Constants.PowerupWarningDuration;
			}
		}
		
		public function update(timeDiff:Number):void {
			if (!this.isActivated) return;
			
			this.gx = this.hero.gx;
			this.gy = this.hero.gy;
			
			// repeat ring effect
			// first ring
			if (Statics.gameTime > this.nextRing1AppearanceTime) {
				ring1Image.alpha = 0;
				ring1Image.scaleX = 1;
				ring1Image.scaleY = 1;
				Starling.juggler.tween(ring1Image, 2.0, {
					transition: Transitions.LINEAR,
					alpha: 1,
					scaleX: 0,
					scaleY: 0
				});
				this.nextRing1AppearanceTime = Statics.gameTime + 2000;
			}
			// second ring
			if (Statics.gameTime > this.nextRing2AppearanceTime) {
				ring2Image.alpha = 0;
				ring2Image.scaleX = 1;
				ring2Image.scaleY = 1;
				Starling.juggler.tween(ring2Image, 2.0, {
					transition: Transitions.LINEAR,
					alpha: 1,
					scaleX: 0,
					scaleY: 0
				});
				this.nextRing2AppearanceTime = Statics.gameTime + 2000;
			}
			
			// check for timed completion unless comet run is on
			if (!this.cometOn) {
				// almost time up, begin powerup reel warning
				if (!this.completionWarned && Statics.gameTime > this.nearCompletionTime) {
					hud.completionWarning();
					this.completionWarned = true;
				}
				
				// time up, deactivate
				if (Statics.gameTime > this.completionTime) {
					ring1Image.visible = false;
					ring2Image.visible = false;
					this.isActivated = false;
					Statics.powerupAttractionEnabled = false;
					
					// misc reset
					hud.clearPowerupReel();
					Statics.powerupsEnabled = true;
				}
			}
		}
		
		public function cometDone():void {
			if (Statics.gameTime > this.completionTime) {
				ring1Image.visible = false;
				ring2Image.visible = false;
				this.isActivated = false;
				Statics.powerupAttractionEnabled = false;
			}
			this.cometOn = false;
		}
	}
}