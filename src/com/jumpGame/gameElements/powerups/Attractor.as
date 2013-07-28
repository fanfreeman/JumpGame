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
		
		private var outerRingImage:Image;
		private var innerRingImage:Image;
		private var hero:Hero;
		private var nearCompletionTime:int; // star flashing powerup reel icon at this time
		private var completionTime:int;
		private var completionWarned:Boolean;
		
		public function Attractor(hero:Hero) {
			this.hero = hero;
			this.createPowerupArt();
			this.isActivated = false;
		}
		
		protected function createPowerupArt():void
		{
			outerRingImage = new Image(Assets.getSprite("AtlasTexture2").getTexture("MagnetRing0000"));
			outerRingImage.pivotX = Math.ceil(outerRingImage.width / 2); // center image on registration point
			outerRingImage.pivotY = Math.ceil(outerRingImage.height / 2);
			outerRingImage.visible = false;
			outerRingImage.alpha = 0;
			this.addChild(outerRingImage);
			
			innerRingImage = new Image(Assets.getSprite("AtlasTexture2").getTexture("MagnetRing0000"));
			innerRingImage.pivotX = Math.ceil(innerRingImage.width / 2); // center image on registration point
			innerRingImage.pivotY = Math.ceil(innerRingImage.height / 2);
			innerRingImage.scaleX = 0.6;
			innerRingImage.scaleY = 0.6;
			innerRingImage.visible = false;
			innerRingImage.alpha = 0.999;
			this.addChild(innerRingImage);
		}
		
		public function activate():void {
			outerRingImage.visible = true;
			Starling.juggler.tween(outerRingImage, 0.5, {
				transition: Transitions.LINEAR,
				repeatCount: 2,
				reverse: true,
				alpha: 0.999,
				onComplete: repeatRings
			});
			
			innerRingImage.visible = true;
			Starling.juggler.tween(innerRingImage, 0.5, {
				transition: Transitions.LINEAR,
				repeatCount: 2,
				reverse: true,
				alpha: 0
			});
			
			Sounds.sndPowerup.play();
			this.isActivated = true;
			this.completionWarned = false;
			this.completionTime = Statics.gameTime + Constants.CharmDurationAttractor;
			this.nearCompletionTime = this.completionTime - Constants.PowerupWarningDuration;
		}
		
		private function repeatRings():void {
			Starling.juggler.tween(outerRingImage, 0.5, {
				transition: Transitions.LINEAR,
				repeatCount: 2,
				reverse: true,
				alpha: 0.999,
				onComplete: repeatRings
			});
			
			Starling.juggler.tween(innerRingImage, 0.5, {
				transition: Transitions.LINEAR,
				repeatCount: 2,
				reverse: true,
				alpha: 0
			});
		}
		
		public function update(timeDiff:Number):void {
			if (!this.isActivated) return;
			
			this.outerRingImage.rotation += 0.004 * timeDiff;
			this.innerRingImage.rotation += 0.004 * timeDiff;
			this.gx = this.hero.gx;
			this.gy = this.hero.gy;
			
			// almost time up, begin powerup reel warning
			if (!this.completionWarned && Statics.gameTime > this.nearCompletionTime) {
				HUD.completionWarning();
				this.completionWarned = true;
			}
			
			// time up, deactivate
			if (Statics.gameTime > this.completionTime) {
				outerRingImage.visible = false;
				innerRingImage.visible = false;
				this.isActivated = false;
				
				// misc reset
				HUD.clearPowerupReel();
				Statics.powerupsEnabled = true;
			}
		}
	}
}