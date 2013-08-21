package com.jumpGame.ui.popups
{
	import com.jumpGame.events.NavigationEvent;
	import com.jumpGame.level.Statics;
	import com.jumpGame.screens.Menu;
	import com.jumpGame.ui.components.GetCoinListItem;
	
	import feathers.controls.Check;
	import feathers.controls.ScrollContainer;
	import feathers.controls.Scroller;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class ScreenGetCoins extends Sprite
	{
		private var parent:Menu;
		private var closeButton:Check;
		private var resizableContainer:ScrollContainer;
		private var coinBoosterPackListItem:GetCoinListItem;
		private var coinMegaPackListItem:GetCoinListItem;
		private var coinSuperPackListItem:GetCoinListItem;
		private var coinUltraPackListItem:GetCoinListItem;
		private var coinUltimatePackListItem:GetCoinListItem;
		
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
			var bg:Quad = new Quad(stage.stageWidth, stage.stageHeight, 0x000000);
			bg.alpha = 0.5;
			this.addChild(bg);
			
			// scroll dialog artwork
			var scrollTop:Image = new Image(Assets.getSprite("AtlasTexture2").getTexture("ScrollLongTop0000"));
			scrollTop.pivotX = Math.ceil(scrollTop.texture.width / 2);
			scrollTop.x = stage.stageWidth / 2;
			scrollTop.y = 60;
			this.addChild(scrollTop);
			
			var scrollBottom:Image = new Image(Assets.getSprite("AtlasTexture2").getTexture("ScrollLongBottom0000"));
			scrollBottom.pivotX = Math.ceil(scrollBottom.texture.width / 2);
			scrollBottom.pivotY = scrollBottom.texture.height;
			scrollBottom.x = stage.stageWidth / 2;
			scrollBottom.y = stage.stageHeight - 70;
			this.addChild(scrollBottom);
			
			var scrollQuad:Quad = new Quad(scrollTop.texture.width - 54, scrollBottom.y - scrollTop.y - scrollTop.texture.height - scrollBottom.texture.height + 2, 0xf1b892);
			scrollQuad.pivotX = Math.ceil(scrollQuad.width / 2);
			scrollQuad.x = stage.stageWidth / 2;
			scrollQuad.y = scrollTop.y + scrollTop.texture.height - 1;
			addChild(scrollQuad);
			// eof scroll dialog artwork
			
			// create matches scroll container
			resizableContainer = new ScrollContainer();
			resizableContainer.width = scrollQuad.width - 10;
			resizableContainer.x = (stage.stageWidth - resizableContainer.width) / 2;
			resizableContainer.y = scrollQuad.y + 15;
			resizableContainer.height = scrollQuad.height - 30;
			resizableContainer.horizontalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			resizableContainer.verticalScrollPolicy = Scroller.SCROLL_POLICY_ON;
			this.addChild(resizableContainer);
			
			// create coin pack list items
			// booster pack
			var coinBoosterPackData:Object = new Object();
			coinBoosterPackData.title = "Coin Booster Pack";
			coinBoosterPackData.subtitle = "20000 Coins";
			coinBoosterPackData.price = 5;
			coinBoosterPackData.handler = purchaseCoinBoosterPackHandler;
			coinBoosterPackListItem = new GetCoinListItem(coinBoosterPackData);
			coinBoosterPackListItem.pivotX = Math.ceil(coinBoosterPackListItem.width / 2);
			coinBoosterPackListItem.x = resizableContainer.width / 2;
			resizableContainer.addChild(coinBoosterPackListItem);
			
			// super pack
			var coinSuperPackData:Object = new Object();
			coinSuperPackData.title = "Coin Super Pack";
			coinSuperPackData.subtitle = "55000 Coins";
			coinSuperPackData.price = 12;
			coinSuperPackData.handler = purchaseCoinSuperPackHandler;
			coinSuperPackListItem = new GetCoinListItem(coinSuperPackData);
			coinSuperPackListItem.pivotX = Math.ceil(coinSuperPackListItem.width / 2);
			coinSuperPackListItem.x = resizableContainer.width / 2;
			coinSuperPackListItem.y = coinBoosterPackListItem.bounds.bottom + 10;
			resizableContainer.addChild(coinSuperPackListItem);
			
			// mega pack
			var coinMegaPackData:Object = new Object();
			coinMegaPackData.title = "Coin Mega Pack";
			coinMegaPackData.subtitle = "230000 Coins";
			coinMegaPackData.price = 50;
			coinMegaPackData.handler = purchaseCoinMegaPackHandler;
			coinMegaPackListItem = new GetCoinListItem(coinMegaPackData);
			coinMegaPackListItem.pivotX = Math.ceil(coinMegaPackListItem.width / 2);
			coinMegaPackListItem.x = resizableContainer.width / 2;
			coinMegaPackListItem.y = coinSuperPackListItem.bounds.bottom + 10;
			resizableContainer.addChild(coinMegaPackListItem);
			
			// ultra pack
			var coinUltraPackData:Object = new Object();
			coinUltraPackData.title = "Coin Ultra Pack";
			coinUltraPackData.subtitle = "600000 Coins";
			coinUltraPackData.price = 120;
			coinUltraPackData.handler = purchaseCoinUltraPackHandler;
			coinUltraPackListItem = new GetCoinListItem(coinUltraPackData);
			coinUltraPackListItem.pivotX = Math.ceil(coinUltraPackListItem.width / 2);
			coinUltraPackListItem.x = resizableContainer.width / 2;
			coinUltraPackListItem.y = coinMegaPackListItem.bounds.bottom + 10;
			resizableContainer.addChild(coinUltraPackListItem);
			
			// ultimate pack
			var coinUltimatePackData:Object = new Object();
			coinUltimatePackData.title = "Coin Ultimate Pack";
			coinUltimatePackData.subtitle = "1350000 Coins";
			coinUltimatePackData.price = 240;
			coinUltimatePackData.handler = purchaseCoinUltimatePackHandler;
			coinUltimatePackListItem = new GetCoinListItem(coinUltimatePackData);
			coinUltimatePackListItem.pivotX = Math.ceil(coinUltimatePackListItem.width / 2);
			coinUltimatePackListItem.x = resizableContainer.width / 2;
			coinUltimatePackListItem.y = coinUltraPackListItem.bounds.bottom + 10;
			resizableContainer.addChild(coinUltimatePackListItem);
			
			// close button
			closeButton = new Check();
			closeButton.isSelected = true;
			closeButton.width = 30;
			closeButton.height = 30;
			closeButton.x = scrollQuad.x + scrollQuad.width / 2 - 40;
			closeButton.y = scrollQuad.y - 25;
			closeButton.addEventListener(Event.TRIGGERED, buttonCloseHandler);
			this.addChild(closeButton);
		}
		
		public function purchaseCoinBoosterPackHandler(event:Event):void {
			if (Statics.playerGems < 5) { // player can't afford this
				// show get gems prompt
				parent.showDialogBox("You do not have enough gems,\n would you like to get more?", true, showGetGemsScreen);
				return;
			}
			
			var jsonStr:String = JSON.stringify({
				item: 'coins_booster'
			});
			parent.displayLoadingNotice("Purchasing Coins...");
			parent.communicator.addEventListener(NavigationEvent.RESPONSE_RECEIVED, parent.dataReceived);
			parent.communicator.postPurchaseCoins(jsonStr);
		}
		
		public function purchaseCoinSuperPackHandler(event:Event):void {
			if (Statics.playerGems < 12) { // player can't afford this
				// show get gems prompt
				parent.showDialogBox("You do not have enough gems,\n would you like to get more?", true, showGetGemsScreen);
				return;
			}
			
			var jsonStr:String = JSON.stringify({
				item: 'coins_super'
			});
			parent.displayLoadingNotice("Purchasing Coins...");
			parent.communicator.addEventListener(NavigationEvent.RESPONSE_RECEIVED, parent.dataReceived);
			parent.communicator.postPurchaseCoins(jsonStr);
		}
		
		public function purchaseCoinMegaPackHandler(event:Event):void {
			if (Statics.playerGems < 50) { // player can't afford this
				// show get gems prompt
				parent.showDialogBox("You do not have enough gems,\n would you like to get more?", true, showGetGemsScreen);
				return;
			}
			
			var jsonStr:String = JSON.stringify({
				item: 'coins_mega'
			});
			parent.displayLoadingNotice("Purchasing Coins...");
			parent.communicator.addEventListener(NavigationEvent.RESPONSE_RECEIVED, parent.dataReceived);
			parent.communicator.postPurchaseCoins(jsonStr);
		}
		
		public function purchaseCoinUltraPackHandler(event:Event):void {
			if (Statics.playerGems < 120) { // player can't afford this
				// show get gems prompt
				parent.showDialogBox("You do not have enough gems,\n would you like to get more?", true, showGetGemsScreen);
				return;
			}
			
			var jsonStr:String = JSON.stringify({
				item: 'coins_ultra'
			});
			parent.displayLoadingNotice("Purchasing Coins...");
			parent.communicator.addEventListener(NavigationEvent.RESPONSE_RECEIVED, parent.dataReceived);
			parent.communicator.postPurchaseCoins(jsonStr);
		}
		
		public function purchaseCoinUltimatePackHandler(event:Event):void {
			if (Statics.playerGems < 240) { // player can't afford this
				// show get gems prompt
				parent.showDialogBox("You do not have enough gems,\n would you like to get more?", true, showGetGemsScreen);
				return;
			}
			
			var jsonStr:String = JSON.stringify({
				item: 'coins_ultimate'
			});
			parent.displayLoadingNotice("Purchasing Coins...");
			parent.communicator.addEventListener(NavigationEvent.RESPONSE_RECEIVED, parent.dataReceived);
			parent.communicator.postPurchaseCoins(jsonStr);
		}
		
		public function refresh():void {
			// fix close button
			closeButton.isSelected = true;
		}
		
		private function buttonCloseHandler(event:Event):void {
			this.visible = false;
		}
		
		private function showGetGemsScreen(event:Event):void {
			event.target.removeEventListener(Event.TRIGGERED, showGetGemsScreen);
			parent.hideDialogBox();
			parent.showGetGemsScreen(null);
		}
	}
}