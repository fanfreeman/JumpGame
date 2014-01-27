package com.jumpGame.ui.popups
{
	import com.jumpGame.customObjects.Font;
	import com.jumpGame.screens.Menu;
	import com.jumpGame.ui.components.CharacterItemRenderer;
	
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.controls.Scroller;
	import feathers.data.ListCollection;
	
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	import feathers.layout.HorizontalLayout;
	
	public class ScreenCharacters extends Sprite
	{
		private var parent:Menu;
		private var popupContainer:Sprite;
		private var charactersList:List;
		private var charactersCollection:ListCollection;
		
		public function ScreenCharacters(parent:Menu)
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
			var popup:Image = new Image(Statics.assets.getTexture("PopupLarge0000"));
			popupContainer.addChild(popup);
			popupContainer.pivotX = Math.ceil(popupContainer.width / 2);
			popupContainer.pivotY = Math.ceil(popupContainer.height / 2);
			popupContainer.x = Statics.stageWidth / 2;
			popupContainer.y = Statics.stageHeight / 2;
			this.addChild(popupContainer);
			
			// popup header
			var popupHeader:Image = new Image(Statics.assets.getTexture("PopupHeaderCharacters0000"));
			popupHeader.pivotX = Math.ceil(popupHeader.width / 2);
			popupHeader.x = popupContainer.width / 2;
			popupHeader.y = popup.bounds.top + 26;
			popupContainer.addChild(popupHeader);
			
			// popup close button
			var buttonClose:Button = new Button();
			buttonClose.defaultSkin = new Image(Statics.assets.getTexture("ButtonPopupClose0000"));
			buttonClose.hoverSkin = new Image(Statics.assets.getTexture("ButtonPopupClose0000"));
			buttonClose.downSkin = new Image(Statics.assets.getTexture("ButtonPopupClose0000"));
			buttonClose.hoverSkin.filter = Statics.btnBrightnessFilter;
			buttonClose.downSkin.filter = Statics.btnInvertFilter;
			buttonClose.useHandCursor = true;
			buttonClose.addEventListener(Event.TRIGGERED, buttonCloseHandler);
			popupContainer.addChild(buttonClose);
			buttonClose.validate();
			buttonClose.pivotX = buttonClose.width;
			buttonClose.x = popup.bounds.right - 25;
			buttonClose.y = popup.bounds.top + 28;
			
			// list of characters
			var layout:HorizontalLayout = new HorizontalLayout();
			charactersList = new List();
			charactersList.layout = layout;
			charactersList.width = 600;
			charactersList.height = 400;
			charactersList.pivotX = Math.ceil(charactersList.width / 2);
			charactersList.x = popupContainer.width / 2;
			charactersList.y = 100;
			charactersList.verticalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			charactersList.horizontalScrollPolicy = Scroller.SCROLL_POLICY_ON;
			popupContainer.addChild(charactersList);
			charactersList.itemRendererType = CharacterItemRenderer;
			charactersList.itemRendererProperties.nicknameField = "nickname";
			charactersList.itemRendererProperties.levelField = "level";
			charactersList.itemRendererProperties.isnewField = "isnew";
			charactersList.addEventListener(Event.CHANGE, charactersListChangeHandler);
			
			this.populateCharactersList();
		}
		
		private function buttonCloseHandler(event:Event):void {
			if (!Sounds.sfxMuted) Statics.assets.playSound("SND_CLICK");
			
			this.visible = false;
		}
		
		public function initialize():void {
			this.parent.showLargeDialog("Awesome characters are coming soon. We promise!");
			
//			this.visible = true;
//			
//			// popup pop out effect
//			popupContainer.scaleX = 0.5;
//			popupContainer.scaleY = 0.5;
//			Starling.juggler.tween(popupContainer, 0.5, {
//				transition: Transitions.EASE_OUT_ELASTIC,
//				scaleX: 1,
//				scaleY: 1
//			});
		}
		
		private function charactersListChangeHandler(event:Event):void {

		}
		
		private function populateCharactersList():void {
			charactersCollection = new ListCollection();
			
			charactersCollection.addItem({ 
				nickname: "cat", 
				level: 1, 
				isnew: true 
			});
			
			charactersCollection.addItem({ 
				nickname: "prince", 
				level: 1, 
				isnew: true 
			});
			
			charactersCollection.addItem({ 
				nickname: "princess", 
				level: 1, 
				isnew: true 
			});
			
			charactersCollection.addItem({ 
				nickname: "girl", 
				level: 1, 
				isnew: true 
			});
			
			charactersCollection.addItem({ 
				nickname: "boy", 
				level: 1, 
				isnew: true 
			});
			
			charactersList.dataProvider = charactersCollection;
		}
	}
}
