package com.jumpGame.ui.popups
{
	import com.jumpGame.screens.Menu;
	import com.jumpGame.ui.components.GetCoinListItem;
	
	import feathers.controls.Check;
	import feathers.controls.ScrollContainer;
	import feathers.controls.Scroller;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class ScreenGetGems extends Sprite
	{
		private var parent:Menu;
		private var closeButton:Check;
		private var resizableContainer:ScrollContainer;
		private var gemBoosterPackListItem:GetCoinListItem;
		private var gemMegaPackListItem:GetCoinListItem;
		private var gemSuperPackListItem:GetCoinListItem;
		private var gemUltraPackListItem:GetCoinListItem;
		private var gemUltimatePackListItem:GetCoinListItem;
		
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
			
			// create gem pack list items
			// booster pack
			var gemBoosterPackData:Object = new Object();
			gemBoosterPackData.title = "Gem Booster Pack";
			gemBoosterPackData.subtitle = "10 Gems";
			gemBoosterPackData.price = "0.99";
			gemBoosterPackData.handler = purchaseGemBoosterPackHandler;
			gemBoosterPackListItem = new GetCoinListItem(gemBoosterPackData);
			gemBoosterPackListItem.pivotX = Math.ceil(gemBoosterPackListItem.width / 2);
			gemBoosterPackListItem.x = resizableContainer.width / 2;
			resizableContainer.addChild(gemBoosterPackListItem);
//			
//			// mega pack
//			var coinMegaPackData:Object = new Object();
//			coinMegaPackData.title = "Coin Mega Pack";
//			coinMegaPackData.subtitle = "50000 Coins";
//			coinMegaPackData.price = 10;
//			coinMegaPackData.handler = purchaseCoinMegaPackHandler;
//			coinMegaPackListItem = new GetCoinListItem(this, coinMegaPackData);
//			coinMegaPackListItem.pivotX = Math.ceil(coinMegaPackListItem.width / 2);
//			coinMegaPackListItem.x = resizableContainer.width / 2;
//			coinMegaPackListItem.y = coinBoosterPackListItem.bounds.bottom + 10;
//			resizableContainer.addChild(coinMegaPackListItem);
			
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
		
		public function purchaseGemBoosterPackHandler(event:Event):void {
//			var jsonStr:String = JSON.stringify({
//				item: 'coins_booster'
//			});
//			parent.displayLoadingNotice("Purchasing Coins...");
//			parent.communicator.addEventListener(NavigationEvent.RESPONSE_RECEIVED, parent.dataReceived);
//			parent.communicator.postPurchaseCoins(jsonStr);
		}
		
		public function refresh():void {
			// fix close button
			closeButton.isSelected = true;
		}
		
		private function buttonCloseHandler(event:Event):void {
			this.visible = false;
		}
	}
}