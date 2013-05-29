package com.jumpGame.gameElements
{
	import Box2D.Dynamics.b2Body;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.events.Event;
	
	public class Platform extends GameObject
	{
		public var body:b2Body;
		
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
			platformArt.x = Math.ceil(-platformArt.width/2); // center art on registration point
			platformArt.y = Math.ceil(-platformArt.height/2);
			starling.core.Starling.juggler.add(platformArt);
			this.addChild(platformArt);
		}
		
		override public function get width():Number
		{
			return platformArt.texture.width;
		}
		
		override public function get height():Number
		{
			return platformArt.texture.height;
		}
	}
}