package com.jumpGame.screens
{
	import com.jumpGame.customObjects.Font;
	import com.jumpGame.ui.PauseButton;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class InGameMenu extends Sprite
	{
		public function InGameMenu()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private var pauseButton:PauseButton;
		
		private var messageTextSmall:TextField;
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			// pause button
			pauseButton = new PauseButton();
			pauseButton.x = pauseButton.width * 0.5;
			pauseButton.y = pauseButton.height * 0.5;
			pauseButton.addEventListener(Event.TRIGGERED, onPauseButtonClick);
			this.addChild(pauseButton);
			
			// on screen message small
			var fontMessageSmall:Font = Fonts.getFont("Materhorn25");
			messageTextSmall = new TextField(stage.stageWidth, 30, "", fontMessageSmall.fontName, fontMessageSmall.fontSize, 0xffffff);
			messageTextSmall.hAlign = HAlign.CENTER;
			messageTextSmall.vAlign = VAlign.TOP;
			messageTextSmall.y = stage.stageHeight - messageTextSmall.height;
			this.addChild(messageTextSmall);
		}
		
		public function initialize():void {
			messageTextSmall.visible = false;
		}
		
		public function hidePauseButton():void {
			this.pauseButton.visible = false;
		}
		
		public function showPauseButton():void {
			this.pauseButton.visible = true;
		}
		
		public function showMessageSmall(message:String):void {
			if (!messageTextSmall.visible) {
				messageTextSmall.text = message;
				messageTextSmall.visible = true;
				Starling.juggler.delayCall(hideMessageSmall, 6);
				return;
			}
		}
		
		private function hideMessageSmall():void {
			this.messageTextSmall.visible = false;
		}
		
		/**
		 * On click of pause button
		 */
		private function onPauseButtonClick(event:Event):void {
			event.stopImmediatePropagation();
			
			// pause or unpause the game
			if (Statics.gamePaused) Statics.gamePaused = false;
			else Statics.gamePaused = true;
		}
	}
}