package com.jumpGame.screens
{
	import com.jumpGame.events.NavigationEvent;
	import com.jumpGame.gameElements.Background;
	import com.jumpGame.gameElements.Camera;
	import com.jumpGame.gameElements.Hero;
	import com.jumpGame.gameElements.Particle;
	import com.jumpGame.gameElements.Platform;
	import com.jumpGame.gameElements.platforms.PlatformDrop;
	import com.jumpGame.gameElements.platforms.PlatformMobile;
	import com.jumpGame.gameElements.platforms.PlatformNormal;
	import com.jumpGame.gameElements.platforms.PlatformNormalBoost;
	import com.jumpGame.gameElements.platforms.PlatformPower;
	import com.jumpGame.gameElements.platforms.PlatformSuper;
	import com.jumpGame.level.LevelParser;
	import com.jumpGame.objectPools.ObjectPool;
	import com.jumpGame.ui.GameOverContainer;
	import com.jumpGame.ui.HUD;
	import com.jumpGame.ui.PauseButton;
	
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.media.SoundMixer;
	import flash.utils.Timer;
	import flash.utils.getDefinitionByName;
	import flash.utils.getTimer;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
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
		
		// ------------------------------------------------------------------------------------------------------------
		// GAME PROPERTIES AND DATA
		// ------------------------------------------------------------------------------------------------------------
		
		// Time calculation for animation
		private var gameStartTime:Number;
		private var timeDiffReal:Number;
		private var gameTime:Number;
		private var timeDiffControlled:Number;
		private var speedFactor:Number = 1.0; // game speed multiplier
		private var delayTimer:Timer; // used for delaying game end upon player fail
		
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
		public static var particleLeaf:PDParticleSystem;
		
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
		private var startButton:starling.display.Button;
		
		/** Tween object for game over container. */
		private var tween_gameOverContainer:Tween;
		
		// ------------------------------------------------------------------------------------------------------------
		// LEVEL PARSING AND GENERATION
		// ------------------------------------------------------------------------------------------------------------
		
		private var levelParser:LevelParser;
		
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
			
			// draw particles
			if (this.isHardwareRendering) {
				particleLeaf = new PDParticleSystem(XML(new ParticleAssets.ParticleLeafXML()), Texture.fromBitmap(new ParticleAssets.ParticleLeafTexture()));
				Starling.juggler.add(particleLeaf);
				
				this.addChild(particleLeaf);
			}
			
			// pause button.
			pauseButton = new PauseButton();
			pauseButton.x = pauseButton.width * 2;
			pauseButton.y = pauseButton.height * 0.5;
			pauseButton.addEventListener(Event.TRIGGERED, onPauseButtonClick);
			this.addChild(pauseButton);
			
			// start button.
			startButton = new starling.display.Button(Assets.getAtlas().getTexture("startButton"));
			startButton.fontColor = 0xffffff;
			startButton.x = stage.stageWidth/2 - startButton.width/2;
			startButton.y = stage.stageHeight/2 - startButton.height/2;
			startButton.addEventListener(Event.TRIGGERED, onStartButtonClick);
			this.addChild(startButton);
			
			// initialize the platforms vector
			this.platformsList = new Vector.<Platform>();
			this.platformsListLength = 0;
			
			// initialize the particles vector
			this.particlesList = new Vector.<Particle>();
			this.particlesListLength = 0;
			
			// create platform pools
			ObjectPool.instance.registerPool(PlatformNormal, 10, true);
			ObjectPool.instance.registerPool(PlatformMobile, 10, true);
			ObjectPool.instance.registerPool(PlatformDrop, 10, true);
			ObjectPool.instance.registerPool(PlatformNormalBoost, 10, true);
			ObjectPool.instance.registerPool(PlatformPower, 5, true);
			ObjectPool.instance.registerPool(PlatformSuper, 5, true);
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
			
			// Pause the background animation too.
			//bg.gamePaused = gamePaused;
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
			gameOverContainer.addEventListener(NavigationEvent.CHANGE_SCREEN, playAgain);
			gameOverContainer.visible = false;
			this.addChild(gameOverContainer);
		}
		
		public function initialize():void
		{
			// populate stage from level file
			this.levelParser = new LevelParser();
			
			// play background music
			if (!Sounds.muted) Sounds.playBgm();
			
			// hide the pause button since the game isn't started yet.
			pauseButton.visible = false;
			
			// show start button.
			startButton.visible = true;
			
			// populate stage from level file
			//this.level.populateStage(this);
			
			// reset scores
			hud.distance = 0;
		}
		
		/**
		 * Play again, when clicked on play again button in Game Over screen. 
		 * 
		 */
		private function playAgain(event:NavigationEvent):void
		{
			if (event.params.id == "playAgain") 
			{
				tween_gameOverContainer = new Tween(gameOverContainer, 1);
				tween_gameOverContainer.fadeTo(0);
				tween_gameOverContainer.onComplete = gameOverFadedOut;
				Starling.juggler.add(tween_gameOverContainer);
			}
		}
		
		/**
		 * On game over screen faded out. 
		 * 
		 */
		private function gameOverFadedOut():void
		{
			gameOverContainer.visible = false;
			initialize();
		}
		
		/**
		 * On start button click. 
		 * @param event
		 * 
		 */
		private function onStartButtonClick(event:Event):void
		{
			// Hide start button.
			startButton.visible = false;
			
			// Show pause button since the game is started.
			pauseButton.visible = true;
			
			// show hero
			this.hero.visible = true;
			
			// Touch interaction
			//this.addEventListener(TouchEvent.TOUCH, onTouch);
			
			// keyboard interaction
			Starling.current.nativeOverlay.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressedDown);
			Starling.current.nativeOverlay.stage.addEventListener(KeyboardEvent.KEY_UP, keyPressedUp);
			
			// Game tick
			this.addEventListener(Event.ENTER_FRAME, onGameTick);
			
			// start game timer
			this.gameStartTime = getTimer();
			this.gameTime = 0;
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
					this.hero.triggerSpecialAbility();
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
		
		/**
		 * Game Tick - every frame of the game.
		 * @param event
		 * 
		 */
		private function onGameTick(event:Event):void
		{
			// update game time
			var timeCurrent:int = getTimer() - this.gameStartTime;
			this.timeDiffReal = timeCurrent - this.gameTime;
			this.gameTime = timeCurrent;
			this.timeDiffControlled = this.timeDiffReal * this.speedFactor;
			
			if (gamePaused) {
				return;
			}
			
			// adjust hero vertical speed for gravity
			this.hero.dy -= Constants.Gravity * this.timeDiffControlled;
			if (this.hero.dy < Constants.MaxHeroFallVelocity) {
				this.hero.dy = Constants.MaxHeroFallVelocity;
			}
			
			// handle left and right arrow key input
			if (this.playerControl) {
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
			}
			
			// move camera
			Camera.update(this.hero.gy);
			
			// move hero
			this.hero.gx += this.timeDiffControlled * this.hero.dx;
			this.hero.gy += this.timeDiffControlled * this.hero.dy;
			
			// update max climb distance
			if (this.hero.gy > this.maxDist) {
				this.maxDist = this.hero.gy;
			}
			
			this.scrollElements();
			
			// sea of fire
			if (Constants.SofEnabled) {
				// scroll sea of fire vertically
				this.bg.scrollSofVertical(this.timeDiffControlled, this.hero.gy);
				this.fg.scrollSofVertical(this.timeDiffControlled, this.hero.gy);
				
				// scroll sea of fire horizontally
				this.bg.scrollSofHorizontal();
				this.fg.scrollSofHorizontal();
			}
			
			// animate stage elements
			for (var i:uint = 0; i < this.platformsListLength; i++) {
				// do the following if player has not yet lost
				if (this.checkWinLose) {
					// detect hero/platform collisions
					//if (this.hero.bounds.intersects(this.platformsList[i].bounds)) {
					if (this.platformsList[i].bounds.contains(this.hero.x - 10, this.hero.y + 20) ||
						this.platformsList[i].bounds.contains(this.hero.x + 10, this.hero.y + 20)) {
						if (this.hero.dy < 0) {
							this.hero.bounce(this.platformsList[i].getBouncePower());
							this.platformsList[i].contact();
							particleLeaf.start(0.1); // play particle effect
						}
					}
				}
			}
			
			// If hardware rendering, set the particle emitter's x and y.
			if (isHardwareRendering)
			{
				particleLeaf.emitterX = hero.x;
				particleLeaf.emitterY = hero.y;
			}
			
			// we lose if we fall
			if (Constants.SofEnabled) {
				if (this.checkWinLose && this.hero.gy < this.fg.sofHeight) {
					this.playerFail();
					return;
				}
			} else {
				if (this.checkWinLose && hero.gy < Camera.gy - Constants.StageHeight / 2) {
					this.playerFail();
					return;
				}
			}
			
			// update hud
			hud.distance = Math.round(this.maxDist);
		}
		
		/**
		 * Player fails, check to see if saves are available
		 */
		private function playerFail():void {
			this.hero.playFailAnimation();
			this.hud.showMessage("OH NOES...");
			
			// stop checking win/lose condition
			this.checkWinLose = false;
			
			// revoke player control of hero
			this.playerControl = false;
			
			// stop sounds
			SoundMixer.stopAll();
			Sounds.sndScratch.play();
			
			// show on screen message
			//this.showMessage("You Lose");
			
			// call endGame() after a brief delay
			this.delayTimer = new Timer(3000, 1);
			this.delayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, endGame);
			this.delayTimer.start();
		}
		
		/**
		 * Clean up the stage and end game
		 */
		public function endGame(event:TimerEvent):void {
			if (event != null) {
				this.delayTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, endGame);
			}
			
			// remove event listeners
			Starling.current.nativeOverlay.stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyPressedDown);
			Starling.current.nativeOverlay.stage.removeEventListener(KeyboardEvent.KEY_UP, keyPressedUp);
			this.removeEventListener(Event.ENTER_FRAME, onGameTick);
			
			// clean up platforms
			for(var i:uint = 0; i < this.platformsListLength; i++)
			{
				if (this.platformsList[i] != null)
				{
					this.returnPlatformToPool(i);
				}
			}
			
			this.removeChild(this.hero);
			this.hero = null;
			
			this.setChildIndex(gameOverContainer, this.numChildren - 1);
			gameOverContainer.initialize(this.maxDist, this.maxDist);
		}
		
		/**
		 * Scroll all of the rainbows downward
		 */
		public function scrollElements():void {
			// scroll platforms
			for (var i:uint = 0; i < this.platformsListLength; i++) {
				this.platformsList[i].update(this.timeDiffControlled);
				
				// remove a rainbow if it has scrolled below sea of fire
				if (this.platformsList[i].gy < this.fg.sofHeight) {
					this.returnPlatformToPool(i);
				}
			}
			
			// scroll background and foreground layers
			this.bg.scroll();
			this.fg.scroll();
			
			// populate area above visible stage with next elements in level elements array
			while (this.levelParser.levelElementsArray.length > 0 && this.levelParser.levelElementsArray[0][0] < this.hero.gy + Constants.StageHeight) {
				var levelElement:Array = this.levelParser.levelElementsArray[0];
				this.addElementFromPool(levelElement[0], levelElement[1], levelElement[2], levelElement[3]);
				this.levelParser.levelElementsArray.splice(0, 1);
				this.setChildIndex(this.platformsList[(uint)(this.platformsList.length) - 1], this.getChildIndex(this.hero)); // push newly added element behind hero
			}
		}
		
		/**
		 * Add an element to the stage
		 */
		private function addElementFromPool(y:Number, x:Number, elementClassName:String, elementSize:int):void {
			var elementClass:Class = getDefinitionByName("com.jumpGame.gameElements.platforms." + elementClassName) as Class;
			var tempElement:Platform = ObjectPool.instance.getObj(elementClass) as elementClass;
			tempElement.initialize(elementSize);
			tempElement.gx = x;
			tempElement.gy = y;
			this.addChild(tempElement);
			this.platformsList[platformsListLength++] = tempElement;
		}
		
		/**
		 * Dispose the platform temporarily. Check-in into pool (will get cleaned) and reduce the vector length by 1
		 * @param arrayIndex
		 * @param platform
		 */
		private function returnPlatformToPool(platformIndex:Number):void
		{
			var platform:Platform = this.platformsList[platformIndex];
			platformsList.splice(platformIndex, 1);
			platformsListLength--;
			ObjectPool.instance.returnObj(platform);
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