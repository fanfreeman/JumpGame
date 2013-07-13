package com.jumpGame.gameElements.contraptions
{
	import com.jumpGame.gameElements.Contraption;
	import com.jumpGame.level.Statics;
	import com.jumpGame.ui.HUD;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	
	public class PowerupBox extends Contraption
	{
		protected var boxAnimation:MovieClip = null;
		private var touched:Boolean = false;
		
		private var _destroyed:Boolean = true; // required by interface
		
		override public function initialize():void {
			if (this.boxAnimation == null) createArt();
			this.show();
			this.touched = false;
		}
		
		protected function createArt():void {}
		
		public function contact(hud:HUD):void {
			if (!this.touched) {
				this.touched = true;
				this.visible = false;
				Sounds.sndGotHourglass.play();
				HUD.showMessage("Mystery Box!");
				hud.spinPowerupReel();
				Statics.powerupsEnabled = false;
			}
		}
		
		override protected function hide():void
		{
			if (this.boxAnimation != null) Starling.juggler.remove(this.boxAnimation);
			this.visible = false;
		}
	}
}