package com.jumpGame.ui.screens
{
	import com.jumpGame.events.NavigationEvent;
	import com.jumpGame.level.Statics;
	import com.jumpGame.screens.Menu;
	import com.jumpGame.ui.components.CustomListItem;
	
	import feathers.controls.Screen;
	import feathers.controls.ScrollContainer;
	import feathers.controls.Scroller;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	
	public class ScreenUpgrades extends Screen
	{
		private var resizableContainer:ScrollContainer;
		private var upgradeDuplicationListItem:CustomListItem;
		private var upgradeSafetyRocketItem:CustomListItem;
		
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
			
			// create a test item
			var upgradeDuplicationData:Object = new Object();
			upgradeDuplicationData.title = "Upgrade Power: Duplication";
			upgradeDuplicationData.subtitle = "Increases Power: Duplication duration by 20%";
			upgradeDuplicationData.handler = upgradeDuplicationHandler;
			upgradeDuplicationData.totalProgress = 10;
			upgradeDuplicationListItem = new CustomListItem(this, upgradeDuplicationData);
			upgradeDuplicationListItem.pivotX = Math.ceil(upgradeDuplicationListItem.width / 2);
			upgradeDuplicationListItem.x = resizableContainer.width / 2;
			resizableContainer.addChild(upgradeDuplicationListItem);
			
			var upgradeSafetyRocketData:Object = new Object();
			upgradeSafetyRocketData.title = "Upgrade Power: Safety Rocket";
			upgradeSafetyRocketData.subtitle = "Increases Power: Safety Rocket duration by 20%";
			upgradeSafetyRocketData.handler = upgradeSafetyRocketHandler;
			upgradeSafetyRocketData.totalProgress = 10;
			upgradeSafetyRocketItem = new CustomListItem(this, upgradeSafetyRocketData);
			upgradeSafetyRocketItem.pivotX = Math.ceil(upgradeSafetyRocketItem.width / 2);
			upgradeSafetyRocketItem.x = resizableContainer.width / 2;
			upgradeSafetyRocketItem.y = upgradeDuplicationListItem.bounds.bottom + 10;
			resizableContainer.addChild(upgradeSafetyRocketItem);
		}
		
		/**
		 * Called each time the upgrades screen is displayed
		 */
		public function refresh():void {
			trace("updating upgrades screen...");
			this.upgradeDuplicationListItem.refreshProperties(Statics.rankDuplication, Statics.upgradePrices.duplication);
			this.upgradeSafetyRocketItem.refreshProperties(Statics.rankSafety, Statics.upgradePrices.safety);
		}
		
		public function upgradeDuplicationHandler(event:Event):void {
			trace("upgrading duplication");
			
			if (Statics.upgradePrices.duplication > Statics.playerCoins) { // player can't afford this
				trace("You do not have enough coins, would you like to get more?");
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
			trace("upgrading safety rocket");
			
			if (Statics.upgradePrices.safety > Statics.playerCoins) { // player can't afford this
				trace("You do not have enough coins, would you like to get more?");
				return;
			}
			
			var jsonStr:String = JSON.stringify({
				item: 'safety'
			});
			Menu(this.owner).displayLoadingNotice("Upgrading Power...");
			Menu(this.owner).communicator.addEventListener(NavigationEvent.RESPONSE_RECEIVED, Menu(this.owner).dataReceived);
			Menu(this.owner).communicator.postPurchaseUpgrade(jsonStr);
		}
	}
}