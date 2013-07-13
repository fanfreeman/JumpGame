package com.jumpGame.screens
{
	import com.jumpGame.gameElements.Background;
	import com.jumpGame.gameElements.Camera;
	import com.jumpGame.gameElements.Contraption;
	import com.jumpGame.gameElements.Hero;
	import com.jumpGame.gameElements.Platform;
	import com.jumpGame.gameElements.contraptions.Bell;
	import com.jumpGame.gameElements.contraptions.Hourglass;
	import com.jumpGame.gameElements.contraptions.PowerupBox;
	import com.jumpGame.gameElements.contraptions.PowerupBoxBlue;
	import com.jumpGame.gameElements.contraptions.PowerupBoxFire;
	import com.jumpGame.gameElements.contraptions.PowerupBoxGreen;
	import com.jumpGame.gameElements.contraptions.PowerupBoxPink;
	import com.jumpGame.gameElements.contraptions.PowerupBoxPurple;
	import com.jumpGame.gameElements.contraptions.Train;
	import com.jumpGame.gameElements.contraptions.TrainFromLeft;
	import com.jumpGame.gameElements.platforms.Coin;
	import com.jumpGame.gameElements.platforms.PlatformDrop;
	import com.jumpGame.gameElements.platforms.PlatformDropBoost;
	import com.jumpGame.gameElements.platforms.PlatformMobile;
	import com.jumpGame.gameElements.platforms.PlatformMobileBoost;
	import com.jumpGame.gameElements.platforms.PlatformNormal;
	import com.jumpGame.gameElements.platforms.PlatformNormalBoost;
	import com.jumpGame.gameElements.platforms.PlatformPower;
	import com.jumpGame.gameElements.platforms.PlatformSuper;
	import com.jumpGame.gameElements.platforms.Star;
	import com.jumpGame.gameElements.platforms.StarMini;
	import com.jumpGame.gameElements.powerups.Attractor;
	import com.jumpGame.gameElements.powerups.Blink;
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
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.BlendMode;
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
		
		// ------------------------------------------------------------------------------------------------------------
		// GAME PROPERTIES AND DATA
		// ------------------------------------------------------------------------------------------------------------
		
		// Time calculation for animation
		private var gameStartTime:int;
		private var timeDiffReal:int;
		private var timeDiffControlled:Number;
		//private var speedFactor:Number = 1.048 * 2; // game speed multiplier [1.099]
		private var speedFactor:Number = 1.099;
		
		// max climb distance
		private var maxDist:Number = 0.0;
		
		// coins obtained
		private var coinsObtained:int = 0;
		
		// times jumped
		private var jumps:int = 0;
		
		// ------------------------------------------------------------------------------------------------------------
		// GAME INTERACTION 
		// ------------------------------------------------------------------------------------------------------------
		
		// whether game currently in paused state
		private var gamePaused:Boolean = false;
		
		// whether or not to check win/lose condition
		private var checkWinLose:Boolean = true;
		
		// time to end the game
		private var endGameTime:int;
		
		// music mode variables
		private var moveMadeThisTurn:Boolean = false;
		private var moveMade:uint = 0;
		
		// ------------------------------------------------------------------------------------------------------------
		// PHYSICS
		// ------------------------------------------------------------------------------------------------------------
		
		
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
				
				// create charge particle emitter
				Statics.particleWind = new PDParticleSystem(XML(new ParticleAssets.ParticleWindXML()), Texture.fromBitmap(new ParticleAssets.ParticleWindTexture()));
				Starling.juggler.add(Statics.particleWind);
				this.addChild(Statics.particleWind);
				Statics.particleWind.emitterX = Constants.StageWidth / 2;
				Statics.particleWind.emitterY = 0;
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
			
			// initialize the trains vector
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
			
			// set up spells and charms
			// spell: blink
			var blink:Blink = new Blink(this.hero);
			this.addChild(blink);
			this.powerupsList[this.powerupsListLength++] = blink;
			// charm: attractor
			var attractor:Attractor = new Attractor(this.hero);
			this.addChild(attractor);
			this.powerupsList[this.powerupsListLength++] = attractor;
			
			// create platform pools
			ObjectPool.instance.registerPool(PlatformNormal, 10, false);
			ObjectPool.instance.registerPool(PlatformMobile, 80, false);
			ObjectPool.instance.registerPool(PlatformDrop, 10, false);
			ObjectPool.instance.registerPool(PlatformNormalBoost, 4, false);
			ObjectPool.instance.registerPool(PlatformDropBoost, 4, false);
			ObjectPool.instance.registerPool(PlatformMobileBoost, 4, false);
			ObjectPool.instance.registerPool(PlatformPower, 5, false);
			ObjectPool.instance.registerPool(PlatformSuper, 5, false);
			ObjectPool.instance.registerPool(Coin, 60, false);
			ObjectPool.instance.registerPool(Star, 100, false);
			ObjectPool.instance.registerPool(StarMini, 20, false);
			ObjectPool.instance.registerPool(Train, 2, false);
			ObjectPool.instance.registerPool(TrainFromLeft, 2, false);
			ObjectPool.instance.registerPool(Hourglass, 3, false);
			ObjectPool.instance.registerPool(Bell, 3, false);
			ObjectPool.instance.registerPool(PowerupBoxPink, 2, false);
			ObjectPool.instance.registerPool(PowerupBoxGreen, 2, false);
			ObjectPool.instance.registerPool(PowerupBoxFire, 2, false);
			ObjectPool.instance.registerPool(PowerupBoxBlue, 2, false);
			ObjectPool.instance.registerPool(PowerupBoxPurple, 2, false);
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
			Statics.preparationStep = Constants.PrepareStep0;
			Statics.gameTime = 0;
			Statics.bonusTime = 0;
			Statics.nextStarNote = 0;
			Statics.powerupsEnabled = true;
			Statics.attractorOn = false;
			
			// play background music
			if (!Sounds.muted) Sounds.playBgm();
			
			// hide the pause button since the game isn't started yet.
			pauseButton.visible = false;
			
			// reset scores
			hud.bonusTime = 0;
			hud.distance = 0;
			hud.coins = 0;
			
			// reset game properties
			Statics.cameraShake = 0;
			
			// start game timer
			this.gameStartTime = getTimer();
			
			// game tick
			this.addEventListener(Event.ENTER_FRAME, onGameTick);
		}
		
		public function initializeBonusMode():void
		{
			this.speedFactor = 1.545;
			Statics.bonusTime = 300; // test
			
			// reset static vars
			Statics.gameMode = Constants.ModeBonus;
			Statics.preparationStep = Constants.PrepareStep0;
			Statics.gameTime = 0;
			Statics.bonusTimeLeft = Number(Statics.bonusTime * 1000);
			
			// hide the pause button since the game isn't started yet.
			pauseButton.visible = false;
			
			// reset scores
			hud.bonusTime = 0;
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
			if (gamePaused) gamePaused = false;
			else gamePaused = true;
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
				this.contraptionControl.scheduleNext(Constants.ContraptionHourglass);
				this.contraptionControl.scheduleNext(Constants.ContraptionTrain);
				this.contraptionControl.scheduleNext(Constants.ContraptionTrainFromLeft);
				this.contraptionControl.scheduleNext(Constants.ContraptionBell);
				this.contraptionControl.scheduleNext(Constants.ContraptionPowerupBoxes);
				
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
					if (this.hero.triggerSpecialAbility()) {
						Statics.particleCharge.start(0.1);
						Statics.particleLeaf.start(0.2);
					}
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
				if (timeCurrent> 1000) {
					HUD.showMessage("3", 1000);
					Statics.preparationStep = Constants.PrepareStep2;
				}
			}
			else if (Statics.preparationStep == Constants.PrepareStep2) {
				if (timeCurrent> 2000) {
					HUD.showMessage("2", 1000);
					Statics.preparationStep = Constants.PrepareStep3;
				}
			}
			else if (Statics.preparationStep == Constants.PrepareStep3) {
				if (timeCurrent> 3000) {
					HUD.showMessage("1", 1000);
					Statics.preparationStep = Constants.PrepareStep4;
				}
			}
			else if (Statics.preparationStep == Constants.PrepareStep4) {
				if (timeCurrent> 4000) {
					HUD.showMessage("JUMP!", 1000);
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
			// update game time
			var timeCurrent:int = getTimer() - this.gameStartTime;
			this.timeDiffReal = timeCurrent - Statics.gameTime;
			Statics.gameTime = timeCurrent;
			this.timeDiffControlled = Number(this.timeDiffReal) * this.speedFactor;
			
			if (gamePaused) {
				return;
			}
			
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
				this.speedFactor = 2.62;
			}
			
			/** update timers in other classes */
			// update HUD and spin powerup reel if needed
			HUD.updateMessage();
			var powerupToActivate:int = this.hud.updatePowerupReel(this.timeDiffReal);
			if (this.checkWinLose) {
				// update powerup reel
				if (powerupToActivate >= 0 && powerupToActivate <= 2) {
					HUD.showMessage("Ancient Power: Teleportation");
					this.powerupsList[Constants.PowerupBlink].activate();
				}
				else if (powerupToActivate >= 3 && powerupToActivate <= 5) {
					HUD.showMessage("Charm: Attractor");
					this.powerupsList[Constants.PowerupAttractor].activate();
				}
				
				// update powerups
				for (var i:uint = 0; i < this.powerupsListLength; i++) {
					this.powerupsList[i].update(this.timeDiffControlled);
				}
			}
			/** eof update timers */
			
			// camera shake
			this.shakeCamera();
			
			// move camera
			Camera.update(this.hero.gx, this.hero.gy);
			
			// scroll all platforms
			this.scrollElements();
			
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
					} // eof normal game mode
				} /** eof player control */
				
				// update hero position, velocity, rotation
				this.hero.update(this.timeDiffControlled);
				
				// update max climb distance
				if (this.hero.gy > this.maxDist) {
					this.maxDist = this.hero.gy;
				}
				/** eof update hero */
				
				// check contraptions scheduling
				if (Statics.gameMode == Constants.ModeNormal) {
					var contraptionStatus:Array = this.contraptionControl.checkSchedules();
					if (contraptionStatus[Constants.ContraptionHourglass]) this.summonHourglass();
					if (contraptionStatus[Constants.ContraptionTrain]) this.launchTrain();
					if (contraptionStatus[Constants.ContraptionTrainFromLeft]) this.launchTrainFromLeft();
					if (contraptionStatus[Constants.ContraptionBell] && !this.contraptionControl.isBellActive) this.dropBell();
					if (contraptionStatus[Constants.ContraptionPowerupBoxes]) this.summonPowerupBoxes();
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
					
					Background.particleSeaOfFire.emitterX = Constants.StageWidth / 2;
					Background.particleSeaOfFire.emitterY = this.fg.sofQuad.y - 100;
				}
				
				// we lose if we fall
				if (Constants.SofEnabled) {
					if (this.hero.gy < this.fg.sofHeight - 60) {
						if (this.checkWinLose) {
							HUD.showMessage("OH NOES...");
							this.playerFail();
							return;
						}
						else this.hero.gy = this.fg.sofHeight - 60; // hide hero just below sof
					}
				} else {
					if (this.checkWinLose && hero.gy < Camera.gy - Constants.StageHeight / 2) {
						HUD.showMessage("OH NOES...");
						this.playerFail();
						return;
					}
				}
				
				// update hud
				if (Statics.gameMode == Constants.ModeNormal) {
					hud.bonusTime = Statics.bonusTime;
				}
				else if (Statics.gameMode == Constants.ModeBonus && this.checkWinLose) {
					// count down time in bonus mode and update hud
					hud.bonusTime = int(Statics.bonusTimeLeft / 1000);
					Statics.bonusTimeLeft = Statics.bonusTime * 1000 - Statics.gameTime;
					if (Statics.bonusTimeLeft <= 0) {
						HUD.showMessage("Time Up!");
						this.playerFail();
						return;
					}
				}
				
				hud.distance = Math.round(this.maxDist);
				hud.coins = this.coinsObtained;
			} // eof not in preparation mode
		}
		
		/**
		 * Player fails, check to see if saves are available
		 */
		private function playerFail():void {
			this.hero.failBounce();
			
			// end game after short duration
			this.endGameTime = Statics.gameTime + 3000;
			
			// stop checking win/lose condition
			this.checkWinLose = false;
			
			// revoke player control of hero
			this.playerControl = false;
			
			// stop sounds
			//SoundMixer.stopAll();
			Sounds.stopBgm();
			if (!Sounds.muted) Sounds.sndScratch.play();
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
			gameOverContainer.initialize(this.coinsObtained, this.maxDist);
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
			
			for (i = 0; i < this.platformsListLength; i++) { // loop through platforms
				isCoin = false;
				isStar = false;
				
				// detect hero/platform collisions if player has not yet lost
				if (this.checkWinLose && this.hero.canBounce) {
					//if (this.hero.bounds.intersects(this.platformsList[i].bounds)) {
					var platformBounds:Rectangle = this.platformsList[i].bounds;
					if (Object(this.platformsList[i]).constructor == Coin) {
						platformBounds.inflate(50, 50); // enlarge coin bounds
						isCoin = true;
					} else if (Object(this.platformsList[i]).constructor == Star || Object(this.platformsList[i]).constructor == StarMini) {
						isStar = true;
					}
					if (platformBounds.contains(this.hero.x - 10, this.hero.y + 20) ||
						platformBounds.contains(this.hero.x + 10, this.hero.y + 20)) { // platform collision!
						if (this.platformsList[i].touch()) { // ensures stuff inside this block only runs once per contact
							if (isCoin) {
								this.coinsObtained++;
								this.returnPlatformToPool(i);
								continue;
							}
							else if (isStar) {
								this.hero.bounce(this.platformsList[i].getBouncePower());
								this.returnPlatformToPool(i);
								continue;
							}
							
							else if (this.hero.dy < 0) { // hero is falling
								if (this.platformsList[i].canBounce) {
									this.hero.bounce(this.platformsList[i].getBouncePower());
									this.platformsList[i].contact();
									Statics.particleLeaf.start(0.2); // play particle effect
									this.jumps++; // record number of jumps
									
									if (Statics.gameMode == Constants.ModeBonus) { // music mode actions
										this.hero.gx = this.platformsList[i].gx;
										if (this.moveMadeThisTurn) {
											this.hero.dx = 0;
											this.moveMadeThisTurn = false;
										}
									}
								}
							}
						}
					} else { // not in collision
						if (!isStar) this.platformsList[i].isTouched = false; // when not colliding anymore, reset touch status
					}
				} // eof platform collision detection
				
				// bof attractor charm
				if (Statics.attractorOn) {
					if (this.platformsList[i].gy < this.hero.gy + Constants.StageHeight / 2) {
						var easingFactor:Number = (620 - Math.abs(this.hero.gy - this.platformsList[i].gy) / 10);
						if (easingFactor < 5) easingFactor = 5;
						
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
						
						if (isCoin || isStar) {
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
					} // eof attractor charm
				}
				
				// update platform position
				this.platformsList[i].update(this.timeDiffControlled);
				
				// for aiming camera at next platform
				if (!(this.platformsList[i] is Coin) && this.platformsList[i].gy > this.hero.gy && this.platformsList[i].gy < smallestPlatformY) {
					smallestPlatformY = this.platformsList[i].gy;
					smallestPlatformIndex = i;
				}
				
				// remove a platform if it has scrolled below sea of fire
				if (this.platformsList[i].gy < this.fg.sofHeight - 100) {
					this.returnPlatformToPool(i);
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
					if (this.checkWinLose && this.hero.canBounce) { // check hero/train collision if not yet lost
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
					if (this.checkWinLose && this.hero.canBounce) { // check hero/train collision if not yet lost
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
									this.platformsList[newCoinIndex].makeKinematic(Constants.NormalBouncePower);
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
						var distance:Number = Math.sqrt(Math.pow(this.contraptionsList[i].gx - this.hero.gx, 2) + Math.pow(this.contraptionsList[i].gy - this.hero.gy, 2));
						if (distance < this.contraptionsList[i].height / 2 + this.hero.width / 2 - 100) {
							if (this.contraptionsList[i].contact(this.hero.gx - this.contraptionsList[i].gx, this.hero.dy)) { // hero made contact with bell
								numCoinsToDrop = int(Math.ceil(Math.random() * 20));
								for (ci = 0; ci < numCoinsToDrop; ci++) {
									newCoinIndex = addElementFromPool(this.contraptionsList[i].gy, this.contraptionsList[i].gx, "Coin");
									this.platformsList[newCoinIndex].makeKinematic(Constants.NormalBouncePower);
								}
							}
						}
					}
				} /** eof bell behaviors */
				
				if (this.contraptionsList[i] is PowerupBox) { /** hourglass behaviors */
					if (this.checkWinLose) { // check hero/hourglass collision if not yet lost
						if (contraptionBounds.contains(this.hero.x - 10, this.hero.y + 20) ||
							contraptionBounds.contains(this.hero.x + 10, this.hero.y + 20) ||
							contraptionBounds.contains(this.hero.x - 10, this.hero.y - 20) ||
							contraptionBounds.contains(this.hero.x + 10, this.hero.y - 20)) {
							this.contraptionsList[i].contact(this.hud);
						}
					}
				} /** eof powerup boxes behaviors */
				
				// update contraptions
				this.contraptionsList[i].update(this.timeDiffControlled);
				if(Object(this.contraptionsList[i]).constructor == Bell) this.contraptionsList[i].debug(this.hero.gy);
				
				// remove a platform if it has scrolled below sea of fire
				if (this.contraptionsList[i].gy < this.fg.sofHeight - this.contraptionsList[i].height) {
					if (Object(this.contraptionsList[i]).constructor == Bell) this.contraptionControl.isBellActive = false;
					this.returnContraptionToPool(i);
				}
			} /** eof contraption behaviors */
			
			// scroll background and foreground layers
			this.bg.scroll();
			this.fg.scroll();
			
			/** Stage Element Population */
			// populate area above visible stage with next elements in level elements array
			while (this.levelParser.levelElementsArray.length > 0 && this.levelParser.levelElementsArray[0][0] <= this.hero.gy + Constants.ElementPreloadWindow) {
				var levelElement:Array = this.levelParser.levelElementsArray[0];
				
				if (levelElement[2] == Constants.ContraptionSettingHourglass) {// check for hourglass settings
					this.contraptionControl.intervals[Constants.ContraptionHourglass] = levelElement[1]; // update hourglass interval
				}
				else if (levelElement[2] == Constants.ContraptionSettingTrain) { // check for train settings
					this.contraptionControl.intervals[Constants.ContraptionTrain] = levelElement[1]; // update train interval
				}
				else if (levelElement[2] == Constants.ContraptionSettingTrainFromLeft) { // check for train from left settings
					this.contraptionControl.intervals[Constants.ContraptionTrainFromLeft] = levelElement[1]; // update train from left interval
				}
				else if (levelElement[2] == Constants.ContraptionSettingBell) { // check for bell settings
					this.contraptionControl.intervals[Constants.ContraptionBell] = levelElement[1]; // update bell interval
				}
				else if (levelElement[2] == Constants.ContraptionSettingPowerupBoxes) {// check for powerup boxes settings
					this.contraptionControl.intervals[Constants.ContraptionPowerupBoxes] = levelElement[1]; // update powerup boxes interval
				}
				else if (levelElement[2] == Constants.Coin && Statics.gameMode == Constants.ModeBonus) {
					// do not add coins if in bonus mode
				}
				else { // add element
					this.addElementFromPool(levelElement[0], levelElement[1], levelElement[2], levelElement[3]);
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
				this.contraptionControl.isBellActive = true;
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
		
		/**
		 * Add an element to the stage
		 * @return uint the platforms array index of the newly added platfrom
		 */
		private function addElementFromPool(y:Number, x:Number, elementClassName:String, elementSize:int = 0):uint {
			var qualifiedName:String = "com.jumpGame.gameElements.platforms::" + elementClassName;
			var elementClass:Class = getDefinitionByName(qualifiedName) as Class;
			var tempElement:Platform = ObjectPool.instance.getObj(qualifiedName) as elementClass;
			if (tempElement == null) throw new Error("Pool is full: " + elementClassName);
			tempElement.initialize(elementSize);
			tempElement.gx = x;
			tempElement.gy = y;
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