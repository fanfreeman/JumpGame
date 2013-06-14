package com.jumpGame.gameElements {
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Background extends Sprite {
		
		private var type:uint; // background or foreground
		private var bgLayer1:BgLayer;
		private var bgLayer2:BgLayer;
		private var bgLayer4:BgLayer;
		
		public function Background(type:uint) {
			super();
			this.type = type;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			if (this.type == Constants.Background) {
				// add layer 1: furthest bg
				this.bgLayer1 = new BgLayer(1);
				this.bgLayer1.parallaxDepth = 0.1;
				this.bgLayer1.setX(-Constants.StageWidth / 2); // place at bottom left of screen
				this.bgLayer1.setY(-Constants.StageHeight / 2);
				this.addChild(this.bgLayer1);
				
				// add layer 2: right behind player
				this.bgLayer2 = new BgLayer(2);
				this.bgLayer2.parallaxDepth = 0.5;
				this.bgLayer2.setX(-Constants.StageWidth / 2); // place at top left of screen
				this.bgLayer2.setY(Constants.StageHeight / 2);
				this.addChild(this.bgLayer2);
			}
			else if (this.type == Constants.Foreground) {
				// there's no bg layer 3 because layer 3 is player's layer
				// add layer 4: right in front of player
				this.bgLayer4 = new BgLayer(4);
				this.bgLayer4.parallaxDepth = 1.5;
				this.bgLayer4.setX(-Constants.StageWidth / 2); // place at top left of screen
				this.bgLayer4.setY(Constants.StageHeight / 2);
				this.addChild(this.bgLayer4);
			}
		}
		
		public function scroll(distance:Number):void {
			if (this.type == Constants.Background) {
				// scroll bg layers
				this.bgLayer1.setY(this.bgLayer1.my - distance * this.bgLayer1.parallaxDepth);
				this.bgLayer2.setY(this.bgLayer2.my - distance * this.bgLayer2.parallaxDepth);
				
				// cycle bg layer 2
				if (this.bgLayer2.my < -Constants.StageHeight * 1.5) {
					this.bgLayer2.cycle();
					this.bgLayer2.setY(Constants.StageHeight * 0.5);
				} else if (this.bgLayer2.my > Constants.StageHeight * 0.5) {
					this.bgLayer2.cycle();
					this.bgLayer2.setY(-Constants.StageHeight * 1.5);
				}
			}
			else if (this.type == Constants.Foreground) {
				// scroll fg layer
				this.bgLayer4.setY(this.bgLayer4.my - distance * this.bgLayer4.parallaxDepth);
				
				// cycle fg layer 4
				if (this.bgLayer4.my < -Constants.StageHeight * 1.5) {
					this.bgLayer4.cycle();
					this.bgLayer4.setY(Constants.StageHeight / 2);
				} else if (this.bgLayer4.my > Constants.StageHeight * 0.5) {
					this.bgLayer4.cycle();
					this.bgLayer4.setY(-Constants.StageHeight * 1.5);
				}
			}
		}
	}
}