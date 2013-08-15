package com.jumpGame.gameElements.powerups
{
	import com.jumpGame.gameElements.Hero;
	import com.jumpGame.level.Statics;
	import com.jumpGame.ui.HUD;
	
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.Image;

	public class Expansion extends GameObject
	{
		private var hero:Hero;
		private var chainsImage:Image;
		private var propellerOffImage:Image;
		private var propellerLeftImage:Image;
		private var propellerRightImage:Image;
		private var propellerBothImage:Image;
		private var nextLaunchTime:int;
		
		public var isActivated:Boolean = false;
		private var nearCompletionTime:int;
		private var completionTime:int;
		private var completionWarned:Boolean;
		
		public function Expansion(hero:Hero)
		{
			this.hero = hero;
			this.createPowerupArt();
		}
		
		protected function createPowerupArt():void
		{
			propellerOffImage = new Image(Assets.getSprite("AtlasTexture2").getTexture("ChainPropOff0000"));
			propellerOffImage.pivotX = Math.ceil(propellerOffImage.width / 2); // center image on registration point
			propellerOffImage.pivotY = Math.ceil(propellerOffImage.height / 2);
			propellerOffImage.y = 60;
			propellerOffImage.visible = false;
			this.addChild(propellerOffImage);
			
			propellerLeftImage = new Image(Assets.getSprite("AtlasTexture2").getTexture("ChainPropLeft0000"));
			propellerLeftImage.pivotX = Math.ceil(propellerLeftImage.width / 2); // center image on registration point
			propellerLeftImage.pivotY = Math.ceil(propellerLeftImage.height / 2);
			propellerLeftImage.y = 60;
			propellerLeftImage.visible = false;
			this.addChild(propellerLeftImage);
			
			propellerRightImage = new Image(Assets.getSprite("AtlasTexture2").getTexture("ChainPropRight0000"));
			propellerRightImage.pivotX = Math.ceil(propellerRightImage.width / 2); // center image on registration point
			propellerRightImage.pivotY = Math.ceil(propellerRightImage.height / 2);
			propellerRightImage.y = 60;
			propellerRightImage.visible = false;
			this.addChild(propellerRightImage);
			
			propellerBothImage = new Image(Assets.getSprite("AtlasTexture2").getTexture("ChainPropBoth0000"));
			propellerBothImage.pivotX = Math.ceil(propellerBothImage.width / 2); // center image on registration point
			propellerBothImage.pivotY = Math.ceil(propellerBothImage.height / 2);
			propellerBothImage.y = 60;
			propellerBothImage.visible = false;
			this.addChild(propellerBothImage);
			
			chainsImage = new Image(Assets.getSprite("AtlasTexture2").getTexture("Chains0000"));
			chainsImage.pivotX = Math.ceil(chainsImage.width / 2); // center image on registration point
			chainsImage.pivotY = Math.ceil(chainsImage.height / 2);
			chainsImage.visible = false;
			chainsImage.alpha = 0;
			this.addChild(chainsImage);
		}
		
		public function activate():void {
			Sounds.sndPowerup.play();
//			this.hero.bouncePowerMultiplier = 1.3;
			chainsImage.visible = true;
			propellerOffImage.visible = true;
			Starling.juggler.tween(chainsImage, 1.0, {
				transition: Transitions.LINEAR,
				alpha: 0.999
			});
			
			// brief push upward
			this.hero.dy += 1.5;
			Statics.particleJet.start(0.1);
			
			this.isActivated = true;
			this.completionWarned = false;
			this.completionTime = Statics.gameTime + 10000; // 10 seconds
			this.nearCompletionTime = this.completionTime - Constants.PowerupWarningDuration;
			
			this.nextLaunchTime = Statics.gameTime + 1000;
		}
		
		public function update(timeDiff:Number):Boolean {
			if (!this.isActivated) return false;
			
			this.chainsImage.rotation += 0.004 * timeDiff;
			this.gx = this.hero.gx;
			this.gy = this.hero.gy;
			
			// almost time up, begin powerup reel warning
			if (!this.completionWarned && Statics.gameTime > this.nearCompletionTime) {
				HUD.completionWarning();
				this.completionWarned = true;
			}
			
			// time up, deactivate
			if (Statics.gameTime > this.completionTime) {
				// brief push upward
				this.hero.dy += 1.5;
				Statics.particleJet.start(0.1);
				
				chainsImage.visible = false;
				this.propellerOffImage.visible = false;
				this.propellerLeftImage.visible = false;
				this.propellerRightImage.visible = false;
				this.propellerBothImage.visible = false;
				
				this.deactivate();
			}
			
			if (Statics.gameTime > this.nextLaunchTime) {
				this.nextLaunchTime = Statics.gameTime + 150; // schedule next launch time
				return true;
			}
			
			return false;
		}
		
		public function deactivate():void {
//			Starling.juggler.remove(heroAnimation);
//			heroAnimation.visible = false;
			//				this.hero.gravity = Constants.Gravity;
//			this.hero.visible = true;
			this.isActivated = false;
			
			// misc reset
			HUD.clearPowerupReel();
			Statics.powerupsEnabled = true;
		}
		
		public function updatePropellers(leftArrow:Boolean, rightArrow:Boolean):void {
			this.propellerOffImage.visible = false;
			this.propellerLeftImage.visible = false;
			this.propellerRightImage.visible = false;
			this.propellerBothImage.visible = false;
			
			if (leftArrow && rightArrow) {
				this.propellerBothImage.visible = true;
			}
			else if (leftArrow) {
				this.propellerRightImage.visible = true;
			}
			else if (rightArrow) {
				this.propellerLeftImage.visible = true;
			}
			else {
				this.propellerOffImage.visible = true;
			}
//			if (leftArrow) {
//				this.propellerRightImage.visible = true;
//			}
//			else if (rightArrow) {
//				this.propellerLeftImage.visible = true;
//			}
//			else {
//				this.propellerBothImage.visible = true;
//			}
		}
	}
}