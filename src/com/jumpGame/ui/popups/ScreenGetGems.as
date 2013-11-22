package com.jumpGame.ui.popups
{
	import com.jumpGame.customObjects.Font;
	import com.jumpGame.events.NavigationEvent;
	import com.jumpGame.level.Statics;
	import com.jumpGame.screens.Menu;
	
	import flash.external.ExternalInterface;
	
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
	
	public class ScreenGetGems extends Sprite
	{
		private var parent:Menu;
//		private var gemHandfulListItem:GetCoinListItem;
//		private var gemPouchListItem:GetCoinListItem;
//		private var gemSackListItem:GetCoinListItem;
//		private var gemBoxListItem:GetCoinListItem;
//		private var gemChestListItem:GetCoinListItem;
//		private var gemTruckloadListItem:GetCoinListItem;
		
		private var popupContainer:Sprite;
		
		public function ScreenGetGems(parent:Menu)
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
			var popup:Image = new Image(Assets.getSprite("AtlasTexture8").getTexture("GetGemsBg0000"));
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
			buttonClose.x = popup.bounds.right - 23;
			buttonClose.y = popup.bounds.top + 25;
			
			// create gem pack list items
//			// handful
//			var gemHandfulData:Object = new Object();
//			gemHandfulData.title = "Handful of Gems";
//			gemHandfulData.subtitle = "20 Gems";
//			gemHandfulData.price = "$1.99";
//			gemHandfulData.handler = purchaseGemHandfulHandler;
//			
//			// pouch
//			var gemPouchData:Object = new Object();
//			gemPouchData.title = "Pouch of Gems";
//			gemPouchData.subtitle = "55 Gems";
//			gemPouchData.price = "$4.99";
//			gemPouchData.handler = purchaseGemPouchHandler;
//			
//			// sack
//			var gemSackData:Object = new Object();
//			gemSackData.title = "Sack of Gems";
//			gemSackData.subtitle = "115 Gems";
//			gemSackData.price = "$9.99";
//			gemSackData.handler = purchaseGemSackHandler;
//			
//			// box
//			var gemBoxData:Object = new Object();
//			gemBoxData.title = "Box of Gems";
//			gemBoxData.subtitle = "240 Gems";
//			gemBoxData.price = "$19.99";
//			gemBoxData.handler = purchaseGemBoxHandler;
//			
//			// chest
//			var gemChestData:Object = new Object();
//			gemChestData.title = "Chest of Gems";
//			gemChestData.subtitle = "625 Gems";
//			gemChestData.price = "$49.99";
//			gemChestData.handler = purchaseGemChestHandler;
//			
//			// truckload
//			var gemTruckloadData:Object = new Object();
//			gemTruckloadData.title = "Truckload of Gems";
//			gemTruckloadData.subtitle = "1300 Gems";
//			gemTruckloadData.price = "$99.99";
//			gemTruckloadData.handler = purchaseGemTruckloadHandler;
			
			var valueFieldsHeight:Number = 300;
			var priceFieldsHeight:Number = 338;
			var buyButtonsHeight:Number = 384;
			
			var font:Font = Fonts.getFont("Materhorn24White");
			var fontValue:Font = Fonts.getFont("Materhorn15White");
			// handful
			// product value field
			var valueField1:TextField = new TextField(75, 35, "20 Gems", fontValue.fontName, fontValue.fontSize, 0xe1f9ff);
			valueField1.pivotX = Math.ceil(valueField1.width / 2);
			valueField1.vAlign = VAlign.CENTER;
			valueField1.hAlign = HAlign.CENTER;
			valueField1.x = 106;
			valueField1.y = valueFieldsHeight;
			popupContainer.addChild(valueField1);
			// product price field
			var priceField1:TextField = new TextField(75, 35, "$1.99", font.fontName, font.fontSize, 0x4e0693);
			priceField1.pivotX = Math.ceil(priceField1.width / 2);
			priceField1.vAlign = VAlign.CENTER;
			priceField1.hAlign = HAlign.CENTER;
			priceField1.x = 106;
			priceField1.y = priceFieldsHeight;
			popupContainer.addChild(priceField1);
			// buy button
			var buttonBuy1:Button = new Button();
			buttonBuy1.defaultSkin = new Image(Assets.getSprite("AtlasTexture8").getTexture("GetGemsBtnBuy0000"));
			buttonBuy1.hoverSkin = new Image(Assets.getSprite("AtlasTexture8").getTexture("GetGemsBtnBuy0000"));
			buttonBuy1.downSkin = new Image(Assets.getSprite("AtlasTexture8").getTexture("GetGemsBtnBuy0000"));
			buttonBuy1.hoverSkin.filter = Statics.btnBrightnessFilter;
			buttonBuy1.downSkin.filter = Statics.btnInvertFilter;
			buttonBuy1.useHandCursor = true;
			buttonBuy1.addEventListener(Event.TRIGGERED, purchaseGemHandfulHandler);
			popupContainer.addChild(buttonBuy1);
			buttonBuy1.x = 60;
			buttonBuy1.y = buyButtonsHeight;
			
			// pouch
			// product value field
			var valueField2:TextField = new TextField(75, 35, "55 Gems", fontValue.fontName, fontValue.fontSize, 0xe1f9ff);
			valueField2.pivotX = Math.ceil(valueField2.width / 2);
			valueField2.vAlign = VAlign.CENTER;
			valueField2.hAlign = HAlign.CENTER;
			valueField2.x = 218;
			valueField2.y = valueFieldsHeight;
			popupContainer.addChild(valueField2);
			// product price field
			var priceField2:TextField = new TextField(75, 35, "$4.99", font.fontName, font.fontSize, 0x4e0693);
			priceField2.pivotX = Math.ceil(priceField2.width / 2);
			priceField2.vAlign = VAlign.CENTER;
			priceField2.hAlign = HAlign.CENTER;
			priceField2.x = 218;
			priceField2.y = priceFieldsHeight;
			popupContainer.addChild(priceField2);
			// buy button
			var buttonBuy2:Button = new Button();
			buttonBuy2.defaultSkin = new Image(Assets.getSprite("AtlasTexture8").getTexture("GetGemsBtnBuy0000"));
			buttonBuy2.hoverSkin = new Image(Assets.getSprite("AtlasTexture8").getTexture("GetGemsBtnBuy0000"));
			buttonBuy2.downSkin = new Image(Assets.getSprite("AtlasTexture8").getTexture("GetGemsBtnBuy0000"));
			buttonBuy2.hoverSkin.filter = Statics.btnBrightnessFilter;
			buttonBuy2.downSkin.filter = Statics.btnInvertFilter;
			buttonBuy2.useHandCursor = true;
			buttonBuy2.addEventListener(Event.TRIGGERED, purchaseGemPouchHandler);
			popupContainer.addChild(buttonBuy2);
			buttonBuy2.x = 172;
			buttonBuy2.y = buyButtonsHeight;
			
			// sack
			// product value field
			var valueField3:TextField = new TextField(75, 35, "115 Gems", fontValue.fontName, fontValue.fontSize, 0xe1f9ff);
			valueField3.pivotX = Math.ceil(valueField3.width / 2);
			valueField3.vAlign = VAlign.CENTER;
			valueField3.hAlign = HAlign.CENTER;
			valueField3.x = 330;
			valueField3.y = valueFieldsHeight;
			popupContainer.addChild(valueField3);
			// product price field
			var priceField3:TextField = new TextField(75, 35, "$9.99", font.fontName, font.fontSize, 0x4e0693);
			priceField3.pivotX = Math.ceil(priceField3.width / 2);
			priceField3.vAlign = VAlign.CENTER;
			priceField3.hAlign = HAlign.CENTER;
			priceField3.x = 330;
			priceField3.y = priceFieldsHeight;
			popupContainer.addChild(priceField3);
			// buy button
			var buttonBuy3:Button = new Button();
			buttonBuy3.defaultSkin = new Image(Assets.getSprite("AtlasTexture8").getTexture("GetGemsBtnBuy0000"));
			buttonBuy3.hoverSkin = new Image(Assets.getSprite("AtlasTexture8").getTexture("GetGemsBtnBuy0000"));
			buttonBuy3.downSkin = new Image(Assets.getSprite("AtlasTexture8").getTexture("GetGemsBtnBuy0000"));
			buttonBuy3.hoverSkin.filter = Statics.btnBrightnessFilter;
			buttonBuy3.downSkin.filter = Statics.btnInvertFilter;
			buttonBuy3.useHandCursor = true;
			buttonBuy3.addEventListener(Event.TRIGGERED, purchaseGemSackHandler);
			popupContainer.addChild(buttonBuy3);
			buttonBuy3.x = 284;
			buttonBuy3.y = buyButtonsHeight;
			
			// box
			// product value field
			var valueField4:TextField = new TextField(75, 35, "240 Gems", fontValue.fontName, fontValue.fontSize, 0xe1f9ff);
			valueField4.pivotX = Math.ceil(valueField4.width / 2);
			valueField4.vAlign = VAlign.CENTER;
			valueField4.hAlign = HAlign.CENTER;
			valueField4.x = 443;
			valueField4.y = valueFieldsHeight;
			popupContainer.addChild(valueField4);
			// product price field
			var priceField4:TextField = new TextField(75, 35, "$19.99", font.fontName, font.fontSize, 0x4e0693);
			priceField4.pivotX = Math.ceil(priceField4.width / 2);
			priceField4.vAlign = VAlign.CENTER;
			priceField4.hAlign = HAlign.CENTER;
			priceField4.x = 443;
			priceField4.y = priceFieldsHeight;
			popupContainer.addChild(priceField4);
			// buy button
			var buttonBuy4:Button = new Button();
			buttonBuy4.defaultSkin = new Image(Assets.getSprite("AtlasTexture8").getTexture("GetGemsBtnBuy0000"));
			buttonBuy4.hoverSkin = new Image(Assets.getSprite("AtlasTexture8").getTexture("GetGemsBtnBuy0000"));
			buttonBuy4.downSkin = new Image(Assets.getSprite("AtlasTexture8").getTexture("GetGemsBtnBuy0000"));
			buttonBuy4.hoverSkin.filter = Statics.btnBrightnessFilter;
			buttonBuy4.downSkin.filter = Statics.btnInvertFilter;
			buttonBuy4.useHandCursor = true;
			buttonBuy4.addEventListener(Event.TRIGGERED, purchaseGemBoxHandler);
			popupContainer.addChild(buttonBuy4);
			buttonBuy4.x = 397;
			buttonBuy4.y = buyButtonsHeight;
			
			// chest
			// product value field
			var valueField5:TextField = new TextField(75, 35, "625 Gems", fontValue.fontName, fontValue.fontSize, 0xe1f9ff);
			valueField5.pivotX = Math.ceil(valueField5.width / 2);
			valueField5.vAlign = VAlign.CENTER;
			valueField5.hAlign = HAlign.CENTER;
			valueField5.x = 555;
			valueField5.y = valueFieldsHeight;
			popupContainer.addChild(valueField5);
			// product price field
			var priceField5:TextField = new TextField(75, 35, "$49.99", font.fontName, font.fontSize, 0x4e0693);
			priceField5.pivotX = Math.ceil(priceField5.width / 2);
			priceField5.vAlign = VAlign.CENTER;
			priceField5.hAlign = HAlign.CENTER;
			priceField5.x = 555;
			priceField5.y = priceFieldsHeight;
			popupContainer.addChild(priceField5);
			// buy button
			var buttonBuy5:Button = new Button();
			buttonBuy5.defaultSkin = new Image(Assets.getSprite("AtlasTexture8").getTexture("GetGemsBtnBuy0000"));
			buttonBuy5.hoverSkin = new Image(Assets.getSprite("AtlasTexture8").getTexture("GetGemsBtnBuy0000"));
			buttonBuy5.downSkin = new Image(Assets.getSprite("AtlasTexture8").getTexture("GetGemsBtnBuy0000"));
			buttonBuy5.hoverSkin.filter = Statics.btnBrightnessFilter;
			buttonBuy5.downSkin.filter = Statics.btnInvertFilter;
			buttonBuy5.useHandCursor = true;
			buttonBuy5.addEventListener(Event.TRIGGERED, purchaseGemChestHandler);
			popupContainer.addChild(buttonBuy5);
			buttonBuy5.x = 509;
			buttonBuy5.y = buyButtonsHeight;
			
			// truckload
			// product value field
			var valueField6:TextField = new TextField(75, 35, "1300 Gems", fontValue.fontName, fontValue.fontSize, 0xe1f9ff);
			valueField6.pivotX = Math.ceil(valueField6.width / 2);
			valueField6.vAlign = VAlign.CENTER;
			valueField6.hAlign = HAlign.CENTER;
			valueField6.x = 667;
			valueField6.y = valueFieldsHeight;
			popupContainer.addChild(valueField6);
			// product price field
			var priceField6:TextField = new TextField(75, 35, "$99.99", font.fontName, font.fontSize, 0x4e0693);
			priceField6.pivotX = Math.ceil(priceField6.width / 2);
			priceField6.vAlign = VAlign.CENTER;
			priceField6.hAlign = HAlign.CENTER;
			priceField6.x = 667;
			priceField6.y = priceFieldsHeight;
			popupContainer.addChild(priceField6);
			// buy button
			var buttonBuy6:Button = new Button();
			buttonBuy6.defaultSkin = new Image(Assets.getSprite("AtlasTexture8").getTexture("GetGemsBtnBuy0000"));
			buttonBuy6.hoverSkin = new Image(Assets.getSprite("AtlasTexture8").getTexture("GetGemsBtnBuy0000"));
			buttonBuy6.downSkin = new Image(Assets.getSprite("AtlasTexture8").getTexture("GetGemsBtnBuy0000"));
			buttonBuy6.hoverSkin.filter = Statics.btnBrightnessFilter;
			buttonBuy6.downSkin.filter = Statics.btnInvertFilter;
			buttonBuy6.useHandCursor = true;
			buttonBuy6.addEventListener(Event.TRIGGERED, purchaseGemTruckloadHandler);
			popupContainer.addChild(buttonBuy6);
			buttonBuy6.x = 621;
			buttonBuy6.y = buyButtonsHeight;
		}
		
		public function initialize():void {
			this.visible = true;
			
			// popup pop out effect
			popupContainer.scaleX = 0.5;
			popupContainer.scaleY = 0.5;
			Starling.juggler.tween(popupContainer, 0.5, {
				transition: Transitions.EASE_OUT_ELASTIC,
				scaleX: 1,
				scaleY: 1
			});
		}
		
		public function purchaseGemHandfulHandler(event:Event):void {
			if (!Sounds.sfxMuted) Sounds.sndClick.play();
			
			if(ExternalInterface.available){
				trace("Calling JS...");
				ExternalInterface.call("displayPurchase", "http://www.raiderbear.com/demo/product/gempacks?pack=gems_handful");
				ExternalInterface.addCallback("returnPurchaseStatusToAs", purchaseStatusReturnedFromJs);
			} else {
				trace("External interface unavailabe");
			}
		}
		
		public function purchaseGemPouchHandler(event:Event):void {
			if (!Sounds.sfxMuted) Sounds.sndClick.play();
			
			if(ExternalInterface.available){
				trace("Calling JS...");
				ExternalInterface.call("displayPurchase", "http://www.raiderbear.com/demo/product/gempacks?pack=gems_pouch");
				ExternalInterface.addCallback("returnPurchaseStatusToAs", purchaseStatusReturnedFromJs);
			} else {
				trace("External interface unavailabe");
			}
		}
		
		public function purchaseGemSackHandler(event:Event):void {
			if (!Sounds.sfxMuted) Sounds.sndClick.play();
			
			if(ExternalInterface.available){
				trace("Calling JS...");
				ExternalInterface.call("displayPurchase", "http://www.raiderbear.com/demo/product/gempacks?pack=gems_sack");
				ExternalInterface.addCallback("returnPurchaseStatusToAs", purchaseStatusReturnedFromJs);
			} else {
				trace("External interface unavailabe");
			}
		}
		
		public function purchaseGemBoxHandler(event:Event):void {
			if (!Sounds.sfxMuted) Sounds.sndClick.play();
			
			if(ExternalInterface.available){
				trace("Calling JS...");
				ExternalInterface.call("displayPurchase", "http://www.raiderbear.com/demo/product/gempacks?pack=gems_box");
				ExternalInterface.addCallback("returnPurchaseStatusToAs", purchaseStatusReturnedFromJs);
			} else {
				trace("External interface unavailabe");
			}
		}
		
		public function purchaseGemChestHandler(event:Event):void {
			if (!Sounds.sfxMuted) Sounds.sndClick.play();
			
			if(ExternalInterface.available){
				trace("Calling JS...");
				ExternalInterface.call("displayPurchase", "http://www.raiderbear.com/demo/product/gempacks?pack=gems_chest");
				ExternalInterface.addCallback("returnPurchaseStatusToAs", purchaseStatusReturnedFromJs);
			} else {
				trace("External interface unavailabe");
			}
		}
		
		public function purchaseGemTruckloadHandler(event:Event):void {
			if (!Sounds.sfxMuted) Sounds.sndClick.play();
			
			if(ExternalInterface.available){
				trace("Calling JS...");
				ExternalInterface.call("displayPurchase", "http://www.raiderbear.com/demo/product/gempacks?pack=gems_truckload");
				ExternalInterface.addCallback("returnPurchaseStatusToAs", purchaseStatusReturnedFromJs);
			} else {
				trace("External interface unavailabe");
			}
		}
		
		private function purchaseStatusReturnedFromJs(signedRequest:String, paymentId:String):void {
			var jsonStr:String = JSON.stringify({
				signed_request: signedRequest,
				payment_id: paymentId
			});
			
			parent.displayLoadingNotice("Verifying purchase...");
			parent.communicator.addEventListener(NavigationEvent.RESPONSE_RECEIVED, parent.dataReceived);
			parent.communicator.postVerifyPurchase(jsonStr);
		}
		
		private function buttonCloseHandler(event:Event):void {
			if (!Sounds.sfxMuted) Sounds.sndClick.play();
			
			this.visible = false;
		}
	}
}