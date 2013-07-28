package com.jumpGame.gameElements.powerups
{
	import com.jumpGame.level.Statics;
	import com.jumpGame.ui.HUD;

	public class Extender extends GameObject
	{
		public var isActivated:Boolean = false;
		private var nearCompletionTime:int; // star flashing powerup reel icon at this time
		private var completionTime:int;
		private var completionWarned:Boolean;
		
		public function activate():void {
			Sounds.sndPowerup.play();
			
			this.isActivated = true;
			this.completionWarned = false;
			this.completionTime = Statics.gameTime + 10000; // 10 seconds
			this.nearCompletionTime = this.completionTime - Constants.PowerupWarningDuration;
		}
		
		public function update(timeDiff:Number):void {
			if (!this.isActivated) return;
			
			// almost time up, begin powerup reel warning
			if (!this.completionWarned && Statics.gameTime > this.nearCompletionTime) {
				HUD.completionWarning();
				this.completionWarned = true;
			}
			
			// time up, deactivate
			if (Statics.gameTime > this.completionTime) {
				this.isActivated = false;
				
				// misc reset
				HUD.clearPowerupReel();
				Statics.powerupsEnabled = true;
			}
		}
	}
}