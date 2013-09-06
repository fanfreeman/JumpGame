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
			super(Texture.fromBitmapData(new BitmapData(Assets.getSprite("AtlasTexture2").getTexture("BtnPause0000").width, Assets.getSprite("AtlasTexture2").getTexture("BtnPause0000").height, true, 0)));
			
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
			pauseImage = new Image(Assets.getSprite("AtlasTexture2").getTexture("BtnPause0000"));
			this.addChild(pauseImage);
		}
	}
}