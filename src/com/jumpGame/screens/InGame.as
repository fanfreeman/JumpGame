package com.jumpGame.screens
{
	import com.jumpGame.customObjects.Localization;
	import com.jumpGame.gameElements.Background;
	import com.jumpGame.gameElements.Camera;
	import com.jumpGame.gameElements.Contraption;
	import com.jumpGame.gameElements.Hero;
	import com.jumpGame.gameElements.Lightning;
	import com.jumpGame.gameElements.Platform;
	import com.jumpGame.gameElements.Transfiguration;
	import com.jumpGame.gameElements.contraptions.Bell;
	import com.jumpGame.gameElements.contraptions.Cannon;
	import com.jumpGame.gameElements.contraptions.CannonFromLeft;
	import com.jumpGame.gameElements.contraptions.PowerupBox;
	import com.jumpGame.gameElements.contraptions.PowerupBoxBlue;
	import com.jumpGame.gameElements.contraptions.PowerupBoxFire;
	import com.jumpGame.gameElements.contraptions.PowerupBoxGreen;
	import com.jumpGame.gameElements.contraptions.PowerupBoxPink;
	import com.jumpGame.gameElements.contraptions.Train;
	import com.jumpGame.gameElements.contraptions.TrainFromLeft;
	import com.jumpGame.gameElements.contraptions.Witch;
	import com.jumpGame.gameElements.platforms.Attractor;
	import com.jumpGame.gameElements.platforms.Bouncer;
	import com.jumpGame.gameElements.platforms.Cannonball;
	import com.jumpGame.gameElements.platforms.Coin;
	import com.jumpGame.gameElements.platforms.CoinBronze;
	import com.jumpGame.gameElements.platforms.CoinBubble;
	import com.jumpGame.gameElements.platforms.CoinSilver;
	import com.jumpGame.gameElements.platforms.Comet;
	import com.jumpGame.gameElements.platforms.PlatformDrop;
	import com.jumpGame.gameElements.platforms.PlatformDropBoost;
	import com.jumpGame.gameElements.platforms.PlatformMobile;
	import com.jumpGame.gameElements.platforms.PlatformMobileBoost;
	import com.jumpGame.gameElements.platforms.PlatformNormal;
	import com.jumpGame.gameElements.platforms.PlatformNormalBoost;
	import com.jumpGame.gameElements.platforms.PlatformSuper;
	import com.jumpGame.gameElements.platforms.Repulsor;
	import com.jumpGame.gameElements.platforms.SpikyBomb;
	import com.jumpGame.gameElements.platforms.Star;
	import com.jumpGame.gameElements.platforms.StarBlue;
	import com.jumpGame.gameElements.platforms.StarDark;
	import com.jumpGame.gameElements.platforms.StarMini;
	import com.jumpGame.gameElements.platforms.StarRed;
	import com.jumpGame.gameElements.powerups.Attraction;
	import com.jumpGame.gameElements.powerups.Blink;
	import com.jumpGame.gameElements.powerups.CometRun;
	import com.jumpGame.gameElements.powerups.Expansion;
	import com.jumpGame.gameElements.powerups.Extender;
	import com.jumpGame.gameElements.powerups.Levitation;
	import com.jumpGame.gameElements.powerups.MasterDapan;
	import com.jumpGame.gameElements.powerups.Pyromancy;
	import com.jumpGame.gameElements.powerups.VermilionBird;
	import com.jumpGame.level.ContraptionControl;
	import com.jumpGame.level.LevelParser;
	import com.jumpGame.objectPools.ObjectPool;
	import com.jumpGame.ui.GameOverContainer;
	import com.jumpGame.ui.HUD;
	
	import flash.geom.Rectangle;
	import flash.utils.getDefinitionByName;
	import flash.utils.getTimer;
	
//	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;
	
	public class InGame extends Sprite
	{
		// ------------------------------------------------------------------------------------------------------------
		// GAME OBJECTS
		// ------------------------------------------------------------------------------------------------------------
		
		// game backgrounds and sea of fire waves
		private var bg:Background;
		private var fg:Background; // decorative layer in front of hero's layer
		
		// camera
		private var camera:Camera;
		
		// hero
		private var hero:Hero;
		
		// hero out of stage indicator
//		private var heroPointerLeft:Image;
//		private var heroPointerRight:Image;
		
		// platforms
		private var platformsList:Vector.<Platform>;
		private var platformsListLength:uint;
		
		// contraptions
		private var contraptionsList:Vector.<Contraption>;
		private var contraptionsListLength:uint;
		
		// powerups
//		private var powerupsList:Vector.<GameObject>;
		private var powerupsListLength:uint;
		
		// comet bright light
		private var brightLightImage:Image;
		
		// big coin caption
//		private var bigCoinCaption:Image;
		
		// ------------------------------------------------------------------------------------------------------------
		// GAME PROPERTIES AND DATA
		// ------------------------------------------------------------------------------------------------------------
		
		// Time calculation for animation
		private var gameStartTime:int;
		private var timeDiffReal:int;
		private var timeDiffControlled:Number;
		//private var speedFactor:Number = 1.048 * 2; // game speed multiplier [1.099]
//		private var speedFactor:Number = 1.099;
		
		// coins obtained
		private var coinsObtained:int;
		
		private var heroHasBouncedOffSof:Boolean;
		
		// fps calculation
		private var frameCount:int;
		private var timeFor60frames:Number;
		private var totalFps:Number;
		private var fpsCounts:int;
		
		// power dulication enabled flag
		private var isDuplicationEnabled:Boolean;
		
		private var tutorialOn:Boolean;
		private var tutorialProgress:uint;
		
		// game element bounds
		private var platformBounds:Rectangle;
		
		private var stageWidth:int;
		private var stageHeight:int;
		
		// ------------------------------------------------------------------------------------------------------------
		// GAME INTERACTION 
		// ------------------------------------------------------------------------------------------------------------
		
		// time to end the game
		private var endGameTime:int;
		
//		// music mode variables
//		private var moveMadeThisTurn:Boolean = false;
//		private var moveMade:uint = 0;
		
		// transfiguration activation
		private var transfiguration:Transfiguration;
		
		// ------------------------------------------------------------------------------------------------------------
		// USER CONTROL
		// ------------------------------------------------------------------------------------------------------------
		
		// keyboard input
		private var leftArrow:Boolean;
		private var rightArrow:Boolean;
//		private var upArrow:Boolean;
//		private var downArrow:Boolean;
		
		// discrete key presses
		private var discreteLeft:Boolean;
		private var discreteRight:Boolean;
		
		// whether or not the player has control of the hero
		private var playerControl:Boolean;
		
		// ------------------------------------------------------------------------------------------------------------
		// PARTICLES
		// ------------------------------------------------------------------------------------------------------------
		
		// weather
		private var weather:Weather;
		
		// lightning
		private var lightning:Lightning;
		
		private var isHardwareRendering:Boolean;
		
		// ------------------------------------------------------------------------------------------------------------
		// HUD
		// ------------------------------------------------------------------------------------------------------------
		
		/** HUD Container. */		
		private var hud:HUD;
		
		// in game menu
		private var inGameMenu:InGameMenu;
		
		// ------------------------------------------------------------------------------------------------------------
		// INTERFACE OBJECTS
		// ------------------------------------------------------------------------------------------------------------
		
		// menu
		public var menu:Menu;
		
		/** GameOver Container. */
		private var gameOverContainer:GameOverContainer;
		
		// localization strings
		private var localization:Localization;
		
		/** Kick Off button in the beginning of the game .*/
		//private var startButton:starling.display.Button;
		
		/** Tween object for game over container. */
//		private var tween_gameOverContainer:Tween;
		
		// ------------------------------------------------------------------------------------------------------------
		// LEVEL PARSING AND GENERATION
		// ------------------------------------------------------------------------------------------------------------
		
		private var levelParser:LevelParser;
		private var contraptionControl:ContraptionControl;
		
		// ------------------------------------------------------------------------------------------------------------
		// Power Ups
		// ------------------------------------------------------------------------------------------------------------
		
		private var powerupTeleportation:Blink;
		private var powerupAttraction:Attraction;
		private var powerupDuplication:Extender;
		private var powerupSafety:Levitation;
		private var powerupBarrels:Pyromancy;
		private var powerupBroomstick:Expansion;
		private var powerupVermilion:VermilionBird;
		private var powerupDaPan:MasterDapan;
		private var powerupCometRun:CometRun;
		
		// ------------------------------------------------------------------------------------------------------------
		// METHODS
		// ------------------------------------------------------------------------------------------------------------

		public function InGame(menu:Menu)
		{
			super();
			this.menu = menu;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			drawGame();
			drawGameOverScreen();
		}
		
		/**
		 * Create all game object in this method
		 * This is execuated as soon as the binary is loaded
		 */
		private function drawGame():void
		{
			this.isHardwareRendering = Statics.isHardwareRendering;
			
			this.localization = new Localization();
			
			this.camera = new Camera();
			this.camera.isHardwareRendering = this.isHardwareRendering;
			
			this.platformBounds = new Rectangle();
			
			// set up background
			this.bg = new Background(Constants.Background);
			this.addChild(this.bg);
//			this.setChildIndex(this.bg, 0); // push background to back
			
			// set up big coin caption
//			bigCoinCaption = new Image(Assets.getSprite("AtlasTexturePlatforms").getTexture("BigCoinCaption0000"));
//			bigCoinCaption.pivotX = Math.ceil(bigCoinCaption.texture.width  / 2); // center art on registration point
//			bigCoinCaption.pivotY = Math.ceil(bigCoinCaption.texture.height / 2);
//			this.addChild(bigCoinCaption);
			
			hud = new HUD();
			this.addChild(hud);
			
			// set up comet bright light
			brightLightImage = new Image(Statics.assets.getTexture("BrightLight0000"));
			brightLightImage.touchable = false;
			brightLightImage.pivotX = Math.ceil(brightLightImage.width / 2); // center image on registration point
			brightLightImage.pivotY = Math.ceil(brightLightImage.height / 2);
			this.addChild(brightLightImage);
			
			// set up hero (atlas 2)
			this.hero = new Hero(hud);
			this.addChild(hero);
			
			// set up hero out of stage indicators
//			heroPointerLeft = new Image(Assets.getSprite("AtlasTexture2").getTexture("Arrow0000"));
//			heroPointerLeft.pivotY = Math.ceil(heroPointerLeft.texture.height / 2);
//			this.addChild(heroPointerLeft);
//			
//			heroPointerRight = new Image(Assets.getSprite("AtlasTexture2").getTexture("Arrow0000"));
//			heroPointerRight.scaleX = -1;
//			heroPointerRight.pivotY = Math.ceil(heroPointerRight.texture.height / 2);
//			heroPointerRight.x = Statics.stageWidth;
//			this.addChild(heroPointerRight);
			
			//lightning (atlas 2)
			lightning = new Lightning();
			this.addChild(lightning);
			
			// bof set up powerups (atlas 2)
			transfiguration = new Transfiguration(this.hero); // transfiguration is not added to stage here (atlas 5)
			
			// power: teleportation
			this.powerupTeleportation = new Blink(this.hero, this.hud);
			this.addChild(this.powerupTeleportation);
			
			// power: attraction
			this.powerupAttraction = new Attraction(this.hero, this.hud);
			this.addChild(this.powerupAttraction);
			
			// power: safety
			this.powerupSafety = new Levitation(this.hero, this.hud);
			this.addChild(this.powerupSafety);
			
			// power: duplication
			this.powerupDuplication = new Extender(this.hud);
			
			// power: broomstick
			this.powerupBroomstick = new Expansion(this.hero, this.hud, transfiguration);
			this.addChild(this.powerupBroomstick);
			
			// power: barrels
			this.powerupBarrels = new Pyromancy(this.hud);
			
			// power: comet run
			this.powerupCometRun = new CometRun(this.hero, this.hud, this.powerupAttraction);
			
			// power: vermilion bird
			this.powerupVermilion = new VermilionBird(this.hero, this.hud, transfiguration);
			this.addChild(this.powerupVermilion);
			
			// power: master da pan
			this.powerupDaPan = new MasterDapan(this.hero, this.hud, transfiguration);
			this.addChild(this.powerupDaPan);
			// eof set up powerups
			
			// bof set up static particle emitters
//			if (this.isHardwareRendering) {
				// create leaf particle emitter
				Statics.particleLeaf = new PDParticleSystem(Statics.assets.getXml("ParticleLeafXML"), Statics.assets.getTexture("ParticleLeaf0000"));
				Statics.particleLeaf.touchable = false;
				Starling.juggler.add(Statics.particleLeaf);
				this.addChild(Statics.particleLeaf);
				
				// create charge particle emitter
				Statics.particleCharge = new PDParticleSystem(Statics.assets.getXml("ParticleChargeXML"),Statics.assets.getTexture("ParticleCharge0000"));
				Statics.particleCharge.touchable = false;
				Starling.juggler.add(Statics.particleCharge);
				this.addChild(Statics.particleCharge);
				
				// create wind particle emitter
				Statics.particleWind = new PDParticleSystem(Statics.assets.getXml("ParticleWindXML"), Statics.assets.getTexture("ParticleWind0000"));
				Statics.particleWind.touchable = false;
				Starling.juggler.add(Statics.particleWind);
				this.addChild(Statics.particleWind);
				Statics.particleWind.emitterX = Statics.stageWidth / 2;
				Statics.particleWind.emitterY = 0;
				
				// create jet particle emitter
				Statics.particleJet = new PDParticleSystem(Statics.assets.getXml("ParticleJetXML"), Texture.fromBitmap(new Assets.ParticleJetTexture(), false));
				Statics.particleJet.touchable = false;
				Starling.juggler.add(Statics.particleJet);
				this.addChild(Statics.particleJet);
				
				// create comet tail particle emitter
				Statics.particleComet = new PDParticleSystem(Statics.assets.getXml("ParticleCometXML"), Texture.fromBitmap(new Assets.ParticleJetTexture(), false));
				Statics.particleComet.touchable = false;
				Starling.juggler.add(Statics.particleComet);
				this.addChild(Statics.particleComet);
				
				// create bounce particle emitter
				Statics.particleBounce = new PDParticleSystem(Statics.assets.getXml("ParticleBounceXML"), Statics.assets.getTexture("ParticleCharge0000"));
				Statics.particleBounce.touchable = false;
				Starling.juggler.add(Statics.particleBounce);
				this.addChild(Statics.particleBounce);
				
				// create explosion particle emitter
				Statics.particleExplode = new PDParticleSystem(Statics.assets.getXml("ParticleExplodeXML"), Statics.assets.getTexture("ParticleCharge0000"));
				Statics.particleExplode.touchable = false;
				Starling.juggler.add(Statics.particleExplode);
				this.addChild(Statics.particleExplode);
				
				// create confetti particle emitter
				Statics.particleConfetti = new PDParticleSystem(Statics.assets.getXml("ParticleConfettiXML"), Statics.assets.getTexture("ParticleConfetti0000"));
				Statics.particleConfetti.touchable = false;
				
				// create hero trail particle emitter
//				Statics.particleTrail = new PDParticleSystem(XML(new ParticleAssets.ParticleTrailXML()), Texture.fromBitmap(new ParticleAssets.ParticleTrailTexture()));
//				Statics.particleTrail.touchable = false;
//				Starling.juggler.add(Statics.particleTrail);
//				this.addChild(Statics.particleTrail);
//				this.setChildIndex(Statics.particleTrail, this.getChildIndex(this.hero));
//			} else { // software rendering
//				
//				// use a smaller particleJet
//				Statics.particleJet = new PDParticleSystem(XML(new ParticleAssets.ParticleJetXML()), Statics.assets.getTexture("ParticleJet0000"));
//				Statics.particleJet.touchable = false;
//				Statics.particleJet.maxNumParticles = 10;
//				Starling.juggler.add(Statics.particleJet);
//				this.addChild(Statics.particleJet);
//				
//				// use a smaller particleComet
//				Statics.particleComet = new PDParticleSystem(XML(new ParticleAssets.ParticleCometXML()), Statics.assets.getTexture("ParticleJet0000"));
//				Statics.particleComet.touchable = false;
//				Statics.particleComet.maxNumParticles = 10;
//				Starling.juggler.add(Statics.particleComet);
//				this.addChild(Statics.particleComet);
//				
//				// create explosion particle emitter
//				Statics.particleExplode = new PDParticleSystem(XML(new ParticleAssets.ParticleExplodeXML()), Statics.assets.getTexture("ParticleCharge0000"));
//				Statics.particleExplode.touchable = false;
//				Starling.juggler.add(Statics.particleExplode);
//				this.addChild(Statics.particleExplode);
//				
//				// create charge particle emitter
//				Statics.particleCharge = new PDParticleSystem(XML(new ParticleAssets.ParticleChargeXML()),Statics.assets.getTexture("ParticleCharge0000"));
//				Statics.particleCharge.touchable = false;
//				Starling.juggler.add(Statics.particleCharge);
//				this.addChild(Statics.particleCharge);
//				
//				// create wind particle emitter
//				Statics.particleWind = new PDParticleSystem(XML(new ParticleAssets.ParticleWindXML()), Statics.assets.getTexture("ParticleWind0000"));
//				Statics.particleWind.touchable = false;
//				Starling.juggler.add(Statics.particleWind);
//				this.addChild(Statics.particleWind);
//				Statics.particleWind.emitterX = Constants.StageWidth / 2;
//				Statics.particleWind.emitterY = 0;
//			}
			// eof set up particle emitters
			
			// set up weather (particle)
			if (this.isHardwareRendering) {
				this.weather = new Weather();
				weather.alpha = 0.999;
				weather.blendMode = BlendMode.ADD;
				this.addChild(weather);
			}
			
			// set up foreground (atlas 5)
			this.fg = new Background(Constants.Foreground);
			this.addChild(this.fg);
			
			// transfiguration activation (atlas 5)
			this.addChild(transfiguration);
			
			// initialize the platforms vector
			this.platformsList = new Vector.<Platform>();
			
			// initialize the contraptions vector
			this.contraptionsList = new Vector.<Contraption>();
			
			// create level builder object
			this.levelParser = new LevelParser();
			
			// create contraption control object
			this.contraptionControl = new ContraptionControl();
			
//			this.setChildIndex(this.hud, this.numChildren - 1); // bring hud to front
			
			// create in game menu
			this.inGameMenu = new InGameMenu();
			this.addChild(this.inGameMenu);
			
			// create platform pools
//			ObjectPool.instance.registerPool(PlatformNormal, 50, false);
//			ObjectPool.instance.registerPool(PlatformMobile, 50, false);
//			ObjectPool.instance.registerPool(PlatformDrop, 40, false);
//			ObjectPool.instance.registerPool(PlatformNormalBoost, 40, false);
//			ObjectPool.instance.registerPool(PlatformDropBoost, 40, false);
//			ObjectPool.instance.registerPool(PlatformMobileBoost, 80, false);
//			ObjectPool.instance.registerPool(PlatformSuper, 40, false);
//			ObjectPool.instance.registerPool(Coin, 130, false);
//			ObjectPool.instance.registerPool(CoinSilver, 100, false);
//			ObjectPool.instance.registerPool(CoinBronze, 100, false);
//			ObjectPool.instance.registerPool(CoinBubble, 40, false);
//			ObjectPool.instance.registerPool(Star, 180, false);
//			ObjectPool.instance.registerPool(StarMini, 60, false);
//			ObjectPool.instance.registerPool(StarBlue, 150, false);
//			ObjectPool.instance.registerPool(StarRed, 60, false);
//			ObjectPool.instance.registerPool(StarDark, 50, false);
//			ObjectPool.instance.registerPool(Comet, 5, false);
//			ObjectPool.instance.registerPool(Repulsor, 60, false);
//			ObjectPool.instance.registerPool(Attractor, 20, false);
//			ObjectPool.instance.registerPool(Bouncer, 60, false);
//			ObjectPool.instance.registerPool(Cannonball, 50, false);
//			ObjectPool.instance.registerPool(SpikyBomb, 30, false);
//			ObjectPool.instance.registerPool(Train, 2, false);
//			ObjectPool.instance.registerPool(TrainFromLeft, 2, false);
//			ObjectPool.instance.registerPool(Cannon, 1, false);
//			ObjectPool.instance.registerPool(CannonFromLeft, 1, false);
//			ObjectPool.instance.registerPool(Bell, 1, false);
//			ObjectPool.instance.registerPool(PowerupBoxPink, 2, false);
//			ObjectPool.instance.registerPool(PowerupBoxGreen, 2, false);
//			ObjectPool.instance.registerPool(PowerupBoxFire, 2, false);
//			ObjectPool.instance.registerPool(PowerupBoxBlue, 2, false);
//			ObjectPool.instance.registerPool(Witch, 2, false);
			
			ObjectPool.instance.registerPool(PlatformNormal, 15, false);
			ObjectPool.instance.registerPool(PlatformMobile, 15, false);
			ObjectPool.instance.registerPool(PlatformDrop, 12, false);
			ObjectPool.instance.registerPool(PlatformNormalBoost, 12, false);
			ObjectPool.instance.registerPool(PlatformDropBoost, 12, false);
			ObjectPool.instance.registerPool(PlatformMobileBoost, 25, false);
			ObjectPool.instance.registerPool(PlatformSuper, 12, false);
			ObjectPool.instance.registerPool(Coin, 20, false);
			ObjectPool.instance.registerPool(CoinSilver, 20, false);
			ObjectPool.instance.registerPool(CoinBronze, 20, false);
			ObjectPool.instance.registerPool(CoinBubble, 25, false);
			ObjectPool.instance.registerPool(Star, 60, false);
			ObjectPool.instance.registerPool(StarMini, 20, false);
			ObjectPool.instance.registerPool(StarBlue, 50, false);
			ObjectPool.instance.registerPool(StarRed, 20, false);
			ObjectPool.instance.registerPool(StarDark, 15, false);
			ObjectPool.instance.registerPool(Comet, 5, false);
			ObjectPool.instance.registerPool(Repulsor, 20, false);
			ObjectPool.instance.registerPool(Attractor, 4, false);
			ObjectPool.instance.registerPool(Bouncer, 20, false);
			ObjectPool.instance.registerPool(Cannonball, 10, false);
			ObjectPool.instance.registerPool(SpikyBomb, 10, false);
			ObjectPool.instance.registerPool(Train, 2, false);
			ObjectPool.instance.registerPool(TrainFromLeft, 2, false);
			ObjectPool.instance.registerPool(Cannon, 1, false);
			ObjectPool.instance.registerPool(CannonFromLeft, 1, false);
			ObjectPool.instance.registerPool(Bell, 1, false);
			ObjectPool.instance.registerPool(PowerupBoxPink, 2, false);
			ObjectPool.instance.registerPool(PowerupBoxGreen, 2, false);
			ObjectPool.instance.registerPool(PowerupBoxFire, 2, false);
			ObjectPool.instance.registerPool(PowerupBoxBlue, 2, false);
			ObjectPool.instance.registerPool(Witch, 2, false);
		}
		
		/**
		 * Draw game over screen. 
		 * 
		 */
		private function drawGameOverScreen():void
		{
			gameOverContainer = new GameOverContainer(this.menu, this);
			this.addChild(gameOverContainer);
		}
		
		/**
		 * This method is called as soon as the play button is pressed
		 * Do not create new objects in this methid, only reset game data
		 */
		public function initializeNormalMode():void
		{
			if (Statics.isAnalyticsEnabled) {
				Statics.mixpanel.track('started a round');
			}
			
			// remove interstitial ad from native stage
			if (Starling.current.nativeOverlay.numChildren > 0) {
				Starling.current.nativeOverlay.removeChildAt(0);
			}
			
			// reset static vars
//			Statics.gameMode = Constants.ModeNormal;
			Statics.gamePaused = false;
			Statics.speedFactor = 1.3; // 1.1
			Statics.preparationStep = Constants.PrepareStep0;
			Statics.gameTime = 0;
//			Statics.bonusTime = 0;
			Sounds.nextStarNote = 1;
			Statics.powerupsEnabled = true;
			Statics.specialReady = true;
			Statics.isBellActive = false;
			Statics.isRightCannonActive = false;
			Statics.isLeftCannonActive = false;
			Statics.cameraShake = 0;
			Statics.maxDist = 0;
			Statics.calculateEmaVelocity = false;
			Statics.invincibilityExpirationTime = 0;
			Statics.cameraTargetModifierY = 0;
			Statics.powerupAttractionEnabled = false;
			Statics.contraptionsEnabled = true;
			Statics.checkWinLose = true;
			Statics.cameraGy = 0;
			
			gameOverContainer.visible = false;
			this.visible = true;
			this.hud.initialize();
			this.inGameMenu.initialize();
			
			// reset game properties
			this.stageWidth = Statics.stageWidth;
			this.stageHeight = Statics.stageHeight;
			this.camera.initialize();
			this.bg.initialize();
			this.brightLightImage.visible = false;
//			this.bigCoinCaption.visible = false;
			this.fg.initialize();
			this.hero.initialize();
			this.platformsList.length = 0;
			this.platformsListLength = 0;
			this.contraptionsList.length = 0;
			this.contraptionsListLength = 0;
			this.lightning.visible = false;
			this.coinsObtained = 0;
			this.leftArrow = false;
			this.rightArrow = false;
//			this.upArrow = false;
//			this.downArrow = false;
			this.discreteLeft = false;
			this.discreteRight = false;
			this.playerControl = true;
			this.isDuplicationEnabled = true;
//			heroPointerLeft.visible = false;
//			heroPointerRight.visible = false;
			frameCount = 0;
			timeFor60frames = 0;
			totalFps = 0;
			fpsCounts = 0;
//			if (Statics.tutorialStep == 1 || Statics.tutorialStep == 2) this.tutorialOn = true;
			if (Statics.tutorialStep == 1) this.tutorialOn = true;
			else this.tutorialOn = false;
			this.tutorialProgress = 0;
			
			// initial level parser
			this.levelParser.initialize();
			
			// play background music
//			if (!Sounds.bgmMuted) Sounds.playBgmIngame();
//			Sounds.stopBgm();
			Sounds.playBgmIngame(); // play bgm regardless of whether bgm is muted
			
			// hide the pause button since the game isn't started yet.
			inGameMenu.hidePauseButton();
			
			// reset scores
//			hud.bonusTime = 0;
			hud.distance = 0;
			hud.coins = 0;
			
			// reset game properties
			this.heroHasBouncedOffSof = false;
			
			// start game timer
			this.gameStartTime = getTimer();
			
			// game tick
			this.addEventListener(Event.ENTER_FRAME, onGameTick);
			
//			Statics.particleTrail.start(); // testing
		}
		
//		public function initializeBonusMode():void
//		{
//			Statics.speedFactor = 1.545;
//			Statics.bonusTime = 300; // test
//			
//			// reset static vars
//			Statics.gameMode = Constants.ModeBonus;
//			Statics.preparationStep = Constants.PrepareStep0;
//			Statics.gameTime = 0;
//			Statics.bonusTimeLeft = Number(Statics.bonusTime * 1000);
//			
//			// hide the pause button since the game isn't started yet.
//			pauseButton.visible = false;
//			
//			// reset scores
////			hud.bonusTime = 0;
//			hud.distance = 0;
//			hud.coins = 0;
//			
//			// start game timer
//			this.gameStartTime = getTimer();
//			
//			// game tick
//			this.addEventListener(Event.ENTER_FRAME, onGameTick);
//		}
		
		/**
		 * Play again, when clicked on play again button in Game Over screen. 
		 * 
		 */
//		private function playAgain(event:NavigationEvent):void
//		{
//			if (event.params.id == "playAgain") 
//			{
//				tween_gameOverContainer = new Tween(gameOverContainer, 1);
//				tween_gameOverContainer.fadeTo(0);
//				tween_gameOverContainer.onComplete = gameOverFadedOut;
//				Starling.juggler.add(tween_gameOverContainer);
//			}
//		}
		
		/**
		 * On game over screen faded out. 
		 * 
		 */
//		private function gameOverFadedOut():void
//		{
//			gameOverContainer.visible = false;
//			initialize();
//		}
		
		private function launchHero():void
		{
			// show pause button since the game is started
			inGameMenu.showPauseButton();
			
			// show hero
			this.hero.visible = true;
			
			// Touch interaction
			//this.addEventListener(TouchEvent.TOUCH, onTouch);
			
			// keyboard interaction
//			Starling.current.nativeOverlay.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressedDown);
//			Starling.current.nativeOverlay.stage.addEventListener(KeyboardEvent.KEY_UP, keyPressedUp);
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressedDown);
			this.stage.addEventListener(KeyboardEvent.KEY_UP, keyPressedUp);
			
			// start scheduling weather effects
			if (this.isHardwareRendering) this.weather.scheduleFirst();
			
			// emit wind particles
			if (this.isHardwareRendering) Statics.particleWind.start(1.0);
			
			// restart game timer
			Statics.gameTime = 0;
			this.gameStartTime = getTimer();
			
			// start calculating hero velocity ema
			Statics.calculateEmaVelocity = true;
			
			// remove hero idle animation
			this.fg.hideHeroIdle();
			
			// show special ability indicators
			this.hud.showAbilityIndicators();
			
//			this.inGameMenu.showMessageSmall(this.localization.getMessageRoundStart());
			Starling.juggler.delayCall(showRoundInfo, 2);
			
			//test
			this.powerupSafety.activate(false, 10000);
//			this.powerupVermilion.activate();
//			this.powerupBroomstick.activate();
//			this.powerupAttraction.activate();
//			this.powerupDuplication.activate();
//			hud.spinPowerupReel();
		}
		
		private function showRoundInfo():void {
			this.inGameMenu.showMessageSmall("Round " + (Statics.currentRound + 1).toString() + " against " + Statics.opponentNameOneLine);
		}
		
		/**
		 * Set keydown states to true
		 */
		public function keyPressedDown(event:KeyboardEvent):void {
			if (event.keyCode == 37 || event.keyCode == 65) { // left arrow or 'a'
				if (!leftArrow) discreteLeft = true;
				leftArrow = true;
			} else if (event.keyCode == 39 || event.keyCode == 68) { // right arrow or 'd'
				if (!rightArrow) discreteRight = true;
				rightArrow = true;        
			} 
//			else if (event.keyCode == 38) {
//				upArrow = true;
//			} else if (event.keyCode == 40) {
//				downArrow = true;
//			} 
			else if (event.keyCode == 32) { // space bar pressed
				if (this.playerControl) {
					this.hero.triggerSpecialAbility(this.levelParser.difficulty);
				}
			}
		}
		
		/**
		 * Set keydown states to false
		 */
		public function keyPressedUp(event:KeyboardEvent):void {
			if (event.keyCode == 37 || event.keyCode == 65) {
				leftArrow = false;
			} else if (event.keyCode == 39 || event.keyCode == 68) {
				rightArrow = false;
			} 
//			else if (event.keyCode == 38) {
//				upArrow = false;
//			} else if (event.keyCode == 40) {
//				downArrow = false;
//			}
		}
		
		// count down three seconds before launching hero
		// return true if still counting down
		private function launchCountdown(timeCurrent:int):Boolean {
			if (Statics.preparationStep == Constants.PrepareStep0) { // preparation mode
				hud.showMessage("Get Ready", 1000);
				Statics.preparationStep = Constants.PrepareStep1;
			}
			else if (Statics.preparationStep == Constants.PrepareStep1) {
				if (timeCurrent> 1000) {
					if (!Sounds.sfxMuted) Statics.assets.playSound("SND_DRUM3");
					hud.showMessage("3", 1000, 1);
					Statics.preparationStep = Constants.PrepareStep2;
				}
			}
			else if (Statics.preparationStep == Constants.PrepareStep2) {
				if (timeCurrent> 2000) {
					if (!Sounds.sfxMuted) Statics.assets.playSound("SND_DRUM1");
					hud.showMessage("2", 1000, 1);
					Statics.preparationStep = Constants.PrepareStep3;
				}
			}
			else if (Statics.preparationStep == Constants.PrepareStep3) {
				if (timeCurrent> 3000) {
					if (!Sounds.sfxMuted) Statics.assets.playSound("SND_DRUM2");
					hud.showMessage("1", 1000, 1);
					Statics.preparationStep = Constants.PrepareStep4;
				}
			}
			else if (Statics.preparationStep == Constants.PrepareStep4) {
				if (timeCurrent> 3800) {
					// play catapult launch animation
					this.fg.launchCatapult();
				}
				if (timeCurrent> 4000) {
					if (!Sounds.sfxMuted) Statics.assets.playSound("SND_DRUM3");
					hud.showMessage("JUMP!", 1000, 1);
					Statics.preparationStep = Constants.PrepareStepDone;
					this.launchHero();
				}
			}
			else {
				return false;
			}
			
			return true;
		}
		
		/**
		 * Game Tick - every frame of the game
		 */
		private function onGameTick(event:EnterFrameEvent):void
		{
//			trace("native children: " + Starling.current.nativeOverlay.numChildren);
			
			// handle pausing
			var timeCurrent:int;
			if (Statics.gamePaused) {
				timeCurrent = getTimer() - this.gameStartTime;
				this.timeDiffReal = timeCurrent - Statics.gameTime;
				this.gameStartTime += this.timeDiffReal;
				return;
			}
			
//			trace("starling elapsed time: " + event.passedTime);
			
			// update game time
			timeCurrent = getTimer() - this.gameStartTime;
			this.timeDiffReal = timeCurrent - Statics.gameTime;
//			trace("flash elapsed time: " + timeDiffReal);
			
			// calculate fps
			timeFor60frames += timeDiffReal;
			if (++frameCount % 60 == 0)
			{
				timeFor60frames /= 1000;
//				trace("total time: " + timeFor60frames);
				var fps:Number = frameCount / timeFor60frames;
//				trace("fps: " + fps);
				totalFps += fps;
				fpsCounts++;
				frameCount = timeFor60frames = 0;
			}
			// eof calculate fps

			if (this.timeDiffReal > 40) { // recover from computer freeze
//				trace("time elapsed: " + this.timeDiffReal);
				this.timeDiffReal = 40;
			}
			Statics.gameTime = timeCurrent;
			this.timeDiffControlled = Number(this.timeDiffReal) * Statics.speedFactor;
			
			// if player fails and end game duration has passed, end the game
			if (!Statics.checkWinLose && Statics.gameTime > this.endGameTime) {
				this.endGame();
				return;
			}
			
			/** update timers in other classes */
			// update HUD and spin powerup reel if needed
			hud.update();
//			var powerupToActivate:int = hud.updatePowerupReel(this.timeDiffReal);
			var powerupToActivate:int = hud.getPowerupToActivate();
			if (powerupToActivate != -1 && this.tutorialOn && this.tutorialProgress < 7) {
				powerupToActivate = 8;
			}

				// activate powerup if needed
				if (powerupToActivate == 0) {
					hud.showCharmActivation(Constants.PowerupBlink);
//					hud.showMessage("Ancient Power: Teleportation");
					this.powerupTeleportation.activate();
					
					if (Statics.isAnalyticsEnabled) { // mixpanel
						Statics.mixpanel.track('activated power: teleportation');
					}
				}
				else if (powerupToActivate == 1) {
					hud.showCharmActivation(Constants.PowerupAttractor);
//					hud.showMessage("Ancient Power: Attraction");
					this.powerupAttraction.activate();
					
					if (Statics.isAnalyticsEnabled) { // mixpanel
						Statics.mixpanel.track('activated power: attraction');
					}
				}
				else if (powerupToActivate == 2) {
					hud.showCharmActivation(Constants.PowerupLevitation);
					hud.showMessage("Protection saves you if you fall", 5000);
					this.powerupSafety.activate();
					
					if (Statics.isAnalyticsEnabled) { // mixpanel
						Statics.mixpanel.track('activated power: protection');
					}
				}
				else if (powerupToActivate == 3) {
					hud.showCharmActivation(Constants.PowerupExtender);
//					hud.showMessage("Ancient Power: Duplication");
					this.powerupDuplication.activate();
					
					if (Statics.isAnalyticsEnabled) { // mixpanel
						Statics.mixpanel.track('activated power: duplication');
					}
				}
				else if (powerupToActivate == 4) {
					hud.showCharmActivation(Constants.PowerupPyromancy);
//					hud.showMessage("Ancient Power: Barrels O' Fire");
					this.powerupBarrels.activate();
					
					if (Statics.isAnalyticsEnabled) { // mixpanel
						Statics.mixpanel.track('activated power: barrels');
					}
				}
				else if (powerupToActivate == 5) {
					this.powerupBroomstick.activate();
					
					if (Statics.isAnalyticsEnabled) { // mixpanel
						Statics.mixpanel.track('activated power: broomstick');
					}
				}
				else if (powerupToActivate == 6) {
					this.powerupVermilion.activate();
					
					if (Statics.isAnalyticsEnabled) { // mixpanel
						Statics.mixpanel.track('activated power: vermilion bird');
					}
				}
				else if (powerupToActivate == 7) {
					this.powerupDaPan.activate();
					
					if (Statics.isAnalyticsEnabled) { // mixpanel
						Statics.mixpanel.track('activated power: master da pan');
					}
				}
				else if (powerupToActivate == 8) {
					this.powerupCometRun.activate();
					this.powerupAttraction.activate(true);
					if (Statics.isAnalyticsEnabled) { // mixpanel
						Statics.mixpanel.track('activated power: comet run from box');
					}
				}
				
//				if (powerupToActivate >= 0) { // for testing
//					this.powerupDuplication.activate();
//				}
				
				// update powerups
				
				// update power: teleportation
				if (this.powerupTeleportation.isActivated) this.powerupTeleportation.update(this.timeDiffControlled);
				
				// update power: attraction
				if (this.powerupAttraction.isActivated) this.powerupAttraction.update(this.timeDiffControlled);
				
				// update power: safety
				if (this.powerupSafety.isActivated) this.powerupSafety.update(this.timeDiffControlled, this.fg.sofHeight);
				
				// update power: duplication
				if (this.powerupDuplication.isActivated) this.powerupDuplication.update(this.timeDiffControlled);
				
				// update power: barrels
				if (this.powerupBarrels.isActivated) {
					if (this.powerupBarrels.update(this.timeDiffControlled)) {
						var newPlatformSuperIndex:int = addElementFromPool(
							this.hero.gy - this.stageHeight / 2 - 150, 
							Math.random() * this.stageWidth - this.stageWidth / 2, "PlatformSuper");
						if (newPlatformSuperIndex != -1) {
							this.platformsList[newPlatformSuperIndex].isPyromancy = true;
							this.platformsList[newPlatformSuperIndex].dy = 2;
						}
					}
				}
				
				// update power: broomstick
				if (this.powerupBroomstick.isActivated) {
					if (this.powerupBroomstick.update(this.timeDiffControlled)) {
						var newCannonballIndex:int = addElementFromPool(
						this.camera.gy + this.stageHeight / 2 + 21, 
						Math.random() * this.stageWidth * 2 - this.stageWidth, "Cannonball");
						if (newCannonballIndex != -1) this.platformsList[newCannonballIndex].setVertical();
					}
				}
				
				// update power: vermilion bird
				if (this.powerupVermilion.isActivated) {
					if (this.powerupVermilion.update(this.timeDiffControlled)) {
						var newSpikyBombIndex:int = addElementFromPool(
							this.camera.gy + this.stageHeight / 2 + 100, 
							Math.random() * this.stageWidth * 2 - this.stageWidth, "SpikyBomb");
					}
				}
				
				// update power: master da pan
				if (this.powerupDaPan.isActivated) {
					if (this.powerupDaPan.update(this.timeDiffControlled)) {
						if (Math.random() < 0.5) {
							var targetLeft:int = -this.stageWidth / 2 + 35; // position of left screen border
							newSpikyBombIndex = addElementFromPool(
								this.camera.gy + this.stageHeight / 2 + 21, 
								targetLeft, "SpikyBomb");
						} else {
							var targetRight:int = this.stageWidth / 2 - 35; // position of right screen border
							newSpikyBombIndex = addElementFromPool(
								this.camera.gy + this.stageHeight / 2 + 21, 
								targetRight, "SpikyBomb");
						}
					}
				}
				
				// update power: comet run
				if (this.powerupCometRun.isActivated) {
					this.powerupCometRun.update(this.timeDiffControlled);
					
					// update bright light
					brightLightImage.visible = true;
					brightLightImage.x = this.hero.x;
					brightLightImage.y = this.hero.y + 20;
				} else {
					brightLightImage.visible = false;
				}
			/** eof update timers */
			
			// camera shake
			this.shakeCamera();
			
			// move camera
			this.camera.update(this.timeDiffControlled, this.hero.gx, this.hero.gy, this.hero.dy);
			
			// prepare for hero bounce
//			this.hero.prepareBounce();
			
			// scroll all platforms and run all platform and contraption behaviors
			this.scrollElements();
			
			// carry out hero bounce
//			this.hero.doBounce();
			
			if (!launchCountdown(timeCurrent)) { // not in preparation mode
				// display tutorial messages if needed
				if (this.tutorialOn) {
					if (this.tutorialProgress == 0) {
						this.powerupSafety.activate(true);
						hud.showMessage("Jump as high as you can", 8000, 2);
						this.tutorialProgress = 1;
					}
					if (this.tutorialProgress == 1 && timeCurrent > 9000) {
						hud.showMessage("Try not to fall", 8000, 2);
						this.tutorialProgress = 2;
					}
					else if (this.tutorialProgress == 2 && timeCurrent > 18000) {
						hud.showMessage("You are safe during", 8000, 2);
						hud.showMessage("this tutorial", 8000, 3);
						this.tutorialProgress = 3;
					}
					else if (this.tutorialProgress == 3 && timeCurrent > 27000) {
						hud.showMessage("Bounce on platforms", 8000, 2);
						hud.showMessage("or stars to go up", 8000, 3);
						this.tutorialProgress = 4;
					}
//					else if (this.tutorialProgress == 3 && timeCurrent > 18000) {
//						hud.showMessage("If you fall, press space", 5000, 2);
//						hud.showMessage("to use special ability", 5000, 3);
//						this.tutorialProgress = 4;
//					}
//					else if (this.tutorialProgress == 4 && timeCurrent > 24000) {
//						hud.showMessage("You can use it three times", 5000, 2);
//						hud.showMessage("per round", 5000, 3);
//						this.tutorialProgress = 5;
//					}
					else if (this.tutorialProgress == 4 && timeCurrent > 36000) {
						hud.showMessage("You may also use the", 8000, 2);
						hud.showMessage("A   and   D   keys for movement", 8000, 3);
						this.tutorialProgress = 5;
					}
					else if (this.tutorialProgress == 5 && timeCurrent > 45000) {
						hud.showMessage("That's it. Good luck!", 8000, 2);
						this.tutorialProgress = 6;
					}
					else if (this.tutorialProgress == 6 && timeCurrent > 60000) {
						hud.showMessage("Turning off safety mode", 5000, 2);
						this.tutorialProgress = 7;
					}
				}
				
				/** update hero */
				// controls: handle left and right arrow key input
				if (this.playerControl) {
//					if (Statics.gameMode == Constants.ModeBonus) {
//						//
//						if (leftArrow) {
//							this.moveMade = 1;
//						}
//						else if (rightArrow) {
//							this.moveMade = 2;
//						}
//						//
//						
//						if (!this.moveMadeThisTurn) {
//							//if (Camera.nextPlatformX < this.hero.gx) { // autopilot
//							//if (this.moveMade == 1) { // left arrow pressed
//							if (leftArrow) {
//								this.hero.turnLeft();
//								this.hero.dx = -0.18;
//								this.moveMadeThisTurn = true;
//							}
//								//else if (Camera.nextPlatformX > this.hero.gx) { // autopilot
//								//else if (this.moveMade == 2) { // right arrow pressed
//							else if (rightArrow) {
//								this.hero.turnRight();
//								this.hero.dx = 0.18;
//								this.moveMadeThisTurn = true;
//							}
//							
//						}
//						
//						//}
//					} else { // normal game mode
						if (this.powerupBroomstick.isActivated) { // broomstick controls
							// x
							if (leftArrow) { // left arrow pressed
								this.hero.turnLeft();
								this.hero.dx -= Constants.HeroSpeedX * this.timeDiffControlled * 0.5;
								if (this.hero.dx < -Constants.HeroExpansionMaxSpeedX) {
									this.hero.dx = -Constants.HeroExpansionMaxSpeedX;
								}
							}
							if (rightArrow) { // right arrow pressed
								this.hero.turnRight();
								this.hero.dx += Constants.HeroSpeedX * this.timeDiffControlled * 0.5;
								if (this.hero.dx > Constants.HeroExpansionMaxSpeedX) {
									this.hero.dx = Constants.HeroExpansionMaxSpeedX;
								}
							}
							if ((leftArrow && rightArrow) || (!leftArrow && !rightArrow)) { // no arrow pressed, reset velocity
								// make hero come to rest
								if (this.hero.dx < 0) {
									if (Math.abs(this.hero.dx) < Constants.HeroSpeedX * this.timeDiffControlled * 0.1) {
										this.hero.dx = 0;
									} else {
										this.hero.dx += Constants.HeroSpeedX * this.timeDiffControlled * 0.1;
									}
								} else if (this.hero.dx > 0) {
									if (Math.abs(this.hero.dx) < Constants.HeroSpeedX * this.timeDiffControlled * 0.1) {
										this.hero.dx = 0;
									} else {
										this.hero.dx -= Constants.HeroSpeedX * this.timeDiffControlled * 0.1;
									}
								}
							}
							
							// y
							if (leftArrow || rightArrow) {
								this.powerupBroomstick.engineOn(this.timeDiffControlled);
								
							} else {
								this.powerupBroomstick.engineOff();
							}
							
							// propeller art
//							this.powerupsList[Constants.PowerupExpansion].updatePropellers(leftArrow, rightArrow);
						} else if (this.powerupVermilion.isActivated) { // vermilion bird controls
							// x
							if (discreteLeft && Statics.gameTime > this.hero.controlRestoreTime) { // left arrow pressed
//								trace("discrete left");
//								if (this.hero.dx > -0.3) this.hero.dx -= Constants.HeroSpeedX * this.timeDiffControlled * 1;
//								else this.hero.dx -= Constants.HeroSpeedX * this.timeDiffControlled;
								this.hero.dx = -Constants.HeroSpeedX * this.timeDiffControlled * 15;
								if (this.hero.dx < -Constants.HeroExpansionMaxSpeedX) {
									this.hero.dx = -Constants.HeroExpansionMaxSpeedX;
								}
								this.hero.dy = 1;
								this.powerupVermilion.beatWings();
							}
							else if (discreteRight && Statics.gameTime > this.hero.controlRestoreTime) { // right arrow pressed
//								trace("discrete right");
//								if (this.hero.dx < 0.3) this.hero.dx += Constants.HeroSpeedX * this.timeDiffControlled * 1;
//								else this.hero.dx += Constants.HeroSpeedX * this.timeDiffControlled;
								this.hero.dx = Constants.HeroSpeedX * this.timeDiffControlled * 15;
								if (this.hero.dx > Constants.HeroExpansionMaxSpeedX) {
									this.hero.dx = Constants.HeroExpansionMaxSpeedX;
								}
								this.hero.dy = 1;
								this.powerupVermilion.beatWings();
							}
							else { // no arrow pressed, reset velocity
								// make hero come to rest
								if (this.hero.dx < 0) {
									if (Math.abs(this.hero.dx) < Constants.HeroSpeedX * this.timeDiffControlled * 0.1) {
										this.hero.dx = 0;
									} else {
										this.hero.dx += Constants.HeroSpeedX * this.timeDiffControlled * 0.1;
									}
								} else if (this.hero.dx > 0) {
									if (Math.abs(this.hero.dx) < Constants.HeroSpeedX * this.timeDiffControlled * 0.1) {
										this.hero.dx = 0;
									} else {
										this.hero.dx -= Constants.HeroSpeedX * this.timeDiffControlled * 0.1;
									}
								}
							}
//						} else if (this.powerupsList[Constants.PowerupQueenNagini].isActivated) { // queen nagini controls
//							// x
//							if (discreteLeft) { // left arrow pressed
//								this.powerupsList[Constants.PowerupQueenNagini].blinkLeft();
//							}
//							else if (discreteRight) { // right arrow pressed
//								this.powerupsList[Constants.PowerupQueenNagini].blinkRight();
//							}
//							// y
//							if (this.hero.dy < 1.0) this.hero.dy += 0.05;
						} else if (this.powerupDaPan.isActivated) { // master da pan controls
							// x
							if (discreteLeft) { // left arrow pressed
								this.powerupDaPan.snapToLeft();
							}
							else if (discreteRight) { // right arrow pressed
								this.powerupDaPan.snapToRight();
							}
						} else { // normal instead of transfigured gameplay
							if (leftArrow || rightArrow) {
								if (leftArrow) { // left arrow pressed
									this.hero.turnLeft();
									//if (this.hero.dx > 0) {this.hero.dx = 0;}
									if (this.hero.dx > -0.2) this.hero.dx -= Constants.HeroSpeedX * this.timeDiffControlled * 1;
									else this.hero.dx -= Constants.HeroSpeedX * this.timeDiffControlled * 1;
									if (this.hero.dx < -Constants.HeroMaxSpeedX) {
										this.hero.dx = -Constants.HeroMaxSpeedX;
									}
								}
								if (rightArrow) { // right arrow pressed
									this.hero.turnRight();
									//if (this.hero.dx < 0) {this.hero.dx = 0;}
									if (this.hero.dx < 0.2) this.hero.dx += Constants.HeroSpeedX * this.timeDiffControlled * 1;
									else this.hero.dx += Constants.HeroSpeedX * this.timeDiffControlled * 1;
									if (this.hero.dx > Constants.HeroMaxSpeedX) {
										this.hero.dx = Constants.HeroMaxSpeedX;
									}
								}
							}
							else { // no arrow pressed, reset velocity
								if (this.hero.dx < 0) {
									if (Math.abs(this.hero.dx) < Constants.HeroSpeedX * this.timeDiffControlled * 0.4) {
										this.hero.dx = 0;
									} else {
										this.hero.dx += Constants.HeroSpeedX * this.timeDiffControlled * 0.4;
									}
								} else if (this.hero.dx > 0) {
									if (Math.abs(this.hero.dx) < Constants.HeroSpeedX * this.timeDiffControlled * 0.4) {
										this.hero.dx = 0;
									} else {
										this.hero.dx -= Constants.HeroSpeedX * this.timeDiffControlled * 0.4;
									}
								}
							}
						} // eof normal instead of transfigured gameplay
//					} // eof normal instead of bonus game mode
						discreteLeft = false;
						discreteRight = false;
				} /** eof player control */
				
				// update hero position, velocity, rotation
				this.hero.update(this.timeDiffControlled, this.levelParser.maxHeroFallVelocity);
				
				// update max climb distance
				if (this.hero.gy > Statics.maxDist) {
					Statics.maxDist = this.hero.gy;
				}
				/** eof update hero */
				
				// check contraptions scheduling
				if (Statics.contraptionsEnabled) {
					var contraptionStatus:Array = this.contraptionControl.checkSchedules();
//					if (contraptionStatus[Constants.ContraptionHourglass]) this.summonHourglass();
					if (contraptionStatus[Constants.ContraptionTrain]) this.launchTrain();
					if (contraptionStatus[Constants.ContraptionTrainFromLeft]) this.launchTrainFromLeft();
					if (contraptionStatus[Constants.ContraptionBell] && !Statics.isBellActive) this.dropBell();
					if (contraptionStatus[Constants.ContraptionPowerupBoxes]) this.summonPowerupBoxes();
					if (contraptionStatus[Constants.ContraptionCannon] && !Statics.isRightCannonActive) this.summonCannon();
					if (contraptionStatus[Constants.ContraptionCannonFromLeft] && !Statics.isLeftCannonActive) this.summonCannonFromLeft();
					if (contraptionStatus[Constants.ContraptionWitch]) this.summonWitch();
				}
				
				// check weather scheduling
				if (this.isHardwareRendering) this.weather.checkSchedules();
				
				// sea of fire
				if (Constants.SofEnabled) {
					// scroll sea of fire vertically
					this.bg.scrollSofVertical(this.timeDiffControlled, this.hero.gy);
					this.fg.scrollSofVertical(this.timeDiffControlled, this.hero.gy);
					
					// scroll sea of fire horizontally
					this.bg.scrollSofHorizontal();
					this.fg.scrollSofHorizontal();
				}
				
				// If hardware rendering, set the particle emitter's x and y.
//				if (this.isHardwareRendering) {
					Statics.particleLeaf.emitterX = hero.x;
					Statics.particleLeaf.emitterY = hero.y;
					
					Statics.particleCharge.emitterX = hero.x;
					Statics.particleCharge.emitterY = hero.y;
					
					Statics.particleJet.emitterX = hero.x;
					Statics.particleJet.emitterY = hero.y;
					Statics.particleJet.speed = Math.sqrt(hero.dx * hero.dx + hero.dy * hero.dy) * 1000;
					
					Statics.particleComet.emitterX = hero.x;
					Statics.particleComet.emitterY = hero.y;
					Statics.particleComet.speed = Math.sqrt(hero.dx * hero.dx + hero.dy * hero.dy) * 1000;
//				} else {
//					Statics.particleJet.emitterX = hero.x;
//					Statics.particleJet.emitterY = hero.y;
//					Statics.particleJet.speed = Math.sqrt(hero.dx * hero.dx + hero.dy * hero.dy) * 1000;
//					
//					Statics.particleComet.emitterX = hero.x;
//					Statics.particleComet.emitterY = hero.y;
//					Statics.particleComet.speed = Math.sqrt(hero.dx * hero.dx + hero.dy * hero.dy) * 1000;
//				}
				
				// misc win/loss conditions
				if (Statics.checkWinLose) {
					// left and right border warning
//					if (this.hero.gx < -Constants.StageWidth / 2 - 100 || 
//						this.hero.gx > Constants.StageWidth / 2 + 100) {
//						HUD.showMessage("Warning: Leaving Survivable Area");
//					}
					// hero out of stage indicators
//					if (this.hero.x < 0) {
//						this.heroPointerLeft.y = this.hero.y;
//						if (!this.heroPointerLeft.visible) this.heroPointerLeft.visible = true;
//					}
//					else if (this.heroPointerLeft.visible) this.heroPointerLeft.visible = false;
//					if (this.hero.x > Statics.stageWidth) {
//						this.heroPointerRight.y = this.hero.y;
//						if (!this.heroPointerRight.visible) this.heroPointerRight.visible = true;
//					}
//					else if (this.heroPointerRight.visible) this.heroPointerRight.visible = false;
				} else {
					// mark hero as bounced out of sea of fire
					if (this.hero.gy > this.fg.sofHeight - 60) {
						this.heroHasBouncedOffSof = true;
					}
				}
				
				// we lose if we drop below sea of fire or move out of bounds
//				if (Constants.SofEnabled) {
					if (this.hero.gy < this.fg.sofHeight - 60) {
						if (Statics.checkWinLose) {
							if (this.powerupBroomstick.isActivated) {
								this.powerupBroomstick.deactivate();
								
								// explosion animation and sfx
								Statics.particleExplode.emitterX = hero.x;
								Statics.particleExplode.emitterY = hero.y;
								Statics.particleExplode.start(0.5);
								if (!Sounds.sfxMuted) Statics.assets.playSound("SND_BOOM");
							}
							else if (this.powerupVermilion.isActivated) {
								this.powerupVermilion.deactivate();
								
								// explosion animation and sfx
								Statics.particleExplode.emitterX = hero.x;
								Statics.particleExplode.emitterY = hero.y;
								Statics.particleExplode.start(0.5);
								if (!Sounds.sfxMuted) Statics.assets.playSound("SND_BOOM");
							}
							else if (this.powerupDaPan.isActivated) {
								this.powerupDaPan.deactivate();
								
								// explosion animation and sfx
								Statics.particleExplode.emitterX = hero.x;
								Statics.particleExplode.emitterY = hero.y;
								Statics.particleExplode.start(0.5);
								if (!Sounds.sfxMuted) Statics.assets.playSound("SND_BOOM");
							}
							else if (Statics.gameTime > Statics.invincibilityExpirationTime) {
//								hud.showMessage("Uh Oh...");
								hud.showMessage("Uh Oh...");
								this.playerFail();
								return;
							}
						}
						else if (this.heroHasBouncedOffSof) {
							this.hero.gy = this.fg.sofHeight - 60; // hide hero just below sof
							Statics.cameraTargetModifierY = 250; // move camera target so we only see the top of sof
						}
					}
//				} else { // test sea of fire turned off
//					if (this.checkWinLose && hero.gy < Camera.gy - Constants.StageHeight / 2) {
//						HUD.showMessage("Uh Oh...");
//						this.playerFail();
//						return;
//					}
//				}
				
				// update hud
//				if (Statics.gameMode == Constants.ModeNormal) {
//					hud.bonusTime = Statics.bonusTime;
//				}
//				else if (Statics.gameMode == Constants.ModeBonus && this.checkWinLose) {
//					// count down time in bonus mode and update hud
//					hud.bonusTime = int(Statics.bonusTimeLeft / 1000);
//					Statics.bonusTimeLeft = Statics.bonusTime * 1000 - Statics.gameTime;
//					if (Statics.bonusTimeLeft <= 0) {
//						HUD.showMessage("Time Up!");
//						this.playerFail();
//						return;
//					}
//				}
				hud.distance = Math.round(Statics.maxDist / 100);
				hud.coins = this.coinsObtained;
				
				// climb distance objectives
				if (!Statics.achievementsList[1] && Statics.maxDist > 20000) {
					hud.showAchievement(Constants.AchievementsData[1][1]);
					Statics.achievementsList[1] = true;
					this.gameOverContainer.addNewAchievement(1);
				}
				if (!Statics.achievementsList[2] && Statics.maxDist > 50000) {
					hud.showAchievement(Constants.AchievementsData[2][1]);
					Statics.achievementsList[2] = true;
					this.gameOverContainer.addNewAchievement(2);
				}
				if (!Statics.achievementsList[3] && Statics.maxDist > 100000) {
					hud.showAchievement(Constants.AchievementsData[3][1]);
					Statics.achievementsList[3] = true;
					this.gameOverContainer.addNewAchievement(3);
				}
				if (!Statics.achievementsList[4] && Statics.maxDist > 200000) {
					hud.showAchievement(Constants.AchievementsData[4][1]);
					Statics.achievementsList[4] = true;
					this.gameOverContainer.addNewAchievement(4);
				}
				if (!Statics.achievementsList[5] && Statics.maxDist > 350000) {
					hud.showAchievement(Constants.AchievementsData[5][1]);
					Statics.achievementsList[5] = true;
					this.gameOverContainer.addNewAchievement(5);
				}
				if (!Statics.achievementsList[6] && Statics.maxDist > 500000) {
					hud.showAchievement(Constants.AchievementsData[6][1]);
					Statics.achievementsList[6] = true;
					this.gameOverContainer.addNewAchievement(6);
				}
				if (!Statics.achievementsList[7] && Statics.maxDist > 650000) {
					hud.showAchievement(Constants.AchievementsData[7][1]);
					Statics.achievementsList[7] = true;
					this.gameOverContainer.addNewAchievement(7);
				}
				if (!Statics.achievementsList[8] && Statics.maxDist > 800000) {
					hud.showAchievement(Constants.AchievementsData[8][1]);
					Statics.achievementsList[8] = true;
					this.gameOverContainer.addNewAchievement(8);
				}
				if (!Statics.achievementsList[9] && Statics.maxDist > 1000000) {
					hud.showAchievement(Constants.AchievementsData[9][1]);
					Statics.achievementsList[9] = true;
					this.gameOverContainer.addNewAchievement(9);
				}
				if (!Statics.achievementsList[10] && Statics.maxDist > 1500000) {
					hud.showAchievement(Constants.AchievementsData[10][1]);
					Statics.achievementsList[10] = true;
					this.gameOverContainer.addNewAchievement(10);
				}
				// eof climb distance achievements
				
				// coin collection achievements
				if (!Statics.achievementsList[11] && this.coinsObtained > 500) {
					hud.showAchievement(Constants.AchievementsData[11][1]);
					Statics.achievementsList[11] = true;
					this.gameOverContainer.addNewAchievement(11);
				}
				if (!Statics.achievementsList[12] && this.coinsObtained > 1000) {
					hud.showAchievement(Constants.AchievementsData[12][1]);
					Statics.achievementsList[12] = true;
					this.gameOverContainer.addNewAchievement(12);
				}
				if (!Statics.achievementsList[13] && this.coinsObtained > 2000) {
					hud.showAchievement(Constants.AchievementsData[13][1]);
					Statics.achievementsList[13] = true;
					this.gameOverContainer.addNewAchievement(13);
				}
				if (!Statics.achievementsList[14] && this.coinsObtained > 3000) {
					hud.showAchievement(Constants.AchievementsData[14][1]);
					Statics.achievementsList[14] = true;
					this.gameOverContainer.addNewAchievement(14);
				}
				if (!Statics.achievementsList[15] && this.coinsObtained > 4000) {
					hud.showAchievement(Constants.AchievementsData[15][1]);
					Statics.achievementsList[15] = true;
					this.gameOverContainer.addNewAchievement(15);
				}
				if (!Statics.achievementsList[16] && this.coinsObtained > 5000) {
					hud.showAchievement(Constants.AchievementsData[16][1]);
					Statics.achievementsList[16] = true;
					this.gameOverContainer.addNewAchievement(16);
				}
				if (!Statics.achievementsList[17] && this.coinsObtained > 6500) {
					hud.showAchievement(Constants.AchievementsData[17][1]);
					Statics.achievementsList[17] = true;
					this.gameOverContainer.addNewAchievement(17);
				}
				if (!Statics.achievementsList[18] && this.coinsObtained > 8000) {
					hud.showAchievement(Constants.AchievementsData[18][1]);
					Statics.achievementsList[18] = true;
					this.gameOverContainer.addNewAchievement(18);
				}
				if (!Statics.achievementsList[19] && this.coinsObtained > 10000) {
					hud.showAchievement(Constants.AchievementsData[19][1]);
					Statics.achievementsList[19] = true;
					this.gameOverContainer.addNewAchievement(19);
				}
				if (!Statics.achievementsList[20] && this.coinsObtained > 15000) {
					hud.showAchievement(Constants.AchievementsData[20][1]);
					Statics.achievementsList[20] = true;
					this.gameOverContainer.addNewAchievement(20);
				}
				// eof coin collection achievements
			} // eof not in preparation mode
		}
		
		/**
		 * Player fails, check to see if saves are available
		 */
		private function playerFail():void {
			Statics.gamePaused = true;
			
			// explosion particles
			Statics.particleExplode.x = hero.x;
			Statics.particleExplode.y = hero.y;
			Statics.particleExplode.start(0.1);
			
			// stop sounds
			//SoundMixer.stopAll();
//			Sounds.stopBgm();
//			if (!Sounds.sfxMuted) Sounds.sndScratch.play();
			if (!Sounds.sfxMuted) Statics.assets.playSound("SND_CATCH_FIRE");
			
			Starling.juggler.delayCall(playerFailPartTwo, 1);
			
			// send round data to backend
			gameOverContainer.sendRoundData(this.coinsObtained, int(Statics.maxDist / 100));
			
			// mixpanel: collect game over info
			var activePowerup:String = "none";
			if (this.powerupAttraction.isActivated) {
				activePowerup = "attraction";
			}
			else if (this.powerupTeleportation.isActivated) {
				activePowerup = "teleportation";
			}
			else if (this.powerupCometRun.isActivated) {
				activePowerup = "comet";
			}
			else if (this.powerupBroomstick.isActivated) {
				activePowerup = "broomstick";
			}
			else if (this.powerupDuplication.isActivated) {
				activePowerup = "duplication";
			}
			else if (this.powerupSafety.isActivated) {
				activePowerup = "protection";
			}
			else if (this.powerupDaPan.isActivated) {
				activePowerup = "master da pan";
			}
			else if (this.powerupBarrels.isActivated) {
				activePowerup = "barrels";
			}
			else if (this.powerupVermilion.isActivated) {
				activePowerup = "vermilion bird";
			}
			if (Statics.isAnalyticsEnabled) {
				Statics.mixpanel.track('game over', { 
					"distance": int(Statics.maxDist / 100),
					"base score": this.coinsObtained,
					"level": Statics.levelNumber,
					"average fps": this.totalFps / this.fpsCounts,
					"active powerup": activePowerup
				});
			}
			trace("average fps: " + this.totalFps / this.fpsCounts);
		}
		
		private function playerFailPartTwo():void {
//			if (!Sounds.sfxMuted) Sounds.sndFail.play();
			this.inGameMenu.showMessageSmall(this.localization.getMessagePlayerFail());
			
			Statics.gamePaused = false;
			
			this.hero.failBounce();
			Statics.particleComet.start(0.5); // burning tail particles
			
			// end game after short duration
			this.endGameTime = Statics.gameTime + 3000;
			
			// stop checking win/lose condition
			Statics.checkWinLose = false;
			
			// revoke player control of hero
			this.playerControl = false;
		}
		
//		private function setupBonusMode(event:TimerEvent):void {
//			if (event != null) {
//				event.target.removeEventListener(TimerEvent.TIMER_COMPLETE, setupBonusMode);
//			}
//			
//			// clean up platforms
//			for(; this.platformsListLength > 0;) this.returnPlatformToPool(0);
//			
//			// clean up trains
//			for(; this.trainsListLength > 0;) this.returnTrainToPool(0);
//			
//			// clean up hourglasses
//			for(; this.hourglassesListLength > 0;) this.returnHourglassToPool(0);
//			
//			// reset music mode properties
//			this.moveMadeThisTurn = false;
//			
//			// set up bonus mode platforms
//			
//			// switch to bonus mode
//			Statics.gameMode = Constants.ModeBonus;
//			
//			// start checking game condition
//			this.checkWinLose = true;
//			this.playerControl = true;
//			
//			// launch hero
//			this.hero.dy = Constants.HeroInitialVelocityY;
//		}
		
		/**
		 * Clean up the stage and end game
		 */
		public function endGame():void {
			// deactivate all powerups
			this.powerupTeleportation.isActivated = false;
			this.powerupAttraction.isActivated = false;
			this.powerupSafety.isActivated = false;
			this.powerupDuplication.isActivated = false;
			this.powerupBarrels.isActivated = false;
			this.powerupBroomstick.isActivated = false;
			this.powerupVermilion.isActivated = false;
			this.powerupDaPan.isActivated = false;
			this.powerupCometRun.isActivated = false;
			
			// clean up platforms
			for(; this.platformsListLength > 0;) this.returnPlatformToPool(0);
			
			// clean up contraptions
			for(; this.contraptionsListLength > 0;) this.returnContraptionToPool(0);
			
			// remove event listeners
			this.stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyPressedDown);
			this.stage.removeEventListener(KeyboardEvent.KEY_UP, keyPressedUp);
			this.removeEventListener(Event.ENTER_FRAME, onGameTick);
			
			// show game over screen
			this.setChildIndex(gameOverContainer, this.numChildren - 1);
			gameOverContainer.initialize();
		}
		
		/**
		 * Scroll all of the rainbows downward
		 */
		public function scrollElements():void {
			var i:uint; // array index
			
			/** platform behaviors */
			// for aiming camera at next platform
			var smallestPlatformY:Number = this.hero.gy + this.stageHeight; // set it to a high value first
			var smallestPlatformIndex:int = -1;
			var isCoin:Boolean;
			var isStar:Boolean;
			var isSuper:Boolean;
			var isComet:Boolean;
			var isRepulsor:Boolean;
			var isBouncer:Boolean;
			var isAttractor:Boolean;
			var hasAttractor:Boolean = false;
			var isCannonball:Boolean;
			var isSpikyBomb:Boolean;
			var isMobile:Boolean;
			
			for (i = 0; i < this.platformsListLength; i++) { // loop through platforms
				isCoin = false;
				isStar = false;
				isSuper = false;
				isComet = false;
				isRepulsor = false;
				isBouncer = false;
				isAttractor = false;
				isCannonball = false;
				isSpikyBomb = false;
				isMobile = false;
				
//				this.platformBounds = this.platformsList[i].getBounds(this);
				this.platformsList[i].getBounds(this, this.platformBounds);
				if (this.platformsList[i] is Coin) {
					if (this.platformsList[i].isAcquired) { // make acquired coins fly out
						this.platformsList[i].dy = this.platformsList[i].yVelocity + this.camera.gyChange / this.timeDiffControlled;
						if (this.platformsList[i].y < 0) { // already moved out of screen, return to pool
							this.returnPlatformToPool(i);
							continue;
						}
					}
					
					platformBounds.inflate(50, 50); // enlarge coin bounds
					isCoin = true;
				} else if (this.platformsList[i] is Comet) {
					isComet = true;
					
					// show bright light
					if (!this.powerupCometRun.isActivated) {
						brightLightImage.visible = true;
						brightLightImage.x = this.platformsList[i].x;
						brightLightImage.y = this.platformsList[i].y;
					}
				} else if (this.platformsList[i] is Star) {
					isStar = true;
				} else if (this.platformsList[i] is PlatformSuper) {
					isSuper = true;
					this.platformsList[i].heroDy = this.hero.dy;
				} else if (this.platformsList[i] is Repulsor) {
					platformBounds.inflate(-100, -100); // shrink repulsor bounds
					isRepulsor = true;
				} else if (this.platformsList[i] is Bouncer) {
					platformBounds.inflate(-100, -100); // shrink repulsor bounds
					isBouncer = true;
				} else if (this.platformsList[i] is Attractor) {
					isAttractor = true;
				} else if (this.platformsList[i] is Cannonball) {
					isCannonball = true;
					platformBounds.inflate(-10, -10);
				} else if (this.platformsList[i] is SpikyBomb) {
					isSpikyBomb = true;
//					platformBounds.inflate(20, 20);
				} else if (this.platformsList[i] is PlatformDrop) {
					var shrinkage:Number = -this.platformsList[i].size * 8;
					platformBounds.inflate(shrinkage, shrinkage);
				} else if (this.platformsList[i] is PlatformMobile) {
					isMobile = true;
					shrinkage = -this.platformsList[i].size * 8;
					platformBounds.inflate(shrinkage, shrinkage);
				} else { // all other platforms
					platformBounds.inflate(-16, -16);
				}
				
				// detect hero/platform collisions if player has not yet lost
				if (Statics.checkWinLose && this.hero.canBounce) {
					var inCollision:Boolean = false;
					if (isAttractor && Statics.distance(this.hero.x, this.hero.y, platformsList[i].x, platformsList[i].y) < Constants.AttractorRadius) {
//					if (isAttractor) {
						// inside attractor aoe
						inCollision = true;
						hasAttractor = true;
					}
					else if (platformBounds.contains(this.hero.x - 10, this.hero.y + 20) ||
						platformBounds.contains(this.hero.x + 10, this.hero.y + 20)) {
						inCollision = true;
					}
					
					if (inCollision) { // platform collision!
						if (this.platformsList[i].touch()) { // ensures stuff inside this block only runs once per contact
							if (isCoin && !this.platformsList[i].isAcquired) {
//								if (this.platformsList[i] is BigCoin) {
//									this.coinsObtained += 100;
//									// show caption
////									bigCoinCaption.x = this.platformsList[i].x;
////									bigCoinCaption.y = this.platformsList[i].y;
////									bigCoinCaption.visible = true;
////									Starling.juggler.tween(bigCoinCaption, 1, {
////										transition: Transitions.EASE_OUT,
////										scaleX: 2.0,
////										scaleY: 2.0,
////										alpha: 0,
////										onComplete: hideBigCoinCaption
////									});
//								} 
								if (Statics.rankCoinDoubler == 1) { // player has coin doubler
									this.coinsObtained += this.platformsList[i].getValue() * 2;
								} else {
									this.coinsObtained += this.platformsList[i].getValue();
								}
								
								// activate coin fly out effect
								this.platformsList[i].isAcquired = true;
								var flightTime:Number = 500;
								// coin target x is Statics.stageWidth / 2
								this.platformsList[i].dx = (this.stageWidth / 2 - this.platformsList[i].gx) / flightTime;
								this.platformsList[i].yVelocity = (this.platformsList[i].y + 50) / flightTime;
								
								continue;
							}
							else if (isComet) {
								Statics.powerupsEnabled = false;
								this.powerupCometRun.activate();
								this.powerupAttraction.activate(true);
								this.returnPlatformToPool(i);
								if (Statics.isAnalyticsEnabled) { // mixpanel
									Statics.mixpanel.track('activated comet');
								}
								continue;
							}
							else if (isStar) {
								if (!this.hero.isTransfigured) {
									if (this.platformsList[i] is StarRed) {
										if (!Sounds.sfxMuted) Statics.assets.playSound("SND_MAGIC_EXPLOSION");
										Statics.particleJet.start(0.5);
									}
									this.hero.bounce(this.platformsList[i].getBouncePower());
//									Statics.particleLeaf.start(0.2); // play particle effect
									if (this.isHardwareRendering) {
										Statics.particleBounce.emitterX = this.platformsList[i].x;
										Statics.particleBounce.emitterY = this.platformsList[i].y;
										Statics.particleBounce.start(0.01);
									}
//									this.returnPlatformToPool(i);
									continue;
								}
							}
							else if (isSuper) {
//								this.hero.bounce(this.hero.dy + this.platformsList[i].getBouncePower());
								this.hero.bounce(this.platformsList[i].getBouncePower());
								this.platformsList[i].contact();
//								Statics.particleLeaf.start(0.2); // play particle effect
								Statics.particleJet.start(0.5);
								this.returnPlatformToPool(i);
								continue;
							}
							else if (isRepulsor) {
								this.hero.repulse(this.platformsList[i].gx, this.platformsList[i].gy);
								this.platformsList[i].contact();
							}
							else if (isBouncer) {
								// if transformed, do not go up, only bounce sideways
								if (this.hero.isTransfigured) this.hero.repulse(this.platformsList[i].gx, this.platformsList[i].gy);
								else this.hero.repulseOffBouncer(this.platformsList[i].gx, this.platformsList[i].gy);
								this.platformsList[i].contact();
								Statics.particleJet.start(0.5);
//								Statics.particleLeaf.start(0.2); // play particle effect
							}
							else if (isAttractor) {
								if (!this.hero.isTransfigured) {
									this.hero.attract(this.timeDiffControlled, this.platformsList[i].gx, this.platformsList[i].gy);
								}
								//lightning
								lightning.show();
								lightning.updatePosition(this.platformsList[i].x, this.platformsList[i].y, this.hero.x, this.hero.y);
							}
							else if (isCannonball) {
//								Statics.particleLeaf.start(0.2); // play particle effect
								if (Statics.gameTime > Statics.invincibilityExpirationTime) this.hero.repulseCannonball(this.platformsList[i].isVertical, this.platformsList[i].dx > 0);
//								this.returnPlatformToPool(i);
//								continue;
							}
							else if (isSpikyBomb) {
//								Statics.particleLeaf.start(0.2); // play particle effect
								if (Statics.gameTime > Statics.invincibilityExpirationTime) this.hero.repulseSpikyBomb();
								Statics.particleExplode.emitterX = hero.x;
								Statics.particleExplode.emitterY = hero.y;
								Statics.particleExplode.start(0.2);
								if (this.powerupDaPan.isActivated) this.hero.isDynamic = true;
//								this.returnPlatformToPool(i);
//								continue;
							}
							else if (this.hero.dy < 0 && !this.hero.isTransfigured) { // all other platforms: only if hero is falling
								if (this.platformsList[i].canBounce) {
									this.hero.bounce(this.platformsList[i].getBouncePower());
									this.platformsList[i].contact();
									// particle effects
									if (this.isHardwareRendering) {
										Statics.particleLeaf.start(0.2); // play particle effect
										Statics.particleBounce.emitterX = this.platformsList[i].x;
										Statics.particleBounce.emitterY = this.platformsList[i].y;
										Statics.particleBounce.start(0.01);
									}
									
									// squeesh effect
//									Starling.juggler.tween(this.hero, 0.2, {
//										transition: Transitions.LINEAR,
//										repeatCount: 2,
//										reverse: true,
//										scaleY:0.5
//									});
								}
							}
						}
					} else { // not in collision
						if (!isStar && !isCannonball && !isSpikyBomb) this.platformsList[i].isTouched = false; // when not colliding anymore, reset touch status
					}
				} // eof platform collision detection
				
				// bof power:attraction
				if (this.powerupAttraction.isActivated) {
//					if (!((isCoin && this.platformsList[i].isAcquired) || isAttractor || isRepulsor || isBouncer)) { // not acquired coin, attractor, repulsor or bouncer
					if (isCoin || isStar) { // test
//						var isCoinOrStar:Boolean = false;
//						var effectiveReachBelow:Number = 280;
//						if (isCoin || isStar) {
//							isCoinOrStar = true;
//							effectiveReachBelow = 140;
//						}
						var effectiveReachBelow:Number = 140;
						if (Statics.distance(this.hero.gx, this.hero.gy, this.platformsList[i].gx, this.platformsList[i].gy) < 300
							&& this.platformsList[i].gy > this.hero.gy - effectiveReachBelow) { // within effective area
							var easingFactor:Number = (150 - Math.abs(this.hero.gy - this.platformsList[i].gy) / 10);
							if (easingFactor < 5) easingFactor = 5;
							
							// x
							var d2x:Number = 0.0; // acceleration
							if (this.hero.gx >= this.platformsList[i].gx) {
								d2x = ((this.hero.gx - this.platformsList[i].gx) - this.platformsList[i].dx * easingFactor) / (0.5 * easingFactor * easingFactor);
							}
							else if (this.hero.gx <= this.platformsList[i].gx) {
								d2x = ((this.hero.gx - this.platformsList[i].gx) - this.platformsList[i].dx * easingFactor) / (0.5 * easingFactor * easingFactor);
							}
							else { // bring to rest
								d2x = -this.platformsList[i].dx / easingFactor;
							}
							this.platformsList[i].dx += d2x * this.timeDiffControlled;
							
//							if (isCoin) {
//								// y
//								var d2y:Number = 0.0; // acceleration
//								if (this.hero.gy >= this.platformsList[i].gy) { // move platform up
//									d2y = ((this.hero.gy - this.platformsList[i].gy) - this.platformsList[i].dy * easingFactor) / (0.5 * easingFactor * easingFactor);
//								}
//								else if (this.hero.gy <= this.platformsList[i].gy) { // move platform down
//									d2y = ((this.hero.gy - this.platformsList[i].gy) - this.platformsList[i].dy * easingFactor) / (0.5 * easingFactor * easingFactor);
//								}
//								else { // bring to rest
//									d2y = -this.platformsList[i].dy / easingFactor;
//								}
//								this.platformsList[i].dy += d2y * this.timeDiffControlled;
//							}
						}
					}
				}
//				else {
//					if (!(isCoin || isStar || isMobile || isCannonball || isComet))
//						this.platformsList[i].dx = 0; // searchmark
//				}
				// eof power:attraction
				
				// power:duplication mobile platforms movement
				if (this.powerupDuplication.isActivated) {
					// update mobile platform position
					if (isMobile) {
						if (this.platformsList[i].extenderStatus == -1) { // on left side of parent
							this.platformsList[i].gx = this.platformsList[i].extenderParent.gx - this.platformsList[i].extenderParent.getWidthFast();
						}
						else if (this.platformsList[i].extenderStatus == 1) { // on right side of parent
							this.platformsList[i].gx = this.platformsList[i].extenderParent.gx + this.platformsList[i].extenderParent.getWidthFast();
						}
					}
				}
				
				// update platform position
				this.platformsList[i].update(this.timeDiffControlled);
				
				// for aiming camera at next platform
				if (!isCoin && this.platformsList[i].gy > this.hero.gy && this.platformsList[i].gy < smallestPlatformY) {
					smallestPlatformY = this.platformsList[i].gy;
					smallestPlatformIndex = i;
				}
				
				// remove a platform if it has scrolled below sea of fire
				if (this.platformsList[i].gy < this.fg.sofHeight - 100) {
					if (platformsList[i].y < this.stageHeight) { // dousing animation and sound if visible
						//					Statics.particleBounce.emitterX = this.platformsList[i].x;
						//					Statics.particleBounce.emitterY = this.platformsList[i].y;
						//					Statics.particleBounce.start(0.4);
						if (!Sounds.sfxMuted) Statics.assets.playSound("SND_DOUSE_FIRE");
					}
					
					this.returnPlatformToPool(i);
					continue;
				}
				// remove a platform if it has flew too high (pyromancy platform supers, moving stars)
				if (this.platformsList[i].gy > this.hero.gy + this.stageHeight * 3.5) {
					this.returnPlatformToPool(i);
					continue;
				}
			} // eof loop through platforms
			
			//lightning
			if (!hasAttractor) this.lightning.hide();
			
			// update next platform position
			if (smallestPlatformIndex != -1) {
				Statics.nextPlatformX = this.platformsList[smallestPlatformIndex].gx;
//				Statics.nextPlatformY = this.platformsList[smallestPlatformIndex].gy + this.platformsList[smallestPlatformIndex].height;
				Statics.nextPlatformY = this.platformsList[smallestPlatformIndex].gy + 100;
			}
			/** eof platform behaviors */
			
			/** contraption behaviors */
			var numCoinsToDrop:int;
			var ci:uint;
			var newCoinIndex:int;
			for (i = 0; i < this.contraptionsListLength; i++) {
//				var contraptionBounds:Rectangle = this.contraptionsList[i].bounds;
				this.contraptionsList[i].getBounds(this, this.platformBounds);
				
//				if (Object(this.contraptionsList[i]).constructor == Hourglass) { /** hourglass behaviors */
//					if (Statics.checkWinLose) { // check hero/hourglass collision if not yet lost
//						if (contraptionBounds.contains(this.hero.x - 10, this.hero.y + 20) ||
//							contraptionBounds.contains(this.hero.x + 10, this.hero.y + 20) ||
//							contraptionBounds.contains(this.hero.x - 10, this.hero.y - 20) ||
//							contraptionBounds.contains(this.hero.x + 10, this.hero.y - 20)) {
//							this.contraptionsList[i].contact();
//						}
//					}
//				} /** eof hourglass behaviors */
				
				if (Object(this.contraptionsList[i]).constructor == Train) { /** train behaviors */
					if (Statics.checkWinLose && this.hero.canBounce && this.contraptionsList[i].isLaunched && Statics.gameTime > Statics.invincibilityExpirationTime) { // check hero/train collision if not yet lost
						platformBounds.left += 120;
						platformBounds.inflate(-50, -50); // shrink train bounds
						if (platformBounds.contains(this.hero.x - 10, this.hero.y + 20) ||
							platformBounds.contains(this.hero.x + 10, this.hero.y + 20) ||
							platformBounds.contains(this.hero.x - 10, this.hero.y - 20) ||
							platformBounds.contains(this.hero.x + 10, this.hero.y - 20)) {
							if (this.hero.gx < this.contraptionsList[i].gx + 100) { // hit by a train
//								this.playerControl = false;
//								this.hero.dx = Constants.TrainVelocity * 4;
								this.hero.bounceAndFade(Constants.DirectionLeft, Constants.TrainVelocity * 3);
								Statics.cameraShake = 40;
								if (Statics.isAnalyticsEnabled) Statics.mixpanel.track('hit by train from right');
							}
							else {
								if (this.hero.gy > this.contraptionsList[i].gy) { // roof bounce
									this.hero.bounceAndFade(Constants.DirectionUp, Constants.PowerBouncePower);
								}
								else { // bottom bounce
									this.hero.bounceAndFade(Constants.DirectionDown, 0);
								}
							}
							// spray some coins
							numCoinsToDrop = int(Math.ceil(Math.random() * 20));
							for (ci = 0; ci < numCoinsToDrop; ci++) {
								newCoinIndex = addElementFromPool(this.hero.gy, this.hero.gx, "Coin");
								if (newCoinIndex != -1) this.platformsList[newCoinIndex].makeKinematic(Constants.PowerBouncePower);
							}
						}
					}
				} /** eof train behaviors */
				
				else if (Object(this.contraptionsList[i]).constructor == TrainFromLeft) { /** train from left behaviors */
					if (Statics.checkWinLose && this.hero.canBounce && this.contraptionsList[i].isLaunched && Statics.gameTime > Statics.invincibilityExpirationTime) { // check hero/train collision if not yet lost
						platformBounds.right -= 120;
						platformBounds.inflate(-50, -50); // shrink train bounds
						if (platformBounds.contains(this.hero.x - 10, this.hero.y + 20) ||
							platformBounds.contains(this.hero.x + 10, this.hero.y + 20) ||
							platformBounds.contains(this.hero.x - 10, this.hero.y - 20) ||
							platformBounds.contains(this.hero.x + 10, this.hero.y - 20)) {
							if (this.hero.gx > this.contraptionsList[i].gx - 100) { // hit by a train
//								this.playerControl = false;
//								this.hero.dx = -Constants.TrainVelocity * 4;
								this.hero.bounceAndFade(Constants.DirectionRight, Constants.TrainVelocity * 3);
								Statics.cameraShake = 40;
								if (Statics.isAnalyticsEnabled) Statics.mixpanel.track('hit by train from left');
							}
							else {
								if (this.hero.gy > this.contraptionsList[i].gy) { // roof bounce
									this.hero.bounceAndFade(Constants.DirectionUp, Constants.PowerBouncePower);
								}
								else { // bottom bounce
									this.hero.bounceAndFade(Constants.DirectionDown, 0);
								}
							}
							// spray some coins
							numCoinsToDrop = int(Math.ceil(Math.random() * 20));
							for (ci = 0; ci < numCoinsToDrop; ci++) {
								newCoinIndex = addElementFromPool(this.hero.gy, this.hero.gx, "Coin");
								if (newCoinIndex != -1) this.platformsList[newCoinIndex].makeKinematic(Constants.PowerBouncePower);
							}
						}
					}
				} /** eof train from left behaviors */
				
				else if (Object(this.contraptionsList[i]).constructor == Bell) { /** bell behaviors */
					if (Statics.checkWinLose) { // check hero/bell collision if not yet lost
//						contraptionBounds.inflate(-100, -100); // shrink bell bounds
//						if (contraptionBounds.contains(this.hero.x - 10, this.hero.y + 20) ||
//							contraptionBounds.contains(this.hero.x + 10, this.hero.y + 20) ||
//							contraptionBounds.contains(this.hero.x - 10, this.hero.y - 20) ||
//							contraptionBounds.contains(this.hero.x + 10, this.hero.y - 20)) {
//							this.contraptionsList[i].contact(this.hero.gx - this.contraptionsList[i].gx, this.hero.dy);
//						}
						// use distance based approach
						var distance:Number = Statics.distance(this.contraptionsList[i].gx, this.contraptionsList[i].gy, this.hero.gx, this.hero.gy);
						if (distance < this.contraptionsList[i].fastHeight / 2 + this.hero.fastHeight / 2 - 150) { // bell collision
							if (this.contraptionsList[i].contact(this.hero.gx - this.contraptionsList[i].gx, this.hero.dy)) { // hero made true contact with bell
								// drop coins
								numCoinsToDrop = int(Math.ceil(Math.random() * 20));
								for (ci = 0; ci < numCoinsToDrop; ci++) {
									newCoinIndex = addElementFromPool(this.contraptionsList[i].gy, this.contraptionsList[i].gx, "CoinBronze");
									if (newCoinIndex != -1) this.platformsList[newCoinIndex].makeKinematic(Constants.NormalBouncePower);
								}
								
								if (this.contraptionsList[i].numDings >= 3) { // three dings
									// drop regular stars
									numCoinsToDrop = int(Math.ceil(Math.random() * 5));
									for (ci = 0; ci < numCoinsToDrop; ci++) {
										newCoinIndex = addElementFromPool(this.contraptionsList[i].gy, this.contraptionsList[i].gx, "Star");
										if (newCoinIndex != -1) this.platformsList[newCoinIndex].makeKinematic(Constants.NormalBouncePower);
									}
									
									// drop blue stars
									numCoinsToDrop = int(Math.ceil(Math.random() * 3));
									for (ci = 0; ci < numCoinsToDrop; ci++) {
										newCoinIndex = addElementFromPool(this.contraptionsList[i].gy, this.contraptionsList[i].gx, "StarBlue");
										if (newCoinIndex != -1) this.platformsList[newCoinIndex].makeKinematic(Constants.NormalBouncePower);
									}
									
									// drop silver coins
									numCoinsToDrop = 5;
									for (ci = 0; ci < numCoinsToDrop; ci++) {
										newCoinIndex = addElementFromPool(this.contraptionsList[i].gy, this.contraptionsList[i].gx, "CoinSilver");
										if (newCoinIndex != -1) this.platformsList[newCoinIndex].makeKinematic(Constants.NormalBouncePower);
									}
								}
								
								if (this.contraptionsList[i].numDings >= 6) { // six dings
									// drop red stars
									numCoinsToDrop = int(Math.ceil(Math.random() * 2));
									for (ci = 0; ci < numCoinsToDrop; ci++) {
										newCoinIndex = addElementFromPool(this.contraptionsList[i].gy, this.contraptionsList[i].gx, "StarRed");
										if (newCoinIndex != -1) this.platformsList[newCoinIndex].makeKinematic(Constants.NormalBouncePower);
									}
									
									// drop gold coins
									numCoinsToDrop = 5;
									for (ci = 0; ci < numCoinsToDrop; ci++) {
										newCoinIndex = addElementFromPool(this.contraptionsList[i].gy, this.contraptionsList[i].gx, "Coin");
										if (newCoinIndex != -1) this.platformsList[newCoinIndex].makeKinematic(Constants.NormalBouncePower);
									}
									
									// drop comets
									newCoinIndex = addElementFromPool(this.contraptionsList[i].gy, this.contraptionsList[i].gx, "Comet");
									this.platformsList[newCoinIndex].makeKinematic(Constants.NormalBouncePower);
								}
							} // eof true bell contact
						} // eof bell collision
					} // eof checkWinLose
				} /** eof bell behaviors */
				
				else if (this.contraptionsList[i] is PowerupBox) { /** powerup boxes behaviors */
					if (!this.contraptionsList[i].touched) {
						if (Statics.checkWinLose) { // check hero/box collision if not yet lost
							platformBounds.inflate(-20, -20); // shrink powerup box bounds
							if (platformBounds.contains(this.hero.x - 10, this.hero.y + 20) ||
								platformBounds.contains(this.hero.x + 10, this.hero.y + 20) ||
								platformBounds.contains(this.hero.x - 10, this.hero.y - 20) ||
								platformBounds.contains(this.hero.x + 10, this.hero.y - 20)) {
								if (Statics.powerupsEnabled) this.contraptionsList[i].contact(this.hud);
								else this.contraptionsList[i].blowUpWithoutContact();
							}
						}
					}
				} /** eof powerup boxes behaviors */
				
				else if (Object(this.contraptionsList[i]).constructor == Cannon) { /** cannon behaviors */
					this.contraptionsList[i].heroGy = this.hero.gy;
					this.contraptionsList[i].sofHeight = this.fg.sofHeight;
					if (this.contraptionsList[i].checkFiring() == 1) {
//						if (Math.random() > 0.5) {
							newCoinIndex = addElementFromPool(this.contraptionsList[i].gy, this.contraptionsList[i].gx, "Cannonball");
							if (newCoinIndex != -1) this.platformsList[newCoinIndex].makeKinematicWithDx(-Math.random() * 1 - 0.5);
//						} else {
//							newCoinIndex = addElementFromPool(this.contraptionsList[i].gy, this.contraptionsList[i].gx, "Star");
//							this.platformsList[newCoinIndex].makeKinematicWithDx(-Math.random() * 1 - 0.5);
//						}
//						if (!Sounds.sfxMuted) Sounds.sndCannonFire.play(); // play cannon firing sound
					}
					if (Statics.checkWinLose) { // check hero/cannon collision if not yet lost
						if (platformBounds.contains(this.hero.x - 10, this.hero.y + 20) ||
							platformBounds.contains(this.hero.x + 10, this.hero.y + 20) ||
							platformBounds.contains(this.hero.x - 10, this.hero.y - 20) ||
							platformBounds.contains(this.hero.x + 10, this.hero.y - 20)) {
							if (this.hero.gy > this.contraptionsList[i].gy && this.hero.dy < 0.5) { // top bounce
								this.contraptionsList[i].contact();
								this.hero.bounce(Constants.PowerBouncePower);
//								Statics.particleLeaf.start(0.2); // play particle effect
								if (this.isHardwareRendering) {
									Statics.particleBounce.emitterX = this.contraptionsList[i].x;
									Statics.particleBounce.emitterY = this.contraptionsList[i].y;
									Statics.particleBounce.start(0.01);
								}
								
								if (Statics.isAnalyticsEnabled) { // mixpanel
									Statics.mixpanel.track('destroyed cannon on right');
								}
							}
//							Statics.particleLeaf.start(0.2); // play particle effect
						}
					}
				} /** eof cannon behaviors */
				
				else if (Object(this.contraptionsList[i]).constructor == CannonFromLeft) { /** cannon from left behaviors */
					this.contraptionsList[i].heroGy = this.hero.gy;
					this.contraptionsList[i].sofHeight = this.fg.sofHeight;
					if (this.contraptionsList[i].checkFiring() == 1) {
//						if (Math.random() > 0.5) {
							newCoinIndex = addElementFromPool(this.contraptionsList[i].gy, this.contraptionsList[i].gx, "Cannonball");
							if (newCoinIndex != -1) this.platformsList[newCoinIndex].makeKinematicWithDx(Math.random() * 1 + 0.5);
//						} else {
//							newCoinIndex = addElementFromPool(this.contraptionsList[i].gy, this.contraptionsList[i].gx, "Star");
//							this.platformsList[newCoinIndex].makeKinematicWithDx(Math.random() * 1 + 0.5);
//						}
//						if (!Sounds.sfxMuted) Sounds.sndCannonFire.play(); // play cannon firing sound
					}
					if (Statics.checkWinLose) { // check hero/cannon collision if not yet lost
						if (platformBounds.contains(this.hero.x - 10, this.hero.y + 20) ||
							platformBounds.contains(this.hero.x + 10, this.hero.y + 20) ||
							platformBounds.contains(this.hero.x - 10, this.hero.y - 20) ||
							platformBounds.contains(this.hero.x + 10, this.hero.y - 20)) {
							if (this.hero.gy > this.contraptionsList[i].gy && this.hero.dy < 0.5) { // top bounce
								this.contraptionsList[i].contact();
								this.hero.bounce(Constants.PowerBouncePower);
//								Statics.particleLeaf.start(0.2); // play particle effect
								if (this.isHardwareRendering) {
									Statics.particleBounce.emitterX = this.contraptionsList[i].x;
									Statics.particleBounce.emitterY = this.contraptionsList[i].y;
									Statics.particleBounce.start(0.01);
								}
								
								if (Statics.isAnalyticsEnabled) { // mixpanel
									Statics.mixpanel.track('destroyed cannon on left');
								}
							}
//							Statics.particleLeaf.start(0.2); // play particle effect
						}
					}
				} /** eof cannon from left behaviors */
				
				else if (this.contraptionsList[i] is Witch) { /** witch behaviors */
					if (this.contraptionsList[i].gx > -this.stageWidth / 2 && this.contraptionsList[i].checkFiring() == 1) {
						newCoinIndex = addElementFromPool(this.contraptionsList[i].gy, this.contraptionsList[i].gx, "Star");
						if (newCoinIndex != -1) this.platformsList[newCoinIndex].makeKinematicWithDx(-0.2);
					}
				} /** eof witch behaviors */
				
				// update contraptions
				this.contraptionsList[i].update(this.timeDiffControlled);
//				if(Object(this.contraptionsList[i]).constructor == Bell) this.contraptionsList[i].debug(this.hero.gy);
				
				// remove a contraption if it has scrolled below sea of fire
//				if (this.contraptionsList[i].gy < this.fg.sofHeight - this.contraptionsList[i].height) {
				if (this.contraptionsList[i].gy < this.fg.sofHeight - 200) {
					// canon crash sound effect
					if (this.contraptionsList[i] is Cannon) {
						if (!Sounds.sfxMuted) Statics.assets.playSound("SND_DISTANT_EXPLOSION");
					}
					
					this.returnContraptionToPool(i);
				}
			} /** eof contraption behaviors */
			
			// scroll background and foreground layers
//			this.bg.scroll(this.timeDiffReal, leftArrow, rightArrow); // also scroll floating stars according to key presses
			this.bg.scroll(this.timeDiffReal, this.camera.gy, this.camera.gyChange, this.hero.dx); // also scroll floating stars according to hero velocity
			this.fg.scroll(this.timeDiffReal, this.camera.gy, this.camera.gyChange);
			
			/** Stage Element Population */
			// populate area above visible stage with next elements in level elements array
			while (this.levelParser.levelElementsArray.length > 0 && this.levelParser.levelElementsArray[0][0] <= this.camera.gy + Constants.ElementPreloadWindow) {
				var levelElement:Array = this.levelParser.levelElementsArray[0];
				
				if (levelElement[1] is String) {
					if (levelElement[1] == Constants.ContraptionSettingHourglass) {// check for hourglass settings
						this.contraptionControl.setIntervalAndScheduleNext(Constants.ContraptionHourglass, levelElement[2]);
					}
					else if (levelElement[1] == Constants.ContraptionSettingTrainRight) { // check for train from right settings
						this.contraptionControl.setIntervalAndScheduleNext(Constants.ContraptionTrain, levelElement[2]);
					}
					else if (levelElement[1] == Constants.ContraptionSettingTrainLeft) { // check for train from left settings
						this.contraptionControl.setIntervalAndScheduleNext(Constants.ContraptionTrainFromLeft, levelElement[2]);
					}
					else if (levelElement[1] == Constants.ContraptionSettingBell) { // check for bell settings
						this.contraptionControl.setIntervalAndScheduleNext(Constants.ContraptionBell, levelElement[2]);
					}
					else if (levelElement[1] == Constants.ContraptionSettingPowerupBoxes) {// check for powerup boxes settings
						this.contraptionControl.setIntervalAndScheduleNext(Constants.ContraptionPowerupBoxes, levelElement[2], false);
					}
					else if (levelElement[1] == Constants.ContraptionSettingCannon) {// check for cannon settings
						this.contraptionControl.setIntervalAndScheduleNext(Constants.ContraptionCannon, levelElement[2]);
						this.contraptionControl.setIntervalAndScheduleNext(Constants.ContraptionCannonFromLeft, levelElement[2]);
					}
					else if (levelElement[1] == Constants.ContraptionSettingWitch) { // check for witch settings
						this.contraptionControl.setIntervalAndScheduleNext(Constants.ContraptionWitch, levelElement[2]);
					}
					else if (levelElement[1] == Constants.PowerSettingDuplication) { // turn power duplication on or off
						if (levelElement[2]) this.isDuplicationEnabled = true;
						else this.isDuplicationEnabled = false;
					}
				}
//				else if (levelElement[2] == Constants.Coin && Statics.gameMode == Constants.ModeBonus) {
//					// do not add coins if in bonus mode
//				}
				else { // add platform element
					var newElementIndex:int = this.addElementFromPool(levelElement[0], levelElement[1], levelElement[2], levelElement[3], levelElement[4], levelElement[5], levelElement[6], levelElement[7], levelElement[8], levelElement[9]);	
					// power:duplication, add extended platforms
//					trace("level: " + Statics.levelNumber); //searchmark
					if (this.powerupDuplication.isActivated && this.isDuplicationEnabled && newElementIndex != -1 && !(this.platformsList[newElementIndex] is Coin) && levelElement[2] != "Attractor" && levelElement[2] != "StarDark") {
						var newPlatformExtenderIndex:int;
						newPlatformExtenderIndex = addElementFromPool(
							levelElement[0],
							-this.stageWidth / 2 - this.platformsList[newElementIndex].getWidthFast(),
							levelElement[2], levelElement[3], levelElement[4], levelElement[5], levelElement[6], levelElement[7], levelElement[8], levelElement[9]);
						if (newPlatformExtenderIndex != -1) this.platformsList[newPlatformExtenderIndex].makeExtender(this.platformsList[newElementIndex],
							-1, levelElement[1] - this.platformsList[newElementIndex].getWidthFast(), this.platformsList[newElementIndex].isStar());
						
						newPlatformExtenderIndex = addElementFromPool(
							levelElement[0],
							this.stageWidth / 2 + this.platformsList[newElementIndex].getWidthFast(),
							levelElement[2], levelElement[3], levelElement[4], levelElement[5], levelElement[6], levelElement[7], levelElement[8], levelElement[9]);
						if (newPlatformExtenderIndex != -1) this.platformsList[newPlatformExtenderIndex].makeExtender(this.platformsList[newElementIndex],
							1, levelElement[1] + this.platformsList[newElementIndex].getWidthFast(), this.platformsList[newElementIndex].isStar());
					}
				}
				this.levelParser.levelElementsArray.splice(0, 1); // remove this entry from level elements array
			}
			// request new block
			if (this.levelParser.levelElementsArray.length == 0) this.levelParser.requestBlock();
//			trace("duplication enabled: " + this.isDuplicationEnabled.toString());
		} /** eof scrollElements() */
		
