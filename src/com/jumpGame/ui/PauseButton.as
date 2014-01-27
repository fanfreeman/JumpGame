package com.jumpGame.ui
{
	import flash.display.BitmapData;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	
	/**
	 * This class is the pause button for the in-game screen.
	 */
	public class PauseButton extends Button
	{
		/** Pause button image. */
		private var pauseImage:Image;
		
		public function PauseButton()
		{
			super(Texture.fromBitmapData(new BitmapData(Statics.assets.getTexture("BtnPause0000").width, Statics.assets.getTexture("BtnPause0000").height, true, 0), false));
			
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
			
			// Pause Image
			pauseImage = new Image(Statics.assets.getTexture("BtnPause0000"));
			this.addChild(pauseImage);
		}
	}
}