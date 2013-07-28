package com.jumpGame.gameElements
{
	import starling.display.BlendMode;
	import starling.display.Image;
	import starling.events.Event;
	
	/**
	 * This class defines each of background layers used in the InGame screen
	 */
	public class BgLayer extends GameObject
	{
		/** Layer identification. */
		private var _layer:int;
		
		// list of images
		private var imageVec:Vector.<Image>;
		
		// active image index
		private var activeImage:uint;
		
		/** Parallax depth - used to decide speed of the animation. */
		private var _parallaxDepth:Number;
		
		// dynamic background elements properties
		private var moonY:Number;
		
		public function BgLayer(_layer:int)
		{
			super();
			
			this._layer = _layer;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		/**
		 * On added to stage. 
		 * @param event
		 * 
		 */
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			this.imageVec = new Vector.<Image>();
			var image:Image;
			if (this._layer == 1) {
				image = new Image(Assets.getSprite("AtlasTexture3").getTexture("Moon0000"));
				image.blendMode = BlendMode.NORMAL;
				image.pivotX = 0; // set registration point to bottom left corner
				image.pivotY = image.texture.height;
				image.x = - image.texture.width;
				this.addChild(image);
				this.imageVec.push(image); // store in vector
				
				image = new Image(Assets.getSprite("AtlasTexture3").getTexture("PirateShip0000"));
				image.blendMode = BlendMode.NORMAL;
				image.pivotX = 0; // set registration point to bottom left corner
				image.pivotY = image.texture.height;
				image.x = Constants.StageWidth;
				image.visible = false;
				this.addChild(image);
				this.imageVec.push(image); // store in vector
				
				this.activeImage = 0;
			}
			else if (this._layer == 2) {
				image = new Image(Assets.getSprite("AtlasTexture3").getTexture("L2Tree10000"));
				image.blendMode = BlendMode.NORMAL;
				image.pivotX = 0; // set registration point to bottom left corner
				image.pivotY = image.texture.height;
				this.addChild(image);
				this.imageVec.push(image); // store in vector
				
				image = new Image(Assets.getSprite("AtlasTexture3").getTexture("L2Tree20000"));
				image.blendMode = BlendMode.NORMAL;
				image.pivotX = -Constants.StageWidth + image.texture.width; // set registration point
				image.pivotY = image.texture.height;
				image.visible = false;
				this.addChild(image);
				this.imageVec.push(image); // store in vector
				
				image = new Image(Assets.getSprite("AtlasTexture3").getTexture("L2Tree30000"));
				image.blendMode = BlendMode.NORMAL;
				image.pivotX = 0; // set registration point to bottom left corner
				image.pivotY = image.texture.height;
				image.visible = false;
				this.addChild(image);
				this.imageVec.push(image); // store in vector
				
				this.activeImage = 0;
			}
			else if (this._layer == 4) {
				image = new Image(Assets.getSprite("AtlasTexture3").getTexture("L4Tree10000"));
				image.blendMode = BlendMode.NORMAL;
				image.pivotX = -Constants.StageWidth + image.texture.width; // set registration point
				image.pivotY = image.texture.height;
				this.addChild(image);
				this.imageVec.push(image); // store in vector
				
				image = new Image(Assets.getSprite("AtlasTexture3").getTexture("L4Tree20000"));
				image.blendMode = BlendMode.NORMAL;
				image.pivotX = 0; // set registration point to bottom left corner
				image.pivotY = image.texture.height;
				image.visible = false;
				this.addChild(image);
				this.imageVec.push(image); // store in vector
				
				this.activeImage = 0;
			}
		}
		
		// cycle background layer image
		public function cycle():void {
			this.imageVec[this.activeImage].visible = false;
			var newImageIndex:uint = Math.floor(Math.random() * this.imageVec.length);
			this.imageVec[newImageIndex].visible = true;
			this.activeImage = newImageIndex;
			
			if (this._layer == 1) {
				this.imageVec[this.activeImage].y = 300; // remove?
			}
		}
		
		// update moon motion
		public function update(timeDiff:int):void {
			// update moon
			this.imageVec[0].x += 0.01 * timeDiff;
//			trace("sine: " + Math.cos(this.imageVec[0].x / 240));
			this.imageVec[0].y = -400 * Math.cos(this.imageVec[0].x / 240) + 300;
			// move moon back to left
			if (this.imageVec[0].x > Constants.StageWidth) {
				this.imageVec[0].x = - this.imageVec[0].texture.width;
			}
			
			// update pirate ship
			this.imageVec[1].x -= 0.02 * timeDiff;
			// move pirate ship back to right
			if (this.imageVec[1].x < - this.imageVec[1].width) {
				this.imageVec[1].x = Constants.StageWidth;
			}
		}
		
		/**
		 * Parallax depth. 
		 * 
		 */
		public function get parallaxDepth():Number { return _parallaxDepth; }
		public function set parallaxDepth(value:Number):void { _parallaxDepth = value; }
	}
}