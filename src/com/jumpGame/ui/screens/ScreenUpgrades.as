package com.jumpGame.ui.screens
{
	import com.jumpGame.events.NavigationEvent;
	import com.jumpGame.level.Statics;
	import com.jumpGame.screens.Menu;
	import com.jumpGame.ui.components.UpgradeListItem;
	
	import feathers.controls.Screen;
	import feathers.controls.ScrollContainer;
	import feathers.controls.Scroller;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	
	public class ScreenUpgrades extends Screen
	{
		private var resizableContainer:ScrollContainer;
		private var upgradeTeleportationListItem:UpgradeListItem;
		private var upgradeAttractionListItem:UpgradeListItem;
		private var upgradeDuplicationListItem:UpgradeListItem;
		private var upgradeSafetyRocketItem:UpgradeListItem;
		
		public function ScreenUpgrades()
		{
		}
		
		override protected function initialize():void
		{
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
			
			// create upgrade list items
			// teleportation
			var upgradeTeleportationData:Object = new Object();
			upgradeTeleportationData.title = "Upgrade Power: Teleportation";
			upgradeTeleportationData.handler = upgradeTeleportationHandler;
			upgradeTeleportationData.totalProgress = 10;
			upgradeTeleportationListItem = new UpgradeListItem(this, upgradeTeleportationData);
			upgradeTeleportationListItem.pivotX = Math.ceil(upgradeTeleportationListItem.width / 2);
			upgradeTeleportationListItem.x = resizableContainer.width / 2;
			resizableContainer.addChild(upgradeTeleportationListItem);
			
			// attraction
			var upgradeAttractionData:Object = new Object();
			upgradeAttractionData.title = "Upgrade Power: Attraction";
			upgradeAttractionData.handler = upgradeAttractionHandler;
			upgradeAttractionData.totalProgress = 10;
			upgradeAttractionListItem = new UpgradeListItem(this, upgradeAttractionData);
			upgradeAttractionListItem.pivotX = Math.ceil(upgradeAttractionListItem.width / 2);
			upgradeAttractionListItem.x = resizableContainer.width / 2;
			upgradeAttractionListItem.y = upgradeTeleportationListItem.bounds.bottom + 10;
			resizableContainer.addChild(upgradeAttractionListItem);
			
			// duplication
			var upgradeDuplicationData:Object = new Object();
			upgradeDuplicationData.title = "Upgrade Power: Duplication";
			upgradeDuplicationData.handler = upgradeDuplicationHandler;
			upgradeDuplicationData.totalProgress = 10;
			upgradeDuplicationListItem = new UpgradeListItem(this, upgradeDuplicationData);
			upgradeDuplicationListItem.pivotX = Math.ceil(upgradeDuplicationListItem.width / 2);
			upgradeDuplicationListItem.x = resizableContainer.width / 2;
			upgradeDuplicationListItem.y = upgradeAttractionListItem.bounds.bottom + 10;
			resizableContainer.addChild(upgradeDuplicationListItem);
			
			// safety rocket
			var upgradeSafetyRocketData:Object = new Object();
			upgradeSafetyRocketData.title = "Upgrade Power: Safety Rocket";
			upgradeSafetyRocketData.handler = upgradeSafetyRocketHandler;
			upgradeSafetyRocketData.totalProgress = 10;
			upgradeSafetyRocketItem = new UpgradeListItem(this, upgradeSafetyRocketData);
			upgradeSafetyRocketItem.pivotX = Math.ceil(upgradeSafetyRocketItem.width / 2);
			upgradeSafetyRocketItem.x = resizableContainer.width / 2;
			upgradeSafetyRocketItem.y = upgradeDuplicationListItem.bounds.bottom + 10;
			resizableContainer.addChild(upgradeSafetyRocketItem);
		}
		
		/**
		 * Called each time the upgrades screen is displayed
		 */
		public function refresh():void {
			if (Statics.upgradePrices.teleportation != null) {
				var upgradeTeleportationSubtitle:String = "Extend Power: Teleportation by " + String(Statics.rankTeleportation * 2 + 2) + " extra teleports";
				this.upgradeTeleportationListItem.refreshProperties(Statics.rankTeleportation, Statics.upgradePrices.teleportation.price, upgradeTeleportationSubtitle);
			} else this.upgradeTeleportationListItem.refreshProperties(Statics.rankTeleportation, null, null);
			
			if (Statics.upgradePrices.attraction != null) {
				var upgradeAttractionSubtitle:String = "Increases Power: Attraction duration by " + String(Statics.rankAttraction * 20 + 20) + "%";
				this.upgradeAttractionListItem.refreshProperties(Statics.rankAttraction, Statics.upgradePrices.attraction.price, upgradeAttractionSubtitle);
			} else this.upgradeAttractionListItem.refreshProperties(Statics.rankAttraction, null, null);
			
			if (Statics.upgradePrices.duplication != null) {
				var upgradeDuplicationSubtitle:String = "Increases Power: Duplication duration by " + String(Statics.rankDuplication * 20 + 20) + "%";
				this.upgradeDuplicationListItem.refreshProperties(Statics.rankDuplication, Statics.upgradePrices.duplication.price, upgradeDuplicationSubtitle);
			} else this.upgradeDuplicationListItem.refreshProperties(Statics.rankDuplication, null, null);
			
			if (Statics.upgradePrices.safety != null) {
				var upgradeSafetyRocketSubtitle:String = "Increases Power: Safety Rocket duration by " + String(Statics.rankSafety * 20 + 20) + "%";
				this.upgradeSafetyRocketItem.refreshProperties(Statics.rankSafety, Statics.upgradePrices.safety.price, upgradeSafetyRocketSubtitle);
			} else this.upgradeSafetyRocketItem.refreshProperties(Statics.rankSafety, null, null);
		}
		
		public function upgradeTeleportationHandler(event:Event):void {
			if (Statics.upgradePrices.teleportation.price > Statics.playerCoins) { // player can't afford this
				// show get coins prompt
				Menu(this.owner).showDialogBox("You do not have enough coins,\n would you like to get more?", true, showGetCoinsScreen);
				return;
			}
			
			var jsonStr:String = JSON.stringify({
				item: 'teleportation'
			});
			Menu(this.owner).displayLoadingNotice("Upgrading Power...");
			Menu(this.owner).communicator.addEventListener(NavigationEvent.RESPONSE_RECEIVED, Menu(this.owner).dataReceived);
			Menu(this.owner).communicator.postPurchaseUpgrade(jsonStr);
		}
		
		public function upgradeAttractionHandler(event:Event):void {
			if (Statics.upgradePrices.attraction.price > Statics.playerCoins) { // player can't afford this
				// show get coins prompt
				Menu(this.owner).showDialogBox("You do not have enough coins,\n would you like to get more?", true, showGetCoinsScreen);
				return;
			}
			
			var jsonStr:String = JSON.stringify({
				item: 'attraction'
			});
			Menu(this.owner).displayLoadingNotice("Upgrading Power...");
			Menu(this.owner).communicator.addEventListener(NavigationEvent.RESPONSE_RECEIVED, Menu(this.owner).dataReceived);
			Menu(this.owner).communicator.postPurchaseUpgrade(jsonStr);
		}
		
		public function upgradeDuplicationHandler(event:Event):void {
			if (Statics.upgradePrices.duplication.price > Statics.playerCoins) { // player can't afford this
				// show get coins prompt
				Menu(this.owner).showDialogBox("You do not have enough coins,\n would you like to get more?", true, showGetCoinsScreen);
				return;
			}

			var jsonStr:String = JSON.stringify({
				item: 'duplication'
			});
			Menu(this.owner).displayLoadingNotice("Upgrading Power...");
			Menu(this.owner).communicator.addEventListener(NavigationEvent.RESPONSE_RECEIVED, Menu(this.owner).dataReceived);
			Menu(this.owner).communicator.postPurchaseUpgrade(jsonStr);
		}
		
		public function upgradeSafetyRocketHandler(event:Event):void {
			if (Statics.upgradePrices.safety.price > Statics.playerCoins) { // player can't afford this
				// show get coins prompt
				Menu(this.owner).showDialogBox("You do not have enough coins,\n would you like to get more?", true, showGetCoinsScreen);
				return;
			}
			
			var jsonStr:String = JSON.stringify({
				item: 'safety'
			});
			Menu(this.owner).displayLoadingNotice("Upgrading Power...");
			Menu(this.owner).communicator.addEventListener(NavigationEvent.RESPONSE_RECEIVED, Menu(this.owner).dataReceived);
			Menu(this.owner).communicator.postPurchaseUpgrade(jsonStr);
		}
		
		private function showGetCoinsScreen(event:Event):void {
			event.target.removeEventListener(Event.TRIGGERED, showGetCoinsScreen);
			Menu(this.owner).hideDialogBox();
			Menu(this.owner).showGetCoinsScreen(null);
		}
	}
}