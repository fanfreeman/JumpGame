package com.jumpGame.gameElements.powerups
{
	import com.jumpGame.level.Statics;
	import com.jumpGame.ui.HUD;

	public class Pyromancy extends GameObject
	{
		public var isActivated:Boolean = false;
		private var completionWarned:Boolean;
		
		private var nextLaunchTime:int;
		private var numLaunches:uint;
		
		public function activate():void {
			if (!Sounds.sfxMuted) Sounds.sndPowerup.play();
			
			this.isActivated = true;
			this.completionWarned = false;
			
			this.numLaunches = 0;
			this.nextLaunchTime = Statics.gameTime + 1000;
		}
		
		public function update(timeDiff:Number):Boolean {
			if (!this.isActivated) return false;
			
			if (Statics.gameTime > this.nextLaunchTime) {
				// laucnh
				this.numLaunches++;
				if (this.numLaunches >= 20) {
					// deactivate
					this.isActivated = false;
					
					// misc reset
					HUD.clearPowerupReel();
					Statics.powerupsEnabled = true;
				}
				
				this.nextLaunchTime = Statics.gameTime + 150; // schedule next launch time
				return true;
			}
			return false;
		}
	}
}