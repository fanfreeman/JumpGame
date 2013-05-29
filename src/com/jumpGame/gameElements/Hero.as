package com.jumpGame.gameElements
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2World;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.events.Event;
	
	/**
	 * This class is the hero character.
	 */
	public class Hero extends GameObject
	{
		/** Hero character animation. */
		private var heroArt:MovieClip;

		public var dx:Number = 0.0;
		public var dy:Number = 0.0;
		private var abilityTimer:Timer;
		private var abilityReady:Boolean = true;
		
		private var world:b2World;
		public var body:b2Body;
		
		public function Hero(world:b2World)
		{
			super();
			this.world = world;
			
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
			
			// hero artwork
			heroArt = new MovieClip(Assets.getSprite("SpriteTextureScarecrow").getTextures("walk.swf/"), 20);
			heroArt.x = Math.ceil(-heroArt.width/2);
			heroArt.y = Math.ceil(-heroArt.height/2);
			starling.core.Starling.juggler.add(heroArt);
			this.addChild(heroArt);
		}
		
		/**
		 * Set hero animation speed. 
		 * @param speed
		 * 
		 */
		public function setHeroAnimationSpeed(speed:int):void {
			if (speed == 0) heroArt.fps = 60;
			else heroArt.fps = 60;
		}
		
		override public function get width():Number
		{
			if (heroArt) return heroArt.texture.width;
			else return NaN;
		}
		
		override public function get height():Number
		{
			if (heroArt) return heroArt.texture.height;
			else return NaN;
		}
		
//		override public function setX(newX:Number):void {
//			// enable left and right border warp
//			if (newX < -1 * stage.stageWidth / 2) {
//				newX += stage.stageWidth;
//			}
//			else if (newX >= stage.stageWidth / 2) {
//				newX -= stage.stageWidth;
//			}
//			
//			this.mx = newX;
//			this.x = stage.stageWidth / 2 + newX;
//		}
		
		public function triggerSpecialAbility():void {
			if (this.abilityReady) {
				// activate ability
				this.dy = 1.5;
				//rgo.soundControl.playBoom();
				
				this.abilityReady = false;
				this.abilityTimer = new Timer(5000, 1);
				this.abilityTimer.addEventListener(TimerEvent.TIMER_COMPLETE, setAbilityReady);
				this.abilityTimer.start();
			}
		}
		
		private function setAbilityReady(event:TimerEvent):void {
			this.abilityTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, setAbilityReady);
			this.abilityReady = true;
			//this.rgo.showMessage("Ability Ready!");
		}
	}
}