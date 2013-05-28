package com.jumpGame.gameElements
{
	import Box2D.Dynamics.b2Body;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Platform extends Sprite
	{
		public var body:b2Body;
		public var mx:int = 0;
		public var my:int = 0;
		
		private var platformArt:MovieClip;
		
		public function Platform()
		{
			super();
			
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
			createPlatformArt();
		}
		
		private function createPlatformArt():void
		{
			platformArt = new MovieClip(Assets.getSprite("SpriteTexturePlatform").getTextures("PlatformGlowTurnOn"), 12);
			platformArt.x = Math.ceil(-platformArt.width/2);
			platformArt.y = Math.ceil(-platformArt.height/2);
			starling.core.Starling.juggler.add(platformArt);
			this.addChild(platformArt);
		}
		
		public function setX(newX:int):void {
			this.mx = newX;
			this.x = stage.stageWidth / 2 + newX;
		}
		
		public function setY(newY:int):void {
			this.my = newY;
			this.y = stage.stageHeight / 2 - newY;
		}
	}
}