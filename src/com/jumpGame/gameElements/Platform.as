package com.jumpGame.gameElements
{
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.events.Event;
	
	public class Platform extends GameObject
	{
		
		private var animations:Vector.<MovieClip>;
		
		public function Platform()
		{
			super();
			this.animations = new Vector.<MovieClip>();
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
			// turned on state
			var platformArt:MovieClip;
			platformArt = new MovieClip(Assets.getSprite("SpriteTexturePlatform").getTextures("PlatformGlowOn"), 12);
			platformArt.x = Math.ceil(-platformArt.width/2); // center art on registration point
			platformArt.y = Math.ceil(-platformArt.height/2);
			starling.core.Starling.juggler.add(platformArt);
			this.addChild(platformArt);
			this.animations.push(platformArt);
			
			// turning on
			platformArt = new MovieClip(Assets.getSprite("SpriteTexturePlatform").getTextures("PlatformGlowTurnOn"), 12);
			platformArt.x = Math.ceil(-platformArt.width/2); // center art on registration point
			platformArt.y = Math.ceil(-platformArt.height/2);
			starling.core.Starling.juggler.add(platformArt);
			platformArt.visible = false;
			platformArt.loop = false;
			this.addChild(platformArt);
			this.animations.push(platformArt);
			
			// turning off
			platformArt = new MovieClip(Assets.getSprite("SpriteTexturePlatform").getTextures("PlatformGlowTurnOff"), 12);
			platformArt.x = Math.ceil(-platformArt.width/2); // center art on registration point
			platformArt.y = Math.ceil(-platformArt.height/2);
			starling.core.Starling.juggler.add(platformArt);
			platformArt.visible = false;
			platformArt.loop = false;
			this.addChild(platformArt);
			this.animations.push(platformArt);
		}
		
		public function contact():void {
			this.animations[0].visible = false;
			this.animations[2].visible = true; // turning light off animation
			this.animations[2].stop();
			this.animations[2].play();
		}
		
		override public function get width():Number
		{
			return this.animations[0].texture.width;
		}
		
		override public function get height():Number
		{
			return this.animations[0].texture.height;
		}
	}
}