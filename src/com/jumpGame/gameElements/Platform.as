package com.jumpGame.gameElements
{
	import starling.display.MovieClip;
	import starling.events.Event;
	
	public class Platform extends GameObject
	{
		protected var animations:Vector.<MovieClip>;
		protected var size:int;
		
		public function Platform(size:int)
		{
			super();
			this.size = size;
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
		
		protected function createPlatformArt():void{}
		
		public function contact():void {
			// play sound effect
			var temp:Number = Math.random() * 3;
			if (temp < 1) {
				Sounds.sndBounce1.play();
			} else if (temp >= 1 && temp < 2) {
				Sounds.sndBounce2.play();
			} else if (temp >= 2 && temp < 3) {
				Sounds.sndBounce3.play();
			}
			
			this.animations[0].stop();
			this.animations[0].play();
		}
		
		public function getBouncePower():Number {
			return Constants.NormalBouncePower;
		}
		
		public function update(timeDiff:Number):void {
			this.gx = this.gx;
			this.gy = this.gy;
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