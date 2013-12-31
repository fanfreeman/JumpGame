package com.jumpGame.ui.popups
{
	import com.jumpGame.customObjects.Font;
	import com.jumpGame.events.NavigationEvent;
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
	
	public class ScreenGetCoins extends Sprite
	{
		private var parent:Menu;
//		private var coinBoosterPackListItem:GetCoinListItem;
//		private var coinSuperPackListItem:GetCoinListItem;
//		private var coinMegaPackListItem:GetCoinListItem;
//		private var coinUltraPackListItem:GetCoinListItem;
//		private var coinUltimatePackListItem:GetCoinListItem;
		
		private var popupContainer:Sprite;
		
		public function ScreenGetCoins(parent:Menu)
		{
			super();
			this.parent = parent;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			// bg quad
			var bg:Quad = new Quad(Statics.stageWidth, Statics.stageHeight, 0x000000);
			bg.alpha = 0.5;
			this.addChild(bg);
			
			popupContainer = new Sprite();
			
			// popup artwork
			var popup:Image = new Image(Statics.assets.getTexture("GetCoinsBg0000"));
			popupContainer.addChild(popup);
			popupContainer.pivotX = Math.ceil(popupContainer.width / 2);
			popupContainer.pivotY = Math.ceil(popupContainer.height / 2);
			popupContainer.x = Statics.stageWidth / 2;
			popupContainer.y = Statics.stageHeight / 2;
			this.addChild(popupContainer);
			
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
			buttonClose.x = popup.bounds.right - 24;
			buttonClose.y = popup.bounds.top + 25;
			
			// create coin pack list items
//			// booster pack
//			var coinBoosterPackData:Object = new Object();
//			coinBoosterPackData.title = "Coin Booster Pack";
//			coinBoosterPackData.subtitle = "20000 Coins";
//			coinBoosterPackData.price = 5;
//			coinBoosterPackData.handler = purchaseCoinBoosterPackHandler;
//			
//			// super pack
//			var coinSuperPackData:Object = new Object();
//			coinSuperPackData.title = "Coin Super Pack";
//			coinSuperPackData.subtitle = "55000 Coins";
//			coinSuperPackData.price = 12;
//			coinSuperPackData.handler = purchaseCoinSuperPackHandler;
//			
//			// mega pack
//			var coinMegaPackData:Object = new Object();
//			coinMegaPackData.title = "Coin Mega Pack";
//			coinMegaPackData.subtitle = "230000 Coins";
//			coinMegaPackData.price = 50;
//			coinMegaPackData.handler = purchaseCoinMegaPackHandler;
//			
//			// ultra pack
//			var coinUltraPackData:Object = new Object();
//			coinUltraPackData.title = "Coin Ultra Pack";
//			coinUltraPackData.subtitle = "600000 Coins";
//			coinUltraPackData.price = 120;
//			coinUltraPackData.handler = purchaseCoinUltraPackHandler;
//			
//			// ultimate pack
//			var coinUltimatePackData:Object = new Object();
//			coinUltimatePackData.title = "Coin Ultimate Pack";
//			coinUltimatePackData.subtitle = "1350000 Coins";
//			coinUltimatePackData.price = 240;
//			coinUltimatePackData.handler = purchaseCoinUltimatePackHandler;
			
			var valueFieldsHeight:Number = 298;
			var priceFieldsHeight:Number = 340;
			var buyButtonsHeight:Number = 391;
			
			var font:Font = Fonts.getFont("Materhorn24White");
			var fontValue:Font = Fonts.getFont("Materhorn15White");
			// booster
			// product value field
			var valueField1:TextField = new TextField(75, 35, "20000 Coins", fontValue.fontName, fontValue.fontSize, 0xe1f9ff);
			valueField1.pivotX = Math.ceil(valueField1.width / 2);
			valueField1.vAlign = VAlign.CENTER;
			valueField1.hAlign = HAlign.CENTER;
			valueField1.x = 121;
			valueField1.y = valueFieldsHeight;
			popupContainer.addChild(valueField1);
			// product price field
			var priceField1:TextField = new TextField(75, 35, "5", font.fontName, font.fontSize, 0x4e0693);
			priceField1.pivotX = priceField1.width;
			priceField1.vAlign = VAlign.CENTER;
			priceField1.hAlign = HAlign.RIGHT;
			priceField1.x = 124;
			priceField1.y = priceFieldsHeight;
			popupContainer.addChild(priceField1);
			// buy button
			var buttonBuy1:Button = new Button();
			buttonBuy1.defaultSkin = new Image(Statics.assets.getTexture("GetGemsBtnBuy0000"));
			buttonBuy1.hoverSkin = new Image(Statics.assets.getTexture("GetGemsBtnBuy0000"));
			buttonBuy1.downSkin = new Image(Statics.assets.getTexture("GetGemsBtnBuy0000"));
			buttonBuy1.hoverSkin.filter = Statics.btnBrightnessFilter;
			buttonBuy1.downSkin.filter = Statics.btnInvertFilter;
			buttonBuy1.useHandCursor = true;
			buttonBuy1.addEventListener(Event.TRIGGERED, purchaseCoinBoosterPackHandler);
			popupContainer.addChild(buttonBuy1);
			buttonBuy1.x = 76;
			buttonBuy1.y = buyButtonsHeight;
			
			// super
			// product value field
			var valueField2:TextField = new TextField(75, 35, "55000 Coins", fontValue.fontName, fontValue.fontSize, 0xe1f9ff);
			valueField2.pivotX = Math.ceil(valueField2.width / 2);
			valueField2.vAlign = VAlign.CENTER;
			valueField2.hAlign = HAlign.CENTER;
			valueField2.x = 246;
			valueField2.y = valueFieldsHeight;
			popupContainer.addChild(valueField2);
			// product price field
			var priceField2:TextField = new TextField(75, 35, "12", font.fontName, font.fontSize, 0x4e0693);
			priceField2.pivotX = priceField2.width;
			priceField2.vAlign = VAlign.CENTER;
			priceField2.hAlign = HAlign.RIGHT;
			priceField2.x = 248;
			priceField2.y = priceFieldsHeight;
			popupContainer.addChild(priceField2);
			// buy button
			var buttonBuy2:Button = new Button();
			buttonBuy2.defaultSkin = new Image(Statics.assets.getTexture("GetGemsBtnBuy0000"));
			buttonBuy2.hoverSkin = new Image(Statics.assets.getTexture("GetGemsBtnBuy0000"));
			buttonBuy2.downSkin = new Image(Statics.assets.getTexture("GetGemsBtnBuy0000"));
			buttonBuy2.hoverSkin.filter = Statics.btnBrightnessFilter;
			buttonBuy2.downSkin.filter = Statics.btnInvertFilter;
			buttonBuy2.useHandCursor = true;
			buttonBuy2.addEventListener(Event.TRIGGERED, purchaseCoinSuperPackHandler);
			popupContainer.addChild(buttonBuy2);
			buttonBuy2.x = 200;
			buttonBuy2.y = buyButtonsHeight;
			
			// mega
			// product value field
			var valueField3:TextField = new TextField(75, 35, "230000 Coins", fontValue.fontName, fontValue.fontSize, 0xe1f9ff);
			valueField3.pivotX = Math.ceil(valueField3.width / 2);
			valueField3.vAlign = VAlign.CENTER;
			valueField3.hAlign = HAlign.CENTER;
			valueField3.x = 370;
			valueField3.y = valueFieldsHeight;
			popupContainer.addChild(valueField3);
			// product price field
			var priceField3:TextField = new TextField(75, 35, "50", font.fontName, font.fontSize, 0x4e0693);
			priceField3.pivotX = priceField3.width;
			priceField3.vAlign = VAlign.CENTER;
			priceField3.hAlign = HAlign.RIGHT;
			priceField3.x = 373;
			priceField3.y = priceFieldsHeight;
			popupContainer.addChild(priceField3);
			// buy button
			var buttonBuy3:Button = new Button();
			buttonBuy3.defaultSkin = new Image(Statics.assets.getTexture("GetGemsBtnBuy0000"));
			buttonBuy3.hoverSkin = new Image(Statics.assets.getTexture("GetGemsBtnBuy0000"));
			buttonBuy3.downSkin = new Image(Statics.assets.getTexture("GetGemsBtnBuy0000"));
			buttonBuy3.hoverSkin.filter = Statics.btnBrightnessFilter;
			buttonBuy3.downSkin.filter = Statics.btnInvertFilter;
			buttonBuy3.useHandCursor = true;
			buttonBuy3.addEventListener(Event.TRIGGERED, purchaseCoinMegaPackHandler);
			popupContainer.addChild(buttonBuy3);
			buttonBuy3.x = 324;
			buttonBuy3.y = buyButtonsHeight;
			
			// ultra
			// product value field
			var valueField4:TextField = new TextField(75, 35, "600000 Coins", fontValue.fontName, fontValue.fontSize, 0xe1f9ff);
			valueField4.pivotX = Math.ceil(valueField4.width / 2);
			valueField4.vAlign = VAlign.CENTER;
			valueField4.hAlign = HAlign.CENTER;
			valueField4.x = 494;
			valueField4.y = valueFieldsHeight;
			popupContainer.addChild(valueField4);
			// product price field
			var priceField4:TextField = new TextField(75, 35, "120", font.fontName, font.fontSize, 0x4e0693);
			priceField4.pivotX = priceField4.width;
			priceField4.vAlign = VAlign.CENTER;
			priceField4.hAlign = HAlign.RIGHT;
			priceField4.x = 499;
			priceField4.y = priceFieldsHeight;
			popupContainer.addChild(priceField4);
			// buy button
			var buttonBuy4:Button = new Button();
			buttonBuy4.defaultSkin = new Image(Statics.assets.getTexture("GetGemsBtnBuy0000"));
			buttonBuy4.hoverSkin = new Image(Statics.assets.getTexture("GetGemsBtnBuy0000"));
			buttonBuy4.downSkin = new Image(Statics.assets.getTexture("GetGemsBtnBuy0000"));
			buttonBuy4.hoverSkin.filter = Statics.btnBrightnessFilter;
			buttonBuy4.downSkin.filter = Statics.btnInvertFilter;
			buttonBuy4.useHandCursor = true;
			buttonBuy4.addEventListener(Event.TRIGGERED, purchaseCoinUltraPackHandler);
			popupContainer.addChild(buttonBuy4);
			buttonBuy4.x = 448;
			buttonBuy4.y = buyButtonsHeight;
			
			// ultimate
			// product value field
			var valueField5:TextField = new TextField(75, 35, "1350000 Coins", fontValue.fontName, fontValue.fontSize, 0xe1f9ff);
			valueField5.pivotX = Math.ceil(valueField5.width / 2);
			valueField5.vAlign = VAlign.CENTER;
			valueField5.hAlign = HAlign.CENTER;
			valueField5.x = 618;
			valueField5.y = valueFieldsHeight;
			popupContainer.addChild(valueField5);
			// product price field
			var priceField5:TextField = new TextField(75, 35, "240", font.fontName, font.fontSize, 0x4e0693);
			priceField5.pivotX = priceField5.width;
			priceField5.vAlign = VAlign.CENTER;
			priceField5.hAlign = HAlign.RIGHT;
			priceField5.x = 624;
			priceField5.y = priceFieldsHeight;
			popupContainer.addChild(priceField5);
			// buy button
			var buttonBuy5:Button = new Button();
			buttonBuy5.defaultSkin = new Image(Statics.assets.getTexture("GetGemsBtnBuy0000"));
			buttonBuy5.hoverSkin = new Image(Statics.assets.getTexture("GetGemsBtnBuy0000"));
			buttonBuy5.downSkin = new Image(Statics.assets.getTexture("GetGemsBtnBuy0000"));
			buttonBuy5.hoverSkin.filter = Statics.btnBrightnessFilter;
			buttonBuy5.downSkin.filter = Statics.btnInvertFilter;
			buttonBuy5.useHandCursor = true;
			buttonBuy5.addEventListener(Event.TRIGGERED, purchaseCoinUltimatePackHandler);
			popupContainer.addChild(buttonBuy5);
			buttonBuy5.x = 572;
			buttonBuy5.y = buyButtonsHeight;
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
		
		public function purchaseCoinBoosterPackHandler(event:Event):void {
			if (!Sounds.sfxMuted) Statics.assets.playSound("SND_CLICK");
			
			if (Statics.isAnalyticsEnabled) {
				Statics.mixpanel.track('clicked on button: coin booster pack');
			}
			
			if (Statics.playerGems < 5) { // player can't afford this
				// show get gems prompt
				parent.showDialogBox("You do not have enough gems, would you like to get more?", parent.showGetGemsScreen);
				return;
			}
			
			var jsonStr:String = JSON.stringify({
				item: 'coins_booster'
			});
			parent.displayLoadingNotice("Purchasing Coins...");
//			parent.communicator.addEventListener(NavigationEvent.RESPONSE_RECEIVED, parent.dataReceived);
			parent.communicator.postPurchaseCoins(jsonStr);
		}
		
		public function purchaseCoinSuperPackHandler(event:Event):void {
			if (!Sounds.sfxMuted) Statics.assets.playSound("SND_CLICK");
			
			if (Statics.isAnalyticsEnabled) {
				Statics.mixpanel.track('clicked on button: coin super pack');
			}
			
			if (Statics.playerGems < 12) { // player can't afford this
				// show get gems prompt
				parent.showDialogBox("You do not have enough gems, would you like to get more?", parent.showGetGemsScreen);
				return;
			}
			
			var jsonStr:String = JSON.stringify({
				item: 'coins_super'
			});
			parent.displayLoadingNotice("Purchasing Coins...");
//			parent.communicator.addEventListener(NavigationEvent.RESPONSE_RECEIVED, parent.dataReceived);
			parent.communicator.postPurchaseCoins(jsonStr);
		}
		
		public function purchaseCoinMegaPackHandler(event:Event):void {
			if (!Sounds.sfxMuted) Statics.assets.playSound("SND_CLICK");
			
			if (Statics.isAnalyticsEnabled) {
				Statics.mixpanel.track('clicked on button: coin mega pack');
			}
			
			if (Statics.playerGems < 50) { // player can't afford this
				// show get gems prompt
				parent.showDialogBox("You do not have enough gems, would you like to get more?", parent.showGetGemsScreen);
				return;
			}
			
			var jsonStr:String = JSON.stringify({
				item: 'coins_mega'
			});
			parent.displayLoadingNotice("Purchasing Coins...");
//			parent.communicator.addEventListener(NavigationEvent.RESPONSE_RECEIVED, parent.dataReceived);
			parent.communicator.postPurchaseCoins(jsonStr);
		}
		
		public function purchaseCoinUltraPackHandler(event:Event):void {
			if (!Sounds.sfxMuted) Statics.assets.playSound("SND_CLICK");
			
			if (Statics.isAnalyticsEnabled) {
				Statics.mixpanel.track('clicked on button: coin ultra pack');
			}
			
			if (Statics.playerGems < 120) { // player can't afford this
				// show get gems prompt
				parent.showDialogBox("You do not have enough gems, would you like to get more?", parent.showGetGemsScreen);
				return;
			}
			
			var jsonStr:String = JSON.stringify({
				item: 'coins_ultra'
			});
			parent.displayLoadingNotice("Purchasing Coins...");
//			parent.communicator.addEventListener(NavigationEvent.RESPONSE_RECEIVED, parent.dataReceived);
			parent.communicator.postPurchaseCoins(jsonStr);
		}
		
		public function purchaseCoinUltimatePackHandler(event:Event):void {
			if (!Sounds.sfxMuted) Statics.assets.playSound("SND_CLICK");
			
			if (Statics.isAnalyticsEnabled) {
				Statics.mixpanel.track('clicked on button: coin ultimate pack');
			}
			
			if (Statics.playerGems < 240) { // player can't afford this
				// show get gems prompt
				parent.showDialogBox("You do not have enough gems, would you like to get more?", parent.showGetGemsScreen);
				return;
			}
			
			var jsonStr:String = JSON.stringify({
				item: 'coins_ultimate'
			});
			parent.displayLoadingNotice("Purchasing Coins...");
//			parent.communicator.addEventListener(NavigationEvent.RESPONSE_RECEIVED, parent.dataReceived);
			parent.communicator.postPurchaseCoins(jsonStr);
		}
		
		private function buttonCloseHandler(event:Event):void {
			if (!Sounds.sfxMuted) Statics.assets.playSound("SND_CLICK");
			
			this.visible = false;
		}
		
//		private function showGetGemsScreen():void {
//			parent.showGetGemsScreen(null);
//		}
	}
}