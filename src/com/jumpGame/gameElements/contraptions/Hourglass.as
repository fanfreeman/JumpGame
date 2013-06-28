package com.jumpGame.gameElements.contraptions
{
	import com.jumpGame.gameElements.Contraption;
	import com.jumpGame.level.Statics;
	import com.jumpGame.ui.HUD;
	
	import starling.display.Image;

	public class Hourglass extends Contraption implements IPoolable
	{
		private var hourglassImage:Image = null;
		private var touched:Boolean = false;
		
		private var _destroyed:Boolean = true; // required by interface
		
		override public function initialize():void {
			if (hourglassImage == null) createArt();
			this.show();
			this.touched = false;
		}
		
		protected function createArt():void
		{
			hourglassImage = new Image(Assets.getSprite("AtlasTexturePlatforms").getTexture("Hourglass"));
			hourglassImage.pivotX = Math.ceil(hourglassImage.width / 2); // center art on registration point
			hourglassImage.pivotY = Math.ceil(hourglassImage.height / 2);
			this.addChild(hourglassImage);
		}
		
		override public function update(timeDiff:Number):void {
			this.gy = this.gy;
			this.hourglassImage.rotation += Math.PI / 36;
		}
		
		public function contact():void {
			if (!this.touched) {
				this.touched = true;
				this.visible = false;
				Sounds.sndGotHourglass.play();
				Statics.bonusTime += 5;
				HUD.showMessage("Bonus Time!");
			}
		}
	}
}