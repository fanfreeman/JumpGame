package com.jumpGame.ui.popups
{
	import com.jumpGame.events.NavigationEvent;
	import com.jumpGame.screens.Menu;
	import com.jumpGame.ui.components.GetCoinListItem;
	
	import flash.external.ExternalInterface;
	
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
		private var gemHandfulListItem:GetCoinListItem;
		private var gemPouchListItem:GetCoinListItem;
		private var gemSackListItem:GetCoinListItem;
		private var gemBoxListItem:GetCoinListItem;
		private var gemChestListItem:GetCoinListItem;
		private var gemTruckloadListItem:GetCoinListItem;
		
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
			// handful
			var gemHandfulData:Object = new Object();
			gemHandfulData.title = "Handful of Gems";
			gemHandfulData.subtitle = "20 Gems";
			gemHandfulData.price = "$1.99";
			gemHandfulData.handler = purchaseGemHandfulHandler;
			gemHandfulListItem = new GetCoinListItem(gemHandfulData);
			gemHandfulListItem.pivotX = Math.ceil(gemHandfulListItem.width / 2);
			gemHandfulListItem.x = resizableContainer.width / 2;
			resizableContainer.addChild(gemHandfulListItem);
			
			// pouch
			var gemPouchData:Object = new Object();
			gemPouchData.title = "Pouch of Gems";
			gemPouchData.subtitle = "55 Gems";
			gemPouchData.price = "$4.99";
			gemPouchData.handler = purchaseGemPouchHandler;
			gemPouchListItem = new GetCoinListItem(gemPouchData);
			gemPouchListItem.pivotX = Math.ceil(gemPouchListItem.width / 2);
			gemPouchListItem.x = resizableContainer.width / 2;
			gemPouchListItem.y = gemHandfulListItem.bounds.bottom + 10;
			resizableContainer.addChild(gemPouchListItem);
			
			// sack
			var gemSackData:Object = new Object();
			gemSackData.title = "Sack of Gems";
			gemSackData.subtitle = "115 Gems";
			gemSackData.price = "$9.99";
			gemSackData.handler = purchaseGemSackHandler;
			gemSackListItem = new GetCoinListItem(gemSackData);
			gemSackListItem.pivotX = Math.ceil(gemSackListItem.width / 2);
			gemSackListItem.x = resizableContainer.width / 2;
			gemSackListItem.y = gemPouchListItem.bounds.bottom + 10;
			resizableContainer.addChild(gemSackListItem);
			
			// box
			var gemBoxData:Object = new Object();
			gemBoxData.title = "Box of Gems";
			gemBoxData.subtitle = "240 Gems";
			gemBoxData.price = "$19.99";
			gemBoxData.handler = purchaseGemBoxHandler;
			gemBoxListItem = new GetCoinListItem(gemBoxData);
			gemBoxListItem.pivotX = Math.ceil(gemBoxListItem.width / 2);
			gemBoxListItem.x = resizableContainer.width / 2;
			gemBoxListItem.y = gemSackListItem.bounds.bottom + 10;
			resizableContainer.addChild(gemBoxListItem);
			
			// chest
			var gemChestData:Object = new Object();
			gemChestData.title = "Chest of Gems";
			gemChestData.subtitle = "625 Gems";
			gemChestData.price = "$49.99";
			gemChestData.handler = purchaseGemChestHandler;
			gemChestListItem = new GetCoinListItem(gemChestData);
			gemChestListItem.pivotX = Math.ceil(gemChestListItem.width / 2);
			gemChestListItem.x = resizableContainer.width / 2;
			gemChestListItem.y = gemBoxListItem.bounds.bottom + 10;
			resizableContainer.addChild(gemChestListItem);
			
			// truckload
			var gemTruckloadData:Object = new Object();
			gemTruckloadData.title = "Truckload of Gems";
			gemTruckloadData.subtitle = "1300 Gems";
			gemTruckloadData.price = "$99.99";
			gemTruckloadData.handler = purchaseGemTruckloadHandler;
			gemTruckloadListItem = new GetCoinListItem(gemTruckloadData);
			gemTruckloadListItem.pivotX = Math.ceil(gemTruckloadListItem.width / 2);
			gemTruckloadListItem.x = resizableContainer.width / 2;
			gemTruckloadListItem.y = gemChestListItem.bounds.bottom + 10;
			resizableContainer.addChild(gemTruckloadListItem);

			
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
		
		public function purchaseGemHandfulHandler(event:Event):void {
			if(ExternalInterface.available){
				trace("Calling JS...");
				ExternalInterface.call("displayPurchase", "http://www.raiderbear.com/demo/product/gempacks?pack=gems_handful");
				ExternalInterface.addCallback("returnPurchaseStatusToAs", purchaseStatusReturnedFromJs);
			} else {
				trace("External interface unavailabe");
			}
		}
		
		public function purchaseGemPouchHandler(event:Event):void {
			if(ExternalInterface.available){
				trace("Calling JS...");
				ExternalInterface.call("displayPurchase", "http://www.raiderbear.com/demo/product/gempacks?pack=gems_pouch");
				ExternalInterface.addCallback("returnPurchaseStatusToAs", purchaseStatusReturnedFromJs);
			} else {
				trace("External interface unavailabe");
			}
		}
		
		public function purchaseGemSackHandler(event:Event):void {
			if(ExternalInterface.available){
				trace("Calling JS...");
				ExternalInterface.call("displayPurchase", "http://www.raiderbear.com/demo/product/gempacks?pack=gems_sack");
				ExternalInterface.addCallback("returnPurchaseStatusToAs", purchaseStatusReturnedFromJs);
			} else {
				trace("External interface unavailabe");
			}
		}
		
		public function purchaseGemBoxHandler(event:Event):void {
			if(ExternalInterface.available){
				trace("Calling JS...");
				ExternalInterface.call("displayPurchase", "http://www.raiderbear.com/demo/product/gempacks?pack=gems_box");
				ExternalInterface.addCallback("returnPurchaseStatusToAs", purchaseStatusReturnedFromJs);
			} else {
				trace("External interface unavailabe");
			}
		}
		
		public function purchaseGemChestHandler(event:Event):void {
			if(ExternalInterface.available){
				trace("Calling JS...");
				ExternalInterface.call("displayPurchase", "http://www.raiderbear.com/demo/product/gempacks?pack=gems_chest");
				ExternalInterface.addCallback("returnPurchaseStatusToAs", purchaseStatusReturnedFromJs);
			} else {
				trace("External interface unavailabe");
			}
		}
		
		public function purchaseGemTruckloadHandler(event:Event):void {
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
		
		public function refresh():void {
			// fix close button
			closeButton.isSelected = true;
		}
		
		private function buttonCloseHandler(event:Event):void {
			this.visible = false;
		}
	}
}