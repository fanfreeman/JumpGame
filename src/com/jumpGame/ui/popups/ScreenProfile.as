package com.jumpGame.ui.popups
{
	import com.jumpGame.customObjects.Font;
	import com.jumpGame.level.Statics;
	import com.jumpGame.screens.Menu;
	
	import feathers.controls.Button;
	
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class ScreenProfile extends Sprite
	{
		private var parent:Menu;
		private var popupContainer:Sprite;
		
		private var nameField:TextField;
		private var highScoreField:TextField;
		
		public function ScreenProfile(parent:Menu)
		{
			super();
			this.parent = parent;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			// bg quad
			var bg:Quad = new Quad(stage.stageWidth, stage.stageHeight, 0x000000);
			bg.alpha = 0.5;
			this.addChild(bg);
			
			popupContainer = new Sprite();
			
			// popup artwork
			var popup:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("PopupLarge0000"));
			popupContainer.addChild(popup);
			popupContainer.pivotX = Math.ceil(popupContainer.width / 2);
			popupContainer.pivotY = Math.ceil(popupContainer.height / 2);
			popupContainer.x = Statics.stageWidth / 2;
			popupContainer.y = Statics.stageHeight / 2;
			this.addChild(popupContainer);
			
			// popup header
			var popupHeader:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("PopupHeaderCharacters0000"));
			popupHeader.pivotX = Math.ceil(popupHeader.width / 2);
			popupHeader.x = popupContainer.width / 2;
			popupHeader.y = popup.bounds.top + 26;
			popupContainer.addChild(popupHeader);
			
			// popup close button
			var buttonClose:Button = new Button();
			buttonClose.defaultSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ButtonPopupClose0000"));
			buttonClose.hoverSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ButtonPopupClose0000"));
			buttonClose.downSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ButtonPopupClose0000"));
			buttonClose.hoverSkin.filter = Statics.btnBrightnessFilter;
			buttonClose.downSkin.filter = Statics.btnInvertFilter;
			buttonClose.useHandCursor = true;
			buttonClose.addEventListener(Event.TRIGGERED, buttonCloseHandler);
			popupContainer.addChild(buttonClose);
			buttonClose.validate();
			buttonClose.pivotX = buttonClose.width;
			buttonClose.x = popup.bounds.right - 25;
			buttonClose.y = popup.bounds.top + 28;
			
			var fontLithos42:Font = Fonts.getFont("Lithos42");
			var fontVerdana23:Font = Fonts.getFont("Verdana23");
			
			// player name field
			nameField = new TextField(300, 45, "", fontLithos42.fontName, fontLithos42.fontSize, 0xffdd1e);
			nameField.vAlign = VAlign.TOP;
			nameField.hAlign = HAlign.LEFT;
			nameField.x = 100;
			nameField.y = 100;
			popupContainer.addChild(nameField);
			
			// high score field
			highScoreField = new TextField(400, 40, "", fontVerdana23.fontName, fontVerdana23.fontSize, 0xffffff);
			highScoreField.vAlign = VAlign.TOP;
			highScoreField.hAlign = HAlign.LEFT;
			highScoreField.x = nameField.bounds.left;
			highScoreField.y = nameField.bounds.bottom + 10;
			popupContainer.addChild(highScoreField);
		}
		
		public function initialize(playerData:Object):void {
			this.visible = true;
			nameField.text = playerData.title;
			highScoreField.text = "High Score: " + playerData.caption;
			
			// popup pop out effect
			popupContainer.scaleX = 0.5;
			popupContainer.scaleY = 0.5;
			Starling.juggler.tween(popupContainer, 0.5, {
				transition: Transitions.EASE_OUT_ELASTIC,
				scaleX: 1,
				scaleY: 1
			});
		}
		
		private function buttonCloseHandler(event:Event):void {
			this.visible = false;
		}
	}
}