package com.jumpGame.ui.popups
{
	import com.jumpGame.level.Statics;
	import com.jumpGame.screens.Menu;
	
	import feathers.controls.Button;
	
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class GetLives extends Sprite
	{
		private var parent:Menu;
		private var headerStockUp:Image;
		private var headerOut:Image;
		private var btnAsk:Button;
		private var btnShop:Button;
		private var popupContainer:Sprite;
		
		public function GetLives(parent:Menu)
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
			bg.alpha = 0.2;
			this.addChild(bg);
			
			popupContainer = new Sprite();
			
			// popup artwork
			var popup:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("PopupGetLivesBg0000"));
			popupContainer.addChild(popup);
			popupContainer.pivotX = Math.ceil(popupContainer.width / 2);
			popupContainer.pivotY = Math.ceil(popupContainer.height / 2);
			popupContainer.x = Statics.stageWidth / 2;
			popupContainer.y = Statics.stageHeight / 2;
			this.addChild(popupContainer);
			
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
			buttonClose.x = popup.bounds.right - 26;
			buttonClose.y = popup.bounds.top + 23;
			
			// stock up message
			headerStockUp = new Image(Assets.getSprite("AtlasTexture4").getTexture("PopupGetLivesHeaderStock0000"));
			headerStockUp.pivotX = Math.ceil(headerStockUp.width / 2);
			headerStockUp.x = Math.ceil(popupContainer.width / 2);
			headerStockUp.y = 56;
			popupContainer.addChild(headerStockUp);
			
			// out of lives message
			headerOut = new Image(Assets.getSprite("AtlasTexture4").getTexture("PopupGetLivesHeaderOut0000"));
			headerOut.pivotX = Math.ceil(headerOut.width / 2);
			headerOut.x = Math.ceil(popupContainer.width / 2);
			headerOut.y = 56;
			headerOut.visible = false;
			popupContainer.addChild(headerOut);
			
			// buy with gems button
			btnShop = new Button();
			btnShop.defaultSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("PopupGetLivesBtnShop0000"));
			btnShop.hoverSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("PopupGetLivesBtnShop0000"));
			btnShop.downSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("PopupGetLivesBtnShop0000"));
			btnShop.hoverSkin.filter = Statics.btnBrightnessFilter;
			btnShop.downSkin.filter = Statics.btnInvertFilter;
			btnShop.useHandCursor = true;
			btnShop.x = 78;
			btnShop.y = 263;
			btnShop.addEventListener(Event.TRIGGERED, buttonShopHandler);
			popupContainer.addChild(btnShop);
			
			// ask friends button
			btnAsk = new Button();
			btnAsk.defaultSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("PopupGetLivesBtnAsk0000"));
			btnAsk.hoverSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("PopupGetLivesBtnAsk0000"));
			btnAsk.downSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("PopupGetLivesBtnAsk0000"));
			btnAsk.hoverSkin.filter = Statics.btnBrightnessFilter;
			btnAsk.downSkin.filter = Statics.btnInvertFilter;
			btnAsk.useHandCursor = true;
			btnAsk.x = popupContainer.width - 223;
			btnAsk.y = 263;
			btnAsk.addEventListener(Event.TRIGGERED, buttonAskHandler);
			popupContainer.addChild(btnAsk);
		}
		
		public function show(isOut:Boolean = false):void {
			this.visible = true;
			if (isOut) {
				this.headerOut.visible = true;
				this.headerStockUp.visible = false;
			} else {
				this.headerStockUp.visible = true;
				this.headerOut.visible = false;
			}
			
			// popup pop out effect
			popupContainer.scaleX = 0.5;
			popupContainer.scaleY = 0.5;
			Starling.juggler.tween(popupContainer, 0.5, {
				transition: Transitions.EASE_OUT_ELASTIC,
				scaleX: 1,
				scaleY: 1
			});
		}
		
		private function buttonShopHandler(event:Event):void {
			if (!Sounds.sfxMuted) Sounds.sndClick.play();
			
			this.visible = false;
			Menu(parent).showBuyLivesDialog();
		}
		
		private function buttonAskHandler(event:Event):void {
			if (!Sounds.sfxMuted) Sounds.sndClick.play();
			
			this.visible = false;
			Menu(parent).showAskFriendsForLives();
		}
		
		private function buttonCloseHandler(event:Event):void {
			if (!Sounds.sfxMuted) Sounds.sndClick.play();
			
			this.visible = false;
		}
	}
}