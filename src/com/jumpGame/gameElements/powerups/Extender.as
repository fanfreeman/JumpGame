package com.jumpGame.gameElements.powerups
{
	import com.jumpGame.ui.HUD;

	public class Extender extends GameObject
	{
		private var hud:HUD;
		public var isActivated:Boolean = false;
		private var nearCompletionTime:int; // star flashing powerup reel icon at this time
		private var completionTime:int;
		private var completionWarned:Boolean;
		
		public function Extender(hud:HUD)
		{
			this.hud = hud;
		}
		
		public function activate():void {
			if (!Sounds.sfxMuted) Statics.assets.playSound("SND_POWERUP");
			
			this.isActivated = true;
			this.completionWarned = false;
			this.completionTime = Statics.gameTime + 5000 + Statics.rankDuplication * 1000; // duration
//			trace("duplication duration: " + (5000 + Statics.rankDuplication * 1000));
			this.nearCompletionTime = this.completionTime - Constants.PowerupWarningDuration;
		}
		
		public function update(timeDiff:Number):void {
			if (!this.isActivated) return;
			
			// almost time up, begin powerup reel warning
			if (!this.completionWarned && Statics.gameTime > this.nearCompletionTime) {
				hud.completionWarning();
				this.completionWarned = true;
			}
			
			// time up, deactivate
			if (Statics.gameTime > this.completionTime) {
				this.isActivated = false;
				
				// misc reset
				hud.clearPowerupReel();
				Statics.powerupsEnabled = true;
			}
		}
	}
}