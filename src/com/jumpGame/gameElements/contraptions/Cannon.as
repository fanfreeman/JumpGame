package com.jumpGame.gameElements.contraptions
{
	import com.jumpGame.gameElements.Contraption;
	
	import starling.display.Image;
	
	public class Cannon extends Contraption implements IPoolable
	{
		public var heroGy:Number;
		public var sofHeight:Number;
		protected var cannonOffImage:Image;
		protected var cannonOnImage:Image;
		private var dy:Number;
		private var d2y:Number;
		private var dyTemp:Number;
		private var thrustersOn:Boolean;
		private var nextFireTime:int;
		private var isTouched:Boolean = false;
		private var rotationSpeed:Number;
		
		override public function initialize():void {
			// create art
//			if (cannonOffImage == null || cannonOnImage == null) {
//				createArt();
//			}
			
			// reset properties
			this.isTouched = false;
			this.rotationSpeed = 0;
			this.rotation = 0;
			this.dy = 0;
			this.thrustersOn = false;
			this.nextFireTime = Statics.gameTime + 1000;
			
			this.show();
			this.markActivated();
		}
		
		protected function markActivated():void {
			Statics.isRightCannonActive = true;
		}
		
		override protected function createArt():void
		{
			cannonOffImage = new Image(Statics.assets.getTexture("CannonOff0000"));
			cannonOffImage.pivotX = Math.ceil(cannonOffImage.width / 2); // center x
			cannonOffImage.pivotY = Math.ceil(cannonOffImage.height / 2); // center y
			this.addChild(cannonOffImage);
			
			cannonOnImage = new Image(Statics.assets.getTexture("CannonOn0000"));
			cannonOnImage.pivotX = Math.ceil(cannonOnImage.width / 2); // center x
			cannonOnImage.pivotY = Math.ceil(cannonOnImage.height / 2); // center y
			cannonOnImage.visible = false;
			this.addChild(cannonOnImage);
		}
		
		override public function update(timeDiff:Number):void {
			// turn on thrusters if cannon drops too low (below hero or too close to sof)
			if (this.gy < this.heroGy - 200 || this.gy < this.sofHeight + 300) {
				if (!this.thrustersOn) {
					// turn on thrusters
					this.turnOnThrusters();
				}
			}
			
			// when thrusters are on
			if (!this.isTouched && this.thrustersOn) {
				if (this.dy > 1.0) { // turn off thrusters
					this.turnOffThrusters();
				} else { // update acceleration
					this.d2y += 0.01 * timeDiff;
					this.dy = this.d2y;
				}
			}
			
			this.dy -= Constants.Gravity * timeDiff;
			this.gy += this.dy * timeDiff;
			this.rotation += this.rotationSpeed;
		}
		
		public function checkFiring():uint {
			// check if should fire
			if (Statics.gameTime > this.nextFireTime) {
				this.nextFireTime = Statics.gameTime + 400; // firing interval
				return 1; // fire
			}
			
			return 0;
		}
		
		private function turnOnThrusters():void {
//			trace("Turning on thrusters!");
			cannonOnImage.visible = true;
			cannonOffImage.visible = false;
			this.thrustersOn = true;
			this.d2y = this.dy / 2;
		}
		
		private function turnOffThrusters():void {
//			trace("Turning off thrusters!");
			cannonOnImage.visible = false;
			cannonOffImage.visible = true;
			this.thrustersOn = false;
		}
		
		override protected function hide():void
		{
			this.visible = false;
			Statics.isRightCannonActive = false;
		}
		
		// cannon crashes upon contact
		public function contact():Boolean {
			if (!this.isTouched) {
				this.isTouched = true;
				
				if (!Sounds.sfxMuted) Statics.assets.playSound("SND_CRASH");
				this.rotationSpeed = Math.PI / 18;
				return true;
			}
			
			return false;
		}
	}
}