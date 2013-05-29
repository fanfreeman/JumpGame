package com.jumpGame.screens
{
	import com.jumpGame.events.NavigationEvent;
	import com.jumpGame.gameElements.Hero;
	import com.jumpGame.gameElements.Platform;
	import com.jumpGame.objectPools.PoolParticle;
	import com.jumpGame.objectPools.PoolPlatform;
	import com.jumpGame.ui.GameOverContainer;
	import com.jumpGame.ui.HUD;
	import com.jumpGame.ui.PauseButton;
	
	import flash.media.SoundMixer;
	import flash.utils.getTimer;
	
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2World;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import com.jumpGame.builders.PhysicsBuilder;
	
	public class InGame extends Sprite
	{
		/** Game background object. */
		//private var bg:GameBackground;
		
		/** Hero character. */		
		private var hero:Hero;
		
		/** Time calculation for animation. */
		private var gameStartTime:Number;
		private var timeDiffReal:Number;
		private var gameTime:Number;
		private var timeDiffControlled:Number;
		private var speedFactor:Number = 1.0;
		
		// ------------------------------------------------------------------------------------------------------------
		// GAME INTERACTION 
		// ------------------------------------------------------------------------------------------------------------
		
		/** Is game rendering through hardware or software? */
		private var isHardwareRendering:Boolean;
		
		/** Is game currently in paused state? */
		private var gamePaused:Boolean = false;
		
		/** Obstacles pool with a maximum cap for reuse of items. */		
		private var platformsPool:PoolPlatform;
		
		/** Bounce Particles pool with a maximum cap for reuse of items. */		
		private var bounceParticlesPool:PoolParticle;
		
		/** Wind Particles pool with a maximum cap for reuse of items. */		
		private var windParticlesPool:PoolParticle;
		
		// ------------------------------------------------------------------------------------------------------------
		// ANIMATION
		// ------------------------------------------------------------------------------------------------------------
		
		/** platforms to animate. */
		private var platformsList:Vector.<Platform>;
		
		/** platforms to animate - array length. */		
		private var platformsListLength:uint = 0;
		
		// ------------------------------------------------------------------------------------------------------------
		// PHYSICS
		// ------------------------------------------------------------------------------------------------------------
		
		private var world:b2World;
		private var bodyDef:b2BodyDef;
		
		private var builder:PhysicsBuilder;
		
		private var physicsDebug:PhysicsDebug;
		
		// ------------------------------------------------------------------------------------------------------------
		// USER CONTROL
		// ------------------------------------------------------------------------------------------------------------
		
		
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
		private var startButton:Button;
		
		/** Tween object for game over container. */
		private var tween_gameOverContainer:Tween;
		
		// ------------------------------------------------------------------------------------------------------------
		// METHODS
		// ------------------------------------------------------------------------------------------------------------

		public function InGame()
		{
			super();
			
			isHardwareRendering = Starling.context.driverInfo.toLowerCase().indexOf("software") == -1;
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
		}
		
		/**
		 * Draw game elements - background, hero, particles, pause button, start button and platforms (in pool).
		 */
		private function drawGame():void
		{
			// draw background
			
			
			
			// pause button.
			pauseButton = new PauseButton();
			pauseButton.x = pauseButton.width * 2;
			pauseButton.y = pauseButton.height * 0.5;
			pauseButton.addEventListener(Event.TRIGGERED, onPauseButtonClick);
			this.addChild(pauseButton);
			
			// start button.
			startButton = new Button(Assets.getAtlas().getTexture("startButton"));
			startButton.fontColor = 0xffffff;
			startButton.x = stage.stageWidth/2 - startButton.width/2;
			startButton.y = stage.stageHeight/2 - startButton.height/2;
			startButton.addEventListener(Event.TRIGGERED, onStartButtonClick);
			this.addChild(startButton);
			
			// Initialize platforms vector
			platformsList = new Vector.<Platform>();
			platformsListLength = 0;
			
			//createPlatformsPool();
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
			// dispose screen temporarily.
			disposeTemporarily();
			
			this.visible = true;
			
			// calculate elapsed time.
			this.addEventListener(Event.ENTER_FRAME, calculateElapsed);
			
			// play screen background music.
			//if (!Sounds.muted) Sounds.sndBgGame.play(0, 999);
			
			// reset game time
			this.gameStartTime = getTimer();
			this.gameTime = 0;
			
			// hide the pause button since the game isn't started yet.
			pauseButton.visible = false;
			
			// show start button.
			startButton.visible = true;
			
			
			
			
			
			
			// get current level and populate stage elements
			//this.level = new Level(MovieClip(root).level);
			
			// create background
			//this.bg = new Background(this, this.level.target);
			
			// populate stage from level file
			//this.level.populateStage(this);
			
			// create sound control object
			//this.soundControl = new SoundControl();
			//this.soundControl.playBgm();
			
			// set original mouse position
			//this.startingMouseX = mouseX;
			
			
			
			
			
			// create physics world
			var gravity:b2Vec2 = new b2Vec2(0.0, -10.0);
			this.world = new b2World(gravity, true);
			this.builder = new PhysicsBuilder(this.world); // physics object builder
			
			// Box2d debug draw
			this.physicsDebug = new PhysicsDebug();
			this.world.SetDebugDraw(this.physicsDebug.debugDraw);
			Starling.current.nativeOverlay.addChild(this.physicsDebug);
			
			// set up platform
			var platform:Platform = this.platformCreate()
			this.platformsList.push(platform);
			platformsListLength++;
			platform.visible = false;
			// create platform body
			trace(platform.width * Constants.PX_TO_M);
			trace(platform.height * Constants.PX_TO_M);
			this.builder.setDimensions(Constants.SHAPE_BOX, platform.width * Constants.PX_TO_M, platform.height * Constants.PX_TO_M);
			this.builder.isStatic = true;
			platform.body = builder.build(platform, 0, -1);
			
			// set up hero
			hero = new Hero(this.world);
			this.addChild(hero);
			this.hero.visible = false;
			builder.setDimensions(Constants.SHAPE_CIRCLE, this.hero.width * Constants.PX_TO_M);
			this.hero.body = builder.build(this.hero, 0, 0);
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
			this.platformsList[0].visible = true;
			// Touch interaction
			//this.addEventListener(TouchEvent.TOUCH, onTouch);
			
			// Game tick
			this.addEventListener(Event.ENTER_FRAME, onGameTick);
		}
		
		/**
		 * Game Tick - every frame of the game.
		 * @param event
		 * 
		 */
		private function onGameTick(event:Event):void
		{
			if (!gamePaused)
			{
				this.world.Step(1.0/60.0, 10, 10);
				this.world.ClearForces();
				
				// go through body list and update sprite positions
				for (var bb:b2Body = this.world.GetBodyList(); bb; bb = bb.GetNext()) {
					if (bb.GetUserData() is GameObject) {
						var sprite:GameObject = bb.GetUserData() as GameObject;
						sprite.setX(bb.GetPosition().x);
						sprite.setY(bb.GetPosition().y);
						sprite.rotation = bb.GetAngle();
					}
				}
				
				this.world.DrawDebugData();
			}
		}
		
		/**
		 * Create platforms pool by passing the create and clean methods/functions to the Pool.  
		 * 
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
		private function createPlatform(_type:int = 1, _distance:Number = 0):void
		{
			// create a new platform
			var platform:Platform = platformsPool.checkOut();
			//platform.type = _type;
			//platform.distance = _distance;
			platform.x = stage.stageWidth;
			platformsList[platformsListLength++] = platform;
		}
		
		private function disposeTemporarily():void
		{
			SoundMixer.stopAll();
			
			gameOverContainer.visible = false;
			
			if (this.hasEventListener(Event.ENTER_FRAME)) this.removeEventListener(Event.ENTER_FRAME, calculateElapsed);
			
			//if (this.hasEventListener(TouchEvent.TOUCH)) this.removeEventListener(TouchEvent.TOUCH, onTouch);
			
			//if (this.hasEventListener(Event.ENTER_FRAME)) this.removeEventListener(Event.ENTER_FRAME, onGameTick);
		}
		
		/**
		 * Calculate elapsed time. 
		 * @param event
		 * 
		 */
		private function calculateElapsed(event:Event):void
		{
			var timeCurrent:int = getTimer() - this.gameStartTime;
			this.timeDiffReal = timeCurrent - this.gameTime;
			this.gameTime = timeCurrent;
			this.timeDiffControlled = this.timeDiffReal * this.speedFactor;
		}
	}
}