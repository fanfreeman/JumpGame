package com.jumpGame.gameElements {
	import com.jumpGame.level.Statics;
	
	import starling.core.Starling;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.PDParticleSystem;
	import starling.filters.BlurFilter;
	import starling.textures.Texture;
	
	public class Background extends Sprite {
		
		// sea of fire properties
		public var sofHeight:Number = -600;
		private var sofSpeed:Number = 0.1;
		
		private var type:uint; // background or foreground
		
		// decorative layers
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
		
		public static var particleSeaOfFire:PDParticleSystem;
		
		public function Background(type:uint) {
			super();
			this.type = type;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			if (this.type == Constants.Background) {
				// add layer 1: furthest bg: full screen image
				this.bgLayer1 = new BgLayer(1);
				this.bgLayer1.parallaxDepth = 0.02;
				this.bgLayer1.gx = -Constants.StageWidth / 2; // place at bottom left of screen
				this.bgLayer1.gy = -Constants.StageHeight / 2;
				this.addChild(this.bgLayer1);
				
				// add sea of fire layer 1
				this.sofLayer1 = new SofLayer();
				this.sofLayer1.parallaxDepth = 0.04;
				this.sofLayer1.gx = -Constants.StageWidth / 2; // place at left of screen
				this.sofLayer1.gy = this.sofHeight + Constants.SofLayer1HeightOffset;
				this.sofLayer1.scaleX = Constants.SofLayer1ScaleFactor;
				this.sofLayer1.scaleY = Constants.SofLayer1ScaleFactor;
				this.sofLayer1.filter = new BlurFilter(0.5, 0.5);
				this.addChild(this.sofLayer1);
				
				// add layer 2: right behind player
				this.bgLayer2 = new BgLayer(2);
				this.bgLayer2.parallaxDepth = 0.5;
				this.bgLayer2.gx = -Constants.StageWidth / 2; // place at top left of screen
				this.bgLayer2.gy = Constants.StageHeight / 2;
				this.addChild(this.bgLayer2);
				
				// add sea of fire layer 2
				this.sofLayer2 = new SofLayer();
				this.sofLayer2.parallaxDepth = 0.08;
				this.sofLayer2.gx = -Constants.StageWidth / 2; // place at left of screen
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
				this.sofLayer3 = new SofLayer();
				this.sofLayer3.parallaxDepth = 0.16;
				this.sofLayer3.gx = -Constants.StageWidth / 2; // place at left of screen
				this.sofLayer3.gy = this.sofHeight + Constants.SofLayer3HeightOffset;
				this.sofLayer3.scaleX = Constants.SofLayer3ScaleFactor;
				this.sofLayer3.scaleY = Constants.SofLayer3ScaleFactor;
				//			var layer3Filter:ColorMatrixFilter = new ColorMatrixFilter();
				//			layer3Filter.adjustBrightness(-0.1);
				//			this.sofLayer3.filter = layer3Filter;
				this.sofLayer3.filter = new BlurFilter(0.5, 0.5);
				this.addChild(this.sofLayer3);
				
				this.sofLayer4 = new SofLayer();
				this.sofLayer4.parallaxDepth = 0.32;
				this.sofLayer4.gx = -Constants.StageWidth / 2; // place at left of screen
				this.sofLayer4.gy = this.sofHeight + Constants.SofLayer4HeightOffset;
				this.sofLayer4.scaleX = Constants.SofLayer4ScaleFactor;
				this.sofLayer4.scaleY = Constants.SofLayer4ScaleFactor;
				//			var layer4Filter:ColorMatrixFilter = new ColorMatrixFilter();
				//			layer4Filter.adjustBrightness(-0.2);
				//			this.sofLayer4.filter = layer4Filter;
				this.sofLayer4.filter = new BlurFilter(1.0, 1.0, 1.0);
				this.addChild(this.sofLayer4);
				
				// there's no bg layer 3 because layer 3 is player's layer
				// add layer 4: right in front of player
				this.bgLayer4 = new BgLayer(4);
				this.bgLayer4.parallaxDepth = 1.5;
				this.bgLayer4.gx = -Constants.StageWidth / 2; // place at top left of screen
				this.bgLayer4.gy = Constants.StageHeight / 2;
				this.addChild(this.bgLayer4);
				
				// create sea of fire particle emitter
				if (Statics.isHardwareRendering) {
					particleSeaOfFire = new PDParticleSystem(XML(new ParticleAssets.ParticleFireXML()), Texture.fromBitmap(new ParticleAssets.ParticleFireTexture()));
					Starling.juggler.add(particleSeaOfFire);
					this.addChild(particleSeaOfFire);
//					particleSeaOfFire.start();
				}
				
				// add sea of fire layer 5: closes to player
				this.sofLayer5 = new SofLayer();
				this.sofLayer5.parallaxDepth = 0.64;
				this.sofLayer5.gx = -Constants.StageWidth / 2; // place at bottom left of screen
				this.sofLayer5.gy = this.sofHeight + Constants.SofLayer5HeightOffset;
				this.sofLayer5.scaleX = Constants.SofLayer5ScaleFactor;
				this.sofLayer5.scaleY = Constants.SofLayer5ScaleFactor;
				//			var layer5Filter:ColorMatrixFilter = new ColorMatrixFilter();
				//			layer5Filter.adjustBrightness(-0.3);
				//			this.sofLayer5.filter = layer5Filter;
				this.sofLayer5.filter = new BlurFilter(1.0, 1.0, 0.75);
				this.addChild(this.sofLayer5);
				
				// add sea of fire endless quad
				this.sofQuad = new Quad(Constants.StageWidth, 10000, 0xdb3a00);
				//this.sofQuad.pivotY = this.sofQuad.height;
				this.sofQuad.x = 0;
				this.sofQuad.y = this.sofLayer5.y + this.sofLayer5.height - 10;
				addChild(this.sofQuad);
				
				if (Constants.SofEnabled == false) {
					this.sofLayer3.visible = false;
					this.sofLayer4.visible = false;
					this.sofLayer5.visible = false;
					this.sofQuad.visible = false;
				}
			}
		}
		
		// scroll bg and fg decorative elements as hero moves
		// @param distance = distance hero moved up
		public function scroll():void {
			if (this.type == Constants.Background) {
				// scroll bg layers
				this.bgLayer1.gy += Camera.dy * (1.0 - this.bgLayer1.parallaxDepth);
				this.bgLayer2.gy += Camera.dy * (1.0 - this.bgLayer2.parallaxDepth);
				
				// cycle bg layer 2
				if (this.bgLayer2.gy < Camera.gy - Constants.StageHeight * 1.5) {
					this.bgLayer2.cycle();
					this.bgLayer2.gy = Camera.gy + Constants.StageHeight * 0.5;
				} else if (this.bgLayer2.gy > Camera.gy + Constants.StageHeight * 0.5) {
					this.bgLayer2.cycle();
					this.bgLayer2.gy = Camera.gy - Constants.StageHeight * 1.5;
				}
				
//				this.bgLayer1.visible = false;
//				this.bgLayer2.visible = false;
			}
			else if (this.type == Constants.Foreground) {
				// scroll fg layer
				this.bgLayer4.gy += Camera.dy * (1.0 - this.bgLayer4.parallaxDepth);
				
				// cycle fg layer 4
				if (this.bgLayer4.gy < Camera.gy - Constants.StageHeight * 1.5) {
					this.bgLayer4.cycle();
					this.bgLayer4.gy = Camera.gy + Constants.StageHeight * 0.5;
				} else if (this.bgLayer4.gy > Camera.gy + Constants.StageHeight * 0.5) {
					this.bgLayer4.cycle();
					this.bgLayer4.gy = Camera.gy - Constants.StageHeight * 1.5;
				}
				
//				this.bgLayer4.visible = false;
			}
		}
		
		// scroll sea of fire according to time elapsed
		public function scrollSofVertical(timeDiff:int, heroGy:Number):void {
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
			
			if (this.type == Constants.Background) { // scroll bg sof layers
				this.sofLayer1.gy = this.sofHeight + Constants.SofLayer1HeightOffset;
				this.sofLayer2.gy = this.sofHeight + Constants.SofLayer2HeightOffset;
			}
			else if (this.type == Constants.Foreground) { // scroll fg sof layers
				this.sofLayer3.gy = this.sofHeight + Constants.SofLayer3HeightOffset;
				this.sofLayer4.gy = this.sofHeight + Constants.SofLayer4HeightOffset;
				this.sofLayer5.gy = this.sofHeight + Constants.SofLayer5HeightOffset;
				this.sofQuad.y = this.sofLayer5.y + this.sofLayer5.height - 10;
			}
		}
		
		// scroll sea of fire waves horizontally
		public function scrollSofHorizontal():void {
			var _speed:Number = 10;
			
			if (this.type == Constants.Background) { // scroll bg sof layers
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
			}
			else if (this.type == Constants.Foreground) { // scroll fg sof layers
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
}