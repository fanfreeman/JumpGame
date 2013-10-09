package com.jumpGame.ui.screens
{
	import com.jumpGame.events.NavigationEvent;
	import com.jumpGame.level.Statics;
	import com.jumpGame.screens.Menu;
	import com.jumpGame.ui.components.UpgradeItemRenderer;
	
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.controls.Scroller;
	import feathers.data.ListCollection;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	
	public class ScreenUpgrades extends Screen
	{
		private var upgradesList:List;
		private var upgradesCollection:ListCollection;
		
		public function ScreenUpgrades()
		{
		}
		
		override protected function initialize():void
		{
			// scroll dialog artwork
			var scrollTop:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("ScrollLongTop0000"));
			scrollTop.pivotX = Math.ceil(scrollTop.texture.width / 2);
			scrollTop.x = Statics.stageWidth / 2;
			scrollTop.y = 60;
			this.addChild(scrollTop);
			
			var scrollBottom:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("ScrollLongBottom0000"));
			scrollBottom.pivotX = Math.ceil(scrollBottom.texture.width / 2);
			scrollBottom.pivotY = scrollBottom.texture.height;
			scrollBottom.x = Statics.stageWidth / 2;
			scrollBottom.y = Statics.stageHeight - 70;
			this.addChild(scrollBottom);
			
			var scrollQuad:Quad = new Quad(scrollTop.texture.width - 54, scrollBottom.y - scrollTop.y - scrollTop.texture.height - scrollBottom.texture.height + 2, 0xf1b892);
			scrollQuad.pivotX = Math.ceil(scrollQuad.width / 2);
			scrollQuad.x = Statics.stageWidth / 2;
			scrollQuad.y = scrollTop.y + scrollTop.texture.height - 1;
			addChild(scrollQuad);
			// eof scroll dialog artwork
			
			// list of upgrades
			upgradesList = new List();
			upgradesList.width = scrollQuad.width - 40;
			upgradesList.height = scrollQuad.height - 40;
			upgradesList.pivotX = Math.ceil(upgradesList.width / 2);
			upgradesList.x = Statics.stageWidth / 2;
			upgradesList.y = scrollQuad.bounds.top + 20;
			upgradesList.horizontalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			addChild(upgradesList);
			upgradesList.itemRendererType = UpgradeItemRenderer;
			upgradesList.itemRendererProperties.titleField = "title";
			upgradesList.itemRendererProperties.captionField = "caption";
			upgradesList.itemRendererProperties.priceField = "price";
			upgradesList.itemRendererProperties.priceTypeField = "price_type";
			upgradesList.itemRendererProperties.progressField = "progress";
			upgradesList.itemRendererProperties.eventidField = "eventid";
			upgradesList.addEventListener(Event.CHANGE, upgradesListChangeHandler);
			
			// upgrade button event handlers
			this.addEventListener(Constants.UpgradeTeleportationId, upgradeTeleportationHandler);
			this.addEventListener(Constants.UpgradeAttractionId, upgradeAttractionHandler);
			this.addEventListener(Constants.UpgradeDuplicationId, upgradeDuplicationHandler);
			this.addEventListener(Constants.UpgradeSafetyRocketId, upgradeSafetyRocketHandler);
			this.addEventListener(Constants.UpgradeBarrelsId, upgradeBarrelsHandler);
			this.addEventListener(Constants.UpgradeCometId, upgradeCometHandler);
			this.addEventListener(Constants.UpgradeAbilityCooldownId, upgradeCooldownHandler);
			this.addEventListener(Constants.UpgradeAbilityPowerId, upgradeAbilityPowerHandler);
			this.addEventListener(Constants.UpgradeExtraAbilityId, upgradeExtraAbilityHandler);
			this.addEventListener(Constants.UpgradeCoinDoublerId, upgradeCoinDoublerHandler);
			
			this.populateUpgradesList();
		}
		
		private function upgradesListChangeHandler(event:Event):void {
//			trace("selected: " + upgradesList.selectedIndex);
		}
		
		private function populateUpgradesList():void {
			upgradesCollection = new ListCollection();
			
			for (var i:uint = 0; i < 10; i++) { // number of items on the upgrades screen
				upgradesCollection.addItem(null);
			}
			this.updateUpgradesList();
			
			upgradesList.dataProvider = upgradesCollection;
		}
		
		private function updateUpgradesList():void {
			// teleportation
			if (Statics.upgradePrices.teleportation != null) {
				upgradesCollection.setItemAt({
					title: "Upgrade Power: Teleportation", 
					caption: "Extend Power: Teleportation by " + String(Statics.rankTeleportation * 2 + 2) + " extra teleports",
					price: Statics.upgradePrices.teleportation.price,
					price_type: Statics.upgradePrices.teleportation.price_type,
					progress: Statics.rankTeleportation,
					eventid: Constants.UpgradeTeleportationId
				}, 0);
			} else {
				upgradesCollection.setItemAt({
					title: "Power: Teleportation at max rank", 
					caption: "",
					price: 0,
					price_type: "coins",
					progress: Statics.rankTeleportation,
					eventid: Constants.UpgradeTeleportationId
				}, 0);
			}
			
			// attraction
			if (Statics.upgradePrices.attraction != null) {
				upgradesCollection.setItemAt({
					title: "Upgrade Power: Attraction", 
					caption: "Increases Power: Attraction duration by " + String(Statics.rankAttraction * 20 + 20) + "%",
					price: Statics.upgradePrices.attraction.price,
					price_type: Statics.upgradePrices.attraction.price_type,
					progress: Statics.rankAttraction,
					eventid: Constants.UpgradeAttractionId
				}, 1);
			} else {
				upgradesCollection.setItemAt({
					title: "Power: Attraction at max rank", 
					caption: "",
					price: 0,
					price_type: "coins",
					progress: Statics.rankAttraction,
					eventid: Constants.UpgradeAttractionId
				}, 1);
			}
			
			// duplication
			if (Statics.upgradePrices.duplication != null) {
				upgradesCollection.setItemAt({
					title: "Upgrade Power: Duplication", 
					caption: "Increases Power: Duplication duration by " + String(Statics.rankDuplication * 20 + 20) + "%",
					price: Statics.upgradePrices.duplication.price,
					price_type: Statics.upgradePrices.duplication.price_type,
					progress: Statics.rankDuplication,
					eventid: Constants.UpgradeDuplicationId
				}, 2);
			} else {
				upgradesCollection.setItemAt({
					title: "Power: Duplication at max rank", 
					caption: "",
					price: 0,
					price_type: "coins",
					progress: Statics.rankDuplication,
					eventid: Constants.UpgradeDuplicationId
				}, 2);
			}
			
			
			// safety rocket
			if (Statics.upgradePrices.safety != null) {
				upgradesCollection.setItemAt({
					title: "Upgrade Power: Safety Rocket", 
					caption: "Increases Power: Safety Rocket duration by " + String(Statics.rankSafety * 20 + 20) + "%",
					price: Statics.upgradePrices.safety.price,
					price_type: Statics.upgradePrices.safety.price_type,
					progress: Statics.rankSafety,
					eventid: Constants.UpgradeSafetyRocketId
				}, 3);
			} else {
				upgradesCollection.setItemAt({
					title: "Power: Safety Rocket at max rank", 
					caption: "",
					price: 0,
					price_type: "coins",
					progress: Statics.rankSafety,
					eventid: Constants.UpgradeSafetyRocketId
				}, 3);
			}
			
			// barrels o' fire
			if (Statics.upgradePrices.barrels != null) {
				upgradesCollection.setItemAt({
					title: "Upgrade Power: Barrels O' Fire", 
					caption: "Launch " + String(Statics.rankBarrels * 2 + 2) + " extra barrels",
					price: Statics.upgradePrices.barrels.price,
					price_type: Statics.upgradePrices.barrels.price_type,
					progress: Statics.rankBarrels,
					eventid: Constants.UpgradeBarrelsId
				}, 4);
			} else {
				upgradesCollection.setItemAt({
					title: "Power: Barrels O' Fire at max rank", 
					caption: "",
					price: 0,
					price_type: "coins",
					progress: Statics.rankBarrels,
					eventid: Constants.UpgradeBarrelsId
				}, 4);
			}
			
			// super comet
			if (Statics.upgradePrices.comet != null) {
				var captionString:String;
				if (Statics.rankComet > 1) captionString = "Increases Super Comet duration by " + String(Statics.rankComet * 0.5 + 0.5) + " seconds";
				else captionString = "Increases Super Comet duration by " + String(Statics.rankComet * 0.5 + 0.5) + " second";
				upgradesCollection.setItemAt({
					title: "Upgrade Super Comet", 
					caption: captionString,
					price: Statics.upgradePrices.comet.price,
					price_type: Statics.upgradePrices.comet.price_type,
					progress: Statics.rankComet,
					eventid: Constants.UpgradeCometId
				}, 5);
			} else {
				upgradesCollection.setItemAt({
					title: "Super Comet at max rank", 
					caption: "",
					price: 0,
					price_type: "coins",
					progress: Statics.rankComet,
					eventid: Constants.UpgradeCometId
				}, 5);
			}
			
			// ability cooldown
			if (Statics.upgradePrices.cooldown != null) {
				if (Statics.rankAbilityCooldown > 1) captionString = "Decreases Special Ability cooldown by " + String(Statics.rankAbilityCooldown * 0.5 + 0.5) + " seconds";
				else captionString = "Decreases Special Ability cooldown by " + String(Statics.rankAbilityCooldown * 0.5 + 0.5) + " second";
				upgradesCollection.setItemAt({
					title: "Upgrade Ability: Focused Regeneration", 
					caption: captionString,
					price: Statics.upgradePrices.cooldown.price,
					price_type: Statics.upgradePrices.cooldown.price_type,
					progress: Statics.rankAbilityCooldown,
					eventid: Constants.UpgradeAbilityCooldownId
				}, 6);
			} else {
				upgradesCollection.setItemAt({
					title: "Focused Ability Regeneration at max rank", 
					caption: "",
					price: 0,
					price_type: "coins",
					progress: Statics.rankAbilityCooldown,
					eventid: Constants.UpgradeAbilityCooldownId
				}, 6);
			}
			
			// ability launch power
			if (Statics.upgradePrices.ability_power != null) {
				upgradesCollection.setItemAt({
					title: "Upgrade Ability: Power Infusion", 
					caption: "Increases speical ability launch power by " + String(Statics.rankAbilityPower * 20 + 20) + "%",
					price: Statics.upgradePrices.ability_power.price,
					price_type: Statics.upgradePrices.ability_power.price_type,
					progress: Statics.rankAbilityPower,
					eventid: Constants.UpgradeAbilityPowerId
				}, 7);
			} else {
				upgradesCollection.setItemAt({
					title: "Ability Power at max rank", 
					caption: "",
					price: 0,
					price_type: "coins",
					progress: Statics.rankAbilityPower,
					eventid: Constants.UpgradeAbilityPowerId
				}, 7);
			}
			
			// extra ability
			if (Statics.upgradePrices.extra_ability != null) {
				upgradesCollection.setItemAt({
					title: "Extra Special Ability", 
					caption: "You can use one extra Speical Ability in a round",
					price: Statics.upgradePrices.extra_ability.price,
					price_type: Statics.upgradePrices.extra_ability.price_type,
					progress: Statics.rankExtraAbility,
					eventid: Constants.UpgradeExtraAbilityId
				}, 8);
			} else {
				upgradesCollection.setItemAt({
					title: "Maximum Number of Extra Abilities", 
					caption: "",
					price: 0,
					price_type: "coins",
					progress: Statics.rankExtraAbility,
					eventid: Constants.UpgradeExtraAbilityId
				}, 8);
			}
			
			// coin doubler
			if (Statics.upgradePrices.coin_doubler != null) {
				upgradesCollection.setItemAt({
					title: "Coin Doubler", 
					caption: "Doubles the amount of coins you collect during gameplay",
					price: Statics.upgradePrices.coin_doubler.price,
					price_type: Statics.upgradePrices.coin_doubler.price_type,
					progress: Statics.rankCoinDoubler,
					eventid: Constants.UpgradeCoinDoublerId
				}, 9);
			} else {
				upgradesCollection.setItemAt({
					title: "Proud Owner of a Shiny Coin Doubler", 
					caption: "",
					price: 0,
					price_type: "coins",
					progress: Statics.rankCoinDoubler,
					eventid: Constants.UpgradeCoinDoublerId
				}, 9);
			}
		}
		
		/**
		 * Called each time the upgrades screen is displayed
		 */
		public function refresh():void {
			this.updateUpgradesList();
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
		
		public function upgradeBarrelsHandler(event:Event):void {
			if (Statics.upgradePrices.barrels.price > Statics.playerCoins) { // player can't afford this
				// show get coins prompt
				Menu(this.owner).showDialogBox("You do not have enough coins,\n would you like to get more?", true, showGetCoinsScreen);
				return;
			}
			
			var jsonStr:String = JSON.stringify({
				item: 'barrels'
			});
			Menu(this.owner).displayLoadingNotice("Upgrading Power...");
			Menu(this.owner).communicator.addEventListener(NavigationEvent.RESPONSE_RECEIVED, Menu(this.owner).dataReceived);
			Menu(this.owner).communicator.postPurchaseUpgrade(jsonStr);
		}
		
		public function upgradeCometHandler(event:Event):void {
			if (Statics.upgradePrices.comet.price > Statics.playerCoins) { // player can't afford this
				// show get coins prompt
				Menu(this.owner).showDialogBox("You do not have enough coins,\n would you like to get more?", true, showGetCoinsScreen);
				return;
			}
			
			var jsonStr:String = JSON.stringify({
				item: 'comet'
			});
			Menu(this.owner).displayLoadingNotice("Upgrading Power...");
			Menu(this.owner).communicator.addEventListener(NavigationEvent.RESPONSE_RECEIVED, Menu(this.owner).dataReceived);
			Menu(this.owner).communicator.postPurchaseUpgrade(jsonStr);
		}
		
		public function upgradeCooldownHandler(event:Event):void {
			if (Statics.upgradePrices.cooldown.price > Statics.playerCoins) { // player can't afford this
				// show get coins prompt
				Menu(this.owner).showDialogBox("You do not have enough coins,\n would you like to get more?", true, showGetCoinsScreen);
				return;
			}
			
			var jsonStr:String = JSON.stringify({
				item: 'cooldown'
			});
			Menu(this.owner).displayLoadingNotice("Upgrading Ability...");
			Menu(this.owner).communicator.addEventListener(NavigationEvent.RESPONSE_RECEIVED, Menu(this.owner).dataReceived);
			Menu(this.owner).communicator.postPurchaseUpgrade(jsonStr);
		}
		
		public function upgradeAbilityPowerHandler(event:Event):void {
			if (Statics.upgradePrices.ability_power.price > Statics.playerCoins) { // player can't afford this
				// show get coins prompt
				Menu(this.owner).showDialogBox("You do not have enough coins,\n would you like to get more?", true, showGetCoinsScreen);
				return;
			}
			
			var jsonStr:String = JSON.stringify({
				item: 'ability_power'
			});
			Menu(this.owner).displayLoadingNotice("Upgrading Ability...");
			Menu(this.owner).communicator.addEventListener(NavigationEvent.RESPONSE_RECEIVED, Menu(this.owner).dataReceived);
			Menu(this.owner).communicator.postPurchaseUpgrade(jsonStr);
		}
		
		public function upgradeExtraAbilityHandler(event:Event):void {
			if (Statics.upgradePrices.extra_ability.price_type == "coins") {
				if (Statics.upgradePrices.extra_ability.price > Statics.playerCoins) { // player can't afford this
					// show get coins prompt
					Menu(this.owner).showDialogBox("You do not have enough coins,\n would you like to get more?", true, showGetCoinsScreen);
					return;
				}
			}
			else if (Statics.upgradePrices.extra_ability.price_type == "gems") {
				if (Statics.upgradePrices.extra_ability.price > Statics.playerGems) { // player can't afford this
					// show get gems prompt
					Menu(this.owner).showDialogBox("You do not have enough gems,\n would you like to get more?", true, showGetGemsScreen);
					return;
				}
			}
			
			
			var jsonStr:String = JSON.stringify({
				item: 'extra_ability'
			});
			Menu(this.owner).displayLoadingNotice("Upgrading Ability...");
			Menu(this.owner).communicator.addEventListener(NavigationEvent.RESPONSE_RECEIVED, Menu(this.owner).dataReceived);
			Menu(this.owner).communicator.postPurchaseUpgrade(jsonStr);
		}
		
		public function upgradeCoinDoublerHandler(event:Event):void {
			if (Statics.upgradePrices.coin_doubler.price > Statics.playerGems) { // player can't afford this
				// show get gems prompt
				Menu(this.owner).showDialogBox("You do not have enough gems,\n would you like to get more?", true, showGetGemsScreen);
				return;
			}
			
			var jsonStr:String = JSON.stringify({
				item: 'coin_doubler'
			});
			Menu(this.owner).displayLoadingNotice("Fabricating Coin Doubler...");
			Menu(this.owner).communicator.addEventListener(NavigationEvent.RESPONSE_RECEIVED, Menu(this.owner).dataReceived);
			Menu(this.owner).communicator.postPurchaseUpgrade(jsonStr);
		}
		
		private function showGetCoinsScreen(event:Event):void {
			event.target.removeEventListener(Event.TRIGGERED, showGetCoinsScreen);
			Menu(this.owner).hideDialogBox();
			Menu(this.owner).showGetCoinsScreen(null);
		}
		
		private function showGetGemsScreen(event:Event):void {
			event.target.removeEventListener(Event.TRIGGERED, showGetGemsScreen);
			Menu(this.owner).hideDialogBox();
			Menu(this.owner).showGetGemsScreen(null);
		}
	}
}