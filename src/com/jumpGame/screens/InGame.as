package com.jumpGame.screens
{
	import com.jumpGame.events.NavigationEvent;
	import com.jumpGame.gameElements.Background;
	import com.jumpGame.gameElements.Hero;
	import com.jumpGame.gameElements.Particle;
	import com.jumpGame.gameElements.Platform;
	import com.jumpGame.gameElements.SeaOfFire;
	import com.jumpGame.gameElements.platforms.PlatformNormal;
	import com.jumpGame.level.LevelParser;
	import com.jumpGame.objectPools.PoolParticle;
	import com.jumpGame.objectPools.PoolPlatform;
	import com.jumpGame.ui.GameOverContainer;
	import com.jumpGame.ui.HUD;
	import com.jumpGame.ui.PauseButton;
	
	import flash.events.KeyboardEvent;
	import flash.external.ExternalInterface;
	import flash.media.SoundMixer;
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
		/** Game background object */
		private var bg:Background;
		
		private var fg:Background; // decorative layer in front of hero's layer
		
		/** Hero character */		
		private var hero:Hero;
		
		/** Time calculation for animation. */
		private var gameStartTime:Number;
		private var timeDiffReal:Number;
		private var gameTime:Number;
		private var timeDiffControlled:Number;
		private var speedFactor:Number = 1.0;
		
		// climb distance
		private var climbDist:Number = 0.0;
		private var maxDist:Number = 0.0;
		
		// ------------------------------------------------------------------------------------------------------------
		// OBJECT POOLING
		// ------------------------------------------------------------------------------------------------------------
		
		/** Obstacles pool with a maximum cap for reuse of items. */		
		private var platformsPool:PoolPlatform;
		
		/** Bounce Particles pool with a maximum cap for reuse of items. */		
		private var bounceParticlesPool:PoolParticle;
		
		/** Wind Particles pool with a maximum cap for reuse of items. */		
		private var windParticlesPool:PoolParticle;
		
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
		// ANIMATION
		// ------------------------------------------------------------------------------------------------------------
		
		/** platforms to animate. */
		private var platformsList:Vector.<Platform>;
		
		/** platforms to animate - array length. */		
		private var platformsListLength:uint = 0;
		
		// particles
		private var particlesList:Vector.<Particle>;
		private var particlesListLength:uint = 0;
		public static var particleLeaf:PDParticleSystem;
		
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
		// LEVEL ELEMENTS
		// ------------------------------------------------------------------------------------------------------------
		
		private var levelParser:LevelParser;
		
		private var seaOfFire:SeaOfFire;
		
		// ------------------------------------------------------------------------------------------------------------
		// COMMUNICATION
		// ------------------------------------------------------------------------------------------------------------
		
		private var communicator:Communicator = null;
		
		// ------------------------------------------------------------------------------------------------------------
		// METHODS
		// ------------------------------------------------------------------------------------------------------------

		public function InGame()
		{
			super();
			
			this.isHardwareRendering = Starling.context.driverInfo.toLowerCase().indexOf("software") == -1;
			trace("Hardware rendering: " + isHardwareRendering);

			this.visible = false;
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
			
			//createPlatformsPool();
			this.seaOfFire = new SeaOfFire();
			this.addChild(this.seaOfFire);
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
			this.addChild(gameOverContainer);
		}
		
		public function initialize():void
		{
			// reset
			disposeTemporarily();
			
			// create background
			this.bg = new Background(Constants.Background);
			this.addChild(this.bg);
			this.setChildIndex(this.bg, 0); // push to back
			
			// populate stage from level file
			this.levelParser = new LevelParser();
			
			this.visible = true;
			
			// play screen background music.
			//if (!Sounds.muted) Sounds.sndBgGame.play(0, 999);
			Sounds.playBgm();
			
			// hide the pause button since the game isn't started yet.
			pauseButton.visible = false;
			
			// show start button.
			startButton.visible = true;
			
			// create background
			//this.bg = new Background(this, this.level.target);
			
			// populate stage from level file
			//this.level.populateStage(this);
			
			// create sound control object
			//this.soundControl = new SoundControl();
			//this.soundControl.playBgm();
			
			// set original mouse position
			//this.startingMouseX = mouseX;
			
			// set up hero
			this.hero = new Hero();
			this.hero.setX(Constants.HERO_INITIAL_X);
			this.hero.setY(Constants.HERO_INITIAL_Y);
			this.addChild(hero);
			this.hero.visible = false;
			this.hero.dy = Constants.HeroInitialVelocityY;
			
			// add sea of fire
//			this.seaOfFire = new SeaOfFire();
//			this.seaOfFire.setX(0);
//			//this.seaOfFire.setY(this.seaOfFireHeight);
//			this.addChild(this.seaOfFire);
//			
//			// add score field
//			this.gameScoreField = new TextField();
//			this.addChild(this.gameScoreField);
//			this.gameScore = 0;
//			this.showGameScore();
//			
//			// add time field
//			this.gameTimeField = new TextField();
//			this.gameTimeField.x = 660;
//			this.addChild(this.gameTimeField);
//			this.gameStartTime = getTimer();
//			this.gameTime = 0;
//			
//			// initial velocity and time
//			this.dx = 0.2;
//			this.dy = 1.8;
//			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressedDown);
//			stage.addEventListener(KeyboardEvent.KEY_UP, keyPressedUp);
//			addEventListener(Event.ENTER_FRAME, animate);
			this.fg = new Background(Constants.Foreground);
			this.addChild(this.fg);
			
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
			// Play coffee sound for button click.
			//if (!Sounds.muted) Sounds.sndCoffee.play();
			
			// Hide start button.
			startButton.visible = false;
			
			// Show pause button since the game is started.
			pauseButton.visible = true;
			
			// Launch hero.
			launchHero();
		}
		
		/**
		 * Launch hero. 
		 * 
		 */
		private function launchHero():void
		{
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
				this.hero.triggerSpecialAbility();
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
			
			// move hero
			this.hero.setX(this.hero.mx + this.timeDiffControlled * this.hero.dx);
			this.hero.setY(this.hero.my + this.timeDiffControlled * this.hero.dy);
			
			// update climb distance
			this.climbDist += this.timeDiffControlled * this.hero.dy;
			if (this.climbDist > this.maxDist) {
				this.maxDist = this.climbDist;
			}
			
			// move everything down on hero moving up
			if (this.hero.my > 0) {
				this.scrollElements(this.hero.my);
				this.hero.setY(0);
			}
			
			// move everything up on hero moving down
			if (this.hero.my < -Constants.ScrollDownThreshold) {
				this.scrollElements(this.hero.my + Constants.ScrollDownThreshold);
				this.hero.setY(-Constants.ScrollDownThreshold);
			}
			
			// scroll sea of fire horizontally
			this.seaOfFire.scrollHorizontal();
			
			// animate stage elements
			for (var i:uint = 0; i < this.platformsListLength; i++) {
				// detect hero/platform collisions
				//if (this.hero.bounds.intersects(this.platformsList[i].bounds)) {
				if (this.platformsList[i].bounds.contains(this.hero.x - 10, this.hero.y + 20) ||
					this.platformsList[i].bounds.contains(this.hero.x + 10, this.hero.y + 20)) {
					if (this.hero.dy < 0) {
						this.hero.bounce();
						this.platformsList[i].contact();
						particleLeaf.start(0.1); // play particle effect
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
			if (this.checkWinLose && hero.my < -1 * Constants.StageHeight / 2) {
			//if (this.checkWinLose && this.climbDist < this.seaOfFireHeight) {
				this.playerFail();
				return;
			}
			
			// update hud
			hud.distance = Math.round(this.maxDist);
		}
		
		/**
		 * Player fails, check to see if saves are available
		 */
		private function playerFail():void {
//			this.soundControl.stopBgm();
//			this.soundControl.playScratch();
//			this.endLevel(false);
		}
		
		/**
		 * Scroll all of the rainbows downward
		 */
		public function scrollElements(distance:Number):void {
			// scroll platforms
			for (var i:uint = 0; i < this.platformsListLength; i++) {
				this.platformsList[i].setY(this.platformsList[i].my - distance);
				
				// remove a rainbow if it has scrolled below sea of fire
				if (this.platformsList[i].my < (-Constants.StageHeight)) {
					//this.removeElement(index);
				}
			}
			
			// scroll background and foreground layers
			this.bg.scroll(distance);
			this.fg.scroll(distance);
			
			// populate area above visible stage with next elements in level elements array
			while (this.levelParser.levelElementsArray.length > 0 && this.levelParser.levelElementsArray[0][0] < this.climbDist + Constants.StageHeight) {
				var levelElement:Array = this.levelParser.levelElementsArray[0];
				this.addElement(levelElement[0] - this.climbDist, levelElement[1], levelElement[2]);
				this.levelParser.levelElementsArray.splice(0, 1);
				this.setChildIndex(this.platformsList[this.platformsList.length - 1], this.getChildIndex(this.hero)); // push newly added element behind hero
			}
		}
		
		/**
		 * Create platforms pool by passing the create and clean methods/functions to the Pool
		 */
		private function createPlatformsPool():void
		{
			platformsPool = new PoolPlatform(platformCreate, platformClean, 20, 50);
		}
		
		/**
		 * Create platform objects and add to display list.
		 * Also called from the Pool class while creating minimum number of objects & run-time objects < maximum number.
		 * @return Platform that was created.
		 * 
		 */
		private function platformCreate():Platform
		{
			var platform:Platform = new Platform();
			platform.setX(-Constants.StageWidth);
			platform.setY(0);
			this.addChild(platform);
			
			return platform;
		}
		
		/**
		 * Clean the platforms before reusing from the pool. Called from the pool. 
		 * @param platform
		 * 
		 */
		private function platformClean(platform:Platform):void
		{
			platform.x = stage.stageWidth + platform.width * 2;
		}
		
		/**
		 * Dispose the platform temporarily. Check-in into pool (will get cleaned) and reduce the vector length by 1. 
		 * @param animateId
		 * @param platform
		 * 
		 */
		private function disposePlatformTemporarily(animateId:uint, platform:Platform):void
		{
			platformsList.splice(animateId, 1);
			platformsListLength--;
			platformsPool.checkIn(platform);
		}
		
		/**
		 * Create the platform object based on the type indicated and make it appear based on the distance passed. 
		 * @param _type
		 * @param _distance
		 * 
		 */
		private function createPlatform():void
		{
			var platform:Platform = this.platformsPool.checkOut();
			platform.setX(0);
			platform.setY(-200);
			this.platformsList[platformsListLength++] = platform;
		}
		
		// add an element to stage
		public function addElement(y:Number, x:Number, elementClassName:String):void {
			switch(elementClassName) {
				case "PlatformNormal":
					var element:Platform = new PlatformNormal();
					break;
			}
			element.setX(x);
			element.setY(y);
			this.addChild(element);
			this.platformsList[platformsListLength++] = element;
		}
		
		private function disposeTemporarily():void
		{
			SoundMixer.stopAll();
			
			gameOverContainer.visible = false;
			
			//if (this.hasEventListener(TouchEvent.TOUCH)) this.removeEventListener(TouchEvent.TOUCH, onTouch);
			
			if (this.hasEventListener(Event.ENTER_FRAME)) this.removeEventListener(Event.ENTER_FRAME, onGameTick);
		}
	}
}