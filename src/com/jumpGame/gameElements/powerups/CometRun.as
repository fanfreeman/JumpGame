package com.jumpGame.gameElements.powerups
{
	import com.jumpGame.gameElements.Hero;
	import com.jumpGame.level.Statics;

	public class CometRun extends GameObject
	{
		public var isActivated:Boolean;
		private var completionTime:int;
		private var hero:Hero;
		
		public function CometRun(hero:Hero)
		{
			this.hero = hero;
			this.isActivated = false;
		}
		
		public function activate():void {
			if (!Sounds.sfxMuted) Sounds.sndComet.play();
			
			Statics.particleComet.start();
			Statics.particleWind.start();
			
			this.hero.showSuper(); // show hero super animation
			
//			Statics.powerupsEnabled = false;
			this.isActivated = true;
			this.completionTime = Statics.gameTime + 3000 + Statics.rankComet * 500; // duration
		}
		
		public function update(timeDiff:Number):void {
			if (!this.isActivated) return;
			
			this.gx = this.hero.gx;
			this.gy = this.hero.gy - 20;
			
			this.hero.dy = 2.5;
			Statics.cameraShake = 10;
			
			// time up, deactivate
			if (Statics.gameTime > this.completionTime) {
				this.hero.dy = 3.0;
				this.hero.hideSuper(); // hide hero super animation
				Statics.particleWind.stop();
				Statics.particleComet.stop();
				Statics.particleComet.start(1);
				this.isActivated = false;
				Statics.powerupsEnabled = true;
			}
		}
	}
}