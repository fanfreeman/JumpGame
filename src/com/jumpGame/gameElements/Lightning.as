package com.jumpGame.gameElements
{
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	
	public class Lightning extends Sprite
	{
		private var baseLength:Number;
		private var lightningAnimation:MovieClip;
		
		public function Lightning()
		{
			super();
			
			this.touchable = false;
			lightningAnimation  = new MovieClip(Assets.getSprite("AtlasTexture2").getTextures("Lightning"), 30);
			lightningAnimation.pivotX = Math.ceil(lightningAnimation.width  / 2); // center art on registration point
			lightningAnimation.pivotY = Math.ceil(lightningAnimation.height / 2);
			this.addChild(lightningAnimation);
			
			this.baseLength = lightningAnimation.width;
		}
		
		public function updatePosition(startX:Number, startY:Number, endX:Number, endY:Number):void {
			// scale
			var targetLength:Number = Statics.distance(startX, startY, endX, endY);
			var scaleFactor:Number = (targetLength / baseLength);
			this.scaleX = scaleFactor;
			this.scaleY = scaleFactor;
			
			// angle
			var angle:Number = Statics.vectorAngle(startX, startY, endX, endY);
			this.rotation = angle;
			
			// position
			var midPointX:Number = (startX + endX) / 2;
			var midPointY:Number = (startY + endY) / 2;
			this.x = midPointX;
			this.y = midPointY;
		}
		
		public function show():void {
			if (!this.visible) {
				starling.core.Starling.juggler.add(lightningAnimation);
				this.visible = true;
			}
		}
		
		public function hide():void {
			if (this.visible) {
				starling.core.Starling.juggler.remove(lightningAnimation);
				this.visible = false;
			}
		}
	}
}