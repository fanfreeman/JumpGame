package com.jumpGame.gameElements {
	import starling.display.BlendMode;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	
	import com.jumpGame.level.Statics;
	
	public class Background extends Sprite {
		// sea of fire properties
		public var sofHeight:Number;
		
		private var type:uint; // background or foreground
		
		// images of bg layer 0
//		private var layer0Image0:GameObject;
//		private var layer0Image1:GameObject;
//		private var layer0Image2:GameObject;
		private var layer0Ground:GameObject;
		private var layer0Sky1:GameObject;
		private var layer0Sky2:GameObject;
		private var layer0Sky3:GameObject;
		
		// other decorative layers
		private var bgLayerPlanets:BgLayer; // bg planet/pirateship/moon
		private var bgLayerCreatures:BgLayer; // dragon/stingray
		private var bgLayerClouds:BgLayer; // bg clouds
		private var bgLayerIslandsSmall:BgLayer; // bg small islands
		private var bgLayerIslandsLarge:BgLayer; // bg medium/large islands
		private var bgLayerBridges:BgLayer; // bg bridges
		private var bgLayerBranches:BgLayer; // fg branches
		
		// expiration times
		private var bgLayerPlanetsExpiration:int;
		private var bgLayerCreaturesExpiration:int;
		private var bgLayerCloudsExpiration:int;
		private var bgLayerIslandsSmallExpiration:int;
		private var bgLayerIslandsLargeExpiration:int;
		private var bgLayerBridgesExpiration:int;
		private var bgLayerBranchesExpiration:int;
		
		// sea of fire layers (waves)
		private var sofLayer1:SofLayer; // bg
		private var sofLayer2:SofLayer; // bg
		private var sofLayer3:SofLayer; // fg
		private var sofLayer4:SofLayer; // fg
		private var sofLayer5:SofLayer; // fg
		public var sofQuad:Quad; // fg
		
		public function Background(type:uint) {
			super();
			this.blendMode = BlendMode.NORMAL;
			this.type = type;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function initialize():void {
			this.sofHeight = Constants.InitialSofHeight;
			
			if (this.type == Constants.Background) {
				bgLayerPlanetsExpiration = Statics.gameTime + Constants.BgLayerPlanetsDuration;
				bgLayerCreaturesExpiration = Statics.gameTime + Constants.BgLayerCreaturesDuration;
				bgLayerCloudsExpiration = Statics.gameTime + Constants.BgLayerCloudsDuration;
				bgLayerIslandsSmallExpiration = Statics.gameTime + Constants.BgLayerIslandsSmallDuration;
				bgLayerIslandsLargeExpiration = Statics.gameTime + Constants.BgLayerIslandsLargeDuration;
				bgLayerBridgesExpiration = Statics.gameTime + Constants.BgLayerBridgesDuration;
				
				layer0Ground.gx = 0;
				layer0Ground.gy = int(-Statics.stageHeight / 2);
				this.addChild(layer0Ground);
				this.setChildIndex(layer0Ground, 0); // send to back
			
				layer0Sky1.gx = 0;
				layer0Sky1.gy = int(-Statics.stageHeight / 2 + layer0Ground.height);
				
				layer0Sky2.gx = 0;
				layer0Sky2.gy = int(-Statics.stageHeight / 2 + layer0Ground.height + layer0Sky1.height);
				
				layer0Sky3.gx = 0;
				layer0Sky3.gy = int(-Statics.stageHeight / 2 + layer0Ground.height + layer0Sky1.height + layer0Sky3.height);
				
				this.sofLayer1.gx = 0;
				this.sofLayer1.gy = this.sofHeight + Constants.SofLayer1HeightOffset;
				
				this.bgLayerPlanets.gx = -Constants.StageWidth / 2; // place at top left of screen
				this.bgLayerPlanets.gy = Constants.StageHeight / 2;
				this.bgLayerPlanets.visible = false;
				
				this.bgLayerCreatures.gx = -Constants.StageWidth / 2; // place at top left of screen
				this.bgLayerCreatures.gy = Constants.StageHeight / 2;
				this.bgLayerCreatures.visible = false;
				
				this.bgLayerClouds.gx = -Constants.StageWidth / 2; // place at top left of screen
				this.bgLayerClouds.gy = Constants.StageHeight / 2;
				this.bgLayerClouds.visible = false;
				
				this.bgLayerIslandsSmall.gx = -Constants.StageWidth / 2; // place at top left of screen
				this.bgLayerIslandsSmall.gy = Constants.StageHeight / 2;
				this.bgLayerIslandsSmall.visible = false;
				
				this.bgLayerIslandsLarge.gx = -Constants.StageWidth / 2; // place at top left of screen
				this.bgLayerIslandsLarge.gy = Constants.StageHeight / 2;
				this.bgLayerIslandsLarge.visible = false;
				
				this.bgLayerBridges.gx = -Constants.StageWidth / 2; // place at top left of screen
				this.bgLayerBridges.gy = Constants.StageHeight / 2;
				this.bgLayerBridges.visible = false;
				
				this.sofLayer2.gx = 0;
				this.sofLayer2.gy = this.sofHeight + Constants.SofLayer2HeightOffset;
			}
			else if (this.type == Constants.Foreground) {
				bgLayerBranchesExpiration = Statics.gameTime + Constants.BgLayerBranchesDuration;
				
				this.sofLayer3.gx = 0;
				this.sofLayer3.gy = this.sofHeight + Constants.SofLayer3HeightOffset;
				
				this.sofLayer4.gx = 0;
				this.sofLayer4.gy = this.sofHeight + Constants.SofLayer4HeightOffset;
				
				this.bgLayerBranches.gx = -Constants.StageWidth / 2; // place at top left of screen
				this.bgLayerBranches.gy = Constants.StageHeight / 2;
				this.bgLayerBranches.visible = false;
				
				this.sofLayer5.gx = 0;
				this.sofLayer5.gy = this.sofHeight + Constants.SofLayer5HeightOffset;
				
				this.sofQuad.x = 0;
				this.sofQuad.y = this.sofLayer5.y + Constants.SofQuadHeightOffset;
			}
		}
		
		private function onAddedToStage(event:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			if (this.type == Constants.Background) {
				// bof layer 0 images
//				layer0Image0 = new GameObject();
//				var image0:Image = new Image(Assets.getTexture("BgLayer0Ground"));
////				var image0:Image = new Image(Assets.getSprite("AtlasTexture3").getTexture("Layer0Ground0000"));
//				layer0Image0.addChild(image0);
//				layer0Image0.blendMode = BlendMode.NONE;
//				layer0Image0.pivotX = layer0Image0.width / 2;
//				layer0Image0.pivotY = layer0Image0.height;
//				this.addChild(layer0Image0);
				
//				layer0Image1 = new GameObject();
//				var image1:Image = new Image(Assets.getTexture("BgLayer0Sky"));
////				var image1:Image = new Image(Assets.getSprite("AtlasTexture3").getTexture("Layer0Sky0000"));
//				layer0Image1.addChild(image1);
//				layer0Image1.blendMode = BlendMode.NONE;
//				layer0Image1.pivotX = layer0Image1.width / 2;
//				layer0Image1.pivotY = layer0Image1.height;
//				this.addChild(layer0Image1);
				
//				layer0Image2 = new GameObject();
//				var image2:Image = new Image(Assets.getTexture("BgLayer0Sky"));
////				var image2:Image = new Image(Assets.getSprite("AtlasTexture3").getTexture("Layer0Sky0000"));
//				layer0Image2.addChild(image2);
//				layer0Image2.blendMode = BlendMode.NONE;
//				layer0Image2.pivotX = layer0Image2.width / 2;
//				layer0Image2.pivotY = layer0Image2.height;
//				this.addChild(layer0Image2);
				
				layer0Ground = new GameObject();
				var image0:Image = new Image(Assets.getTexture("BgLayer0Ground"));
				layer0Ground.addChild(image0);
				layer0Ground.blendMode = BlendMode.NONE;
				layer0Ground.pivotX = Math.ceil(layer0Ground.width / 2);
				layer0Ground.pivotY = layer0Ground.height;
//				this.addChild(layer0Ground);
				
				layer0Sky1 = new GameObject();
				var image1:Image = new Image(Assets.getTexture("BgLayer0Sky"));
				layer0Sky1.addChild(image1);
				layer0Sky1.blendMode = BlendMode.NONE;
				layer0Sky1.pivotX = Math.ceil(layer0Sky1.width / 2);
				layer0Sky1.pivotY = layer0Sky1.height;
				this.addChild(layer0Sky1);
				
				layer0Sky2 = new GameObject();
				var image2:Image = new Image(Assets.getTexture("BgLayer0Sky"));
				layer0Sky2.addChild(image2);
				layer0Sky2.blendMode = BlendMode.NONE;
				layer0Sky2.pivotX = Math.ceil(layer0Sky2.width / 2);
				layer0Sky2.pivotY = layer0Sky2.height;
				this.addChild(layer0Sky2);
				
				layer0Sky3 = new GameObject();
				var image3:Image = new Image(Assets.getTexture("BgLayer0Sky"));
				layer0Sky3.addChild(image3);
				layer0Sky3.blendMode = BlendMode.NONE;
				layer0Sky3.pivotX = Math.ceil(layer0Sky3.width / 2);
				layer0Sky3.pivotY = layer0Sky3.height;
				this.addChild(layer0Sky3);
				// eof layer 0 images
				
				// add sea of fire layer 1
				this.sofLayer1 = new SofLayer(2);
				this.sofLayer1.parallaxDepth = 0.04;
				this.sofLayer1.scaleX = Constants.SofLayer1ScaleFactor;
				this.sofLayer1.scaleY = Constants.SofLayer1ScaleFactor;
				this.addChild(this.sofLayer1);
				
				// add bg layer: moon/pirate ship/planet
				this.bgLayerPlanets = new BgLayer(10);
				this.bgLayerPlanets.parallaxDepth = Constants.BgLayerPlanetsParallaxDepth;
				this.addChild(this.bgLayerPlanets);
				
				// add bg layer: dragon/stingray
				this.bgLayerCreatures = new BgLayer(15);
				this.bgLayerCreatures.parallaxDepth = Constants.BgLayerCreaturesParallaxDepth;
				this.addChild(this.bgLayerCreatures);
				
				// add layer 15: clouds
				this.bgLayerClouds = new BgLayer(20);
				this.bgLayerClouds.parallaxDepth = Constants.BgLayerCloudsParallaxDepth;
				this.addChild(this.bgLayerClouds);
				
				// add layer 17: small islands
				this.bgLayerIslandsSmall = new BgLayer(30);
				this.bgLayerIslandsSmall.parallaxDepth = Constants.BgLayerIslandsSmallParallaxDepth;
				this.addChild(this.bgLayerIslandsSmall);
				
				this.bgLayerIslandsLarge = new BgLayer(40);
				this.bgLayerIslandsLarge.parallaxDepth = Constants.BgLayerIslandsLargeParallaxDepth;
				this.addChild(this.bgLayerIslandsLarge);
				
				this.bgLayerBridges = new BgLayer(50);
				this.bgLayerBridges.parallaxDepth = Constants.BgLayerBridgesParallaxDepth;
				this.addChild(this.bgLayerBridges);
				
				// add sea of fire layer 2
				this.sofLayer2 = new SofLayer(1);
				this.sofLayer2.parallaxDepth = 0.08;
				this.sofLayer2.scaleX = Constants.SofLayer2ScaleFactor;
				this.sofLayer2.scaleY = Constants.SofLayer2ScaleFactor;
				this.addChild(this.sofLayer2);
				
//				if (Constants.SofEnabled == false) {
//					this.sofLayer1.visible = false;
//					this.sofLayer2.visible = false;
//				}
			}
			else if (this.type == Constants.Foreground) {
				// add sea of fire layers 3, 4: further than fg decorative elements
				this.sofLayer3 = new SofLayer(0);
				this.sofLayer3.parallaxDepth = 0.16;
				this.sofLayer3.scaleX = Constants.SofLayer3ScaleFactor;
				this.sofLayer3.scaleY = Constants.SofLayer3ScaleFactor;
				this.addChild(this.sofLayer3);
				
				this.sofLayer4 = new SofLayer(1);
				this.sofLayer4.parallaxDepth = 0.32;
				this.sofLayer4.scaleX = Constants.SofLayer4ScaleFactor;
				this.sofLayer4.scaleY = Constants.SofLayer4ScaleFactor;
				this.addChild(this.sofLayer4);
				
				// there's no bg layer 3 because layer 3 is player's layer
				// add layer 40: right in front of player
				this.bgLayerBranches = new BgLayer(60);
				this.bgLayerBranches.parallaxDepth = Constants.bgLayerBranchesParallaxDepth;
				this.addChild(this.bgLayerBranches);
				
				// add sea of fire layer 5: closes to player
				this.sofLayer5 = new SofLayer(2);
				this.sofLayer5.parallaxDepth = 0.64;
				this.sofLayer5.scaleX = Constants.SofLayer5ScaleFactor;
				this.sofLayer5.scaleY = Constants.SofLayer5ScaleFactor;
				this.addChild(this.sofLayer5);
				
				// add sea of fire endless quad
				this.sofQuad = new Quad(Constants.StageWidth, 10000, 0xdb3a00);
				//this.sofQuad.pivotY = this.sofQuad.height;
				addChild(this.sofQuad);
				
//				if (Constants.SofEnabled == false) {
//					this.sofLayer3.visible = false;
//					this.sofLayer4.visible = false;
//					this.sofLayer5.visible = false;
//					this.sofQuad.visible = false;
//				}
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
				this.layer0Sky1.gy += Camera.dy * (1.0 - Constants.BgLayer0ParallaxDepth);
				this.layer0Sky2.gy += Camera.dy * (1.0 - Constants.BgLayer0ParallaxDepth);
				this.layer0Sky3.gy += Camera.dy * (1.0 - Constants.BgLayer0ParallaxDepth);
				
				// scroll / hide ground after it scrolls out
				if (this.layer0Ground.visible) {
					this.layer0Ground.gy += Camera.dy * (1.0 - Constants.BgLayer0ParallaxDepth);
					// hide it
					if (this.layer0Ground.gy < -Constants.StageHeight / 2 - this.layer0Ground.height) {
						this.layer0Ground.visible = false;
						this.removeChild(layer0Ground);
					}
				}
				
				// move sky image to top after it scrolls out
				if (this.layer0Sky1.gy < Camera.gy - Constants.StageHeight / 2 - this.layer0Sky1.height) {
					this.layer0Sky1.gy = this.layer0Sky3.gy + this.layer0Sky3.height;
				}
				if (this.layer0Sky2.gy < Camera.gy - Constants.StageHeight / 2 - this.layer0Sky2.height) {
					this.layer0Sky2.gy = this.layer0Sky1.gy + this.layer0Sky1.height;
				}
				if (this.layer0Sky3.gy < Camera.gy - Constants.StageHeight / 2 - this.layer0Sky3.height) {
					this.layer0Sky3.gy = this.layer0Sky2.gy + this.layer0Sky2.height;
				}
				
				// scroll bg layers
				this.bgLayerPlanets.gy += Camera.dy * (1.0 - this.bgLayerPlanets.parallaxDepth);
				this.bgLayerCreatures.gy += Camera.dy * (1.0 - this.bgLayerCreatures.parallaxDepth);
				this.bgLayerClouds.gy += Camera.dy * (1.0 - this.bgLayerClouds.parallaxDepth);
				this.bgLayerIslandsSmall.gy += Camera.dy * (1.0 - this.bgLayerIslandsSmall.parallaxDepth);
				this.bgLayerIslandsLarge.gy += Camera.dy * (1.0 - this.bgLayerIslandsLarge.parallaxDepth);
				this.bgLayerBridges.gy += Camera.dy * (1.0 - this.bgLayerBridges.parallaxDepth);
				
				// update bg layers that move
				this.bgLayerPlanets.updateLayerPlanets(timeDiff);
				this.bgLayerCreatures.updateLayerCreatures(timeDiff);
				this.bgLayerClouds.updateLayerClouds(timeDiff);
				
				// cycle bg layers
//				if (this.bgLayerPlanets.gy < Camera.gy - Constants.StageHeight * 1.5) {
//					this.bgLayerPlanets.cycle();
//					this.bgLayerPlanets.gy = Camera.gy + Constants.StageHeight * 1.5;
//				} else if (this.bgLayerPlanets.gy > Camera.gy + Constants.StageHeight * 1.5) {
//					this.bgLayerPlanets.cycle();
//					this.bgLayerPlanets.gy = Camera.gy - Constants.StageHeight * 1.5;
//				}
//				
//				if (this.bgLayerCreatures.gy < Camera.gy - Constants.StageHeight * 1.5) {
//					this.bgLayerCreatures.cycle();
////					this.bgLayerCreatures.gy = Camera.gy + Constants.StageHeight * 0.5;
//					this.bgLayerCreatures.gy = Camera.gy + Constants.StageHeight * 1.5;
////				} else if (this.bgLayerCreatures.gy > Camera.gy + Constants.StageHeight * 0.5) {
//				} else if (this.bgLayerCreatures.gy > Camera.gy + Constants.StageHeight * 1.5) {
//					this.bgLayerCreatures.cycle();
//					this.bgLayerCreatures.gy = Camera.gy - Constants.StageHeight * 1.5;
//				}
//				
//				if (this.bgLayerClouds.gy < Camera.gy - Constants.StageHeight * 1.5) {
//					this.bgLayerClouds.cycle();
//					this.bgLayerClouds.gy = Camera.gy + Constants.StageHeight * 1.5;
//				} else if (this.bgLayerClouds.gy > Camera.gy + Constants.StageHeight * 1.5) {
//					this.bgLayerClouds.cycle();
//					this.bgLayerClouds.gy = Camera.gy - Constants.StageHeight * 1.5;
//				}
//				
//				if (this.bgLayerIslandsSmall.gy < Camera.gy - Constants.StageHeight * 1.5) {
//					this.bgLayerIslandsSmall.cycle();
//					this.bgLayerIslandsSmall.gy = Camera.gy + Constants.StageHeight * 1.5;
//				} else if (this.bgLayerIslandsSmall.gy > Camera.gy + Constants.StageHeight * 1.5) {
//					this.bgLayerIslandsSmall.cycle();
//					this.bgLayerIslandsSmall.gy = Camera.gy - Constants.StageHeight * 1.5;
//				}
//				
//				if (this.bgLayerIslandsLarge.gy < Camera.gy - Constants.StageHeight * 1.5) {
//					this.bgLayerIslandsLarge.cycle();
//					this.bgLayerIslandsLarge.gy = Camera.gy + Constants.StageHeight * 1.5;
//				} else if (this.bgLayerIslandsLarge.gy > Camera.gy + Constants.StageHeight * 1.5) {
//					this.bgLayerIslandsLarge.cycle();
//					this.bgLayerIslandsLarge.gy = Camera.gy - Constants.StageHeight * 1.5;
//				}
				
//				if (this.bgLayerBridges.gy < Camera.gy - Constants.StageHeight * 1.5) {
//					this.bgLayerBridges.cycle();
//					this.bgLayerBridges.gy = Camera.gy + Constants.StageHeight * 1.5;
//				} else if (this.bgLayerBridges.gy > Camera.gy + Constants.StageHeight * 1.5) {
//					this.bgLayerBridges.cycle();
//					this.bgLayerBridges.gy = Camera.gy - Constants.StageHeight * 1.5;
//				}
				
				// hide out of stage element
				if (this.bgLayerPlanets.gy < Camera.gy - Constants.StageHeight - this.bgLayerPlanets.height) {
					this.bgLayerPlanets.visible = false;
				}
				if (Statics.gameTime > this.bgLayerPlanetsExpiration && !this.bgLayerPlanets.visible) { // cycle element
					this.bgLayerPlanets.cycle();
					this.bgLayerPlanets.gy = Camera.gy + Constants.StageHeight * 0.5;
					this.bgLayerPlanets.visible = true;
					this.bgLayerPlanetsExpiration = getExpirationTime(Constants.BgLayerPlanetsDuration);
				}
				
				// hide out of stage element
				if (this.bgLayerCreatures.gy < Camera.gy - Constants.StageHeight - this.bgLayerCreatures.height) {
					this.bgLayerCreatures.visible = false;
				}
				if (Statics.gameTime > this.bgLayerCreaturesExpiration && !this.bgLayerCreatures.visible) { // cycle element
					this.bgLayerCreatures.cycle();
					this.bgLayerCreatures.gy = Camera.gy + Constants.StageHeight * 0.5;
					this.bgLayerCreatures.visible = true;
					this.bgLayerCreaturesExpiration = getExpirationTime(Constants.BgLayerCreaturesDuration);
				}
				
				// hide out of stage element
				if (this.bgLayerClouds.gy < Camera.gy - Constants.StageHeight - this.bgLayerClouds.height) {
					this.bgLayerClouds.visible = false;
				}
				if (Statics.gameTime > this.bgLayerCloudsExpiration && !this.bgLayerClouds.visible) { // cycle element
					this.bgLayerClouds.cycle();
					this.bgLayerClouds.gy = Camera.gy + Constants.StageHeight * 0.5;
					this.bgLayerClouds.visible = true;
					this.bgLayerCloudsExpiration = getExpirationTime(Constants.BgLayerCloudsDuration);
				}
				
				// hide out of stage element
				if (this.bgLayerIslandsSmall.gy < Camera.gy - Constants.StageHeight - this.bgLayerIslandsSmall.height) {
					this.bgLayerIslandsSmall.visible = false;
				}
				if (Statics.gameTime > this.bgLayerIslandsSmallExpiration && !this.bgLayerIslandsSmall.visible) { // cycle element
					this.bgLayerIslandsSmall.cycle();
					this.bgLayerIslandsSmall.gy = Camera.gy + Constants.StageHeight * 0.5;
					this.bgLayerIslandsSmall.visible = true;
					this.bgLayerIslandsSmallExpiration = getExpirationTime(Constants.BgLayerIslandsSmallDuration);
				}
				
				// hide out of stage element
				if (this.bgLayerIslandsLarge.gy < Camera.gy - Constants.StageHeight - this.bgLayerIslandsLarge.height) {
					this.bgLayerIslandsLarge.visible = false;
				}
				if (Statics.gameTime > this.bgLayerIslandsLargeExpiration && !this.bgLayerIslandsLarge.visible) { // cycle element
					this.bgLayerIslandsLarge.cycle();
					this.bgLayerIslandsLarge.gy = Camera.gy + Constants.StageHeight * 0.5;
					this.bgLayerIslandsLarge.visible = true;
					this.bgLayerIslandsLargeExpiration = getExpirationTime(Constants.BgLayerIslandsLargeDuration);
				}
				
				// hide out of stage element
				if (this.bgLayerBridges.gy < Camera.gy - Constants.StageHeight - this.bgLayerBridges.height) {
					this.bgLayerBridges.visible = false;
				}
				if (Statics.gameTime > this.bgLayerBridgesExpiration && !this.bgLayerBridges.visible) { // cycle element
					this.bgLayerBridges.cycle();
					this.bgLayerBridges.gy = Camera.gy + Constants.StageHeight * 0.5;
					this.bgLayerBridges.visible = true;
					this.bgLayerBridgesExpiration = getExpirationTime(Constants.BgLayerBridgesDuration);
				}
				// eof cycling
			}
			else if (this.type == Constants.Foreground) {
				// scroll fg layers
				this.bgLayerBranches.gy += Camera.dy * (1.0 - this.bgLayerBranches.parallaxDepth);
				
				// cycle fg layers
//				if (this.bgLayerBranches.gy < Camera.gy - Constants.StageHeight * 1.5) {
//					this.bgLayerBranches.cycle();
//					this.bgLayerBranches.gy = Camera.gy + Constants.StageHeight * 1.5;
//				} else if (this.bgLayerBranches.gy > Camera.gy + Constants.StageHeight * 1.5) {
//					this.bgLayerBranches.cycle();
//					this.bgLayerBranches.gy = Camera.gy - Constants.StageHeight * 1.5;
//				}
				// hide out of stage element
				if (this.bgLayerBranches.gy < Camera.gy - Constants.StageHeight - this.bgLayerBranches.height) {
					this.bgLayerBranches.visible = false;
				}
				if (Statics.gameTime > this.bgLayerBranchesExpiration && !this.bgLayerBranches.visible) { // cycle element
					this.bgLayerBranches.cycle();
					this.bgLayerBranches.gy = Camera.gy + Constants.StageHeight * 0.5;
					this.bgLayerBranches.visible = true;
					this.bgLayerBranchesExpiration = getExpirationTime(Constants.BgLayerBranchesDuration);
				}
			}
		}
		
		private function getExpirationTime(averageDuration:int):int {
			var actualDuration:int = int(Math.random() * (averageDuration * 2));
//			if (actualDuration < 5000) actualDuration = 5000;
			return (Statics.gameTime + actualDuration);
		}
		
		// scroll sea of fire vertically according to time elapsed
		public function scrollSofVertical(timeDiff:int, heroGy:Number):void {
			// adjust sof height property
			this.sofHeight += timeDiff * 0.1;
			
			// adjust sea of fire so it keeps up with player
			if ((heroGy - this.sofHeight) > Constants.StageHeight) {
				this.sofHeight = heroGy - Constants.StageHeight;
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