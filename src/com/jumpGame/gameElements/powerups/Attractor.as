package com.jumpGame.gameElements.powerups
{
	import com.jumpGame.gameElements.Hero;
	import com.jumpGame.level.Statics;
	import com.jumpGame.ui.HUD;
	
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.Image;

	public class Attractor extends GameObject
	{
		public var isActivated:Boolean;
		
		private var ring1Image:Image;
		private var ring2Image:Image;
		private var hero:Hero;
		private var nearCompletionTime:int; // star flashing powerup reel icon at this time
		private var completionTime:int;
		private var completionWarned:Boolean;
		private var nextRing1AppearanceTime:int;
		private var nextRing2AppearanceTime:int;
		
		public function Attractor(hero:Hero) {
			this.hero = hero;
			this.createPowerupArt();
			this.isActivated = false;
		}
		
		protected function createPowerupArt():void
		{
			ring1Image = new Image(Assets.getSprite("AtlasTexture2").getTexture("AttractionRing0000"));
			ring1Image.pivotX = Math.ceil(ring1Image.width / 2); // center image on registration point
			ring1Image.pivotY = Math.ceil(ring1Image.height / 2);
			ring1Image.visible = false;
			ring1Image.alpha = 0;
			this.addChild(ring1Image);
			
			ring2Image = new Image(Assets.getSprite("AtlasTexture2").getTexture("AttractionRing0000"));
			ring2Image.pivotX = Math.ceil(ring2Image.width / 2); // center image on registration point
			ring2Image.pivotY = Math.ceil(ring2Image.height / 2);
			ring2Image.visible = false;
			ring2Image.alpha = 0;
			this.addChild(ring2Image);
		}
		
		public function activate():void {
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
			
			if (!Sounds.sfxMuted) Sounds.sndPowerup.play();
			this.isActivated = true;
			this.completionWarned = false;
			this.completionTime = Statics.gameTime + 10000;
			this.nearCompletionTime = this.completionTime - Constants.PowerupWarningDuration;
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
			
			// almost time up, begin powerup reel warning
			if (!this.completionWarned && Statics.gameTime > this.nearCompletionTime) {
				HUD.completionWarning();
				this.completionWarned = true;
			}
			
			// time up, deactivate
			if (Statics.gameTime > this.completionTime) {
				ring1Image.visible = false;
				ring2Image.visible = false;
				this.isActivated = false;
				
				// misc reset
				HUD.clearPowerupReel();
				Statics.powerupsEnabled = true;
			}
		}
	}
}