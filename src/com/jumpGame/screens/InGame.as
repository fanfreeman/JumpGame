package com.jumpGame.screens
{
	import com.jumpGame.gameElements.Background;
	import com.jumpGame.gameElements.Camera;
	import com.jumpGame.gameElements.Contraption;
	import com.jumpGame.gameElements.Hero;
	import com.jumpGame.gameElements.Platform;
	import com.jumpGame.gameElements.Transfiguration;
	import com.jumpGame.gameElements.contraptions.Bell;
	import com.jumpGame.gameElements.contraptions.Cannon;
	import com.jumpGame.gameElements.contraptions.CannonFromLeft;
	import com.jumpGame.gameElements.contraptions.Hourglass;
	import com.jumpGame.gameElements.contraptions.PowerupBox;
	import com.jumpGame.gameElements.contraptions.PowerupBoxBlue;
	import com.jumpGame.gameElements.contraptions.PowerupBoxFire;
	import com.jumpGame.gameElements.contraptions.PowerupBoxGreen;
	import com.jumpGame.gameElements.contraptions.PowerupBoxPink;
	import com.jumpGame.gameElements.contraptions.PowerupBoxPurple;
	import com.jumpGame.gameElements.contraptions.Train;
	import com.jumpGame.gameElements.contraptions.TrainFromLeft;
	import com.jumpGame.gameElements.contraptions.Witch;
	import com.jumpGame.gameElements.platforms.BigCoin;
	import com.jumpGame.gameElements.platforms.Cannonball;
	import com.jumpGame.gameElements.platforms.Coin;
	import com.jumpGame.gameElements.platforms.Comet;
	import com.jumpGame.gameElements.platforms.PlatformDrop;
	import com.jumpGame.gameElements.platforms.PlatformDropBoost;
	import com.jumpGame.gameElements.platforms.PlatformMobile;
	import com.jumpGame.gameElements.platforms.PlatformMobileBoost;
	import com.jumpGame.gameElements.platforms.PlatformNormal;
	import com.jumpGame.gameElements.platforms.PlatformNormalBoost;
	import com.jumpGame.gameElements.platforms.PlatformPower;
	import com.jumpGame.gameElements.platforms.PlatformSuper;
	import com.jumpGame.gameElements.platforms.Repulsor;
	import com.jumpGame.gameElements.platforms.Star;
	import com.jumpGame.gameElements.platforms.StarBlue;
	import com.jumpGame.gameElements.platforms.StarDark;
	import com.jumpGame.gameElements.platforms.StarMini;
	import com.jumpGame.gameElements.platforms.StarRed;
	import com.jumpGame.gameElements.powerups.Attractor;
	import com.jumpGame.gameElements.powerups.Blink;
	import com.jumpGame.gameElements.powerups.CometRun;
	import com.jumpGame.gameElements.powerups.Expansion;
	import com.jumpGame.gameElements.powerups.Extender;
	import com.jumpGame.gameElements.powerups.Levitation;
	import com.jumpGame.gameElements.powerups.Pyromancy;
	import com.jumpGame.level.ContraptionControl;
	import com.jumpGame.level.LevelParser;
	import com.jumpGame.level.Statics;
	import com.jumpGame.objectPools.ObjectPool;
	import com.jumpGame.ui.GameOverContainer;
	import com.jumpGame.ui.HUD;
	import com.jumpGame.ui.PauseButton;
	
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import flash.utils.getDefinitionByName;
	import flash.utils.getTimer;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
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
		
		// hero
		private var hero:Hero;
		
		// platforms
		private var platformsList:Vector.<Platform>;
		private var platformsListLength:uint = 0;
		
		// contraptions
		private var contraptionsList:Vector.<Contraption>;
		private var contraptionsListLength:uint = 0;
		
		// powerups
		private var powerupsList:Vector.<GameObject>;
		private var powerupsListLength:uint = 0;
		
		// comet bright light
		private var brightLightImage:Image;
		
		// big coin caption
		private var bigCoinCaption:Image;
		
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
		private var coinsObtained:int = 0;
		
		// times jumped
		private var jumps:int = 0;
		
		private var heroHasBouncedOffSof:Boolean;
		
		// ------------------------------------------------------------------------------------------------------------
		// GAME INTERACTION 
		// ------------------------------------------------------------------------------------------------------------
		
		// whether or not to check win/lose condition
		private var checkWinLose:Boolean = true;
		
		// time to end the game
		private var endGameTime:int;
		
		// music mode variables
		private var moveMadeThisTurn:Boolean = false;
		private var moveMade:uint = 0;
		
		// transfiguration activation
		private var transfiguration:Transfiguration;
		
		// ------------------------------------------------------------------------------------------------------------
		// USER CONTROL
		// ------------------------------------------------------------------------------------------------------------
		
		// keyboard input
		private var leftArrow:Boolean = false;
		private var rightArrow:Boolean = false;
		private var upArrow:Boolean = false;
		private var downArrow:Boolean = false;
		
		// whether or not the player has control of the hero
		private var playerControl:Boolean = true;
		
		// ------------------------------------------------------------------------------------------------------------
		// PARTICLES
		// ------------------------------------------------------------------------------------------------------------
		
		// particles
//		private var particlesList:Vector.<Particle>;
//		private var particlesListLength:uint = 0;
		
		// weather
		private var weather:Weather;
		
		// ------------------------------------------------------------------------------------------------------------
		// HUD
		// ------------------------------------------------------------------------------------------------------------
		
		/** HUD Container. */		
		private var hud:HUD;
		
		// ------------------------------------------------------------------------------------------------------------
		// INTERFACE OBJECTS
		// ------------------------------------------------------------------------------------------------------------
		
		/** GameOver Container. */
		private var gameOverContainer:GameOverContainer;
		
		/** Pause button. */
		private var pauseButton:PauseButton;
		
		/** Kick Off button in the beginning of the game .*/
		//private var startButton:starling.display.Button;
		
		/** Tween object for game over container. */
		private var tween_gameOverContainer:Tween;
		
		// ------------------------------------------------------------------------------------------------------------
		// LEVEL PARSING AND GENERATION
		// ------------------------------------------------------------------------------------------------------------
		
		private var levelParser:LevelParser;
		private var contraptionControl:ContraptionControl;
		
		// ------------------------------------------------------------------------------------------------------------
		// COMMUNICATION
		// ------------------------------------------------------------------------------------------------------------
		
		//private var communicator:Communicator = null;
		
		// ------------------------------------------------------------------------------------------------------------
		// METHODS
		// ------------------------------------------------------------------------------------------------------------

		public function InGame()
		{
			super();
			
			Statics.isHardwareRendering = Starling.context.driverInfo.toLowerCase().indexOf("software") == -1;
			trace("Hardware rendering: " + Statics.isHardwareRendering);
			Camera.reset();
			//this.referenceElementClasses();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			drawGame();
			drawHUD();
			drawGameOverScreen();
			
			// call JS
//			if(ExternalInterface.available){
//				trace("Calling JS...");
//				ExternalInterface.call("requestFbId");
//			} else {
//				trace("External interface unavailabe");
//			}
		}
		
		/**
		 * Create all game object in this method
		 * This is execuated as soon as the binary is loaded
		 */
		private function drawGame():void
		{
			// set up background
			this.bg = new Background(Constants.Background);
			this.addChild(this.bg);
			this.setChildIndex(this.bg, 0); // push to back
			
			// set up comet bright light
			brightLightImage = new Image(Assets.getSprite("AtlasTexturePlatforms").getTexture("BrightLight0000"));
			brightLightImage.pivotX = Math.ceil(brightLightImage.width / 2); // center image on registration point
			brightLightImage.pivotY = Math.ceil(brightLightImage.height / 2);
			brightLightImage.visible = false;
			this.addChild(brightLightImage);
			
			// set up big coin caption
			bigCoinCaption = new Image(Assets.getSprite("AtlasTexturePlatforms").getTexture("BigCoinCaption0000"));
			bigCoinCaption.pivotX = Math.ceil(bigCoinCaption.texture.width  / 2); // center art on registration point
			bigCoinCaption.pivotY = Math.ceil(bigCoinCaption.texture.height / 2);
			bigCoinCaption.visible = false;
			this.addChild(bigCoinCaption);
			
			// set up hero
			this.hero = new Hero();
			this.hero.gx = Constants.HERO_INITIAL_X;
			this.hero.gy = Constants.HERO_INITIAL_Y;
			this.addChild(hero);
			this.hero.visible = false;
			this.hero.dy = Constants.HeroInitialVelocityY;
			
			// set up foreground
			this.fg = new Background(Constants.Foreground);
			this.addChild(this.fg);
			
			// set up static particles
			if (Statics.isHardwareRendering) {
				// create leaf particle emitter
				Statics.particleLeaf = new PDParticleSystem(XML(new ParticleAssets.ParticleLeafXML()), Texture.fromBitmap(new ParticleAssets.ParticleLeafTexture()));
				Starling.juggler.add(Statics.particleLeaf);
				this.addChild(Statics.particleLeaf);
				
				// create charge particle emitter
				Statics.particleCharge = new PDParticleSystem(XML(new ParticleAssets.ParticleChargeXML()), Texture.fromBitmap(new ParticleAssets.ParticleChargeTexture()));
				Starling.juggler.add(Statics.particleCharge);
				this.addChild(Statics.particleCharge);
				
				// create wind particle emitter
				Statics.particleWind = new PDParticleSystem(XML(new ParticleAssets.ParticleWindXML()), Texture.fromBitmap(new ParticleAssets.ParticleWindTexture()));
				Starling.juggler.add(Statics.particleWind);
				this.addChild(Statics.particleWind);
				Statics.particleWind.emitterX = Constants.StageWidth / 2;
				Statics.particleWind.emitterY = 0;
				
				// create jet particle emitter
				Statics.particleJet = new PDParticleSystem(XML(new ParticleAssets.ParticleJetXML()), Texture.fromBitmap(new ParticleAssets.ParticleJetTexture()));
				Starling.juggler.add(Statics.particleJet);
				this.addChild(Statics.particleJet);
				
				// create comet tail particle emitter
				Statics.particleComet = new PDParticleSystem(XML(new ParticleAssets.ParticleCometXML()), Texture.fromBitmap(new ParticleAssets.ParticleCometTexture()));
				Starling.juggler.add(Statics.particleComet);
				this.addChild(Statics.particleComet);
				
				// create bounce particle emitter
				Statics.particleBounce = new PDParticleSystem(XML(new ParticleAssets.ParticleBounceXML()), Texture.fromBitmap(new ParticleAssets.ParticleBounceTexture()));
				Starling.juggler.add(Statics.particleBounce);
				this.addChild(Statics.particleBounce);
			} else { // software rendering
				
				// use a smaller particleJet
				Statics.particleJet = new PDParticleSystem(XML(new ParticleAssets.ParticleJetXML()), Texture.fromBitmap(new ParticleAssets.ParticleJetTexture()));
				Statics.particleJet.maxNumParticles = 10;
				Starling.juggler.add(Statics.particleJet);
				this.addChild(Statics.particleJet);
				
				// use a smaller particleComet
				Statics.particleComet = new PDParticleSystem(XML(new ParticleAssets.ParticleCometXML()), Texture.fromBitmap(new ParticleAssets.ParticleJCometTexture()));
				Statics.particleComet.maxNumParticles = 10;
				Starling.juggler.add(Statics.particleComet);
				this.addChild(Statics.particleComet);
			}
			
			// pause button.
			pauseButton = new PauseButton();
			pauseButton.x = pauseButton.width * 2;
			pauseButton.y = pauseButton.height * 0.5;
			pauseButton.addEventListener(Event.TRIGGERED, onPauseButtonClick);
			this.addChild(pauseButton);
			
			// start button.
//			startButton = new starling.display.Button(Assets.getAtlas().getTexture("startButton"));
//			startButton.fontColor = 0xffffff;
//			startButton.x = stage.stageWidth/2 - startButton.width/2;
//			startButton.y = stage.stageHeight/2 - startButton.height/2;
//			startButton.addEventListener(Event.TRIGGERED, onStartButtonClick);
//			this.addChild(startButton);
			
			// initialize the platforms vector
			this.platformsList = new Vector.<Platform>();
			this.platformsListLength = 0;
			
			// initialize the contraptions vector
			this.contraptionsList = new Vector.<Contraption>();
			this.contraptionsListLength = 0;
			
			// initialize the powerups vector
			this.powerupsList = new Vector.<GameObject>();
			this.powerupsListLength = 0;
			
			// initialize the particles vector
//			this.particlesList = new Vector.<Particle>();
//			this.particlesListLength = 0;
			
			// set up weather
			this.weather = new Weather();
			weather.alpha = 0.999;
			weather.blendMode = BlendMode.ADD;
			this.addChild(weather);
			
			// create level builder object
			this.levelParser = new LevelParser();
			
			// create contraption control object
			this.contraptionControl = new ContraptionControl();
			
			// transfiguration activation
			transfiguration = new Transfiguration();
			this.addChild(transfiguration);
			
			// set up powers and charms
			// power: teleportation
			var blink:Blink = new Blink(this.hero);
			this.addChild(blink);
			this.powerupsList[this.powerupsListLength++] = blink;
			// power: attraction
			var attractor:Attractor = new Attractor(this.hero);
			this.addChild(attractor);
			this.powerupsList[this.powerupsListLength++] = attractor;
			// power: levitation
			var levitation:Levitation = new Levitation(this.hero);
			this.addChild(levitation);
			this.powerupsList[this.powerupsListLength++] = levitation;
			// power: duplication
			var extender:Extender = new Extender();
			this.powerupsList[this.powerupsListLength++] = extender;
			// power: expansion
			var expansion:Expansion = new Expansion(this.hero, transfiguration);
			this.addChild(expansion);
			this.setChildIndex(expansion, this.getChildIndex(hero));
			this.powerupsList[this.powerupsListLength++] = expansion;
			// power: fireworks
			var pyromancy:Pyromancy = new Pyromancy();
			this.powerupsList[this.powerupsListLength++] = pyromancy;
			// power: comet run (not from box)
			var cometRun:CometRun = new CometRun(this.hero);
//			this.addChild(cometRun);
//			this.setChildIndex(cometRun, this.getChildIndex(this.hero)); // push cometRun behind hero
			this.powerupsList[this.powerupsListLength++] = cometRun;
			
			// create platform pools
			ObjectPool.instance.registerPool(PlatformNormal, 30, false);
			ObjectPool.instance.registerPool(PlatformMobile, 20, false);
			ObjectPool.instance.registerPool(PlatformDrop, 20, false);
			ObjectPool.instance.registerPool(PlatformNormalBoost, 12, false);
			ObjectPool.instance.registerPool(PlatformDropBoost, 12, false);
			ObjectPool.instance.registerPool(PlatformMobileBoost, 80, false);
			ObjectPool.instance.registerPool(PlatformPower, 8, false);
			ObjectPool.instance.registerPool(PlatformSuper, 25, false);
			ObjectPool.instance.registerPool(Coin, 100, false);
			ObjectPool.instance.registerPool(BigCoin, 10, false);
			ObjectPool.instance.registerPool(Star, 150, false);
			ObjectPool.instance.registerPool(StarMini, 50, false);
			ObjectPool.instance.registerPool(StarBlue, 150, false);
			ObjectPool.instance.registerPool(StarRed, 50, false);
			ObjectPool.instance.registerPool(StarDark, 50, false);
			ObjectPool.instance.registerPool(Comet, 30, false);
			ObjectPool.instance.registerPool(Repulsor, 60, false);
			ObjectPool.instance.registerPool(Cannonball, 20, false);
			ObjectPool.instance.registerPool(Train, 2, false);
			ObjectPool.instance.registerPool(TrainFromLeft, 2, false);
			ObjectPool.instance.registerPool(Cannon, 1, false);
			ObjectPool.instance.registerPool(CannonFromLeft, 1, false);
			ObjectPool.instance.registerPool(Hourglass, 3, false);
			ObjectPool.instance.registerPool(Bell, 1, false);
			ObjectPool.instance.registerPool(PowerupBoxPink, 2, false);
			ObjectPool.instance.registerPool(PowerupBoxGreen, 2, false);
			ObjectPool.instance.registerPool(PowerupBoxFire, 2, false);
			ObjectPool.instance.registerPool(PowerupBoxBlue, 2, false);
			ObjectPool.instance.registerPool(PowerupBoxPurple, 2, false);
			ObjectPool.instance.registerPool(Witch, 2, false);
		}
		
		private function drawHUD():void
		{
			hud = new HUD();
			this.addChild(hud);
		}
		
		/**
		 * Draw game over screen. 
		 * 
		 */
		private function drawGameOverScreen():void
		{
			gameOverContainer = new GameOverContainer();
//			gameOverContainer.addEventListener(NavigationEvent.CHANGE_SCREEN, playAgain);
			gameOverContainer.visible = false;
			this.addChild(gameOverContainer);
		}
		
		/**
		 * This method is called as soon as the play button is pressed
		 * Do not create new objects in this methid, only reset game data
		 */
		public function initializeNormalMode():void
		{
			// reset static vars
			Statics.gameMode = Constants.ModeNormal;
			Statics.gamePaused = false;
			Statics.speedFactor = 1;
			Statics.preparationStep = Constants.PrepareStep0;
			Statics.gameTime = 0;
			Statics.bonusTime = 0;
			Statics.nextStarNote = 0;
			Statics.powerupsEnabled = true;
			Statics.specialReady = true;
			Statics.isBellActive = false;
			Statics.isRightCannonActive = false;
			Statics.isLeftCannonActive = false;
			Statics.cameraShake = 0;
			Statics.maxDist = 0;
			Statics.displayingBadge = false;
			Camera.targetModifierY = 0;
			
			// play background music
			if (!Sounds.muted) Sounds.playBgm();
			
			// hide the pause button since the game isn't started yet.
			pauseButton.visible = false;
			
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
		}
		
		public function initializeBonusMode():void
		{
			Statics.speedFactor = 1.545;
			Statics.bonusTime = 300; // test
			
			// reset static vars
			Statics.gameMode = Constants.ModeBonus;
			Statics.preparationStep = Constants.PrepareStep0;
			Statics.gameTime = 0;
			Statics.bonusTimeLeft = Number(Statics.bonusTime * 1000);
			
			// hide the pause button since the game isn't started yet.
			pauseButton.visible = false;
			
			// reset scores
//			hud.bonusTime = 0;
			hud.distance = 0;
			hud.coins = 0;
			
			// start game timer
			this.gameStartTime = getTimer();
			
			// game tick
			this.addEventListener(Event.ENTER_FRAME, onGameTick);
		}
		
		/**
		 * On click of pause button. 
		 * @param event
		 * 
		 */
		private function onPauseButtonClick(event:Event):void
		{
			event.stopImmediatePropagation();
			
			// Pause or unpause the game.
			if (Statics.gamePaused) Statics.gamePaused = false;
			else Statics.gamePaused = true;
		}
		
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
			// Show pause button since the game is started.
			pauseButton.visible = true;
			
			// show hero
			this.hero.visible = true;
			
			// Touch interaction
			//this.addEventListener(TouchEvent.TOUCH, onTouch);
			
			// keyboard interaction
			Starling.current.nativeOverlay.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressedDown);
			Starling.current.nativeOverlay.stage.addEventListener(KeyboardEvent.KEY_UP, keyPressedUp);
			
			if (Statics.gameMode == Constants.ModeNormal) { // normal mode specific
				// start contraptions; must be done after parsing level
//				this.contraptionControl.scheduleNext(Constants.ContraptionHourglass);
//				this.contraptionControl.scheduleNext(Constants.ContraptionTrain);
//				this.contraptionControl.scheduleNext(Constants.ContraptionTrainFromLeft);
//				this.contraptionControl.scheduleNext(Constants.ContraptionBell);
//				this.contraptionControl.scheduleNext(Constants.ContraptionPowerupBoxes);
//				this.contraptionControl.scheduleNext(Constants.ContraptionCannon);
//				this.contraptionControl.scheduleNext(Constants.ContraptionCannonFromLeft);
//				this.contraptionControl.scheduleNext(Constants.ContraptionWitch);
				
				// start scheduling weather effects
				this.weather.scheduleFirst();
			}
			else if (Statics.gameMode == Constants.ModeBonus) { // bonus mode specific
				//SoundMixer.stopAll();
				if (!Sounds.muted) Sounds.playBgmFireAura();
			}
			
			// emit wind particles
			Statics.particleWind.start(1.0);
			
			// restart game timer
			Statics.gameTime = 0;
			this.gameStartTime = getTimer();
			
			//test
