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
		}
		
		public function activate():void {
			Statics.particleComet.start();
			Statics.particleWind.start();
			
			Statics.powerupsEnabled = false;
			this.isActivated = true;
			this.completionTime = Statics.gameTime + 5000; // lasts 5 seconds
		}
		
		public function update(timeDiff:Number):void {
			if (!this.isActivated) return;
			
			this.hero.dy = 2.5;
			Statics.cameraShake = 10;
			
			// time up, deactivate
			if (Statics.gameTime > this.completionTime) {
				this.hero.dy = 3.0;
				Statics.particleWind.stop();
				Statics.particleComet.stop();
				Statics.particleComet.start(0.5);
				this.isActivated = false;
				Statics.powerupsEnabled = true;
			}
		}
	}
}