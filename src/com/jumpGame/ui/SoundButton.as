package com.jumpGame.ui
{
	import flash.display.BitmapData;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.events.Event;
	import starling.textures.Texture;
	
	/**
	 * This class is the sound/mute button.
	 */
	public class SoundButton extends Button
	{
		/** Animation shown when sound is playing.  */
		private var mcUnmuteState:MovieClip;
		
		/** Image shown when the sound is muted. */
		private var imageMuteState:Image;
		
		public function SoundButton()
		{
			super(Texture.fromBitmapData(new BitmapData(Assets.getSprite("AtlasTexture4").getTexture("BtnSoundOff0000").width, Assets.getSprite("AtlasTexture4").getTexture("BtnSoundOff0000").height, true, 0)));
			
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
			
			setButtonTextures();
			showUnmuteState();
		}
		
		/**
		 * Set textures for button states. 
		 * 
		 */
		private function setButtonTextures():void
		{
			// Normal state - image
			mcUnmuteState = new MovieClip(Assets.getSprite("AtlasTexture4").getTextures("BtnSoundOn"), 3);
			Starling.juggler.add(mcUnmuteState);
			this.addChild(mcUnmuteState);
			
			// Selected state - animation
			imageMuteState = new Image(Assets.getSprite("AtlasTexture4").getTexture("BtnSoundOff0000"));
			this.addChild(imageMuteState);
		}
		
		/**
		 * Show Off State - Show the mute symbol (sound is muted). 
		 * 
		 */
		public function showUnmuteState():void
		{
			mcUnmuteState.visible = true;
			imageMuteState.visible = false;
		}
		
		/**
		 * Show On State - Show the unmute animation (sound is playing). 
		 * 
		 */
		public function showMuteState():void
		{
			mcUnmuteState.visible = false;
			imageMuteState.visible = true;
		}
	}
}