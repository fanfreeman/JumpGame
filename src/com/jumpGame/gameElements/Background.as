package com.jumpGame.gameElements {
	import com.jumpGame.level.Statics;
	
	import starling.display.BlendMode;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Background extends Sprite {
		// sea of fire properties
		public var sofHeight:Number = -600;
		private var sofSpeed:Number = 0.1;
		
		private var type:uint; // background or foreground
		
		// images of bg layer 0
		private var layer0Image0:GameObject;
		private var layer0Image1:GameObject;
		private var layer0Image2:GameObject;
		
		// other decorative layers
		private var bgLayer1:BgLayer; // bg
		private var bgLayer2:BgLayer; // bg
		private var bgLayer4:BgLayer; // fg
		
		// sea of fire layers (waves)
		private var sofLayer1:SofLayer; // bg
		private var sofLayer2:SofLayer; // bg
		private var sofLayer3:SofLayer; // fg
		private var sofLayer4:SofLayer; // fg
		private var sofLayer5:SofLayer; // fg
		public var sofQuad:Quad; // fg
		
		public function Background(type:uint) {
			super();
			this.type = type;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			if (this.type == Constants.Background) {
				// bof layer 0 images
				layer0Image0 = new GameObject();
				var image0:Image = new Image(Assets.getTexture("BgLayer0Ground"));
//				var image0:Image = new Image(Assets.getSprite("AtlasTexture3").getTexture("Layer0Ground0000"));
				layer0Image0.addChild(image0);
				layer0Image0.blendMode = BlendMode.NONE;
				layer0Image0.pivotX = layer0Image0.width / 2;
				layer0Image0.pivotY = layer0Image0.height;
				layer0Image0.gx = 0;
				layer0Image0.gy = int(-Constants.StageHeight / 2);
				this.addChild(layer0Image0);
				
				layer0Image1 = new GameObject();
				var image1:Image = new Image(Assets.getTexture("BgLayer0Sky"));
//				var image1:Image = new Image(Assets.getSprite("AtlasTexture3").getTexture("Layer0Sky0000"));
				layer0Image1.addChild(image1);
				layer0Image1.blendMode = BlendMode.NONE;
				layer0Image1.pivotX = layer0Image1.width / 2;
				layer0Image1.pivotY = layer0Image1.height;
				layer0Image1.gx = 0;
				layer0Image1.gy = int(-Constants.StageHeight / 2 + layer0Image0.height);
				this.addChild(layer0Image1);
				
				layer0Image2 = new GameObject();
				var image2:Image = new Image(Assets.getTexture("BgLayer0Sky"));
//				var image2:Image = new Image(Assets.getSprite("AtlasTexture3").getTexture("Layer0Sky0000"));
				layer0Image2.addChild(image2);
				layer0Image2.blendMode = BlendMode.NONE;
				layer0Image2.pivotX = layer0Image2.width / 2;
				layer0Image2.pivotY = layer0Image2.height;
				layer0Image2.gx = 0;
				layer0Image2.gy = -Constants.StageHeight / 2 + layer0Image0.height + layer0Image1.height;
				this.addChild(layer0Image2);
				// eof layer 0 images
				
				// add sea of fire layer 1
				this.sofLayer1 = new SofLayer(2);
				this.sofLayer1.parallaxDepth = 0.04;
				this.sofLayer1.gx = 0;
				this.sofLayer1.gy = this.sofHeight + Constants.SofLayer1HeightOffset;
				this.sofLayer1.scaleX = Constants.SofLayer1ScaleFactor;
				this.sofLayer1.scaleY = Constants.SofLayer1ScaleFactor;
				this.addChild(this.sofLayer1);
				
				// add bg layer 1: moon
				this.bgLayer1 = new BgLayer(1);
				this.bgLayer1.parallaxDepth = Constants.BgLayer1ParallaxDepth;
				this.bgLayer1.gx = -Constants.StageWidth / 2; // place at top left of screen
				this.bgLayer1.gy = Constants.StageHeight / 2;
				this.addChild(this.bgLayer1);
				
				// add layer 2: right behind player
				this.bgLayer2 = new BgLayer(2);
				this.bgLayer2.parallaxDepth = Constants.BgLayer2ParallaxDepth;
				this.bgLayer2.gx = -Constants.StageWidth / 2; // place at top left of screen
				this.bgLayer2.gy = Constants.StageHeight / 2;
				this.addChild(this.bgLayer2);
				
				// add sea of fire layer 2
				this.sofLayer2 = new SofLayer(1);
				this.sofLayer2.parallaxDepth = 0.08;
				this.sofLayer2.gx = 0;
				this.sofLayer2.gy = this.sofHeight + Constants.SofLayer2HeightOffset;
				this.sofLayer2.scaleX = Constants.SofLayer2ScaleFactor;
				this.sofLayer2.scaleY = Constants.SofLayer2ScaleFactor;
				this.addChild(this.sofLayer2);
				
				if (Constants.SofEnabled == false) {
					this.sofLayer1.visible = false;
					this.sofLayer2.visible = false;
				}
			}
			else if (this.type == Constants.Foreground) {
				// add sea of fire layers 3, 4: further than fg decorative elements
				this.sofLayer3 = new SofLayer(0);
				this.sofLayer3.parallaxDepth = 0.16;
				this.sofLayer3.gx = 0;
				this.sofLayer3.gy = this.sofHeight + Constants.SofLayer3HeightOffset;
				this.sofLayer3.scaleX = Constants.SofLayer3ScaleFactor;
				this.sofLayer3.scaleY = Constants.SofLayer3ScaleFactor;
				this.addChild(this.sofLayer3);
				
				this.sofLayer4 = new SofLayer(1);
				this.sofLayer4.parallaxDepth = 0.32;
				this.sofLayer4.gx = 0;
				this.sofLayer4.gy = this.sofHeight + Constants.SofLayer4HeightOffset;
				this.sofLayer4.scaleX = Constants.SofLayer4ScaleFactor;
				this.sofLayer4.scaleY = Constants.SofLayer4ScaleFactor;
				this.addChild(this.sofLayer4);
				
				// there's no bg layer 3 because layer 3 is player's layer
				// add layer 4: right in front of player
				this.bgLayer4 = new BgLayer(4);
				this.bgLayer4.parallaxDepth = Constants.BgLayer4ParallaxDepth;
				this.bgLayer4.gx = -Constants.StageWidth / 2; // place at top left of screen
				this.bgLayer4.gy = Constants.StageHeight / 2;
				this.addChild(this.bgLayer4);
				
				// add sea of fire layer 5: closes to player
				this.sofLayer5 = new SofLayer(2);
				this.sofLayer5.parallaxDepth = 0.64;
				this.sofLayer5.gx = 0;
				this.sofLayer5.gy = this.sofHeight + Constants.SofLayer5HeightOffset;
				this.sofLayer5.scaleX = Constants.SofLayer5ScaleFactor;
				this.sofLayer5.scaleY = Constants.SofLayer5ScaleFactor;
				this.addChild(this.sofLayer5);
				
				// add sea of fire endless quad
				this.sofQuad = new Quad(Constants.StageWidth, 10000, 0xdb3a00);
				//this.sofQuad.pivotY = this.sofQuad.height;
				this.sofQuad.x = 0;
				this.sofQuad.y = this.sofLayer5.y + Constants.SofQuadHeightOffset;
				addChild(this.sofQuad);
				
				if (Constants.SofEnabled == false) {
					this.sofLayer3.visible = false;
					this.sofLayer4.visible = false;
					this.sofLayer5.visible = false;
					this.sofQuad.visible = false;
				}
			}
			
//			//testing
//			if (this.type == Constants.Background) {
//				this.sofLayer1.visible = false;
//				this.sofLayer2.visible = false;
//			} else if (this.type == Constants.Foreground) {
//				this.sofLayer4.visible = false;
//				this.sofLayer5.visible = false;
//			}
		} // eof onAddedToStage()
		
		// scroll bg and fg decorative elements as hero moves
		// @param distance = distance hero moved up
		public function scroll(timeDiff:int):void {
			if (this.type == Constants.Background) {
				// scroll bg layer 0
				this.layer0Image1.gy += Camera.dy * (1.0 - Constants.BgLayer0ParallaxDepth);
				this.layer0Image2.gy += Camera.dy * (1.0 - Constants.BgLayer0ParallaxDepth);
				
				// scroll / hide ground after it scrolls out
				if (this.layer0Image0.visible) {
					this.layer0Image0.gy += Camera.dy * (1.0 - Constants.BgLayer0ParallaxDepth);
					// scroll it
					if (this.layer0Image0.gy < -Constants.StageHeight / 2 - this.layer0Image0.height) {
						this.layer0Image0.visible = false;
					}
				}
				
				// move sky image to top after it scrolls out
				if (this.layer0Image1.gy < Camera.gy - Constants.StageHeight / 2 - this.layer0Image1.height) {
					this.layer0Image1.gy = this.layer0Image2.gy + this.layer0Image2.height;
				}
				if (this.layer0Image2.gy < Camera.gy - Constants.StageHeight / 2 - this.layer0Image2.height) {
					this.layer0Image2.gy = this.layer0Image1.gy + this.layer0Image1.height;
				}
				
				// scroll bg layer 1
				this.bgLayer1.gy += Camera.dy * (1.0 - this.bgLayer1.parallaxDepth);
				
				// scroll bg layer 2
				this.bgLayer2.gy += Camera.dy * (1.0 - this.bgLayer2.parallaxDepth);
				
				// update bg layer 1 (moon and pirate ship)
				this.bgLayer1.update(timeDiff);
				
				// cycle bg layer 1
				if (this.bgLayer1.gy < Camera.gy - Constants.StageHeight * 1.5) {
					this.bgLayer1.cycle();
					this.bgLayer1.gy = Camera.gy + Constants.StageHeight * 1.5;
				} else if (this.bgLayer1.gy > Camera.gy + Constants.StageHeight * 1.5) {
					this.bgLayer1.cycle();
					this.bgLayer1.gy = Camera.gy - Constants.StageHeight * 1.5;
				}
				
				// cycle bg layer 2
				if (this.bgLayer2.gy < Camera.gy - Constants.StageHeight * 1.5) {
					this.bgLayer2.cycle();
					this.bgLayer2.gy = Camera.gy + Constants.StageHeight * 0.5;
				} else if (this.bgLayer2.gy > Camera.gy + Constants.StageHeight * 0.5) {
					this.bgLayer2.cycle();
					this.bgLayer2.gy = Camera.gy - Constants.StageHeight * 1.5;
				}
			}
			else if (this.type == Constants.Foreground) {
				// scroll fg layer 4
				this.bgLayer4.gy += Camera.dy * (1.0 - this.bgLayer4.parallaxDepth);
				
				// cycle fg layer 4
				if (this.bgLayer4.gy < Camera.gy - Constants.StageHeight * 1.5) {
					this.bgLayer4.cycle();
					this.bgLayer4.gy = Camera.gy + Constants.StageHeight * 0.5;
				} else if (this.bgLayer4.gy > Camera.gy + Constants.StageHeight * 0.5) {
					this.bgLayer4.cycle();
					this.bgLayer4.gy = Camera.gy - Constants.StageHeight * 1.5;
				}
			}
		}
		
		// scroll sea of fire vertically according to time elapsed
		public function scrollSofVertical(timeDiff:int, heroGy:Number):void {
			// adjust sof height property
			this.sofHeight += timeDiff * this.sofSpeed;
			
			// adjust sea of fire so it keeps up with player
			if (Statics.gameMode == Constants.ModeBonus) {
				if ((heroGy - this.sofHeight) > 300) {
					this.sofHeight = heroGy - 300;
				}
			} else {
				if ((heroGy - this.sofHeight) > Constants.StageHeight) {
					this.sofHeight = heroGy - Constants.StageHeight;
				}
			}
			
			// move all sof layers vertically according to sof height property
			if (this.type == Constants.Background) { // scroll bg sof layers
				this.sofLayer1.gy = this.sofHeight + Constants.SofLayer1HeightOffset;
				this.sofLayer2.gy = this.sofHeight + Constants.SofLayer2HeightOffset;
			}
			else if (this.type == Constants.Foreground) { // scroll fg sof layers
				this.sofLayer3.gy = this.sofHeight + Constants.SofLayer3HeightOffset;
				this.sofLayer4.gy = this.sofHeight + Constants.SofLayer4HeightOffset;
				this.sofLayer5.gy = this.sofHeight + Constants.SofLayer5HeightOffset;
				this.sofQuad.y = this.sofLayer5.y + Constants.SofQuadHeightOffset;
			}
		}
		
		// scroll sea of fire waves horizontally
		public function scrollSofHorizontal():void {
			var _speed:Number = 10;
			
			if (this.type == Constants.Background) { // scroll bg sof layers
				sofLayer1.gx -= _speed * sofLayer1.parallaxDepth;
//				if (sofLayer1.x > 0) { // sea of fire scroll right
//					sofLayer1.flip();
//					sofLayer1.x = -Constants.SofWidth * Constants.SofLayer1ScaleFactor;
//				}
				if (sofLayer1.gx < 0 - Constants.SofWidth * Constants.SofLayer1ScaleFactor) { // sea of fire scroll left
					sofLayer1.flip();
					sofLayer1.gx = 0;
				}
				
				sofLayer2.gx -= _speed * sofLayer2.parallaxDepth;
//				if (sofLayer2.x > 0) { // sea of fire scroll right
//					sofLayer2.flip();
//					sofLayer2.x = -Constants.SofWidth * Constants.SofLayer2ScaleFactor;
//				}
				if (sofLayer2.gx < 0 - Constants.SofWidth * Constants.SofLayer2ScaleFactor) { // sea of fire scroll left
					sofLayer2.flip();
					sofLayer2.gx = 0;
				}
			}
			else if (this.type == Constants.Foreground) { // scroll fg sof layers
				sofLayer3.gx -= _speed * sofLayer3.parallaxDepth;
//				if (sofLayer3.x > 0) { // sea of fire scroll right
//					sofLayer3.flip();
//					sofLayer3.x = -Constants.SofWidth * Constants.SofLayer3ScaleFactor;
//				}
				if (sofLayer3.gx < 0 - Constants.SofWidth * Constants.SofLayer3ScaleFactor) { // sea of fire scroll left
					sofLayer3.flip();
					sofLayer3.gx = 0;
				}
				
				sofLayer4.gx -= _speed * sofLayer4.parallaxDepth;
//				if (sofLayer4.x > 0) { // sea of fire scroll right
//					sofLayer4.flip();
//					sofLayer4.x = -Constants.SofWidth * Constants.SofLayer4ScaleFactor;
//				}
				if (sofLayer4.gx < 0 - Constants.SofWidth * Constants.SofLayer4ScaleFactor) { // sea of fire scroll left
					sofLayer4.flip();
					sofLayer4.gx = 0;
				}
				
				sofLayer5.gx -= _speed * sofLayer5.parallaxDepth;
//				if (sofLayer5.x > 0) { // sea of fire scroll right
//					sofLayer5.flip();
//					sofLayer5.x = -Constants.SofWidth * Constants.SofLayer5ScaleFactor;
//				}
				if (sofLayer5.gx < 0 - Constants.SofWidth * Constants.SofLayer5ScaleFactor) { // sea of fire scroll left
					sofLayer5.flip();
					sofLayer5.gx = 0;
				}
			}
		}
	}
}