//			this.powerupsList[Constants.PowerupExpansion].activate();
		}
		
		/**
		 * Set keydown states to true
		 */
		public function keyPressedDown(event:KeyboardEvent):void {
			if (event.keyCode == 37 || event.keyCode == 65) { // left arrow or 'a'
				leftArrow = true;
			} else if (event.keyCode == 39 || event.keyCode == 68) { // right arrow or 'd'
				rightArrow = true;        
			} else if (event.keyCode == 38) {
				upArrow = true;
			} else if (event.keyCode == 40) {
				downArrow = true;
			} else if (event.keyCode == 32) { // space bar pressed
				if (Statics.gameMode == Constants.ModeBonus) {
					HUD.showMessage("Unavailable in Bonus Mode");
				}
				else if (this.playerControl) {
//					if (this.hero.triggerSpecialAbility()) {
//						Statics.particleLeaf.start(0.2);
//					}
					this.hero.triggerSpecialAbility()
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
			} else if (event.keyCode == 38) {
				upArrow = false;
			} else if (event.keyCode == 40) {
				downArrow = false;
			}
		}
		
		// count down three seconds before launching hero
		// return true if still counting down
		private function launchCountdown(timeCurrent:int):Boolean {
			if (Statics.preparationStep == Constants.PrepareStep0) { // preparation mode
				if (Statics.gameMode == Constants.ModeNormal) HUD.showMessage("Get Ready", 1000);
				else if (Statics.gameMode == Constants.ModeBonus) HUD.showMessage("Drop some beats!", 1000);
				Statics.preparationStep = Constants.PrepareStep1;
			}
			else if (Statics.preparationStep == Constants.PrepareStep1) {
				if (timeCurrent> 850) {
					HUD.showMessage("3", 1000, 1);
					Statics.preparationStep = Constants.PrepareStep2;
				}
			}
			else if (Statics.preparationStep == Constants.PrepareStep2) {
				if (timeCurrent> 1700) {
					HUD.showMessage("2", 1000, 1);
					Statics.preparationStep = Constants.PrepareStep3;
				}
			}
			else if (Statics.preparationStep == Constants.PrepareStep3) {
				if (timeCurrent> 2550) {
					HUD.showMessage("1", 1000, 1);
					Statics.preparationStep = Constants.PrepareStep4;
				}
			}
			else if (Statics.preparationStep == Constants.PrepareStep4) {
				if (timeCurrent> 3400) {
					HUD.showMessage("JUMP!", 1000, 1);
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
		private function onGameTick(event:Event):void
		{
			// handle pausing
			var timeCurrent:int;
			if (Statics.gamePaused) {
				timeCurrent = getTimer() - this.gameStartTime;
				this.timeDiffReal = timeCurrent - Statics.gameTime;
				this.gameStartTime += this.timeDiffReal;
				return;
			}
			
			// update game time
			timeCurrent = getTimer() - this.gameStartTime;
			this.timeDiffReal = timeCurrent - Statics.gameTime;
			Statics.gameTime = timeCurrent;
			this.timeDiffControlled = Number(this.timeDiffReal) * Statics.speedFactor;
			
			// if player fails and end game duration has passed, end the game
			if (!this.checkWinLose && Statics.gameTime > this.endGameTime) {
				this.endGame();
				return;
			}
			
			// normal mode grow difficulty
			this.levelParser.updateDifficulty();
			
			// bonus mode speed up
			if (Statics.gameMode == Constants.ModeBonus && timeCurrent > 40000 && timeCurrent < 40050) {
				HUD.showMessage("Doubling Speed!");
			}
			//if (Statics.gameMode == Constants.ModeBonus && timeCurrent > 42800) {
			if (Statics.gameMode == Constants.ModeBonus && this.jumps >= 64) {
				Statics.speedFactor = 2.62;
			}
			
			/** update timers in other classes */
			// update HUD and spin powerup reel if needed
			HUD.update();
			var powerupToActivate:int = this.hud.updatePowerupReel(this.timeDiffReal);
//			if (this.checkWinLose && Constants.powerupsEnabled) {
			if (Constants.powerupsEnabled) {
				// update powerup reel
				if (powerupToActivate == 0) {
					HUD.showMessage("Ancient Power: Teleportation");
					this.powerupsList[Constants.PowerupBlink].activate();
				}
				else if (powerupToActivate == 1) {
					HUD.showMessage("Ancient Power: Attraction");
					this.powerupsList[Constants.PowerupAttractor].activate();
				}
				else if (powerupToActivate == 2) {
					HUD.showMessage("Ancient Power: Safety Rocket");
					this.powerupsList[Constants.PowerupLevitation].activate();
				}
				else if (powerupToActivate == 3) {
					HUD.showMessage("Ancient Power: Duplication");
					this.powerupsList[Constants.PowerupExtender].activate();
				}
				else if (powerupToActivate == 4) {
					HUD.showMessage("Ancient Power: Barrels O' Fire");
					this.powerupsList[Constants.PowerupPyromancy].activate();
				}
				else if (powerupToActivate == 5) {
					HUD.showMessage("Ancient Curse: Rain of Cannonballs");
					this.powerupsList[Constants.PowerupExpansion].activate();
				}
//				if (powerupToActivate >= 0) {
//					HUD.showMessage("Ancient Power: Duplication");
//					this.powerupsList[Constants.PowerupExtender].activate();
//				}
				
				// update powerups
				var i:uint;
				for (i = 0; i < 4; i++) { // skip power:pyromancy
					if (this.powerupsList[i].isActivated) this.powerupsList[i].update(this.timeDiffControlled);
				}
				
				// update power: expansion
				if (this.powerupsList[Constants.PowerupExpansion].isActivated) {
					if (this.powerupsList[Constants.PowerupExpansion].update(this.timeDiffControlled)) {
						var newCannonballIndex:uint = addElementFromPool(
						Camera.gy + Constants.StageHeight / 2 + 21, 
						Math.random() * Constants.StageWidth * 2 - Constants.StageWidth, "Cannonball");
						this.platformsList[newCannonballIndex].enableWarning();
					}
				}
				
				// update power: fireworks
				if (this.powerupsList[Constants.PowerupPyromancy].isActivated) {
					if (this.powerupsList[Constants.PowerupPyromancy].update(this.timeDiffControlled)) {
						var newPlatformSuperIndex:uint = addElementFromPool(
							this.hero.gy - Constants.StageHeight / 2 - 150, 
							Math.random() * Constants.StageWidth - Constants.StageWidth / 2, "PlatformSuper");
						this.platformsList[newPlatformSuperIndex].isPyromancy = true;
						this.platformsList[newPlatformSuperIndex].dy = 2;
					}
				}
				
				// update power: comet run
				if (this.powerupsList[Constants.PowerupCometRun].isActivated) {
					this.powerupsList[Constants.PowerupCometRun].update(this.timeDiffControlled);
					
					// update bright light
					brightLightImage.visible = true;
					brightLightImage.x = this.hero.x;
					brightLightImage.y = this.hero.y + 20;
				} else {
					brightLightImage.visible = false;
				}
			}
			/** eof update timers */
			
			// camera shake
			this.shakeCamera();
			
			// move camera
			Camera.update(this.hero.gx, this.hero.gy);
			
			// prepare for hero bounce
//			this.hero.prepareBounce();
			
			// scroll all platforms and run all platform and contraption behaviors
			this.scrollElements();
			
			// carry out hero bounce
//			this.hero.doBounce();
			
			if (!launchCountdown(timeCurrent)) { // not in preparation mode
				/** update hero */
				//trace(this.moveMadeThisTurn);
				//trace(Camera.nextPlatformX);
				// handle left and right arrow key input
				if (this.playerControl) {
					if (Statics.gameMode == Constants.ModeBonus) {
						//
						if (leftArrow) {
							this.moveMade = 1;
						}
						else if (rightArrow) {
							this.moveMade = 2;
						}
						//
						
						if (!this.moveMadeThisTurn) {
							//if (Camera.nextPlatformX < this.hero.gx) { // autopilot
							//if (this.moveMade == 1) { // left arrow pressed
							if (leftArrow) {
								this.hero.turnLeft();
								this.hero.dx = -0.18;
								this.moveMadeThisTurn = true;
							}
								//else if (Camera.nextPlatformX > this.hero.gx) { // autopilot
								//else if (this.moveMade == 2) { // right arrow pressed
							else if (rightArrow) {
								this.hero.turnRight();
								this.hero.dx = 0.18;
								this.moveMadeThisTurn = true;
							}
							
						}
						
						//}
					} else { // normal game mode
						if (this.powerupsList[Constants.PowerupExpansion].isActivated) { // expansion power up controls
							// x
							if (leftArrow) { // left arrow pressed
								this.hero.turnLeft();
								if (this.hero.dx > -0.3) this.hero.dx -= Constants.HeroSpeedX * this.timeDiffControlled * 1;
								else this.hero.dx -= Constants.HeroSpeedX * this.timeDiffControlled;
								if (this.hero.dx < -Constants.HeroExpansionMaxSpeedX) {
									this.hero.dx = -Constants.HeroExpansionMaxSpeedX;
								}
							}
							if (rightArrow) { // right arrow pressed
								this.hero.turnRight();
								if (this.hero.dx < 0.3) this.hero.dx += Constants.HeroSpeedX * this.timeDiffControlled * 1;
								else this.hero.dx += Constants.HeroSpeedX * this.timeDiffControlled;
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
//								if (this.hero.dy < -0.5) this.hero.dy = -0.5;
								if (this.hero.dy < 1) this.hero.dy += 0.05;
							}
							
							// propeller art
							this.powerupsList[Constants.PowerupExpansion].updatePropellers(leftArrow, rightArrow);
						} else { // normal gameplay
							if (leftArrow) { // left arrow pressed
								this.hero.turnLeft();
								//if (this.hero.dx > 0) {this.hero.dx = 0;}
								if (this.hero.dx > -0.2) this.hero.dx -= Constants.HeroSpeedX * this.timeDiffControlled * 2;
								else this.hero.dx -= Constants.HeroSpeedX * this.timeDiffControlled;
								if (this.hero.dx < -Constants.HeroMaxSpeedX) {
									this.hero.dx = -Constants.HeroMaxSpeedX;
								}
							}
							else if (rightArrow) { // right arrow pressed
								this.hero.turnRight();
								//if (this.hero.dx < 0) {this.hero.dx = 0;}
								if (this.hero.dx < 0.2) this.hero.dx += Constants.HeroSpeedX * this.timeDiffControlled * 2;
								else this.hero.dx += Constants.HeroSpeedX * this.timeDiffControlled;
								if (this.hero.dx > Constants.HeroMaxSpeedX) {
									this.hero.dx = Constants.HeroMaxSpeedX;
								}
							}
							else { // no arrow pressed, reset velocity
								if (this.hero.dx < 0) {
									if (Math.abs(this.hero.dx) < Constants.HeroSpeedX * this.timeDiffControlled * 0.5) {
										this.hero.dx = 0;
									} else {
										this.hero.dx += Constants.HeroSpeedX * this.timeDiffControlled * 0.5;
									}
								} else if (this.hero.dx > 0) {
									if (Math.abs(this.hero.dx) < Constants.HeroSpeedX * this.timeDiffControlled * 0.5) {
										this.hero.dx = 0;
									} else {
										this.hero.dx -= Constants.HeroSpeedX * this.timeDiffControlled * 0.5;
									}
								}
							}
						} // eof normal gameplay
					} // eof normal game mode
				} /** eof player control */
				
				// update hero position, velocity, rotation
				this.hero.update(this.timeDiffControlled);
				
				// update max climb distance
				if (this.hero.gy > Statics.maxDist) {
					Statics.maxDist = this.hero.gy;
				}
				/** eof update hero */
				
				// check contraptions scheduling
				if (Statics.gameMode == Constants.ModeNormal && Constants.contraptionsEnabled) {
					var contraptionStatus:Array = this.contraptionControl.checkSchedules();
					if (contraptionStatus[Constants.ContraptionHourglass]) this.summonHourglass();
					if (contraptionStatus[Constants.ContraptionTrain]) this.launchTrain();
					if (contraptionStatus[Constants.ContraptionTrainFromLeft]) this.launchTrainFromLeft();
					if (contraptionStatus[Constants.ContraptionBell] && !Statics.isBellActive) this.dropBell();
					if (contraptionStatus[Constants.ContraptionPowerupBoxes]) this.summonPowerupBoxes();
					if (contraptionStatus[Constants.ContraptionCannon] && !Statics.isRightCannonActive) this.summonCannon();
					if (contraptionStatus[Constants.ContraptionCannonFromLeft] && !Statics.isLeftCannonActive) this.summonCannonFromLeft();
					if (contraptionStatus[Constants.ContraptionWitch]) this.summonWitch();
				}
				
				// check weather scheduling
				this.weather.checkSchedules();
				
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
				if (Statics.isHardwareRendering)
				{
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
//					Background.particleSeaOfFire.emitterX = Constants.StageWidth / 2;
//					Background.particleSeaOfFire.emitterY = this.fg.sofQuad.y - 100;
				}
				
				// misc win/loss conditions
				if (this.checkWinLose) {
					// left and right border warning
//					if (this.hero.gx < -Constants.StageWidth / 2 - 100 || 
//						this.hero.gx > Constants.StageWidth / 2 + 100) {
//						HUD.showMessage("Warning: Leaving Survivable Area");
//					}
				} else {
					// mark hero as bounced out of sea of fire
					if (this.hero.gy > this.fg.sofHeight - 60) {
						this.heroHasBouncedOffSof = true;
					}
				}
				
				// we lose if we drop below sea of fire or move out of bounds
				if (Constants.SofEnabled) {
					//if (this.hero.gy < this.fg.sofHeight - 60 || this.hero.gx < -Constants.StageWidth || this.hero.gx > Constants.StageWidth) {
					if (this.hero.gy < this.fg.sofHeight - 60) { // disable out of bounds for now because it's less fun
						if (this.checkWinLose) {
							HUD.showMessage("Uh Oh...");
							this.playerFail();
							return;
						}
						else if (this.heroHasBouncedOffSof) {
							this.hero.gy = this.fg.sofHeight - 60; // hide hero just below sof
							Camera.targetModifierY = 250; // move camera target so we only see the top of sof
						}
					}
				} else {
					if (this.checkWinLose && hero.gy < Camera.gy - Constants.StageHeight / 2) {
						HUD.showMessage("Uh Oh...");
						this.playerFail();
						return;
					}
				}
				
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
				if (!Statics.achievementsList[1] && Statics.maxDist > 10000) {
					HUD.showAchievement(Constants.AchievementsData[1][1]);
					Statics.achievementsList[1] = true;
					this.gameOverContainer.addNewAchievement(1);
				}
				if (!Statics.achievementsList[2] && Statics.maxDist > 50000) {
					HUD.showAchievement(Constants.AchievementsData[2][1]);
					Statics.achievementsList[2] = true;
					this.gameOverContainer.addNewAchievement(2);
				}
				if (!Statics.achievementsList[3] && Statics.maxDist > 100000) {
					HUD.showAchievement(Constants.AchievementsData[3][1]);
					Statics.achievementsList[3] = true;
					this.gameOverContainer.addNewAchievement(3);
				}
				if (!Statics.achievementsList[4] && Statics.maxDist > 200000) {
					HUD.showAchievement(Constants.AchievementsData[4][1]);
					Statics.achievementsList[4] = true;
					this.gameOverContainer.addNewAchievement(4);
				}
				if (!Statics.achievementsList[5] && Statics.maxDist > 300000) {
					HUD.showAchievement(Constants.AchievementsData[5][1]);
					Statics.achievementsList[5] = true;
					this.gameOverContainer.addNewAchievement(5);
				}
				if (!Statics.achievementsList[6] && Statics.maxDist > 400000) {
					HUD.showAchievement(Constants.AchievementsData[6][1]);
					Statics.achievementsList[6] = true;
					this.gameOverContainer.addNewAchievement(6);
				}
				if (!Statics.achievementsList[7] && Statics.maxDist > 500000) {
					HUD.showAchievement(Constants.AchievementsData[7][1]);
					Statics.achievementsList[7] = true;
					this.gameOverContainer.addNewAchievement(7);
				}
				if (!Statics.achievementsList[8] && Statics.maxDist > 600000) {
					HUD.showAchievement(Constants.AchievementsData[8][1]);
					Statics.achievementsList[8] = true;
					this.gameOverContainer.addNewAchievement(8);
				}
				if (!Statics.achievementsList[9] && Statics.maxDist > 800000) {
					HUD.showAchievement(Constants.AchievementsData[9][1]);
					Statics.achievementsList[9] = true;
					this.gameOverContainer.addNewAchievement(9);
				}
				if (!Statics.achievementsList[10] && Statics.maxDist > 1000000) {
					HUD.showAchievement(Constants.AchievementsData[10][1]);
					Statics.achievementsList[10] = true;
					this.gameOverContainer.addNewAchievement(10);
				}
				// eof climb distance achievements
				
				// coin collection achievements
				if (!Statics.achievementsList[11] && this.coinsObtained > 250) {
					HUD.showAchievement(Constants.AchievementsData[11][1]);
					Statics.achievementsList[11] = true;
					this.gameOverContainer.addNewAchievement(11);
				}
				if (!Statics.achievementsList[12] && this.coinsObtained > 500) {
					HUD.showAchievement(Constants.AchievementsData[12][1]);
					Statics.achievementsList[12] = true;
					this.gameOverContainer.addNewAchievement(12);
				}
				if (!Statics.achievementsList[13] && this.coinsObtained > 1000) {
					HUD.showAchievement(Constants.AchievementsData[13][1]);
					Statics.achievementsList[13] = true;
					this.gameOverContainer.addNewAchievement(13);
				}
				if (!Statics.achievementsList[14] && this.coinsObtained > 2000) {
					HUD.showAchievement(Constants.AchievementsData[14][1]);
					Statics.achievementsList[14] = true;
					this.gameOverContainer.addNewAchievement(14);
				}
				if (!Statics.achievementsList[15] && this.coinsObtained > 3000) {
					HUD.showAchievement(Constants.AchievementsData[15][1]);
					Statics.achievementsList[15] = true;
					this.gameOverContainer.addNewAchievement(15);
				}
				if (!Statics.achievementsList[16] && this.coinsObtained > 4000) {
					HUD.showAchievement(Constants.AchievementsData[16][1]);
					Statics.achievementsList[16] = true;
					this.gameOverContainer.addNewAchievement(16);
				}
				if (!Statics.achievementsList[17] && this.coinsObtained > 5000) {
					HUD.showAchievement(Constants.AchievementsData[17][1]);
					Statics.achievementsList[17] = true;
					this.gameOverContainer.addNewAchievement(17);
				}
				if (!Statics.achievementsList[18] && this.coinsObtained > 6500) {
					HUD.showAchievement(Constants.AchievementsData[18][1]);
					Statics.achievementsList[18] = true;
					this.gameOverContainer.addNewAchievement(18);
				}
				if (!Statics.achievementsList[19] && this.coinsObtained > 8000) {
					HUD.showAchievement(Constants.AchievementsData[19][1]);
					Statics.achievementsList[19] = true;
					this.gameOverContainer.addNewAchievement(19);
				}
				if (!Statics.achievementsList[20] && this.coinsObtained > 10000) {
					HUD.showAchievement(Constants.AchievementsData[20][1]);
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
			
			// stop sounds
			//SoundMixer.stopAll();
			Sounds.stopBgm();
			if (!Sounds.muted) Sounds.sndScratch.play();
			
			Starling.juggler.delayCall(playerFailPartTwo, 1);
		}
		
		private function playerFailPartTwo():void {
			Statics.gamePaused = false;
			
			this.hero.failBounce();
			
			// end game after short duration
			this.endGameTime = Statics.gameTime + 3000;
			
			// stop checking win/lose condition
			this.checkWinLose = false;
			
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
			// clean up platforms
			for(; this.platformsListLength > 0;) this.returnPlatformToPool(0);
			
			// clean up contraption
			for(; this.contraptionsListLength > 0;) this.returnContraptionToPool(0);
			
			// remove event listeners
			Starling.current.nativeOverlay.stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyPressedDown);
			Starling.current.nativeOverlay.stage.removeEventListener(KeyboardEvent.KEY_UP, keyPressedUp);
			this.removeEventListener(Event.ENTER_FRAME, onGameTick);
			
			// clean up hero
			this.removeChild(this.hero);
			this.hero = null;
			
			// show game over screen
			this.setChildIndex(gameOverContainer, this.numChildren - 1);
			gameOverContainer.initialize(this.coinsObtained, int(Statics.maxDist / 100));
		}
		
		/**
		 * Scroll all of the rainbows downward
		 */
		public function scrollElements():void {
			var i:uint; // array index
			
			/** platform behaviors */
			// for aiming camera at next platform
			var smallestPlatformY:Number = this.hero.gy + Constants.StageHeight; // set it to a high value first
			var smallestPlatformIndex:int = -1;
			var isCoin:Boolean;
			var isStar:Boolean;
			var isSuper:Boolean;
			var isComet:Boolean;
			var isRepulsor:Boolean;
			var isCannonball:Boolean;
			
			for (i = 0; i < this.platformsListLength; i++) { // loop through platforms
				isCoin = false;
				isStar = false;
				isSuper = false;
				isComet = false;
				isRepulsor = false;
				isCannonball = false;
				
				var platformBounds:Rectangle = this.platformsList[i].bounds;
				if (this.platformsList[i] is Coin) {
					if (this.platformsList[i].isAcquired) { // make acquired coins fly out
						this.platformsList[i].dy = this.platformsList[i].yVelocity + Camera.dy / this.timeDiffControlled;
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
					if (!this.powerupsList[Constants.PowerupCometRun].isActivated) {
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
				} else if (this.platformsList[i] is Cannonball) {
					isCannonball = true;
					platformBounds.inflate(20, 20);
				}
				
				// detect hero/platform collisions if player has not yet lost
				if (this.checkWinLose && this.hero.canBounce) {
					var inCollision:Boolean = false;
					if (platformBounds.contains(this.hero.x - 10, this.hero.y + 20) ||
						platformBounds.contains(this.hero.x + 10, this.hero.y + 20)) {
						inCollision = true;
					}
					
					if (inCollision) { // platform collision!
						if (this.platformsList[i].touch()) { // ensures stuff inside this block only runs once per contact
							if (isCoin) {
								if (this.platformsList[i] is BigCoin) {
									this.coinsObtained += 100;
									// show caption
									bigCoinCaption.x = this.platformsList[i].x;
									bigCoinCaption.y = this.platformsList[i].y;
									bigCoinCaption.visible = true;
									Starling.juggler.tween(bigCoinCaption, 1, {
										transition: Transitions.EASE_OUT,
										scaleX: 2.0,
										scaleY: 2.0,
										alpha: 0,
										onComplete: hideBigCoinCaption
									});
								} else this.coinsObtained++;
								
								// activate coin fly out effect
								this.platformsList[i].isAcquired = true;
								var flightTime:Number = 500;
								this.platformsList[i].dx = (Constants.CoinTargetX - this.platformsList[i].gx) / flightTime;
								this.platformsList[i].yVelocity = (this.platformsList[i].y + 50) / flightTime;
								
								continue;
							}
							else if (isComet) {
								this.powerupsList[Constants.PowerupCometRun].activate();
								this.jumps++;
								this.returnPlatformToPool(i);
								continue;
							}
							else if (isStar) {
								if (!this.hero.isTransfigured) {
									if (this.platformsList[i] is StarRed) Statics.particleJet.start(0.5);
									this.hero.bounce(this.platformsList[i].getBouncePower());
									Statics.particleLeaf.start(0.2); // play particle effect
									Statics.particleBounce.emitterX = this.platformsList[i].x;
									Statics.particleBounce.emitterY = this.platformsList[i].y;
									Statics.particleBounce.start(0.01);
									this.jumps++; // record number of jumps
									this.returnPlatformToPool(i);
									continue;
								}
							}
							else if (isSuper) {
								this.hero.bounce(this.hero.dy + this.platformsList[i].getBouncePower());
								this.platformsList[i].contact();
								Statics.particleLeaf.start(0.2); // play particle effect
								Statics.particleJet.start(0.5);
								this.jumps++; // record number of jumps
								this.returnPlatformToPool(i);
								continue;
							}
							else if (isRepulsor) {
								this.hero.repulse(this.platformsList[i].gx, this.platformsList[i].gy);
								this.platformsList[i].contact();
							}
							else if (isCannonball) {
								Statics.particleLeaf.start(0.2); // play particle effect
								this.hero.repulseCannonball(this.platformsList[i].isVertical, this.platformsList[i].dx > 0);
								this.returnPlatformToPool(i);
								continue;
							}
							else if (this.hero.dy < 0) { // all other platforms: only if hero is falling
								if (this.platformsList[i].canBounce) {
									this.hero.bounce(this.platformsList[i].getBouncePower());
									this.platformsList[i].contact();
									// particle effects
									Statics.particleLeaf.start(0.2); // play particle effect
									Statics.particleBounce.emitterX = this.platformsList[i].x;
									Statics.particleBounce.emitterY = this.platformsList[i].y;
									Statics.particleBounce.start(0.01);
									
									this.jumps++; // record number of jumps
								}
							}
						}
					} else { // not in collision
						if (!isStar) this.platformsList[i].isTouched = false; // when not colliding anymore, reset touch status
					}
				} // eof platform collision detection
				
				// bof power: attraction
				if (this.powerupsList[Constants.PowerupAttractor].isActivated) {
//					if ((this.platformsList[i].gy < this.hero.gy + Constants.StageHeight / 2)
//						&& (this.platformsList[i].gy > this.hero.gy - 100)) { // platform moved into screen
					if (Statics.distance(this.hero.gx, this.hero.gy, this.platformsList[i].gx, this.platformsList[i].gy) < 300
						&& this.platformsList[i].gy > this.hero.gy - 140) {
						var easingFactor:Number;
						if ((isCoin && !this.platformsList[i].isAcquired) || isStar) { // coins and stars come fast
							easingFactor = (200 - Math.abs(this.hero.gy - this.platformsList[i].gy) / 10);
							if (easingFactor < 5) easingFactor = 5;
						} else {
							easingFactor = (620 - Math.abs(this.hero.gy - this.platformsList[i].gy) / 10);
							if (easingFactor < 5) easingFactor = 5;
						}
						
						// x
						var d2x:Number = 0.0; // acceleration
						if (this.hero.gx >= this.platformsList[i].gx) {
							d2x = ((this.hero.gx - this.platformsList[i].gx) - this.platformsList[i].dx * easingFactor) / (0.5 * easingFactor * easingFactor);
						}
						else if (this.hero.gx <= this.platformsList[i].gx) { // move platform down
							d2x = ((this.hero.gx - this.platformsList[i].gx) - this.platformsList[i].dx * easingFactor) / (0.5 * easingFactor * easingFactor);
						}
						else { // bring camera to rest
							d2x = -this.platformsList[i].dx / easingFactor;
						}
						//d2y *= this.timeDiffControlled * 0.001;
						this.platformsList[i].dx += d2x * this.timeDiffControlled;
						
						if ((isCoin && !this.platformsList[i].isAcquired) || isStar) {
							// y
							var d2y:Number = 0.0; // acceleration
							if (this.hero.gy >= this.platformsList[i].gy) { // move platform up
								d2y = ((this.hero.gy - this.platformsList[i].gy) - this.platformsList[i].dy * easingFactor) / (0.5 * easingFactor * easingFactor);
							}
							else if (this.hero.gy <= this.platformsList[i].gy) { // move platform down
								d2y = ((this.hero.gy - this.platformsList[i].gy) - this.platformsList[i].dy * easingFactor) / (0.5 * easingFactor * easingFactor);
							}
							else { // bring camera to rest
								d2y = -this.platformsList[i].dy / easingFactor;
							}
							//d2y *= this.timeDiffControlled * 0.001;
							this.platformsList[i].dy += d2y * this.timeDiffControlled;
						}
					}
				} // eof power:attraction
				
				// extender power
				if (this.powerupsList[Constants.PowerupExtender].isActivated) {
					// update mobile platform position
					if (this.platformsList[i] is PlatformMobile) {
						if (this.platformsList[i].extenderStatus == -1) { // on left side of parent
							this.platformsList[i].gx = this.platformsList[i].extenderParent.gx - this.platformsList[i].extenderParent.width;
						}
						else if (this.platformsList[i].extenderStatus == 1) { // on right side of parent
							this.platformsList[i].gx = this.platformsList[i].extenderParent.gx + this.platformsList[i].extenderParent.width;
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
					if (platformsList[i].y < Constants.StageHeight) { // dousing animation and sound if visible
						//					Statics.particleBounce.emitterX = this.platformsList[i].x;
						//					Statics.particleBounce.emitterY = this.platformsList[i].y;
						//					Statics.particleBounce.start(0.4);
						Sounds.sndDouseFire.play();
					}
					
					this.returnPlatformToPool(i);
					continue;
				}
				// remove a platform if it has flew too high (pyromancy platform supers)
				if (this.platformsList[i].gy > this.hero.gy + Constants.StageHeight * 1.5) {
					this.returnPlatformToPool(i);
					continue;
				}
			} // eof loop through platforms
			
			// update next platform position
			if (smallestPlatformIndex != -1) {
				Statics.nextPlatformX = this.platformsList[smallestPlatformIndex].gx;
				Statics.nextPlatformY = this.platformsList[smallestPlatformIndex].gy;
			}
			/** eof platform behaviors */
			
			/** contraption behaviors */
			var numCoinsToDrop:int;
			var ci:uint;
			var newCoinIndex:uint;
			for (i = 0; i < this.contraptionsListLength; i++) {
				var contraptionBounds:Rectangle = this.contraptionsList[i].bounds;
				
				if (Object(this.contraptionsList[i]).constructor == Hourglass) { /** hourglass behaviors */
					if (this.checkWinLose) { // check hero/hourglass collision if not yet lost
						if (contraptionBounds.contains(this.hero.x - 10, this.hero.y + 20) ||
							contraptionBounds.contains(this.hero.x + 10, this.hero.y + 20) ||
							contraptionBounds.contains(this.hero.x - 10, this.hero.y - 20) ||
							contraptionBounds.contains(this.hero.x + 10, this.hero.y - 20)) {
							this.contraptionsList[i].contact();
						}
					}
				} /** eof hourglass behaviors */
				
				else if (Object(this.contraptionsList[i]).constructor == Train) { /** train behaviors */
					if (this.checkWinLose && this.hero.canBounce && this.contraptionsList[i].isLaunched) { // check hero/train collision if not yet lost
						contraptionBounds.left += 120;
						contraptionBounds.inflate(-50, -50); // shrink train bounds
						if (contraptionBounds.contains(this.hero.x - 10, this.hero.y + 20) ||
							contraptionBounds.contains(this.hero.x + 10, this.hero.y + 20) ||
							contraptionBounds.contains(this.hero.x - 10, this.hero.y - 20) ||
							contraptionBounds.contains(this.hero.x + 10, this.hero.y - 20)) {
							if (this.hero.gx < this.contraptionsList[i].gx + 100) { // hit by a train
								this.playerControl = false;
								this.hero.dx = Constants.TrainVelocity * 2;
								if (!Sounds.muted) {
//									Sounds.sndVoiceAh.play();
									Sounds.sndTrainHit.play();
								}
								
								Statics.cameraShake = 40;
							}
							else {
								if (this.hero.gy > this.contraptionsList[i].gy) { // roof bounce
									this.hero.bounceAndFade(Constants.DirectionUp, Constants.BoostBouncePower);
								}
								else { // bottom bounce
									this.hero.bounceAndFade(Constants.DirectionDown, Constants.NormalBouncePower);
								}
								Statics.particleLeaf.start(0.2); // play particle effect
								numCoinsToDrop = int(Math.ceil(Math.random() * 20));
								for (ci = 0; ci < numCoinsToDrop; ci++) {
									newCoinIndex = addElementFromPool(this.hero.gy, this.hero.gx, "Coin");
									this.platformsList[newCoinIndex].makeKinematic(Constants.PowerBouncePower);
								}
							}
						}
					}
				} /** eof train behaviors */
				
				else if (Object(this.contraptionsList[i]).constructor == TrainFromLeft) { /** train from left behaviors */
					if (this.checkWinLose && this.hero.canBounce && this.contraptionsList[i].isLaunched) { // check hero/train collision if not yet lost
						contraptionBounds.right -= 120;
						contraptionBounds.inflate(-50, -50); // shrink train bounds
						if (contraptionBounds.contains(this.hero.x - 10, this.hero.y + 20) ||
							contraptionBounds.contains(this.hero.x + 10, this.hero.y + 20) ||
							contraptionBounds.contains(this.hero.x - 10, this.hero.y - 20) ||
							contraptionBounds.contains(this.hero.x + 10, this.hero.y - 20)) {
							if (this.hero.gx > this.contraptionsList[i].gx - 100) { // hit by a train
								this.playerControl = false;
								this.hero.dx = -Constants.TrainVelocity * 2;
								if (!Sounds.muted) {
//									Sounds.sndVoiceAh.play();
									Sounds.sndTrainHit.play();
								}
								
								Statics.cameraShake = 40;
							}
							else {
								if (this.hero.gy > this.contraptionsList[i].gy) { // roof bounce
									this.hero.bounceAndFade(Constants.DirectionUp, Constants.BoostBouncePower);
								}
								else { // bottom bounce
									this.hero.bounceAndFade(Constants.DirectionDown, Constants.NormalBouncePower);
								}
								Statics.particleLeaf.start(0.2); // play particle effect
								numCoinsToDrop = int(Math.ceil(Math.random() * 20));
								for (ci = 0; ci < numCoinsToDrop; ci++) {
									newCoinIndex = addElementFromPool(this.hero.gy, this.hero.gx, "Coin");
									this.platformsList[newCoinIndex].makeKinematic(Constants.PowerBouncePower);
								}
							}
						}
					}
				} /** eof train from left behaviors */
				
				else if (Object(this.contraptionsList[i]).constructor == Bell) { /** bell behaviors */
					if (this.checkWinLose) { // check hero/bell collision if not yet lost
//						contraptionBounds.inflate(-100, -100); // shrink bell bounds
//						if (contraptionBounds.contains(this.hero.x - 10, this.hero.y + 20) ||
//							contraptionBounds.contains(this.hero.x + 10, this.hero.y + 20) ||
//							contraptionBounds.contains(this.hero.x - 10, this.hero.y - 20) ||
//							contraptionBounds.contains(this.hero.x + 10, this.hero.y - 20)) {
//							this.contraptionsList[i].contact(this.hero.gx - this.contraptionsList[i].gx, this.hero.dy);
//						}
						// use distance based approach
						var distance:Number = Statics.distance(this.contraptionsList[i].gx, this.contraptionsList[i].gy, this.hero.gx, this.hero.gy);
						if (distance < this.contraptionsList[i].height / 2 + this.hero.width / 2 - 150) { // bell collision
							if (this.contraptionsList[i].contact(this.hero.gx - this.contraptionsList[i].gx, this.hero.dy)) { // hero made true contact with bell
								// drop coins
								numCoinsToDrop = int(Math.ceil(Math.random() * 20));
								for (ci = 0; ci < numCoinsToDrop; ci++) {
									newCoinIndex = addElementFromPool(this.contraptionsList[i].gy, this.contraptionsList[i].gx, "Coin");
									this.platformsList[newCoinIndex].makeKinematic(Constants.NormalBouncePower);
								}
								
								if (this.contraptionsList[i].numDings >= 3) { // three dings
									// drop stars
									numCoinsToDrop = int(Math.ceil(Math.random() * 5));
									for (ci = 0; ci < numCoinsToDrop; ci++) {
										newCoinIndex = addElementFromPool(this.contraptionsList[i].gy, this.contraptionsList[i].gx, "Star");
										this.platformsList[newCoinIndex].makeKinematic(Constants.NormalBouncePower);
									}
									
									// drop blue stars
									numCoinsToDrop = int(Math.ceil(Math.random() * 3));
									for (ci = 0; ci < numCoinsToDrop; ci++) {
										newCoinIndex = addElementFromPool(this.contraptionsList[i].gy, this.contraptionsList[i].gx, "StarBlue");
										this.platformsList[newCoinIndex].makeKinematic(Constants.NormalBouncePower);
									}
								}
								
								if (this.contraptionsList[i].numDings >= 6) { // six dings
									// drop red stars
									numCoinsToDrop = int(Math.ceil(Math.random() * 2));
									for (ci = 0; ci < numCoinsToDrop; ci++) {
										newCoinIndex = addElementFromPool(this.contraptionsList[i].gy, this.contraptionsList[i].gx, "StarRed");
										this.platformsList[newCoinIndex].makeKinematic(Constants.NormalBouncePower);
									}
									
									// drop comets
									numCoinsToDrop = int(Math.ceil(Math.random() * 1));
									for (ci = 0; ci < numCoinsToDrop; ci++) {
										newCoinIndex = addElementFromPool(this.contraptionsList[i].gy, this.contraptionsList[i].gx, "Comet");
										this.platformsList[newCoinIndex].makeKinematic(Constants.NormalBouncePower);
									}
								}
							} // eof true bell contact
						} // eof bell collision
					} // eof checkWinLose
				} /** eof bell behaviors */
				
				else if (this.contraptionsList[i] is PowerupBox) { /** powerup boxes behaviors */
					if (this.checkWinLose) { // check hero/hourglass collision if not yet lost
						if (contraptionBounds.contains(this.hero.x - 10, this.hero.y + 20) ||
							contraptionBounds.contains(this.hero.x + 10, this.hero.y + 20) ||
							contraptionBounds.contains(this.hero.x - 10, this.hero.y - 20) ||
							contraptionBounds.contains(this.hero.x + 10, this.hero.y - 20)) {
							this.contraptionsList[i].contact(this.hud);
						}
					}
				} /** eof powerup boxes behaviors */
				
				else if (Object(this.contraptionsList[i]).constructor == Cannon) { /** cannon behaviors */
					this.contraptionsList[i].heroGy = this.hero.gy;
					this.contraptionsList[i].sofHeight = this.fg.sofHeight;
					if (this.contraptionsList[i].checkFiring() == 1) {
//						if (Math.random() > 0.5) {
							newCoinIndex = addElementFromPool(this.contraptionsList[i].gy, this.contraptionsList[i].gx, "Cannonball");
							this.platformsList[newCoinIndex].makeKinematicWithDx(-Math.random() * 1 - 0.5);
//						} else {
//							newCoinIndex = addElementFromPool(this.contraptionsList[i].gy, this.contraptionsList[i].gx, "Star");
//							this.platformsList[newCoinIndex].makeKinematicWithDx(-Math.random() * 1 - 0.5);
//						}
//						Sounds.sndCannonFire.play(); // play cannon firing sound
					}
					if (this.checkWinLose) { // check hero/cannon collision if not yet lost
						if (contraptionBounds.contains(this.hero.x - 10, this.hero.y + 20) ||
							contraptionBounds.contains(this.hero.x + 10, this.hero.y + 20) ||
							contraptionBounds.contains(this.hero.x - 10, this.hero.y - 20) ||
							contraptionBounds.contains(this.hero.x + 10, this.hero.y - 20)) {
							if (this.hero.gy > this.contraptionsList[i].gy && this.hero.dy < 0) { // top bounce
								this.contraptionsList[i].contact();
								this.hero.bounce(Constants.BoostBouncePower);
								Statics.particleLeaf.start(0.2); // play particle effect
								Statics.particleBounce.emitterX = this.contraptionsList[i].x;
								Statics.particleBounce.emitterY = this.contraptionsList[i].y;
								Statics.particleBounce.start(0.01);
							}
							Statics.particleLeaf.start(0.2); // play particle effect
						}
					}
				} /** eof cannon behaviors */
				
				else if (Object(this.contraptionsList[i]).constructor == CannonFromLeft) { /** cannon from left behaviors */
					this.contraptionsList[i].heroGy = this.hero.gy;
					this.contraptionsList[i].sofHeight = this.fg.sofHeight;
					if (this.contraptionsList[i].checkFiring() == 1) {
//						if (Math.random() > 0.5) {
							newCoinIndex = addElementFromPool(this.contraptionsList[i].gy, this.contraptionsList[i].gx, "Cannonball");
							this.platformsList[newCoinIndex].makeKinematicWithDx(Math.random() * 1 + 0.5);
//						} else {
//							newCoinIndex = addElementFromPool(this.contraptionsList[i].gy, this.contraptionsList[i].gx, "Star");
//							this.platformsList[newCoinIndex].makeKinematicWithDx(Math.random() * 1 + 0.5);
//						}
//						Sounds.sndCannonFire.play(); // play cannon firing sound
					}
					if (this.checkWinLose) { // check hero/cannon collision if not yet lost
						if (contraptionBounds.contains(this.hero.x - 10, this.hero.y + 20) ||
							contraptionBounds.contains(this.hero.x + 10, this.hero.y + 20) ||
							contraptionBounds.contains(this.hero.x - 10, this.hero.y - 20) ||
							contraptionBounds.contains(this.hero.x + 10, this.hero.y - 20)) {
							if (this.hero.gy > this.contraptionsList[i].gy && this.hero.dy < 0) { // top bounce
								this.contraptionsList[i].contact();
								this.hero.bounce(Constants.BoostBouncePower);
								Statics.particleLeaf.start(0.2); // play particle effect
								Statics.particleBounce.emitterX = this.contraptionsList[i].x;
								Statics.particleBounce.emitterY = this.contraptionsList[i].y;
								Statics.particleBounce.start(0.01);
							}
							Statics.particleLeaf.start(0.2); // play particle effect
						}
					}
				} /** eof cannon from left behaviors */
				
				else if (this.contraptionsList[i] is Witch) { /** witch behaviors */
					if (this.contraptionsList[i].gx > -Constants.StageWidth / 2 && this.contraptionsList[i].checkFiring() == 1) {
						newCoinIndex = addElementFromPool(this.contraptionsList[i].gy, this.contraptionsList[i].gx, "Star");
						this.platformsList[newCoinIndex].makeKinematicWithDx(-0.2);
					}
				} /** eof witch behaviors */
				
				// update contraptions
				this.contraptionsList[i].update(this.timeDiffControlled);
//				if(Object(this.contraptionsList[i]).constructor == Bell) this.contraptionsList[i].debug(this.hero.gy);
				
				// remove a contraption if it has scrolled below sea of fire
				if (this.contraptionsList[i].gy < this.fg.sofHeight - this.contraptionsList[i].height) {
					// canon crash sound effect
					if (this.contraptionsList[i] is Cannon) {
						Sounds.sndDistantExplosion.play();
					}
					
					this.returnContraptionToPool(i);
				}
			} /** eof contraption behaviors */
			
			// scroll background and foreground layers
			this.bg.scroll(this.timeDiffReal);
			this.fg.scroll(this.timeDiffReal);
			
			/** Stage Element Population */
			// populate area above visible stage with next elements in level elements array
			while (this.levelParser.levelElementsArray.length > 0 && this.levelParser.levelElementsArray[0][0] <= this.hero.gy + Constants.ElementPreloadWindow) {
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
						this.contraptionControl.setIntervalAndScheduleNext(Constants.ContraptionPowerupBoxes, levelElement[2]);
					}
					else if (levelElement[1] == Constants.ContraptionSettingCannon) {// check for cannon settings
						this.contraptionControl.setIntervalAndScheduleNext(Constants.ContraptionCannon, levelElement[2]);
						this.contraptionControl.setIntervalAndScheduleNext(Constants.ContraptionCannonFromLeft, levelElement[2]);
					}
					else if (levelElement[1] == Constants.ContraptionSettingWitch) { // check for witch settings
						this.contraptionControl.setIntervalAndScheduleNext(Constants.ContraptionWitch, levelElement[2]);
					}
				}
//				else if (levelElement[2] == Constants.Coin && Statics.gameMode == Constants.ModeBonus) {
//					// do not add coins if in bonus mode
//				}
				else { // add platform element
					var newElementIndex:uint = this.addElementFromPool(levelElement[0], levelElement[1], levelElement[2], levelElement[3], levelElement[4], levelElement[5], levelElement[6], levelElement[7], levelElement[8], levelElement[9]);	
					// duplication power, add extended platforms
					if (this.powerupsList[Constants.PowerupExtender].isActivated && levelElement[2] != "Coin"  && levelElement[2] != "BigCoin") {
						var newPlatformExtenderIndex:uint;
						newPlatformExtenderIndex = addElementFromPool(
							levelElement[0],
							-Constants.StageWidth / 2 - this.platformsList[newElementIndex].width,
							levelElement[2], levelElement[3], levelElement[4], levelElement[5], levelElement[6], levelElement[7], levelElement[8]);
						this.platformsList[newPlatformExtenderIndex].makeExtender(this.platformsList[newElementIndex],
							-1, levelElement[1] - this.platformsList[newElementIndex].width);
						
						newPlatformExtenderIndex = addElementFromPool(
							levelElement[0],
							Constants.StageWidth / 2 + this.platformsList[newElementIndex].width,
							levelElement[2], levelElement[3], levelElement[4], levelElement[5], levelElement[6], levelElement[7], levelElement[8]);
						this.platformsList[newPlatformExtenderIndex].makeExtender(this.platformsList[newElementIndex],
							1, levelElement[1] + this.platformsList[newElementIndex].width);
					}
				}
				this.levelParser.levelElementsArray.splice(0, 1); // remove this entry from level elements array
			}
			// request new block
			if (this.levelParser.levelElementsArray.length == 0) this.levelParser.requestBlock();
		} /** eof scrollElements() */
		
		private function summonHourglass():void {
			if (Statics.gameMode == Constants.ModeNormal) { // only summon hourglass in normal mode
				var gx:Number = Math.random() * (Constants.StageWidth - Constants.ScreenBorder) 
					- (Constants.StageWidth - Constants.ScreenBorder) / 2;
				this.addContraptionFromPool(this.hero.gy + Constants.StageHeight / 2, gx, "Hourglass");
				this.contraptionControl.scheduleNext(Constants.ContraptionHourglass);
			}
		}
		
		private function launchTrain():void {
			if (Statics.gameMode == Constants.ModeNormal) { // only dispatch train in normal mode
				this.addContraptionFromPool(this.hero.gy + Constants.StageHeight / 2, Constants.StageWidth / 2, "Train");
				//Sounds.sndTrainWarning.play();
				this.contraptionControl.scheduleNext(Constants.ContraptionTrain);
			}
		}
		
		private function launchTrainFromLeft():void {
			if (Statics.gameMode == Constants.ModeNormal) { // only dispatch train in normal mode
				this.addContraptionFromPool(this.hero.gy + Constants.StageHeight / 2, -Constants.StageWidth / 2, "TrainFromLeft");
				//Sounds.sndTrainWarning.play();
				this.contraptionControl.scheduleNext(Constants.ContraptionTrainFromLeft);
			}
		}
		
		private function dropBell():void {
			trace("Dropping bell...");
			if (Statics.gameMode == Constants.ModeNormal) { // only summon bell in normal mode
				this.addContraptionFromPool(this.hero.gy + Constants.StageHeight, 0, "Bell");
				this.contraptionControl.scheduleNext(Constants.ContraptionBell);
			}
		}
		
		private function summonPowerupBoxes():void {
			if (Statics.gameMode == Constants.ModeNormal && Statics.powerupsEnabled) { // only summon powerup boxes in normal mode
				this.addContraptionFromPool(this.hero.gy + Constants.StageHeight / 2, -300, "PowerupBoxPink");
				this.addContraptionFromPool(this.hero.gy + Constants.StageHeight / 2, -150, "PowerupBoxGreen");
				this.addContraptionFromPool(this.hero.gy + Constants.StageHeight / 2, 0, "PowerupBoxFire");
				this.addContraptionFromPool(this.hero.gy + Constants.StageHeight / 2, 150, "PowerupBoxBlue");
				this.addContraptionFromPool(this.hero.gy + Constants.StageHeight / 2, 300, "PowerupBoxPurple");
				this.contraptionControl.scheduleNext(Constants.ContraptionPowerupBoxes);
			}
		}
		
		private function summonCannon():void {
			this.addContraptionFromPool(this.hero.gy + Constants.StageHeight / 2, Constants.StageWidth / 2 - 100, "Cannon");
			this.contraptionControl.scheduleNext(Constants.ContraptionCannon);
		}
		
		private function summonCannonFromLeft():void {
			this.addContraptionFromPool(this.hero.gy + Constants.StageHeight / 2, -Constants.StageWidth / 2 + 100, "CannonFromLeft");
			this.contraptionControl.scheduleNext(Constants.ContraptionCannonFromLeft);
		}
		
		private function summonWitch():void {
			this.addContraptionFromPool(Camera.gy + Constants.StageHeight / 2 + 50, Constants.StageWidth / 2 + 100, "Witch");
			this.contraptionControl.scheduleNext(Constants.ContraptionWitch);
		}
		
		/**
		 * Add an element to the stage
		 * @return uint the platforms array index of the newly added platfrom
		 */
		private function addElementFromPool(y:Number, x:Number, elementClassName:String, elementSize:int = 0, ... args):uint {
			var qualifiedName:String = "com.jumpGame.gameElements.platforms::" + elementClassName;
			var elementClass:Class = getDefinitionByName(qualifiedName) as Class;
			var tempElement:Platform = ObjectPool.instance.getObj(qualifiedName) as elementClass;
			if (tempElement == null) throw new Error("Pool is full: " + elementClassName);
			tempElement.initialize(x, y, elementSize, args);
			tempElement.fixedGy = y;
			this.addChild(tempElement);
			this.platformsList[platformsListLength++] = tempElement;
			this.setChildIndex(tempElement, this.getChildIndex(this.hero)); // push newly added element behind hero
			return platformsListLength - 1;
		}
		
		// add a contraption to stage
		private function addContraptionFromPool(y:Number, x:Number, elementClassName:String):void {
			var qualifiedName:String = "com.jumpGame.gameElements.contraptions::" + elementClassName;
			var elementClass:Class = getDefinitionByName(qualifiedName) as Class;
			var tempElement:Contraption = ObjectPool.instance.getObj(qualifiedName) as elementClass;
			if (tempElement == null) throw new Error("Pool is full: " + elementClassName);
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
		private function returnPlatformToPool(platformIndex:Number):void
		{
			var platform:Platform = platformsList[platformIndex];
			platformsList.splice(platformIndex, 1);
			platformsListLength--;
			ObjectPool.instance.returnObj(platform);
		}
		
		/**
		 * Dispose the contraption temporarily. Check-in into pool (will get cleaned) and reduce the vector length by 1
		 */
		private function returnContraptionToPool(contraptionIndex:Number):void
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
		
		private function hideBigCoinCaption():void {
			bigCoinCaption.visible = false;
			bigCoinCaption.scaleX = 1;
			bigCoinCaption.scaleY = 1;
			bigCoinCaption.alpha = 1;
		}
		
		/**
		 * Reference Classes
		 */
		private function referenceElementClasses():void {
			PlatformNormal;
			PlatformDrop;
			PlatformMobile;
			PlatformNormalBoost;
		}
	}
}