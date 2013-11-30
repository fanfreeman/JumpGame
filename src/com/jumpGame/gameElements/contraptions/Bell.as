package com.jumpGame.gameElements.contraptions
{
	import com.jumpGame.gameElements.Contraption;
	import com.jumpGame.level.Statics;
	
	import starling.core.Starling;
	import starling.display.Image;

	public class Bell extends Contraption implements IPoolable
	{
		public var numDings:uint;
		private var bellImage:Image;
		private var dx:Number;
		private var dy:Number;
		private var rotationSpeed:Number = Math.PI / 72;
		private var isTouched:Boolean = false;
		
		override public function initialize():void {
			if (bellImage == null) createArt();
			this.isTouched = false;
			this.dx = 0;
			this.dy = 0;
			this.numDings = 0;
			this.show();
			Statics.isBellActive = true;
		}
		
		protected function createArt():void
		{
			bellImage = new Image(Assets.getSprite("AtlasTexturePlatforms").getTexture("Bell0000"));
			bellImage.pivotX = Math.ceil(bellImage.width / 2); // center image on registration point
			bellImage.pivotY = Math.ceil(bellImage.height / 2);
			this.addChild(bellImage);
		}
		
		override public function update(timeDiff:Number):void {
			this.dy -= Constants.Gravity * timeDiff;
			if (this.dy < Constants.MaxHeroFallVelocity) {
				this.dy = Constants.MaxHeroFallVelocity;
			}
			
//			if (this.dy < 0) this.isTouched = false;
//			this.isTouched = false;
			
			this.gx += this.dx;
			this.gy += timeDiff * this.dy;
			this.bellImage.rotation += this.rotationSpeed;
		}
		
		public function debug(heroGy:Number):void {
			trace("bell gx: " + this.gx + " bell y from hero: " + (this.gy - heroGy));
		}
		
		public function contact(distanceFromCenter:Number, heroDy:Number):Boolean {
			if (!this.isTouched) {
				this.isTouched = true;
				if (!Sounds.sfxMuted) Sounds.sndBell.play();
				this.numDings++;
				
				this.dx = -(distanceFromCenter / 100);
				this.dy = Math.max(heroDy * 2, Constants.PowerBouncePower);
				this.rotationSpeed = -(distanceFromCenter / 200) * (Math.PI / 180);
				Starling.juggler.delayCall(resetTouchState, 0.2); // prevent continous contact with bell
				return true;
			}
			
			return false;
		}
		
		private function resetTouchState():void {
			this.isTouched = false;
		}
		
		override protected function hide():void
		{
			this.visible = false;
			Statics.isBellActive = false;
		}
	}
}