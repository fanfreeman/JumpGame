package com.jumpGame.gameElements.contraptions
{
	import com.jumpGame.gameElements.Contraption;
	import com.jumpGame.ui.HUD;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	
	public class PowerupBox extends Contraption
	{
		protected var boxAnimation:MovieClip = null;
		private var blastAnimation:MovieClip;
		public var touched:Boolean = false;
		
		override public function initialize():void {
			if (this.boxAnimation == null) createArt();
			this.boxAnimation.visible = true;
			Starling.juggler.add(this.boxAnimation);
			this.show();
			this.touched = false;
		}
		
		protected function createArt():void {
			blastAnimation = new MovieClip(Statics.assets.getTextures("Blast"), 30);
			blastAnimation.pivotX = Math.ceil(blastAnimation.texture.width  / 2); // center art on registration point
			blastAnimation.pivotY = Math.ceil(blastAnimation.texture.height / 2);
			blastAnimation.visible = false;
			blastAnimation.stop();
			blastAnimation.loop = false;
			this.addChild(blastAnimation);
		}
		
		public function contact(hud:HUD):void {
			if (!this.touched) {
				this.touched = true;
				this.boxAnimation.visible = false;
				if (!Sounds.sfxMuted) Statics.assets.playSound("SND_GOT_HOURGLASS");
				blastAnimation.visible = true;
				Starling.juggler.add(this.blastAnimation);
				blastAnimation.play();
//				HUD.showMessage("Mystery Box!", 2000, 1);
//				hud.spinPowerupReel();
				hud.activateRandomPowerup();
				Statics.powerupsEnabled = false;
			}
		}
		
		public function blowUpWithoutContact():void {
			if (!this.touched) {
				this.touched = true;
				this.boxAnimation.visible = false;
				blastAnimation.visible = true;
				Starling.juggler.add(this.blastAnimation);
				blastAnimation.play();
			}
		}
		
		override protected function hide():void
		{
			Starling.juggler.remove(this.boxAnimation);
			blastAnimation.visible = false;
			blastAnimation.stop();
			Starling.juggler.remove(this.blastAnimation);
			this.visible = false;
		}
	}
}