//		private function summonHourglass():void {
////			if (Statics.gameMode == Constants.ModeNormal) { // only summon hourglass in normal mode
//				var gx:Number = Math.random() * (Constants.StageWidth - Constants.ScreenBorder) 
//					- (Constants.StageWidth - Constants.ScreenBorder) / 2;
//				this.addContraptionFromPool(this.hero.gy + Constants.StageHeight / 2, gx, "Hourglass");
//				this.contraptionControl.scheduleNext(Constants.ContraptionHourglass);
////			}
//		}
		
		private function launchTrain():void {
//			if (Statics.gameMode == Constants.ModeNormal) { // only dispatch train in normal mode
				this.addContraptionFromPool(this.hero.gy + this.stageHeight / 2, this.stageWidth / 2, "Train");
				//if (!Sounds.sfxMuted) Sounds.sndTrainWarning.play();
				this.contraptionControl.scheduleNext(Constants.ContraptionTrain);
//			}
		}
		
		private function launchTrainFromLeft():void {
//			if (Statics.gameMode == Constants.ModeNormal) { // only dispatch train in normal mode
				this.addContraptionFromPool(this.hero.gy + this.stageHeight / 2, -this.stageWidth / 2, "TrainFromLeft");
				//if (!Sounds.sfxMuted) Sounds.sndTrainWarning.play();
				this.contraptionControl.scheduleNext(Constants.ContraptionTrainFromLeft);
//			}
		}
		
		private function dropBell():void {
//			trace("Dropping bell...");
//			if (Statics.gameMode == Constants.ModeNormal) { // only summon bell in normal mode
				this.addContraptionFromPool(this.hero.gy + this.stageHeight, Math.random() * 50 - 25, "Bell");
				this.contraptionControl.scheduleNext(Constants.ContraptionBell);
//			}
		}
		
		private function summonPowerupBoxes():void {
			if (Statics.powerupsEnabled) { // only summon powerup boxes in normal mode
				var yPos:Number = Statics.maxDist + this.stageHeight / 2;
				this.addContraptionFromPool(yPos, -300, "PowerupBoxPink");
				this.addContraptionFromPool(yPos, -100, "PowerupBoxGreen");
				this.addContraptionFromPool(yPos, 100, "PowerupBoxFire");
				this.addContraptionFromPool(yPos, 300, "PowerupBoxBlue");
//				this.addContraptionFromPool(this.hero.gy + Constants.StageHeight / 2, 300, "PowerupBoxPurple");
				this.contraptionControl.scheduleNext(Constants.ContraptionPowerupBoxes, false);
			}
		}
		
		private function summonCannon():void {
			this.addContraptionFromPool(this.hero.gy + this.stageHeight / 2, this.stageWidth / 2 - 100, "Cannon");
			this.contraptionControl.scheduleNext(Constants.ContraptionCannon);
		}
		
		private function summonCannonFromLeft():void {
			this.addContraptionFromPool(this.hero.gy + this.stageHeight / 2, -this.stageWidth / 2 + 100, "CannonFromLeft");
			this.contraptionControl.scheduleNext(Constants.ContraptionCannonFromLeft);
		}
		
		private function summonWitch():void {
			this.addContraptionFromPool(this.camera.gy + this.stageHeight / 2 + 50, this.stageWidth / 2 + 100, "Witch");
			this.contraptionControl.scheduleNext(Constants.ContraptionWitch);
		}
		
		/**
		 * Add an element to the stage
		 * @return uint the platforms array index of the newly added platfrom
		 */
		private function addElementFromPool(y:Number, x:Number, elementClassName:String, elementSize:int = 0, ... args):int {
			var qualifiedName:String = "com.jumpGame.gameElements.platforms::" + elementClassName;
			var elementClass:Class = getDefinitionByName(qualifiedName) as Class;
			var tempElement:Platform = ObjectPool.instance.getObj(qualifiedName) as elementClass;
			if (tempElement == null) {
//				throw new Error("Pool is full: " + elementClassName);
				trace("Pool is full: " + elementClassName);
				return -1;
			}
			tempElement.initialize(x, y, elementSize, args);
			this.addChild(tempElement);
			this.platformsList[platformsListLength++] = tempElement;
			if (elementClassName == "SpikyBomb") this.setChildIndex(tempElement, this.getChildIndex(this.hud) + 1); // place in front of HUD because spiky bomb is on the same atlas
			else this.setChildIndex(tempElement, this.getChildIndex(this.hero)); // push newly added element behind hero
			return platformsListLength - 1;
		}
		
		// add a contraption to stage
		private function addContraptionFromPool(y:Number, x:Number, elementClassName:String):void {
			var qualifiedName:String = "com.jumpGame.gameElements.contraptions::" + elementClassName;
			var elementClass:Class = getDefinitionByName(qualifiedName) as Class;
			var tempElement:Contraption = ObjectPool.instance.getObj(qualifiedName) as elementClass;
			if (tempElement == null) {
//				throw new Error("Pool is full: " + elementClassName);
				trace("Pool is full: " + elementClassName);
				return;
			}
			tempElement.initialize();
			tempElement.gx = x;
			tempElement.gy = y;
			this.addChild(tempElement);
			this.contraptionsList[contraptionsListLength++] = tempElement;
			this.setChildIndex(tempElement, this.getChildIndex(this.hero)); // push newly added element behind hero
		}
		
		/**
		 * Dispose the platform temporarily. Check-in into pool (will get cleaned) and reduce the vector length by 1
		 */
		private function returnPlatformToPool(platformIndex:uint):void
		{
			var platform:Platform = platformsList[platformIndex];
			platformsList.splice(platformIndex, 1);
			platformsListLength--;
			ObjectPool.instance.returnObj(platform);
		}
		
		/**
		 * Dispose the contraption temporarily. Check-in into pool (will get cleaned) and reduce the vector length by 1
		 */
		private function returnContraptionToPool(contraptionIndex:uint):void
		{
			var contraption:Contraption = contraptionsList[contraptionIndex];
			contraptionsList.splice(contraptionIndex, 1);
			contraptionsListLength--;
			ObjectPool.instance.returnObj(contraption);
		}
		
		// shake camera
		private function shakeCamera():void {
			// animate quake effect, shaking the camera a little to the sides and up and down
			if (Statics.cameraShake > 0)
			{
				Statics.cameraShake -= 0.1 * this.timeDiffReal;
				// Shake left right randomly.
				this.x = int(Math.random() * Statics.cameraShake - Statics.cameraShake * 0.5); 
				// Shake up down randomly.
				this.y = int(Math.random() * Statics.cameraShake - Statics.cameraShake * 0.5); 
			}
			else if (x != 0) 
			{
				// If the shake value is 0, reset the stage back to normal.
				// Reset to initial position.
				this.x = 0;
				this.y = 0;
			}
		}
		
//		private function hideBigCoinCaption():void {
//			bigCoinCaption.visible = false;
//			bigCoinCaption.scaleX = 1;
//			bigCoinCaption.scaleY = 1;
//			bigCoinCaption.alpha = 1;
//		}
		
		/**
		 * Reference Classes
		 */
//		private function referenceElementClasses():void {
//			PlatformNormal;
//			PlatformDrop;
//			PlatformMobile;
//			PlatformNormalBoost;
//		}
	}
}