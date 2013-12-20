package com.jumpGame.ui.popups
{
	import com.jumpGame.customObjects.Font;
	
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class PurchaseStatus extends Sprite
	{
		private var popupContainer:Sprite;
		private var statusText:TextField;
		
		public function PurchaseStatus()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.visible = false;
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			popupContainer = new Sprite();
			
			// popup artwork
			var popup:Image = new Image(Assets.getSprite("AtlasTexture8").getTexture("PurchaseStatusBg0000"));
			popupContainer.addChild(popup);
			popupContainer.pivotX = Math.ceil(popupContainer.width / 2);
			popupContainer.pivotY = Math.ceil(popupContainer.height / 2);
			popupContainer.x = Statics.stageWidth / 2;
			popupContainer.y = Statics.stageHeight / 2;
			this.addChild(popupContainer);
			
			// status text
			var fontStatus:Font = Fonts.getFont("BellGothicBlack25");
			statusText = new TextField(240, 40, "Purchase Successful", fontStatus.fontName, fontStatus.fontSize, 0xffffff);
			statusText.pivotX = statusText.width / 2;
			statusText.pivotY = statusText.height / 2;
			statusText.vAlign = VAlign.CENTER;
			statusText.hAlign = HAlign.CENTER;
			statusText.x = Math.ceil(popup.width / 2);
			statusText.y = Math.ceil(popup.height / 2) - 5;
			popupContainer.addChild(statusText);
		}
		
		public function show():void {
			popupContainer.alpha = 1;
			this.visible = true;
			
			if (!Sounds.sfxMuted) Sounds.sndClick.play();
			
			// popup pop out effect
			popupContainer.scaleX = 0.5;
			popupContainer.scaleY = 0.5;
			Starling.juggler.removeTweens(popupContainer);
			Starling.juggler.tween(popupContainer, 0.5, {
				transition: Transitions.EASE_OUT_ELASTIC,
				scaleX: 1,
				scaleY: 1
			});
			
			Starling.juggler.delayCall(fadeThisOut, 2);
		}
		
		private function fadeThisOut():void {
			Starling.juggler.tween(popupContainer, 0.5, {
				transition: Transitions.LINEAR,
				alpha: 0
			});
			Starling.juggler.delayCall(hideThis, 0.5);
		}
		
		private function hideThis():void {
			this.visible = false;
		}
	}
}
