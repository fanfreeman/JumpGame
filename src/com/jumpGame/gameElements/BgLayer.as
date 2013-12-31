package com.jumpGame.gameElements
{
	
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
		private var imageWidthVec:Vector.<uint>;
		
		// list of movieclips
		private var movieclipVec:Vector.<MovieClip>;
		
		// active image index
		private var activeImage:uint;
		
		/** Parallax depth - used to decide speed of the animation. */
		private var _parallaxDepth:Number;
		
		// dynamic background elements properties
		private var moonY:Number;
		
		private var stageWidth:int;
		
		public function BgLayer(_layer:int)
		{
			super();
			this.stageWidth = Statics.stageWidth;
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
			
			if (this._layer == 15 || this._layer == 70) { // animated creatures layer
				this.imageVec = null;
				this.movieclipVec = new Vector.<MovieClip>();
				var movieClip:MovieClip;
				if (this._layer == 15) { // dragon/stingray
					movieClip = new MovieClip(Statics.assets.getTextures("Dragon"), 20);
					movieClip.pivotY = movieClip.height;
					movieClip.scaleX = 1.2;
					movieClip.scaleY = 1.2;
					movieClip.x = -movieClip.width;
					this.addChild(movieClip);
					starling.core.Starling.juggler.add(movieClip);
					this.movieclipVec.push(movieClip); // store in vector
					
					movieClip = new MovieClip(Statics.assets.getTextures("Stingray"), 20);
					movieClip.pivotY = movieClip.height;
					movieClip.scaleX = 1.2;
					movieClip.scaleY = 1.2;
					movieClip.x = -movieClip.width;
					movieClip.visible = false;
					this.addChild(movieClip);
					this.movieclipVec.push(movieClip); // store in vector
				}
				else if (this._layer == 70) { // fairy
					movieClip = new MovieClip(Statics.assets.getTextures("Fairy"), 30);
					movieClip.pivotX = Math.ceil(movieClip.width / 2);
					movieClip.pivotY = movieClip.height;
					movieClip.x = this.stageWidth + movieClip.width;
					this.addChild(movieClip);
					starling.core.Starling.juggler.add(movieClip);
					this.movieclipVec.push(movieClip); // store in vector
					
					this.fairyFlightTargets = new Vector.<int>();
				}
			} else { // image layer
				this.movieclipVec = null;
				this.imageVec = new Vector.<Image>();
				var image:Image;
				if (this._layer == 10) { // moon/planet/pirate ship
					this.imageWidthVec = new Vector.<uint>(); // store image widths
					
					image = new Image(Statics.assets.getTexture("Moon0000"));
					image.pivotX = 0; // set registration point to bottom left corner
					image.pivotY = image.texture.height;
					image.x = - image.texture.width;
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					this.imageWidthVec.push(image.texture.width);
					
					image = new Image(Statics.assets.getTexture("PirateShip0000"));
					image.pivotX = 0; // set registration point to bottom left corner
					image.pivotY = image.texture.height;
					image.x = this.stageWidth;
					image.visible = false;
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					this.imageWidthVec.push(image.texture.width);
					
					image = new Image(Statics.assets.getTexture("Planet0000"));
					image.pivotX = image.texture.width;
					image.pivotY = image.texture.height;
					image.x = this.stageWidth;
					image.visible = false;
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					this.imageWidthVec.push(image.texture.width);
					
					this.activeImage = 0;
				}
				else if (this._layer == 20) { // clouds
					this.imageWidthVec = new Vector.<uint>(); // store image widths
					
					image = new Image(Statics.assets.getTexture("Cloud10000"));
					image.pivotY = image.texture.height;
					image.x = this.stageWidth;
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					this.imageWidthVec.push(image.texture.width);
					
					image = new Image(Statics.assets.getTexture("Cloud20000"));
					image.pivotY = image.texture.height;
					image.x = this.stageWidth;
					image.visible = false;
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					this.imageWidthVec.push(image.texture.width);
					
					image = new Image(Statics.assets.getTexture("Cloud30000"));
					image.pivotY = image.texture.height;
					image.x = this.stageWidth;
					image.visible = false;
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					this.imageWidthVec.push(image.texture.width);
					
					image = new Image(Statics.assets.getTexture("Cloud40000"));
					image.pivotY = image.texture.height;
					image.x = this.stageWidth;
					image.visible = false;
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					this.imageWidthVec.push(image.texture.width);
					
					this.activeImage = 0;
				}
				else if (this._layer == 30) { // small islands
					image = new Image(Statics.assets.getTexture("IslandSmall10000"));
					image.pivotY = image.texture.height;
					image.x = Math.floor(Math.random() * (this.stageWidth - image.texture.width));
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					
					image = new Image(Statics.assets.getTexture("IslandSmall20000"));
					image.pivotY = image.texture.height;
					image.x = Math.floor(Math.random() * (this.stageWidth - image.texture.width));
					image.visible = false;
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					
					image = new Image(Statics.assets.getTexture("IslandSmall30000"));
					image.pivotY = image.texture.height;
					image.x = Math.floor(Math.random() * (this.stageWidth - image.texture.width));
					image.visible = false;
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					
					this.activeImage = 0;
				}
				else if (this._layer == 40) { // medium/large islands
					image = new Image(Statics.assets.getTexture("IslandLarge0000"));
					image.pivotX = Math.ceil(image.texture.width / 2);
					image.pivotY = image.texture.height;
					image.x = Math.ceil(this.stageWidth / 2);
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					
					image = new Image(Statics.assets.getTexture("IslandMedium10000"));
					image.pivotX = Math.ceil(image.texture.width / 2);
					image.pivotY = image.texture.height;
					image.x = Math.ceil(this.stageWidth / 2);
					image.visible = false;
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					
					image = new Image(Statics.assets.getTexture("IslandMedium20000"));
					image.pivotX = Math.ceil(image.texture.width / 2);
					image.pivotY = image.texture.height;
					image.x = Math.ceil(this.stageWidth / 2);
					image.visible = false;
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					
					image = new Image(Statics.assets.getTexture("IslandMedium30000"));
					image.pivotX = Math.ceil(image.texture.width / 2);
					image.pivotY = image.texture.height;
					image.x = Math.ceil(this.stageWidth / 2);
					image.visible = false;
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					
					this.activeImage = 0;
				}
				else if (this._layer == 50) { // bridges
					image = new Image(Statics.assets.getTexture("Bridge10000"));
					image.pivotY = image.texture.height;
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					
					image = new Image(Statics.assets.getTexture("Bridge20000"));
					image.pivotY = image.texture.height;
					image.visible = false;
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					
					this.activeImage = 0;
				}
				else if (this._layer == 60) {
					image = new Image(Statics.assets.getTexture("Branch10000"));
					image.pivotX = image.texture.width;
					image.pivotY = image.texture.height;
					image.x = this.stageWidth;
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					
					image = new Image(Statics.assets.getTexture("Branch20000"));
					image.pivotX = image.texture.width;
					image.pivotY = image.texture.height;
					image.x = this.stageWidth
					image.visible = false;
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					
					image = new Image(Statics.assets.getTexture("Branch30000"));
					image.pivotX = image.texture.width;
					image.pivotY = image.texture.height;
					image.x = this.stageWidth
					image.visible = false;
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					
					image = new Image(Statics.assets.getTexture("Branch40000"));
					image.pivotX = image.texture.width;
					image.pivotY = image.texture.height;
					image.x = this.stageWidth
					image.visible = false;
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					
					image = new Image(Statics.assets.getTexture("Branch10000"));
					image.pivotX = image.texture.width;
					image.pivotY = image.texture.height;
					image.scaleX = -1;
					image.visible = false;
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					
					image = new Image(Statics.assets.getTexture("Branch20000"));
					image.pivotX = image.texture.width;
					image.pivotY = image.texture.height;
					image.scaleX = -1;
					image.visible = false;
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					
					image = new Image(Statics.assets.getTexture("Branch30000"));
					image.pivotX = image.texture.width;
					image.pivotY = image.texture.height;
					image.scaleX = -1;
					image.visible = false;
					this.addChild(image);
					this.imageVec.push(image); // store in vector
					
					image = new Image(Statics.assets.getTexture("Branch40000"));
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
//				this.imageVec[0].y = -400 * Math.cos(this.imageVec[0].x / 240) + 300;
				// move moon back to left
				if (this.imageVec[0].x > this.stageWidth) {
					this.imageVec[0].x = - this.imageWidthVec[0];
				}
			}
			
			// update pirate ship
			if (this.imageVec[1].visible) {
				this.imageVec[1].x -= 0.02 * timeDiff;
				// move pirate ship back to right
				if (this.imageVec[1].x < - this.imageWidthVec[1]) {
					this.imageVec[1].x = this.stageWidth;
				}
			}
		}
		
		// update dragon and stingray layer
		public function updateLayerCreatures(timeDiff:int):void {
			var numElements:uint = this.movieclipVec.length;
			for (var i:uint = 0; i < numElements; i++) {
				if (this.movieclipVec[i].visible) {
					this.movieclipVec[i].x += 0.025 * timeDiff;
					// move back to left
					if (this.movieclipVec[i].x > this.stageWidth) {
						this.movieclipVec[i].x = -movieclipVec[i].width;
					}
				}
			}
		}
		
		private var fairyFlightTargets:Vector.<int>;
		private var dx:Number;
		private var dy:Number;
		
		public function initLayerFairy():void {
			this.fairyFlightTargets.length = 0;
			this.dx = 0;
			this.dy = 0;
		}
		
		public function setupLayerFairyTargets():void {
			var stageHeight:int = Statics.stageHeight;
			var numTargets:uint = uint(3 + Math.floor(Math.random() * 4)); // 3 to 6 targets
			while (numTargets > 0) {
				// generate random flight targets
				var randX:Number = Math.random() * this.stageWidth;
				var randY:Number = Math.random() * stageHeight;
				fairyFlightTargets.push(randX);
				fairyFlightTargets.push(randY);
				numTargets--;
			}
			// finally, fly to a random stage bottom target
			fairyFlightTargets.push(Math.random() * this.stageWidth);
			fairyFlightTargets.push(stageHeight + 200);
		}
		
		public function updateLayerFairy(timeDiff:int):void {
			if (this.movieclipVec[0].visible) {
				
				// no targets
				if (fairyFlightTargets.length < 2) {
					this.visible = false;
//					trace("fairy gone!");
					return;
				}
				
				// remove targets that have been reached
				var dist:Number = Statics.distance(this.movieclipVec[0].x, this.movieclipVec[0].y, fairyFlightTargets[0], fairyFlightTargets[1]);
//				trace("fairy dist: " + dist);
				if (dist < 60) {
					fairyFlightTargets.shift();
					fairyFlightTargets.shift();
					
					if (fairyFlightTargets.length >= 2) {
//						trace("new fairy target!");
						if (fairyFlightTargets[0] > this.movieclipVec[0].x && this.movieclipVec[0].scaleX > 0 ||
							fairyFlightTargets[0] < this.movieclipVec[0].x && this.movieclipVec[0].scaleX < 0) {
							this.movieclipVec[0].scaleX *= -1;
						}
					}
					return;
				}
				
				var easingControl:Number = 100;
				
				// x
				var easingFactor:Number = (easingControl - Math.abs(this.movieclipVec[0].x - fairyFlightTargets[0]) / 10);
				var d2x:Number = 0.0; // acceleration
				if (fairyFlightTargets[0] >= this.movieclipVec[0].x) {
					d2x = ((fairyFlightTargets[0] - this.movieclipVec[0].x) - this.dx * easingFactor) / (0.5 * easingFactor * easingFactor);
				}
				else if (fairyFlightTargets[0] <= this.movieclipVec[0].x) {
					d2x = ((fairyFlightTargets[0] - this.movieclipVec[0].x) - this.dx * easingFactor) / (0.5 * easingFactor * easingFactor);
				}
				else { // bring to rest
					d2x = -this.dx / easingFactor;
				}
				this.dx += d2x * timeDiff;
				this.movieclipVec[0].x += this.dx;
				
				// y
				easingFactor = (easingControl - Math.abs(this.movieclipVec[0].y - fairyFlightTargets[1]) / 10);
				var d2y:Number = 0.0; // acceleration
				if (fairyFlightTargets[1] >= this.movieclipVec[0].y) { // move platform up
					d2y = ((fairyFlightTargets[1] - this.movieclipVec[0].y) - this.dy * easingFactor) / (0.5 * easingFactor * easingFactor);
				}
				else if (fairyFlightTargets[1] <= this.movieclipVec[0].y) { // move platform down
					d2y = ((fairyFlightTargets[1] - this.movieclipVec[0].y) - this.dy * easingFactor) / (0.5 * easingFactor * easingFactor);
				}
				else { // bring to rest
					d2y = -this.dy / easingFactor;
				}
				this.dy += d2y * timeDiff;
				this.movieclipVec[0].y += this.dy;
			}
		}
		
		public function updateLayerClouds(timeDiff:int):void {
			var numElements:uint = this.imageVec.length;
			for (var i:uint = 0; i < numElements; i++) {
				if (this.imageVec[i].visible) {
					this.imageVec[i].x -= 0.015 * timeDiff;
					// move back to right
					if (this.imageVec[i].x < - this.imageWidthVec[i]) {
						this.imageVec[i].x = this.stageWidth;
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