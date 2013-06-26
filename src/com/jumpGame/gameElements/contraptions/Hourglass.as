package com.jumpGame.gameElements.contraptions
{
	import com.jumpGame.level.Statics;
	import com.jumpGame.ui.HUD;
	
	import starling.display.Image;

	public class Hourglass extends GameObject implements IPoolable
	{
		private var hourglassImage:Image = null;
		private var touched:Boolean = false;
		
		private var _destroyed:Boolean = true; // required by interface
		
		public function initialize():void {
			if (hourglassImage == null) createHourglassArt();
			this.show();
			this.touched = false;
		}
		
		protected function createHourglassArt():void
		{
			hourglassImage = new Image(Assets.getSprite("AtlasTexturePlatforms").getTexture("Hourglass"));
			hourglassImage.pivotX = Math.ceil(hourglassImage.width / 2); // center art on registration point
			hourglassImage.pivotY = Math.ceil(hourglassImage.height / 2);
			this.addChild(hourglassImage);
		}
		
		public function update(timeDiff:Number):void {
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
		
		/**
		 * hide artwork before returning to pool
		 */
		private function hide():void
		{
			this.visible = false;
		}
		
		/**
		 * show artwork after retrieved from pool
		 */
		private function show():void
		{
			this.visible = true;
		}
		
		// methods required by interface
		
		public function get destroyed():Boolean
		{
			return _destroyed;
		}
		
		public function renew():void
		{
			if (!_destroyed) { return; }
			_destroyed = false;
		}
		
		public function destroy():void
		{
			if (_destroyed) { return; }
			_destroyed = true;
			this.hide();
		}
	}
}