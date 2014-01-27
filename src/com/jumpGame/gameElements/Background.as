package com.jumpGame.gameElements {
	
	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Background extends Sprite {
		// sea of fire properties
		public var sofHeight:Number;
		
		private var type:uint; // background or foreground
		
		// images of bg layer 0
//		private var layer0Image0:GameObject;
//		private var layer0Image1:GameObject;
//		private var layer0Image2:GameObject;
		private var layer0Ground:GameObject;
//		private var layer0Sky1_left:GameObject;
//		private var layer0Sky2_left:GameObject;
//		private var layer0Sky3_left:GameObject;
//		private var layer0Sky1_right:GameObject;
//		private var layer0Sky2_right:GameObject;
//		private var layer0Sky3_right:GameObject;
		private var layer0Sky_test:Image;
		
		// other decorative layers
//		private var bgLayerPlanets:BgLayer; // bg planet/pirateship/moon
		private var bgLayerCreatures:BgLayer; // dragon/stingray
		private var bgLayerClouds:BgLayer; // bg clouds
		private var bgLayerIslandsSmall:BgLayer; // bg small islands
		private var bgLayerIslandsLarge:BgLayer; // bg medium/large islands
		private var bgLayerBridges:BgLayer; // bg bridges
		private var bgLayerBranches:BgLayer; // fg branches
		private var bgLayerFairy:BgLayer;
		
		// expiration times
//		private var bgLayerPlanetsExpiration:int;
		private var bgLayerCreaturesExpiration:int;
		private var bgLayerCloudsExpiration:int;
		private var bgLayerIslandsSmallExpiration:int;
		private var bgLayerIslandsLargeExpiration:int;
		private var bgLayerBridgesExpiration:int;
		private var bgLayerBranchesExpiration:int;
		private var bgLayerFairyExpiration:int;
		private var bgFloatingStarsExpiration:int;
		
		// sea of fire layers (waves)
		private var sofLayer1:SofLayer; // bg
		private var sofLayer2:SofLayer; // bg
		private var sofLayer3:SofLayer; // fg
		private var sofLayer4:SofLayer; // fg
		private var sofLayer5:SofLayer; // fg
		public var sofQuad:Quad; // fg
		
		private var catapult:MovieClip;
		private var heroIdle:MovieClip; // idle hero standing on catapult
		private var catapultLaunched:Boolean;
		
		private var skyImageWidth:Number;
		private var skyImageHeight:Number;
		private var groundImageHeight:Number;
		private var layerPlanetsHeight:Number;
		private var layerCreaturesHeight:Number;
		private var layerCloudsHeight:Number;
		private var layerIslandsSmallHeight:Number;
		private var layerIslandsLargeHeight:Number;
		private var layerBridgesHeight:Number;
		private var catapultHeight:Number;
		private var layerBranchesHeight:Number;
		
		// floating stars/snow
		private var starList:Vector.<BgStar>;
		private var starDx:Number;
		
		private var stageWidth:int;
		private var stageHeight:int;
		
		
		public function Background(type:uint) {
			super();
			
			this.touchable = false;
			this.blendMode = BlendMode.NORMAL;
			this.type = type;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function initialize():void {
			this.stageWidth = Statics.stageWidth;
			this.stageHeight = Statics.stageHeight;
			this.sofHeight = Constants.InitialSofHeight;
			
			if (this.type == Constants.Background) {
//				bgLayerPlanetsExpiration = Statics.gameTime + Constants.BgLayerPlanetsDuration;
				bgLayerCreaturesExpiration = Statics.gameTime + Constants.BgLayerCreaturesDuration;
				bgLayerCloudsExpiration = Statics.gameTime + Constants.BgLayerCloudsDuration;
				bgLayerIslandsSmallExpiration = Statics.gameTime + Constants.BgLayerIslandsSmallDuration;
				bgLayerIslandsLargeExpiration = Statics.gameTime + Constants.BgLayerIslandsLargeDuration;
				bgLayerBridgesExpiration = Statics.gameTime + Constants.BgLayerBridgesDuration;
			
				// sky
//				skyImageWidth = layer0Sky1_left.width;
//				skyImageHeight = layer0Sky1_left.height;
//				layer0Sky1_left.gx = int(-this.stageWidth / 2);
//				layer0Sky1_left.gy = int(-this.stageHeight / 2);
//				
//				layer0Sky2_left.gx = int(-this.stageWidth / 2);
//				layer0Sky2_left.gy = int(-this.stageHeight / 2 + skyImageHeight);
//				
//				layer0Sky3_left.gx = int(-this.stageWidth / 2);
//				layer0Sky3_left.gy = int(-this.stageHeight / 2 + skyImageHeight * 2);
//				
//				layer0Sky1_right.gx = int(-this.stageWidth / 2 + skyImageWidth);
//				layer0Sky1_right.gy = int(-this.stageHeight / 2);
//				
//				layer0Sky2_right.gx = int(-this.stageWidth / 2 + skyImageWidth);
//				layer0Sky2_right.gy = int(-this.stageHeight / 2 + skyImageHeight);
//				
//				layer0Sky3_right.gx = int(-this.stageWidth / 2 + skyImageWidth);
//				layer0Sky3_right.gy = int(-this.stageHeight / 2 + skyImageHeight * 2);
				// eof sky
				if (Statics.randomSkyNum != null) {
					if (this.layer0Sky_test == null) {
						this.layer0Sky_test = new Image(Statics.assets.getTexture("bg" + Statics.randomSkyNum));
						layer0Sky_test.blendMode = BlendMode.NONE;
//						this.addChild(layer0Sky_test);
						this.addChildAt(layer0Sky_test, 0);
					} else {
						this.layer0Sky_test.texture = Statics.assets.getTexture("bg" + Statics.randomSkyNum);
					}
				}
				
				// floating stars
				for (var i:uint = 0; i < Constants.NumBgFloatingStarsInGame; i++) {
					this.starList[i].initialize(false);
				}
				bgFloatingStarsExpiration = getExpirationTime(Constants.BgFloatingStarsDuration);
				starDx = (Math.random() - 0.5) * Constants.FloatingStarsBaseVelocity;
				
				// ground
				layer0Ground.gx = 0;
				layer0Ground.gy = int(-this.stageHeight / 2);
				this.addChild(layer0Ground);
//				layer0Ground.visible = false; // testing
//				this.setChildIndex(layer0Ground, 0); // send to back
				this.groundImageHeight = layer0Ground.height;
				
				this.sofLayer1.gx = 0;
				this.sofLayer1.gy = this.sofHeight + Constants.SofLayer1HeightOffset;
				
//				this.bgLayerPlanets.gx = -this.stageWidth / 2; // place at top left of screen
//				this.bgLayerPlanets.gy = this.stageHeight / 2;
//				this.bgLayerPlanets.visible = false;
//				this.layerPlanetsHeight = this.bgLayerPlanets.height;
				
				this.bgLayerCreatures.gx = -this.stageWidth / 2; // place at top left of screen
				this.bgLayerCreatures.gy = this.stageHeight / 2;
				this.bgLayerCreatures.visible = false;
				this.layerCreaturesHeight = this.bgLayerCreatures.height;
				
				this.bgLayerClouds.gx = -this.stageWidth / 2; // place at top left of screen
				this.bgLayerClouds.gy = this.stageHeight / 2;
				this.bgLayerClouds.visible = false;
				this.layerCloudsHeight = this.bgLayerClouds.height;
				
				this.bgLayerIslandsSmall.gx = -this.stageWidth / 2; // place at top left of screen
				this.bgLayerIslandsSmall.gy = this.stageHeight / 2;
				this.bgLayerIslandsSmall.visible = false;
				this.layerIslandsSmallHeight = this.bgLayerIslandsSmall.height;
				
				this.bgLayerIslandsLarge.gx = -this.stageWidth / 2; // place at top left of screen
				this.bgLayerIslandsLarge.gy = this.stageHeight / 2;
				this.bgLayerIslandsLarge.visible = false;
				this.layerIslandsLargeHeight = this.bgLayerIslandsLarge.height;
				
				this.bgLayerBridges.gx = -this.stageWidth / 2; // place at top left of screen
				this.bgLayerBridges.gy = this.stageHeight / 2;
				this.bgLayerBridges.visible = false;
				this.layerBridgesHeight = this.bgLayerBridges.height;
				
				this.sofLayer2.gx = 0;
				this.sofLayer2.gy = this.sofHeight + Constants.SofLayer2HeightOffset;
			}
			else if (this.type == Constants.Foreground) {
				// initialize catapult
				catapult.x = this.stageWidth / 2;
				catapult.y = this.stageHeight;
				catapultLaunched = false;
				this.addChild(catapult);
				catapult.visible = true;
				catapult.stop();
				starling.core.Starling.juggler.add(catapult);
				this.catapultHeight = catapult.texture.height;
				
				// initialize hero idle animation
				heroIdle.x = this.stageWidth / 2;
				heroIdle.y = catapult.y - 50;
				this.addChild(heroIdle);
				starling.core.Starling.juggler.add(heroIdle);
				
				// initialize other foreground elements
				bgLayerBranchesExpiration = Statics.gameTime + Constants.BgLayerBranchesDuration;
//				bgLayerFairyExpiration = Statics.gameTime; // testing
				bgLayerFairyExpiration = getExpirationTime(Constants.BgLayerFairyDuration);
				
				this.sofLayer3.gx = 0;
				this.sofLayer3.gy = this.sofHeight + Constants.SofLayer3HeightOffset;
				
				this.sofLayer4.gx = 0;
				this.sofLayer4.gy = this.sofHeight + Constants.SofLayer4HeightOffset;
				
				this.bgLayerBranches.gx = -this.stageWidth / 2; // place at top left of screen
				this.bgLayerBranches.gy = this.stageHeight / 2;
				this.bgLayerBranches.visible = false;
				this.layerBranchesHeight = this.bgLayerBranches.height;
				
				this.bgLayerFairy.gx = -this.stageWidth / 2; // place at top left of screen
				this.bgLayerFairy.gy = this.stageHeight / 2;
				this.bgLayerFairy.visible = false;
				this.bgLayerFairy.initLayerFairy();
				
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
				
				// add sky images
//				layer0Sky1_left = new GameObject();
//				var image1:Image = new Image(Statics.assets.getTexture("layer0_sky"));
//				layer0Sky1_left.addChild(image1);
//				layer0Sky1_left.blendMode = BlendMode.NONE;
//				layer0Sky1_left.pivotY = layer0Sky1_left.height;
//				this.addChild(layer0Sky1_left);
//				
//				layer0Sky2_left = new GameObject();
//				var image2:Image = new Image(Statics.assets.getTexture("layer0_sky"));
//				layer0Sky2_left.addChild(image2);
//				layer0Sky2_left.blendMode = BlendMode.NONE;
//				layer0Sky2_left.pivotY = layer0Sky2_left.height;
//				this.addChild(layer0Sky2_left);
//				
//				layer0Sky3_left = new GameObject();
//				var image3:Image = new Image(Statics.assets.getTexture("layer0_sky"));
//				layer0Sky3_left.addChild(image3);
//				layer0Sky3_left.blendMode = BlendMode.NONE;
//				layer0Sky3_left.pivotY = layer0Sky3_left.height;
//				this.addChild(layer0Sky3_left);
//				
//				layer0Sky1_right = new GameObject();
//				var image4:Image = new Image(Statics.assets.getTexture("layer0_sky"));
//				layer0Sky1_right.addChild(image4);
//				layer0Sky1_right.blendMode = BlendMode.NONE;
//				layer0Sky1_right.pivotY = layer0Sky1_right.height;
//				this.addChild(layer0Sky1_right);
//				
//				layer0Sky2_right = new GameObject();
//				var image5:Image = new Image(Statics.assets.getTexture("layer0_sky"));
//				layer0Sky2_right.addChild(image5);
//				layer0Sky2_right.blendMode = BlendMode.NONE;
//				layer0Sky2_right.pivotY = layer0Sky2_right.height;
//				this.addChild(layer0Sky2_right);
//				
//				layer0Sky3_right = new GameObject();
//				var image6:Image = new Image(Statics.assets.getTexture("layer0_sky"));
//				layer0Sky3_right.addChild(image6);
//				layer0Sky3_right.blendMode = BlendMode.NONE;
//				layer0Sky3_right.pivotY = layer0Sky3_right.height;
//				this.addChild(layer0Sky3_right);
				// eof add sky images
				
				// create bg sky
				
				// add ground image
				layer0Ground = new GameObject();
				var image0:Image = new Image(Statics.assets.getTexture("layer0_ground"));
				layer0Ground.addChild(image0);
//				layer0Ground.blendMode = BlendMode.NONE;
				layer0Ground.pivotX = Math.ceil(layer0Ground.width / 2);
				layer0Ground.pivotY = layer0Ground.height;
				
				// add sea of fire layer 1
				this.sofLayer1 = new SofLayer(2);
				this.sofLayer1.parallaxDepth = 0.04;
				this.sofLayer1.scaleX = Constants.SofLayer1ScaleFactor;
				this.sofLayer1.scaleY = Constants.SofLayer1ScaleFactor;
				this.addChild(this.sofLayer1);
				
				// add bg layer: moon/pirate ship/planet
//				this.bgLayerPlanets = new BgLayer(10);
//				this.bgLayerPlanets.parallaxDepth = Constants.BgLayerPlanetsParallaxDepth;
//				this.addChild(this.bgLayerPlanets);
				
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
				
				// add layer: large islands
				this.bgLayerIslandsLarge = new BgLayer(40);
				this.bgLayerIslandsLarge.parallaxDepth = Constants.BgLayerIslandsLargeParallaxDepth;
				this.addChild(this.bgLayerIslandsLarge);
				
				// add layer: bridges
				this.bgLayerBridges = new BgLayer(50);
				this.bgLayerBridges.parallaxDepth = Constants.BgLayerBridgesParallaxDepth;
				this.addChild(this.bgLayerBridges);
				
				// add background floating stars
				this.starList = new Vector.<BgStar>();
				for (var i:uint = 0; i < Constants.NumBgFloatingStarsInGame; i++) { // add this many floating stars
					var star:BgStar = new BgStar();
					this.starList.push(star);
					this.addChild(star);
				}
				
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
				
				// add layer 60: right in front of player; branches
				this.bgLayerBranches = new BgLayer(60);
				this.bgLayerBranches.parallaxDepth = Constants.bgLayerBranchesParallaxDepth;
				this.addChild(this.bgLayerBranches);
				
				// add layer 70: fairy
				this.bgLayerFairy = new BgLayer(70);
				this.addChild(this.bgLayerFairy);
				
				// catapult
//				var bgLayerCatapult:GameObject = new GameObject();
				catapult = new MovieClip(Statics.assets.getTextures("Catapult"), 40);
				catapult.pivotX = Math.ceil(catapult.width  / 2); // center art on registration point
				catapult.pivotY = catapult.height;
				catapult.loop = false;
				
				// hero idle animation
				heroIdle = new MovieClip(Statics.assets.getTextures("CharPrinceIdle"), 40);
				heroIdle.pivotX = Math.ceil(heroIdle.width  / 2); // center art on registration point
				heroIdle.pivotY = heroIdle.height;
				heroIdle.scaleX = 0.5;
				heroIdle.scaleY = 0.5;
				
				// add sea of fire layer 5: closes to player
				this.sofLayer5 = new SofLayer(2);
				this.sofLayer5.parallaxDepth = 0.64;
				this.sofLayer5.scaleX = Constants.SofLayer5ScaleFactor;
				this.sofLayer5.scaleY = Constants.SofLayer5ScaleFactor;
				this.addChild(this.sofLayer5);
				
				// add sea of fire endless quad
				this.sofQuad = new Quad(Statics.stageWidth, 10000, 0xdb3a00);
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
//		public function scroll(timeDiff:int, leftKeyDown:Boolean = false, rightKeyDown:Boolean = false):void {
		public function scroll(timeDiff:int, cameraGy:Number, cameraDy:Number, heroDx:Number = 0):void {
			if (this.type == Constants.Background) {
				// scroll bg layer 0 sky
//				this.layer0Sky1_left.gy += cameraDy * (1.0 - Constants.BgLayer0ParallaxDepth);
//				this.layer0Sky2_left.gy += cameraDy * (1.0 - Constants.BgLayer0ParallaxDepth);
//				this.layer0Sky3_left.gy += cameraDy * (1.0 - Constants.BgLayer0ParallaxDepth);
//				this.layer0Sky1_right.gy += cameraDy * (1.0 - Constants.BgLayer0ParallaxDepth);
//				this.layer0Sky2_right.gy += cameraDy * (1.0 - Constants.BgLayer0ParallaxDepth);
//				this.layer0Sky3_right.gy += cameraDy * (1.0 - Constants.BgLayer0ParallaxDepth);
//				
//				var skyHorizontalSpeed:Number = 0.01;
//				this.layer0Sky1_left.gx -= timeDiff * skyHorizontalSpeed;
//				this.layer0Sky2_left.gx -= timeDiff * skyHorizontalSpeed;
//				this.layer0Sky3_left.gx -= timeDiff * skyHorizontalSpeed;
//				this.layer0Sky1_right.gx -= timeDiff * skyHorizontalSpeed;
//				this.layer0Sky2_right.gx -= timeDiff * skyHorizontalSpeed;
//				this.layer0Sky3_right.gx -= timeDiff * skyHorizontalSpeed;
				
				// scroll floating stars
				if (Statics.gameTime > this.bgFloatingStarsExpiration) {
//					starDx = (Math.random() - 0.5) * Constants.FloatingStarsBaseVelocity;
					if (Math.random() < 0.5) starDx += 0.02;
					else starDx -= 0.02;
					this.bgFloatingStarsExpiration = getExpirationTime(Constants.BgFloatingStarsDuration);
				}
				for (var i:uint = 0; i < Constants.NumBgFloatingStarsInGame; i++) {
//					this.starList[i].update(timeDiff, leftKeyDown, rightKeyDown);
					this.starList[i].update(timeDiff, this.starDx + heroDx);
				}
				
				// scroll / hide ground after it scrolls out
				if (this.layer0Ground.visible) {
					this.layer0Ground.gy += cameraDy * (1.0 - Constants.BgLayer0ParallaxDepth);
					// hide it
					if (this.layer0Ground.gy < -this.stageHeight / 2 - this.groundImageHeight) {
						this.removeChild(layer0Ground);
					}
				}
				
				// move sky image to top after it scrolls out vertically
//				if (this.layer0Sky1_left.gy < cameraGy - this.stageHeight / 2 - this.skyImageHeight) {
//					this.layer0Sky1_left.gy = this.layer0Sky3_left.gy + this.skyImageHeight;
//				}
//				if (this.layer0Sky2_left.gy < cameraGy - this.stageHeight / 2 - this.skyImageHeight) {
//					this.layer0Sky2_left.gy = this.layer0Sky1_left.gy + this.skyImageHeight;
//				}
//				if (this.layer0Sky3_left.gy < cameraGy - this.stageHeight / 2 - this.skyImageHeight) {
//					this.layer0Sky3_left.gy = this.layer0Sky2_left.gy + this.skyImageHeight;
//				}
//				if (this.layer0Sky1_right.gy < cameraGy - this.stageHeight / 2 - this.skyImageHeight) {
//					this.layer0Sky1_right.gy = this.layer0Sky3_right.gy + this.skyImageHeight;
//				}
//				if (this.layer0Sky2_right.gy < cameraGy - this.stageHeight / 2 - this.skyImageHeight) {
//					this.layer0Sky2_right.gy = this.layer0Sky1_right.gy + this.skyImageHeight;
//				}
//				if (this.layer0Sky3_right.gy < cameraGy - this.stageHeight / 2 - this.skyImageHeight) {
//					this.layer0Sky3_right.gy = this.layer0Sky2_right.gy + this.skyImageHeight;
//				}
				
				// move sky to right after it scrolls out horizontally
//				if (layer0Sky1_left.gx < int(-this.stageWidth / 2 - skyImageWidth)) layer0Sky1_left.gx = int(layer0Sky1_right.gx + skyImageWidth);
//				if (layer0Sky2_left.gx < int(-this.stageWidth / 2 - skyImageWidth)) layer0Sky2_left.gx = int(layer0Sky2_right.gx + skyImageWidth);
//				if (layer0Sky3_left.gx < int(-this.stageWidth / 2 - skyImageWidth)) layer0Sky3_left.gx = int(layer0Sky3_right.gx + skyImageWidth);
//				if (layer0Sky1_right.gx < int(-this.stageWidth / 2 - skyImageWidth)) layer0Sky1_right.gx = int(layer0Sky1_left.gx + skyImageWidth);
//				if (layer0Sky2_right.gx < int(-this.stageWidth / 2 - skyImageWidth)) layer0Sky2_right.gx = int(layer0Sky2_left.gx + skyImageWidth);
//				if (layer0Sky3_right.gx < int(-this.stageWidth / 2 - skyImageWidth)) layer0Sky3_right.gx = int(layer0Sky3_left.gx + skyImageWidth);
				
				// scroll planets layer
//				if (this.bgLayerPlanets.visible) {
//					this.bgLayerPlanets.updateLayerPlanets(timeDiff);
//					this.bgLayerPlanets.gy += cameraDy * (1.0 - this.bgLayerPlanets.parallaxDepth);
//					if (this.bgLayerPlanets.gy < cameraGy - this.stageHeight - this.layerPlanetsHeight) {
//						this.bgLayerPlanets.visible = false;
//					}
//				}
//				else if (Statics.gameTime > this.bgLayerPlanetsExpiration) { // cycle element
//					this.bgLayerPlanets.cycle();
//					this.bgLayerPlanets.gy = cameraGy + this.stageHeight * 0.5;
//					this.bgLayerPlanets.visible = true;
//					this.bgLayerPlanetsExpiration = getExpirationTime(Constants.BgLayerPlanetsDuration);
//				}
				
				// scroll dragon/stingray layer
				if (this.bgLayerCreatures.visible) {
					this.bgLayerCreatures.updateLayerCreatures(timeDiff);
					this.bgLayerCreatures.gy += cameraDy * (1.0 - this.bgLayerCreatures.parallaxDepth);
					if (this.bgLayerCreatures.gy < cameraGy - this.stageHeight - this.layerCreaturesHeight) {
						this.bgLayerCreatures.visible = false;
					}
				}
				else if (Statics.gameTime > this.bgLayerCreaturesExpiration) { // cycle element
					this.bgLayerCreatures.cycle();
					this.bgLayerCreatures.gy = cameraGy + this.stageHeight * 0.5;
					this.bgLayerCreatures.visible = true;
					this.bgLayerCreaturesExpiration = getExpirationTime(Constants.BgLayerCreaturesDuration);
				}
				
				// scroll clouds layer
				if (this.bgLayerClouds.visible) {
					this.bgLayerClouds.updateLayerClouds(timeDiff);
					this.bgLayerClouds.gy += cameraDy * (1.0 - this.bgLayerClouds.parallaxDepth);
					if (this.bgLayerClouds.gy < cameraGy - this.stageHeight - this.layerCloudsHeight) {
						this.bgLayerClouds.visible = false;
					}
				}
				else if (Statics.gameTime > this.bgLayerCloudsExpiration) { // cycle element
					this.bgLayerClouds.cycle();
					this.bgLayerClouds.gy = cameraGy + this.stageHeight * 0.5;
					this.bgLayerClouds.visible = true;
					this.bgLayerCloudsExpiration = getExpirationTime(Constants.BgLayerCloudsDuration);
				}
				
				// scroll small islands layer
				if (this.bgLayerIslandsSmall.visible) {
					this.bgLayerIslandsSmall.gy += cameraDy * (1.0 - this.bgLayerIslandsSmall.parallaxDepth);
					if (this.bgLayerIslandsSmall.gy < cameraGy - this.stageHeight - this.layerIslandsSmallHeight) {
						this.bgLayerIslandsSmall.visible = false;
					}
				}
				else if (Statics.gameTime > this.bgLayerIslandsSmallExpiration) { // cycle element
					this.bgLayerIslandsSmall.cycle();
					this.bgLayerIslandsSmall.gy = cameraGy + this.stageHeight * 0.5;
					this.bgLayerIslandsSmall.visible = true;
					this.bgLayerIslandsSmallExpiration = getExpirationTime(Constants.BgLayerIslandsSmallDuration);
				}
				
				// scroll medium and large islands layer
				if (this.bgLayerIslandsLarge.visible) {
					this.bgLayerIslandsLarge.gy += cameraDy * (1.0 - this.bgLayerIslandsLarge.parallaxDepth);
					if (this.bgLayerIslandsLarge.gy < cameraGy - this.stageHeight - this.layerIslandsLargeHeight) {
						this.bgLayerIslandsLarge.visible = false;
					}
				}
				else if (Statics.gameTime > this.bgLayerIslandsLargeExpiration) { // cycle element
					this.bgLayerIslandsLarge.cycle();
					this.bgLayerIslandsLarge.gy = cameraGy + this.stageHeight * 0.5;
					this.bgLayerIslandsLarge.visible = true;
					this.bgLayerIslandsLargeExpiration = getExpirationTime(Constants.BgLayerIslandsLargeDuration);
				}
				
				// scroll bridges layer
				if (this.bgLayerBridges.visible) {
					this.bgLayerBridges.gy += cameraDy * (1.0 - this.bgLayerBridges.parallaxDepth);
					if (this.bgLayerBridges.gy < cameraGy - this.stageHeight - this.layerBridgesHeight) {
						this.bgLayerBridges.visible = false;
					}
				}
				else if (Statics.gameTime > this.bgLayerBridgesExpiration) { // cycle element
					this.bgLayerBridges.cycle();
					this.bgLayerBridges.gy = cameraGy + this.stageHeight * 0.5;
					this.bgLayerBridges.visible = true;
					this.bgLayerBridgesExpiration = getExpirationTime(Constants.BgLayerBridgesDuration);
				}
			}
			else if (this.type == Constants.Foreground) {
				// scroll catapult
				if (this.heroIdle.y > 0) {
					if (catapultLaunched) {
						this.heroIdle.y -= 2 * timeDiff;
					}
				}
				
				if (this.catapult.visible) {
					if (this.catapult.y > this.stageHeight + this.catapultHeight) { // hide catapult
						// remove catapult
						this.catapult.visible = false;
						this.removeChild(catapult);
						starling.core.Starling.juggler.remove(catapult);
					} else {
						this.catapult.y -= cameraDy * (1.0 - this.bgLayerBranches.parallaxDepth); // scroll catapult out of stage
					}
				}
				
				// scroll branches layer
				if (this.bgLayerBranches.visible) {
					this.bgLayerBranches.gy += cameraDy * (1.0 - this.bgLayerBranches.parallaxDepth);
					if (this.bgLayerBranches.gy < cameraGy - this.stageHeight - this.layerBranchesHeight) {
						this.bgLayerBranches.visible = false;
					}
				}
				else if (Statics.gameTime > this.bgLayerBranchesExpiration) { // cycle element
					this.bgLayerBranches.cycle();
					this.bgLayerBranches.gy = cameraGy + this.stageHeight * 0.5;
					this.bgLayerBranches.visible = true;
					this.bgLayerBranchesExpiration = getExpirationTime(Constants.BgLayerBranchesDuration);
				}
				
				// scroll fairy layer
				if (this.bgLayerFairy.visible) {
					this.bgLayerFairy.updateLayerFairy(timeDiff);
					this.bgLayerFairy.gy += cameraDy; // scroll layer
				}
				else if (Statics.gameTime > this.bgLayerFairyExpiration) { // cycle element
					this.bgLayerFairy.setupLayerFairyTargets(); // set up fairy flight targets
					this.bgLayerFairy.gy = cameraGy + this.stageHeight * 0.5;
					this.bgLayerFairy.visible = true;
					this.bgLayerFairyExpiration = getExpirationTime(Constants.BgLayerFairyDuration);
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
//			if ((heroGy - this.sofHeight) > this.stageHeight * 3) {
//				this.sofHeight = heroGy - this.stageHeight * 3;
//			}
			// test
			if ((heroGy - this.sofHeight) > this.stageHeight * 1.2) {
				this.sofHeight = heroGy - this.stageHeight * 1.2;
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
		
		public function launchCatapult():void {
			if (!catapultLaunched) {
				if (!Sounds.sfxMuted) Statics.assets.playSound("SND_AIRJUMP");
				this.catapult.play();
				catapultLaunched = true;
			}
		}
		
		public function hideHeroIdle():void {
			// remove hero idle animation
			this.removeChild(heroIdle);
			starling.core.Starling.juggler.remove(heroIdle);
		}
	}
}