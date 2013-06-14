package com.jumpGame.gameElements
{
	import starling.events.Event;
	import starling.filters.ColorMatrixFilter;
	import starling.filters.BlurFilter;
	
	public class SeaOfFire extends GameObject
	{
		private var sofLayer1:SofLayer;
		private var sofLayer2:SofLayer;
		private var sofLayer3:SofLayer;
		private var sofLayer4:SofLayer;
		private var sofLayer5:SofLayer;
		
		public function SeaOfFire()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			this.sofLayer1 = new SofLayer();
			this.sofLayer1.parallaxDepth = 0.04;
			this.sofLayer1.setX(-Constants.StageWidth / 2); // place at bottom left of screen
			this.sofLayer1.setY(-Constants.StageHeight / 2 + 150);
			this.sofLayer1.scaleX = Constants.SofLayer1ScaleFactor;
			this.sofLayer1.scaleY = Constants.SofLayer1ScaleFactor;
			var layer1Filter:ColorMatrixFilter = new ColorMatrixFilter();
			layer1Filter.adjustHue(-0.1);
			layer1Filter.adjustBrightness(-0.1);
			this.sofLayer1.filter = layer1Filter;
			this.addChild(this.sofLayer1);
			
			this.sofLayer2 = new SofLayer();
			this.sofLayer2.parallaxDepth = 0.08;
			this.sofLayer2.setX(-Constants.StageWidth / 2); // place at bottom left of screen
			this.sofLayer2.setY(-Constants.StageHeight / 2 + 140);
			this.sofLayer2.scaleX = Constants.SofLayer2ScaleFactor;
			this.sofLayer2.scaleY = Constants.SofLayer2ScaleFactor;
			this.addChild(this.sofLayer2);
			
			this.sofLayer3 = new SofLayer();
			this.sofLayer3.parallaxDepth = 0.16;
			this.sofLayer3.setX(-Constants.StageWidth / 2); // place at bottom left of screen
			this.sofLayer3.setY(-Constants.StageHeight / 2 + 120);
			this.sofLayer3.scaleX = Constants.SofLayer3ScaleFactor;
			this.sofLayer3.scaleY = Constants.SofLayer3ScaleFactor;
//			var layer3Filter:ColorMatrixFilter = new ColorMatrixFilter();
//			layer3Filter.adjustBrightness(-0.1);
//			this.sofLayer3.filter = layer3Filter;
			this.sofLayer3.filter = new BlurFilter(0.5, 0.5);
			this.addChild(this.sofLayer3);
			
			this.sofLayer4 = new SofLayer();
			this.sofLayer4.parallaxDepth = 0.32;
			this.sofLayer4.setX(-Constants.StageWidth / 2); // place at bottom left of screen
			this.sofLayer4.setY(-Constants.StageHeight / 2 + 90);
			this.sofLayer4.scaleX = Constants.SofLayer4ScaleFactor;
			this.sofLayer4.scaleY = Constants.SofLayer4ScaleFactor;
//			var layer4Filter:ColorMatrixFilter = new ColorMatrixFilter();
//			layer4Filter.adjustBrightness(-0.2);
//			this.sofLayer4.filter = layer4Filter;
			this.sofLayer4.filter = new BlurFilter(1.0, 1.0, 1.0);
			this.addChild(this.sofLayer4);
			
			this.sofLayer5 = new SofLayer();
			this.sofLayer5.parallaxDepth = 0.64;
			this.sofLayer5.setX(-Constants.StageWidth / 2); // place at bottom left of screen
			this.sofLayer5.setY(-Constants.StageHeight / 2 + 50);
			this.sofLayer5.scaleX = Constants.SofLayer5ScaleFactor;
			this.sofLayer5.scaleY = Constants.SofLayer5ScaleFactor;
//			var layer5Filter:ColorMatrixFilter = new ColorMatrixFilter();
//			layer5Filter.adjustBrightness(-0.3);
//			this.sofLayer5.filter = layer5Filter;
			this.sofLayer5.filter = new BlurFilter(1.0, 1.0, 0.75);
			this.addChild(this.sofLayer5);
		}
		
		public function scrollHorizontal():void {
			var _speed:Number = 10;
			
			sofLayer1.x -= _speed * sofLayer1.parallaxDepth;
			if (sofLayer1.x > 0) { // sea of fire scroll right
				sofLayer1.flip();
				sofLayer1.x = -Constants.SofWidth * Constants.SofLayer1ScaleFactor;
			}
			if (sofLayer1.x < -Constants.SofWidth * Constants.SofLayer1ScaleFactor) { // sea of fire scroll left
				sofLayer1.flip();
				sofLayer1.x = 0;
			}
			
			sofLayer2.x -= _speed * sofLayer2.parallaxDepth;
			if (sofLayer2.x > 0) { // sea of fire scroll right
				sofLayer2.flip();
				sofLayer2.x = -Constants.SofWidth * Constants.SofLayer2ScaleFactor;
			}
			if (sofLayer2.x < -Constants.SofWidth * Constants.SofLayer2ScaleFactor) { // sea of fire scroll left
				sofLayer2.flip();
				sofLayer2.x = 0;
			}
			
			sofLayer3.x -= _speed * sofLayer3.parallaxDepth;
			if (sofLayer3.x > 0) { // sea of fire scroll right
				sofLayer3.flip();
				sofLayer3.x = -Constants.SofWidth * Constants.SofLayer3ScaleFactor;
			}
			if (sofLayer3.x < -Constants.SofWidth * Constants.SofLayer3ScaleFactor) { // sea of fire scroll left
				sofLayer3.flip();
				sofLayer3.x = 0;
			}
			
			sofLayer4.x -= _speed * sofLayer4.parallaxDepth;
			if (sofLayer4.x > 0) { // sea of fire scroll right
				sofLayer4.flip();
				sofLayer4.x = -Constants.SofWidth * Constants.SofLayer4ScaleFactor;
			}
			if (sofLayer4.x < -Constants.SofWidth * Constants.SofLayer4ScaleFactor) { // sea of fire scroll left
				sofLayer4.flip();
				sofLayer4.x = 0;
			}
			
			sofLayer5.x -= _speed * sofLayer5.parallaxDepth;
			if (sofLayer5.x > 0) { // sea of fire scroll right
				sofLayer5.flip();
				sofLayer5.x = -Constants.SofWidth * Constants.SofLayer5ScaleFactor;
			}
			if (sofLayer5.x < -Constants.SofWidth * Constants.SofLayer5ScaleFactor) { // sea of fire scroll left
				sofLayer5.flip();
				sofLayer5.x = 0;
			}
		}
	}
}