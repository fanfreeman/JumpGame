package com.jumpGame.screens
{
	import com.jumpGame.events.NavigationEvent;
	import com.jumpGame.gameElements.Background;
	import com.jumpGame.gameElements.Camera;
	import com.jumpGame.gameElements.Hero;
	import com.jumpGame.gameElements.Particle;
	import com.jumpGame.gameElements.Platform;
	import com.jumpGame.gameElements.contraptions.Hourglass;
	import com.jumpGame.gameElements.contraptions.Train;
	import com.jumpGame.gameElements.contraptions.Bell;
	import com.jumpGame.gameElements.platforms.PlatformDrop;
	import com.jumpGame.gameElements.platforms.PlatformMobile;
	import com.jumpGame.gameElements.platforms.PlatformNormal;
	import com.jumpGame.gameElements.platforms.PlatformNormalBoost;
	import com.jumpGame.gameElements.platforms.PlatformPower;
	import com.jumpGame.gameElements.platforms.PlatformSuper;
	import com.jumpGame.level.ContraptionControl;
	import com.jumpGame.level.LevelParser;
	import com.jumpGame.level.Statics;
	import com.jumpGame.objectPools.ObjectPool;
	import com.jumpGame.ui.GameOverContainer;
	import com.jumpGame.ui.HUD;
	import com.jumpGame.ui.PauseButton;
	
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.geom.Rectangle;
	import flash.media.SoundMixer;
	import flash.utils.Timer;
	import flash.utils.getDefinitionByName;
	import flash.utils.getTimer;
	
	import starling.animation.Tween;
	import starling.core.Starling;
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
		
		// trains
		private var trainsList:Vector.<Train>;
		private var trainsListLength:uint = 0;
		
		// hourglasses
		private var hourglassesList:Vector.<Hourglass>;
		private var hourglassesListLength:uint = 0;
		
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
		
		// ------------------------------------------------------------------------------------------------------------
		// GAME INTERACTION 
		// ------------------------------------------------------------------------------------------------------------
		
		/** Is game rendering through hardware or software? */
		private var isHardwareRendering:Boolean;
		
		/** Is game currently in paused state? */
		private var gamePaused:Boolean = false;
		
		// whether or not to check win/lose condition
		private var checkWinLose:Boolean = true;
		
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
		private var particlesList:Vector.<Particle>;
		private var particlesListLength:uint = 0;
		
		private static var particleLeaf:PDParticleSystem;
		private static var particleCharge:PDParticleSystem;
		
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
			
			this.isHardwareRendering = Starling.context.driverInfo.toLowerCase().indexOf("software") == -1;
			trace("Hardware rendering: " + isHardwareRendering);
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
			if(ExternalInterface.available){
				trace("Calling JS...");
				ExternalInterface.call("requestFbId");
			} else {
				trace("External interface unavailabe");
			}
		}
		
		/**
		 * Draw game elements - background, hero, particles, pause button, start button and platforms (in pool).
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
			if (this.isHardwareRendering) {
				// create leaf particle emitter
				particleLeaf = new PDParticleSystem(XML(new ParticleAssets.ParticleLeafXML()), Texture.fromBitmap(new ParticleAssets.ParticleLeafTexture()));
				Starling.juggler.add(particleLeaf);
				this.addChild(particleLeaf);
				
				// create charge particle emitter
				particleCharge = new PDParticleSystem(XML(new ParticleAssets.ParticleChargeXML()), Texture.fromBitmap(new ParticleAssets.ParticleChargeTexture()));
				Starling.juggler.add(particleCharge);
				this.addChild(particleCharge);
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
			this.trainsList = new Vector.<Train>();
			this.trainsListLength = 0;
			
			// initialize the hourglasses vector
			this.hourglassesList = new Vector.<Hourglass>();
			this.hourglassesListLength = 0;
			
			// initialize the particles vector
			this.particlesList = new Vector.<Particle>();
			this.particlesListLength = 0;
			
			// create platform pools
			ObjectPool.instance.registerPool(PlatformNormal, 10, false);
			ObjectPool.instance.registerPool(PlatformMobile, 10, false);
			ObjectPool.instance.registerPool(PlatformDrop, 10, false);
			ObjectPool.instance.registerPool(PlatformNormalBoost, 10, false);
			ObjectPool.instance.registerPool(PlatformPower, 5, false);
			ObjectPool.instance.registerPool(PlatformSuper, 5, false);
			ObjectPool.instance.registerPool(Train, 3, false);
			ObjectPool.instance.registerPool(Hourglass, 3, false);
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
		
		public function initializeNormalMode():void
		{
			// reset static vars
			Statics.gameMode = Constants.ModeNormal;
			Statics.preparationStep = Constants.PrepareStep0;
			Statics.gameTime = 0;
			Statics.bonusTime = 0;
			
			// populate stage from level file
			this.levelParser = new LevelParser();
			
			// play background music
			if (!Sounds.muted) Sounds.playBgm();
			
			// hide the pause button since the game isn't started yet.
			pauseButton.visible = false;
			
			// show start button.
//			startButton.visible = true;
			
			// start contraption control
			this.contraptionControl = new ContraptionControl();
			this.contraptionControl.addEventListener(NavigationEvent.TRAIN_LAUNCH, launchTrain);
			this.contraptionControl.addEventListener(NavigationEvent.HOURGLASS_SUMMON, summonHourglass);
			
			// reset scores
			hud.bonusTime = 0;
			hud.distance = 0;
			hud.coins = 0;
			
			// start game timer
			this.gameStartTime = getTimer();
			
			// game tick
			this.addEventListener(Event.ENTER_FRAME, onGameTick);
		}
		
		public function initializeBonusMode():void
		{
			// reset static vars
			Statics.gameMode = Constants.ModeBonus;
			Statics.preparationStep = Constants.PrepareStep0;
			Statics.gameTime = 0;
			Statics.bonusTimeLeft = Number(Statics.bonusTime * 1000);
			
			// populate stage from level file
			this.levelParser = new LevelParser();
			
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
				this.contraptionControl.scheduleNextHourglass();
				this.contraptionControl.scheduleNextTrain();
			}
			else if (Statics.gameMode == Constants.ModeBonus) { // bonus mode specific
				//SoundMixer.stopAll();
				if (!Sounds.muted) Sounds.playBgmFireAura();
			}
			
			// restart game timer
			Statics.gameTime = 0;
			this.gameStartTime = getTimer();
		}
		
		/**
		 * Set keydown states to true
		 */
		public function keyPressedDown(event:KeyboardEvent):void {
			if (event.keyCode == 37) {
				leftArrow = true;
			} else if (event.keyCode == 39) {
				rightArrow = true;        
			} else if (event.keyCode == 38) {
				upArrow = true;
			} else if (event.keyCode == 40) {
				downArrow = true;
			} else if (event.keyCode == 32) { // space bar pressed
				if (this.playerControl) {
					if (this.hero.triggerSpecialAbility()) particleCharge.start(0.1);
				}
			}
		}
		
		/**
		 * Set keydown states to false
		 */
		public function keyPressedUp(event:KeyboardEvent):void {
			if (event.keyCode == 37) {
				leftArrow = false;
			} else if (event.keyCode == 39) {
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
				else if (Statics.gameMode == Constants.ModeBonus) HUD.showMessage("Get ready for some musical action!", 1000);
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
			
			/** update timers in other classes */
			// update HUD message
			HUD.updateMessageDisplay();
			/** eof update timers */
			
			// move camera
			Camera.update(this.hero.gx, this.hero.gy);
			
			// scroll all platforms
			this.scrollElements();
			
			if (!launchCountdown(timeCurrent)) { // not in preparation mode
				/** update hero */
				// adjust hero vertical speed for gravity
				this.hero.fall(this.timeDiffControlled);
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
								this.hero.dx = -0.28;
								this.moveMadeThisTurn = true;
							}
								//else if (Camera.nextPlatformX > this.hero.gx) { // autopilot
								//else if (this.moveMade == 2) { // right arrow pressed
							else if (rightArrow) {
								this.hero.turnRight();
								this.hero.dx = 0.28;
								this.moveMadeThisTurn = true;
							}
							
						}
						
						//}
					} else { // normal game mode
						if (leftArrow) { // left arrow pressed
							this.hero.turnLeft();
							if (this.hero.dx > 0) {this.hero.dx = 0;}
							this.hero.dx -= Constants.HeroSpeedX * this.timeDiffControlled;
							if (this.hero.dx < -Constants.HeroMaxSpeedX) {
								this.hero.dx = -Constants.HeroMaxSpeedX;
							}
						}
						else if (rightArrow) { // right arrow pressed
							this.hero.turnRight();
							if (this.hero.dx < 0) {this.hero.dx = 0;}
							this.hero.dx += Constants.HeroSpeedX * this.timeDiffControlled;
							if (this.hero.dx > Constants.HeroMaxSpeedX) {
								this.hero.dx = Constants.HeroMaxSpeedX;
							}
						}
						else { // no arrow pressed, reset velocity
							if (this.hero.dx < 0) {
								if (Math.abs(this.hero.dx) < Constants.HeroSpeedX * this.timeDiffControlled) {
									this.hero.dx = 0;
								} else {
									this.hero.dx += Constants.HeroSpeedX * this.timeDiffControlled;
								}
							} else if (this.hero.dx > 0) {
								if (Math.abs(this.hero.dx) < Constants.HeroSpeedX * this.timeDiffControlled) {
									this.hero.dx = 0;
								} else {
									this.hero.dx -= Constants.HeroSpeedX * this.timeDiffControlled;
								}
							}
						}
					} // eof normal game mode
				}
				
				// move hero
				this.hero.gx += this.timeDiffControlled * this.hero.dx;
				this.hero.gy += this.timeDiffControlled * this.hero.dy;
				
				// update max climb distance
				if (this.hero.gy > this.maxDist) {
					this.maxDist = this.hero.gy;
				}
				/** eof update hero */
				
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
				if (isHardwareRendering)
				{
					particleLeaf.emitterX = hero.x;
					particleLeaf.emitterY = hero.y;
					
					particleCharge.emitterX = hero.x;
					particleCharge.emitterY = hero.y;
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
			} // eof not in preparation mode
		}
		
		/**
		 * Player fails, check to see if saves are available
		 */
		private function playerFail():void {
			this.hero.failBounce();
			
			// stop checking win/lose condition
			this.checkWinLose = false;
			
			// revoke player control of hero
			this.playerControl = false;
			
			// stop sounds
			SoundMixer.stopAll();
			Sounds.sndScratch.play();
			
			// trigger bonus mode
			var delayTimer:Timer = new Timer(3000, 1);
			delayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, endGame);
			delayTimer.start();
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
		public function endGame(event:TimerEvent):void {
			if (event != null) {
				event.target.removeEventListener(TimerEvent.TIMER_COMPLETE, endGame);
			}
			
			// clean up platforms
			for(; this.platformsListLength > 0;) this.returnPlatformToPool(0);
			
			// clean up trains
			for(; this.trainsListLength > 0;) this.returnTrainToPool(0);
			
			// clean up hourglasses
			for(; this.hourglassesListLength > 0;) this.returnHourglassToPool(0);
			
			// remove event listeners
			Starling.current.nativeOverlay.stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyPressedDown);
			Starling.current.nativeOverlay.stage.removeEventListener(KeyboardEvent.KEY_UP, keyPressedUp);
			this.removeEventListener(Event.ENTER_FRAME, onGameTick);
			if (Statics.gameMode == Constants.ModeNormal) {
				this.contraptionControl.removeEventListener(NavigationEvent.TRAIN_LAUNCH, launchTrain);
				this.contraptionControl.removeEventListener(NavigationEvent.HOURGLASS_SUMMON, summonHourglass);
			}
			
			// clean up hero
			this.removeChild(this.hero);
			this.hero = null;
			
			// show game over screen
			this.setChildIndex(gameOverContainer, this.numChildren - 1);
			gameOverContainer.initialize(0, this.maxDist);
		}
		
		/**
		 * Scroll all of the rainbows downward
		 */
		public function scrollElements():void {
			var i:uint; // array index
			
			/** platform behaviors */
			// for aiming camera at next platform
			var smallestPlatformY:Number = this.hero.gy + Constants.StageHeight; // set it to a high value first
			
			for (i = 0; i < this.platformsListLength; i++) {
				if (this.checkWinLose && this.hero.canBounce) { // detect hero/platform collisions if player has not yet lost
					//if (this.hero.bounds.intersects(this.platformsList[i].bounds)) {
					if (this.platformsList[i].bounds.contains(this.hero.x - 10, this.hero.y + 20) ||
						this.platformsList[i].bounds.contains(this.hero.x + 10, this.hero.y + 20)) { // platform collision!
						this.platformsList[i].touch();
						if (this.hero.dy < 0) { // hero is falling
							this.hero.bounce(this.platformsList[i].getBouncePower());
							this.platformsList[i].contact();
							particleLeaf.start(0.1); // play particle effect
							
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
				
				// update platform position
				this.platformsList[i].update(this.timeDiffControlled);
				
				// for aiming camera at next platform
				if (!this.platformsList[i].isTouched && this.platformsList[i].gy < smallestPlatformY) {
					smallestPlatformY = this.platformsList[i].gy;
					Camera.nextPlatformX = this.platformsList[i].gx;
				}
				
				// remove a platform if it has scrolled below sea of fire
				if (this.platformsList[i].gy < this.fg.sofHeight - 100) {
					this.returnPlatformToPool(i);
				}
			} /** eof platform behaviors */
			
			/** train behaviors */
			for (i = 0; i < this.trainsListLength; i++) {
				if (this.checkWinLose && this.hero.canBounce) { // check hero/train collision if not yet lost
					var trainBounds:Rectangle = this.trainsList[i].bounds;
					trainBounds.inflate(-50, -50); // shrink train bounds
					if (trainBounds.contains(this.hero.x - 10, this.hero.y + 20) ||
						trainBounds.contains(this.hero.x + 10, this.hero.y + 20) ||
						trainBounds.contains(this.hero.x - 10, this.hero.y - 20) ||
						trainBounds.contains(this.hero.x + 10, this.hero.y - 20)) {
						if (this.hero.gx < this.trainsList[i].gx + 100) { // hit by a train
							this.playerControl = false;
							this.hero.dx = Constants.TrainVelocity * 2;
							Sounds.sndTrainHit.play();
						}
						else {
							if (this.hero.dy < 0) { // roof bounce
								this.hero.bounceAndFade(Constants.DirectionUp, Constants.NormalBouncePower);
							}
							else { // bottom bounce
								this.hero.bounceAndFade(Constants.DirectionDown, Constants.NormalBouncePower);
							}
							particleLeaf.start(0.1); // play particle effect
						}
					}
				}
				
				// update train position
				this.trainsList[i].update(this.timeDiffControlled);
				
				// remove a platform if it has scrolled below sea of fire
				if (this.trainsList[i].gy < this.fg.sofHeight - 100) {
					this.returnTrainToPool(i);
				}
			} /** eof train behaviors */
			
			/** hourglass behaviors */
			for (i = 0; i < this.hourglassesListLength; i++) {
				if (this.checkWinLose) { // check hero/hourglass collision if not yet lost
					var hourglassBounds:Rectangle = this.hourglassesList[i].bounds;
					if (hourglassBounds.contains(this.hero.x - 10, this.hero.y + 20) ||
						hourglassBounds.contains(this.hero.x + 10, this.hero.y + 20) ||
						hourglassBounds.contains(this.hero.x - 10, this.hero.y - 20) ||
						hourglassBounds.contains(this.hero.x + 10, this.hero.y - 20)) {
						this.hourglassesList[i].contact();
					}
				}
				
				// update hourglass position
				this.hourglassesList[i].update(this.timeDiffControlled);
				
				// remove a platform if it has scrolled below sea of fire
				if (this.hourglassesList[i].gy < this.fg.sofHeight - 100) {
					this.returnHourglassToPool(i);
				}
			} /** eof hourglass behaviors */
			
			// scroll background and foreground layers
			this.bg.scroll();
			this.fg.scroll();
			
			/** Stage Element Population */
			// populate area above visible stage with next elements in level elements array
			while (this.levelParser.levelElementsArray.length > 0 && this.levelParser.levelElementsArray[0][0] <= this.hero.gy + Constants.ElementPreloadWindow) {
				var levelElement:Array = this.levelParser.levelElementsArray[0];
				
				if (levelElement[2] == Constants.ContraptionSettingHourglass) {// check for hourglass settings
					this.contraptionControl.hourglassInterval = levelElement[1]; // update hourglass interval
				}
				else if (levelElement[2] == Constants.ContraptionSettingTrain) { // check for train settings
					this.contraptionControl.trainInterval = levelElement[1]; // update train interval
				}
				else if (levelElement[2] == Constants.ContraptionSettingBell) { // check for bell settings
					this.contraptionControl.bellInterval = levelElement[1]; // update bell interval
				}
				else { // add element
					this.addElementFromPool(levelElement[0], levelElement[1], levelElement[2], levelElement[3]);
					this.setChildIndex(this.platformsList[(uint)(this.platformsList.length) - 1], this.getChildIndex(this.hero)); // push newly added element behind hero
				}
				this.levelParser.levelElementsArray.splice(0, 1); // remove this entry from level elements array
			}
		}
		
		private function launchTrain():void {
			if (Statics.gameMode == Constants.ModeNormal && this.checkWinLose) { // only dispatch train in normal mode
				this.addTrainFromPool(this.hero.gy - 100, Constants.StageWidth);
				this.contraptionControl.scheduleNextTrain();
			}
		}
		
		private function summonHourglass():void {
			if (Statics.gameMode == Constants.ModeNormal && this.checkWinLose) { // only summon hourglass in normal mode
				var gx:Number = Math.random() * (Constants.StageWidth - Constants.ScreenBorder) 
					- (Constants.StageWidth - Constants.ScreenBorder) / 2;
				this.addHourglassFromPool(this.hero.gy + Constants.StageHeight, gx);
				this.contraptionControl.scheduleNextHourglass();
			}
		}
		
		/**
		 * Add an element to the stage
		 */
		private function addElementFromPool(y:Number, x:Number, elementClassName:String, elementSize:int):void {
			var elementClass:Class = getDefinitionByName("com.jumpGame.gameElements.platforms." + elementClassName) as Class;
			var tempElement:Platform = ObjectPool.instance.getObj(elementClass) as elementClass;
			if (tempElement == null) throw new Error("Pool is full");
			tempElement.initialize(elementSize);
			tempElement.gx = x;
			tempElement.gy = y;
			this.addChild(tempElement);
			this.platformsList[platformsListLength++] = tempElement;
		}
		
		// add a train to stage
		private function addTrainFromPool(y:Number, x:Number):void {
			var elementClass:Class = getDefinitionByName("com.jumpGame.gameElements.contraptions.Train") as Class;
			var tempElement:Train = ObjectPool.instance.getObj(elementClass) as elementClass;
			if (tempElement == null) throw new Error("Pool is full");
			tempElement.initialize();
			tempElement.gx = x;
			tempElement.gy = y;
			this.addChild(tempElement);
			this.trainsList[trainsListLength++] = tempElement;
		}
		
		// add an hourglass to stage
		private function addHourglassFromPool(y:Number, x:Number):void {
			var elementClass:Class = getDefinitionByName("com.jumpGame.gameElements.contraptions.Hourglass") as Class;
			var tempElement:Hourglass = ObjectPool.instance.getObj(elementClass) as elementClass;
			if (tempElement == null) throw new Error("Pool is full");
			tempElement.initialize();
			tempElement.gx = x;
			tempElement.gy = y;
			this.addChild(tempElement);
			this.hourglassesList[hourglassesListLength++] = tempElement;
		}
		
		/**
		 * Dispose the platform temporarily. Check-in into pool (will get cleaned) and reduce the vector length by 1
		 */
		private function returnPlatformToPool(platformIndex:Number):void
		{
			var platform:Platform = this.platformsList[platformIndex];
			platformsList.splice(platformIndex, 1);
			platformsListLength--;
			ObjectPool.instance.returnObj(platform);
		}
		
		/**
		 * Dispose the train temporarily. Check-in into pool (will get cleaned) and reduce the vector length by 1
		 */
		private function returnTrainToPool(trainIndex:Number):void
		{
			var train:Train = this.trainsList[trainIndex];
			trainsList.splice(trainIndex, 1);
			trainsListLength--;
			ObjectPool.instance.returnObj(train);
		}
		
		/**
		 * Dispose the hourglass temporarily. Check-in into pool (will get cleaned) and reduce the vector length by 1
		 */
		private function returnHourglassToPool(hourglassIndex:Number):void
		{
			var hourglass:Hourglass = this.hourglassesList[hourglassIndex];
			hourglassesList.splice(hourglassIndex, 1);
			hourglassesListLength--;
			ObjectPool.instance.returnObj(hourglass);
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