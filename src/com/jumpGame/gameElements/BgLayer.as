package com.jumpGame.gameElements
{
	import com.jumpGame.level.Statics;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
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
		
		// list of movieclips
		private var movieclipVec:Vector.<MovieClip>;
		
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
			
			if (this._layer == 15) { // movieclip layer
				this.imageVec = null;
				this.movieclipVec = new Vector.<MovieClip>();
				var movieClip:MovieClip;
//				if (this._layer == 15) { // dragon/stingray
					movieClip = new MovieClip(Assets.getSprite("AtlasTexture6").getTextures("Dragon"), 20);
					movieClip.pivotY = movieClip.height;
					movieClip.scaleX = 1.2;
					movieClip.scaleY = 1.2;
					movieClip.x = -movieClip.width;
					this.addChild(movieClip);
					starling.core.Starling.juggler.add(movieClip);
					this.movieclipVec.push(movieClip); // store in vector
					
					movieClip = new MovieClip(Assets.getSprite("AtlasTexture6").getTextures("Stingray"), 20);
					movieClip.pivotY = movieClip.height;
					movieClip.scaleX = 1.2;
					movieClip.scaleY = 1.2;
					movieClip.x = -movieClip.width;
					movieClip.visible = false;
					this.addChild(movieClip);
					this.movieclipVec.push(movieClip); // store in vector
//				}
			} else { // image layer
				this.movieclipVec = null;
				this.imageVec = new Vector.<Image>();
				var image:Image;
				if (this._layer == 10) { // moon/planet/pirate ship
					image = new Image(Assets.getSprite("AtlasTexture3").getTexture("Moon0000"));
					image.pivotX = 0; // set registration point to bottom left corner
					image.pivotY = image.texture.height;
					image.x = - image.texture.width;
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					
					image = new Image(Assets.getSprite("AtlasTexture3").getTexture("PirateShip0000"));
					image.pivotX = 0; // set registration point to bottom left corner
					image.pivotY = image.texture.height;
					image.x = Constants.StageWidth;
					image.visible = false;
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					
					image = new Image(Assets.getSprite("AtlasTexture3").getTexture("Planet0000"));
					image.pivotX = image.texture.width;
					image.pivotY = image.texture.height;
					image.x = Statics.stageWidth;
					image.visible = false;
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					
					this.activeImage = 0;
				}
				else if (this._layer == 20) { // clouds
					image = new Image(Assets.getSprite("AtlasTexture3").getTexture("Cloud10000"));
					image.pivotY = image.texture.height;
					image.x = Statics.stageWidth;
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					
					image = new Image(Assets.getSprite("AtlasTexture3").getTexture("Cloud20000"));
					image.pivotY = image.texture.height;
					image.x = Statics.stageWidth;
					image.visible = false;
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					
					image = new Image(Assets.getSprite("AtlasTexture3").getTexture("Cloud30000"));
					image.pivotY = image.texture.height;
					image.x = Statics.stageWidth;
					image.visible = false;
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					
					image = new Image(Assets.getSprite("AtlasTexture3").getTexture("Cloud40000"));
					image.pivotY = image.texture.height;
					image.x = Statics.stageWidth;
					image.visible = false;
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					
					this.activeImage = 0;
				}
				else if (this._layer == 30) { // small islands
					image = new Image(Assets.getSprite("AtlasTexture3").getTexture("IslandSmall10000"));
					image.pivotY = image.texture.height;
					image.x = Math.floor(Math.random() * (Statics.stageWidth - image.texture.width));
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					
					image = new Image(Assets.getSprite("AtlasTexture3").getTexture("IslandSmall20000"));
					image.pivotY = image.texture.height;
					image.x = Math.floor(Math.random() * (Statics.stageWidth - image.texture.width));
					image.visible = false;
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					
					image = new Image(Assets.getSprite("AtlasTexture3").getTexture("IslandSmall30000"));
					image.pivotY = image.texture.height;
					image.x = Math.floor(Math.random() * (Statics.stageWidth - image.texture.width));
					image.visible = false;
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					
					this.activeImage = 0;
				}
				else if (this._layer == 40) { // medium/large islands
					image = new Image(Assets.getSprite("AtlasTexture3").getTexture("IslandLarge0000"));
					image.pivotX = Math.ceil(image.texture.width / 2);
					image.pivotY = image.texture.height;
					image.x = Math.ceil(Statics.stageWidth / 2);
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					
					image = new Image(Assets.getSprite("AtlasTexture3").getTexture("IslandMedium10000"));
					image.pivotX = Math.ceil(image.texture.width / 2);
					image.pivotY = image.texture.height;
					image.x = Math.ceil(Statics.stageWidth / 2);
					image.visible = false;
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					
					image = new Image(Assets.getSprite("AtlasTexture3").getTexture("IslandMedium20000"));
					image.pivotX = Math.ceil(image.texture.width / 2);
					image.pivotY = image.texture.height;
					image.x = Math.ceil(Statics.stageWidth / 2);
					image.visible = false;
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					
					image = new Image(Assets.getSprite("AtlasTexture3").getTexture("IslandMedium30000"));
					image.pivotX = Math.ceil(image.texture.width / 2);
					image.pivotY = image.texture.height;
					image.x = Math.ceil(Statics.stageWidth / 2);
					image.visible = false;
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					
					this.activeImage = 0;
				}
				else if (this._layer == 50) { // bridges
					image = new Image(Assets.getSprite("AtlasTexture3").getTexture("Bridge10000"));
					image.pivotY = image.texture.height;
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					
					image = new Image(Assets.getSprite("AtlasTexture3").getTexture("Bridge20000"));
					image.pivotY = image.texture.height;
					image.visible = false;
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					
					this.activeImage = 0;
				}
				else if (this._layer == 60) {
					image = new Image(Assets.getSprite("AtlasTexture5").getTexture("Branch10000"));
					image.pivotX = image.texture.width;
					image.pivotY = image.texture.height;
					image.x = Statics.stageWidth;
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					
					image = new Image(Assets.getSprite("AtlasTexture5").getTexture("Branch20000"));
					image.pivotX = image.texture.width;
					image.pivotY = image.texture.height;
					image.x = Statics.stageWidth
					image.visible = false;
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					
					image = new Image(Assets.getSprite("AtlasTexture5").getTexture("Branch30000"));
					image.pivotX = image.texture.width;
					image.pivotY = image.texture.height;
					image.x = Statics.stageWidth
					image.visible = false;
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					
					image = new Image(Assets.getSprite("AtlasTexture5").getTexture("Branch40000"));
					image.pivotX = image.texture.width;
					image.pivotY = image.texture.height;
					image.x = Statics.stageWidth
					image.visible = false;
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					
					image = new Image(Assets.getSprite("AtlasTexture5").getTexture("Branch10000"));
					image.pivotX = image.texture.width;
					image.pivotY = image.texture.height;
					image.scaleX = -1;
					image.visible = false;
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					
					image = new Image(Assets.getSprite("AtlasTexture5").getTexture("Branch20000"));
					image.pivotX = image.texture.width;
					image.pivotY = image.texture.height;
					image.scaleX = -1;
					image.visible = false;
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					
					image = new Image(Assets.getSprite("AtlasTexture5").getTexture("Branch30000"));
					image.pivotX = image.texture.width;
					image.pivotY = image.texture.height;
					image.scaleX = -1;
					image.visible = false;
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					
					image = new Image(Assets.getSprite("AtlasTexture5").getTexture("Branch40000"));
					image.pivotX = image.texture.width;
					image.pivotY = image.texture.height;
					image.scaleX = -1;
					image.visible = false;
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					
					this.activeImage = 0;
				}
			}
		}
		
		// cycle background layer image
		public function cycle():void {
			var newImageIndex:uint
			if (this.imageVec != null) { // image layer
				this.imageVec[this.activeImage].visible = false;
				newImageIndex = Math.floor(Math.random() * this.imageVec.length);
				this.imageVec[newImageIndex].visible = true;
				this.activeImage = newImageIndex;
				
//				if (this._layer == 1) {
//					this.imageVec[this.activeImage].y = 300; // remove?
//				}
			} else if (this.movieclipVec != null) { // movieclip layer
				this.movieclipVec[this.activeImage].visible = false;
				starling.core.Starling.juggler.remove(this.movieclipVec[this.activeImage]);
				newImageIndex = Math.floor(Math.random() * this.movieclipVec.length);
				this.movieclipVec[newImageIndex].visible = true;
				starling.core.Starling.juggler.add(this.movieclipVec[newImageIndex]);
				this.activeImage = newImageIndex;
			}
		}
		
		// update moon motion
		public function updateLayerPlanets(timeDiff:int):void {
			// update moon
			if (this.imageVec[0].visible) {
				this.imageVec[0].x += 0.01 * timeDiff;
				this.imageVec[0].y = -400 * Math.cos(this.imageVec[0].x / 240) + 300;
				// move moon back to left
				if (this.imageVec[0].x > Constants.StageWidth) {
					this.imageVec[0].x = - this.imageVec[0].texture.width;
				}
			}
			
			// update pirate ship
			if (this.imageVec[1].visible) {
				this.imageVec[1].x -= 0.02 * timeDiff;
				// move pirate ship back to right
				if (this.imageVec[1].x < - this.imageVec[1].width) {
					this.imageVec[1].x = Constants.StageWidth;
				}
			}
		}
		
		public function updateLayerCreatures(timeDiff:int):void {
			var numElements:uint = this.movieclipVec.length;
			for (var i:uint = 0; i < numElements; i++) {
				if (this.movieclipVec[i].visible) {
					this.movieclipVec[i].x += 0.025 * timeDiff;
					// move back to left
					if (this.movieclipVec[i].x > Statics.stageWidth) {
						this.movieclipVec[i].x = -movieclipVec[i].width;
					}
				}
			}
		}
		
		public function updateLayerClouds(timeDiff:int):void {
			var numElements:uint = this.imageVec.length;
			for (var i:uint = 0; i < numElements; i++) {
				if (this.imageVec[i].visible) {
					this.imageVec[i].x -= 0.015 * timeDiff;
					// move back to right
					if (this.imageVec[i].x < - this.imageVec[i].width) {
						this.imageVec[i].x = Constants.StageWidth;
					}
				}
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