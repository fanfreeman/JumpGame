package com.jumpGame.gameElements
{
	
	import starling.animation.IAnimatable;
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class BgStar extends Sprite implements IAnimatable
	{
		private var velocity:Number;
		private var windDx:Number;
		
		public function BgStar()
		{
			super();
			var starImage:Image = new Image(Assets.getSprite("AtlasTexture3").getTexture("Star0000"));
//			var starImage:Image = new Image(Assets.getSprite("AtlasTexturePlatforms").getTexture("Snowflake0000"));
//			starImage.pivotX = Math.ceil(starImage.width  / 2); // center art on registration point
//			starImage.pivotY = Math.ceil(starImage.height / 2);
			this.addChild(starImage);
		}
		
		public function initialize(forMenu:Boolean = true):void {
			this.x = Math.random() * Statics.stageWidth;
			this.y = Math.random() * Statics.stageHeight;
			
			var dice:Number = Math.random();
			
			// bof snow
			if (forMenu) {
				if (dice > 0.9) { // super fast moving stars
					this.velocity = Math.random() * 1.99 + 0.01;
					this.scaleX = this.velocity * 2;
					this.scaleY = this.velocity * 2;
				}
				else if (dice > 0.6) { // fast moving stars
					this.velocity = Math.random() * 0.99 + 0.01;
					this.scaleX = this.velocity;
					this.scaleY = this.velocity;
				}
				else if (dice > 0.3) { // medium moving stars
					this.velocity = Math.random() * 0.49 + 0.01;
					this.scaleX = this.velocity;
					this.scaleY = this.velocity;
				}
				else { // slow moving stars
					this.velocity = Math.random() * 0.19 + 0.01;
					this.scaleX = this.velocity;
					this.scaleY = this.velocity;
				}
			}
			// eof snow
			
			// bof stars
			else {
				if (dice > 0.7) { // medium moving stars
					this.velocity = Math.random() * 0.49 + 0.01;
					this.scaleX = (0.2 - this.velocity / 5) * 5;
					this.scaleY = (0.2 - this.velocity / 5) * 5;
				}
				else { // slow moving stars
					this.velocity = Math.random() * 0.19 + 0.01;
					this.scaleX = (0.2 - this.velocity / 2) * 5;
					this.scaleY = (0.2 - this.velocity / 2) * 5;
				}
			}
			// eof stars
			
			this.visible = true;
		}
		
//		public function update(timeDiff:int, leftKeyDown:Boolean = false, rightKeyDown:Boolean = false):void {
		public function update(timeDiff:int, heroDx:Number):void {
			this.x -= heroDx * this.velocity * timeDiff * 2;
			if (this.x > Statics.stageWidth) {
				this.x = -this.width;
			}
			else if (this.x < -this.width) {
				this.x = Statics.stageWidth;
			}
//			if (leftKeyDown) {
//				this.x += this.velocity * timeDiff;
//				if (this.x > Statics.stageWidth) {
//					this.x = -this.width;
//				}
//			}
//			if (rightKeyDown) {
//				this.x -= this.velocity * timeDiff;
//				if (this.x < -this.width) {
//					this.x = Statics.stageWidth;
//				}
//			}

//			this.y -= this.velocity * timeDiff;
//			if (this.y < -this.height) {
//				this.y = Statics.stageHeight;
//			}
			this.y += this.velocity * timeDiff * 0.3;
			if (this.y > Statics.stageHeight) {
				this.y = -this.height;
			}
		}
		
		public function advanceTime(time:Number):void {
//			trace("time: " + time);
//			this.x += this.velocity * time * 1000;
//			if (this.x > Statics.stageWidth) {
//				this.x = -this.width;
//			}
//			else if (this.x < -this.width) {
//				this.x = Statics.stageWidth;
//			}
//			
//			this.y += this.velocity * time * 0.3 * 1000;
//			if (this.y > Statics.stageHeight) {
//				this.y = -this.height;
//			}
			this.update(int(time * 1000), this.windDx);
		}
		
		public function updateWindDx(windDx:Number):void {
			this.windDx = windDx;
		}
	}
}