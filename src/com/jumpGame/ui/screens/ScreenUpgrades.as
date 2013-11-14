package com.jumpGame.ui.screens
{
	import com.jumpGame.events.NavigationEvent;
	import com.jumpGame.level.Statics;
	import com.jumpGame.screens.Menu;
	import com.jumpGame.ui.components.UpgradeItemRenderer;
	
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.controls.Scroller;
	import feathers.data.ListCollection;
	
	import starling.display.Image;
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
			// popup artwork
			var popup:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("PopupLarge0000"));
			popup.pivotX = Math.ceil(popup.width / 2);
			popup.pivotY = Math.ceil(popup.height / 2);
			popup.x = Statics.stageWidth / 2;
			popup.y = Statics.stageHeight / 2;
			this.addChild(popup);
			
			// popup header
			var popupHeader:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("PopupHeaderUpgrades0000"));
			popupHeader.pivotX = Math.ceil(popupHeader.width / 2);
			popupHeader.x = Statics.stageWidth / 2;
			popupHeader.y = popup.bounds.top + 24;
			this.addChild(popupHeader);
			
			// popup close button
			var buttonClose:Button = new Button();
			buttonClose.defaultSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ButtonPopupClose0000"));
			buttonClose.hoverSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ButtonPopupClose0000"));
			buttonClose.downSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ButtonPopupClose0000"));
			buttonClose.hoverSkin.filter = Statics.btnBrightnessFilter;
			buttonClose.downSkin.filter = Statics.btnInvertFilter;
			buttonClose.useHandCursor = true;
			buttonClose.addEventListener(Event.TRIGGERED, Menu(this.owner).buttonClosePopupHandler);
			this.addChild(buttonClose);
			buttonClose.validate();
			buttonClose.pivotX = buttonClose.width;
			buttonClose.x = popup.bounds.right - 25;
			buttonClose.y = popup.bounds.top + 28;
			
			// list of upgrades
			upgradesList = new List();
			upgradesList.width = 588;
			upgradesList.height = 400;
			upgradesList.pivotX = Math.ceil(upgradesList.width / 2);
			upgradesList.x = Statics.stageWidth / 2;
			upgradesList.y = popup.bounds.top + 95;
			upgradesList.horizontalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			addChild(upgradesList);
			upgradesList.itemRendererType = UpgradeItemRenderer;
			upgradesList.itemRendererProperties.iconField = "icon";
			upgradesList.itemRendererProperties.titleField = "title";
			upgradesList.itemRendererProperties.captionField = "caption";
			upgradesList.itemRendererProperties.caption2Field = "caption2";
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
					icon: "Teleportation",
					title: "Power: Teleportation", 
					caption: "Current Rank: " + String(12 + Statics.rankTeleportation * 2) + " teleports",
					caption2: "Next Rank: " + String(12 + (Statics.rankTeleportation + 1) * 2) + " teleports",
					price: Statics.upgradePrices.teleportation.price,
					price_type: Statics.upgradePrices.teleportation.price_type,
					progress: Statics.rankTeleportation,
					eventid: Constants.UpgradeTeleportationId
				}, 0);
			} else {
				upgradesCollection.setItemAt({
					icon: "Teleportation",
					title: "Power: Teleportation", 
					caption: "Current Rank: " + String(12 + Statics.rankTeleportation * 2) + " teleports",
					caption2: "",
					price: 0,
					price_type: "coins",
					progress: Statics.rankTeleportation,
					eventid: Constants.UpgradeTeleportationId
				}, 0);
			}
			
			// attraction
			if (Statics.upgradePrices.attraction != null) {
				upgradesCollection.setItemAt({
					icon: "Attraction",
					title: "Power: Attraction", 
					caption: "Current Rank: " + String(5 + Statics.rankAttraction * 1) + " second duration",
					caption2: "Next Rank: " + String(5 + (Statics.rankAttraction + 1) * 1) + " second duration",
					price: Statics.upgradePrices.attraction.price,
					price_type: Statics.upgradePrices.attraction.price_type,
					progress: Statics.rankAttraction,
					eventid: Constants.UpgradeAttractionId
				}, 1);
			} else {
				upgradesCollection.setItemAt({
					icon: "Attraction",
					title: "Power: Attraction", 
					caption: "Current Rank: " + String(5 + Statics.rankAttraction * 1) + " second duration",
					caption2: "",
					price: 0,
					price_type: "coins",
					progress: Statics.rankAttraction,
					eventid: Constants.UpgradeAttractionId
				}, 1);
			}
			
			// duplication
			if (Statics.upgradePrices.duplication != null) {
				upgradesCollection.setItemAt({
					icon: "Duplication",
					title: "Power: Duplication", 
					caption: "Current Rank: " + String(5 + Statics.rankDuplication * 1) + " second duration",
					caption2: "Next Rank: " + String(5 + (Statics.rankDuplication + 1) * 1) + " second duration",
					price: Statics.upgradePrices.duplication.price,
					price_type: Statics.upgradePrices.duplication.price_type,
					progress: Statics.rankDuplication,
					eventid: Constants.UpgradeDuplicationId
				}, 2);
			} else {
				upgradesCollection.setItemAt({
					icon: "Duplication",
					title: "Power: Duplication", 
					caption: "Current Rank: " + String(5 + Statics.rankDuplication * 1) + " second duration",
					caption2: "",
					price: 0,
					price_type: "coins",
					progress: Statics.rankDuplication,
					eventid: Constants.UpgradeDuplicationId
				}, 2);
			}
			
			
			// safety rocket
			if (Statics.upgradePrices.safety != null) {
				upgradesCollection.setItemAt({
					icon: "Safety",
					title: "Power: Safety Rocket", 
					caption: "Current Rank: " + String(5 + Statics.rankSafety * 1) + " second duration",
					caption2: "Next Rank: " + String(5 + (Statics.rankSafety + 1) * 1) + " second duration",
					price: Statics.upgradePrices.safety.price,
					price_type: Statics.upgradePrices.safety.price_type,
					progress: Statics.rankSafety,
					eventid: Constants.UpgradeSafetyRocketId
				}, 3);
			} else {
				upgradesCollection.setItemAt({
					icon: "Safety",
					title: "Power: Safety Rocket", 
					caption: "Current Rank: " + String(5 + Statics.rankSafety * 1) + " second duration",
					caption2: "",
					price: 0,
					price_type: "coins",
					progress: Statics.rankSafety,
					eventid: Constants.UpgradeSafetyRocketId
				}, 3);
			}
			
			// barrels o' fire
			if (Statics.upgradePrices.barrels != null) {
				upgradesCollection.setItemAt({
					icon: "Barrels",
					title: "Power: Barrels O' Fire", 
					caption: "Current Rank: launch " + String(20 + Statics.rankBarrels * 2) + " barrels",
					caption2: "Next Rank: launch " + String(20 + (Statics.rankBarrels + 1) * 2) + " barrels",
					price: Statics.upgradePrices.barrels.price,
					price_type: Statics.upgradePrices.barrels.price_type,
					progress: Statics.rankBarrels,
					eventid: Constants.UpgradeBarrelsId
				}, 4);
			} else {
				upgradesCollection.setItemAt({
					icon: "Barrels",
					title: "Power: Barrels O' Fire", 
					caption: "Current Rank: launch " + String(20 + Statics.rankBarrels * 2) + " barrels",
					caption2: "",
					price: 0,
					price_type: "coins",
					progress: Statics.rankBarrels,
					eventid: Constants.UpgradeBarrelsId
				}, 4);
			}
			
			// super comet
			if (Statics.upgradePrices.comet != null) {
				upgradesCollection.setItemAt({
					icon: "Comet",
					title: "Super Comet", 
					caption: "Current Rank: " + String(3 + Statics.rankComet * 0.5) + " second duration",
					caption2: "Next Rank: " + String(3 + (Statics.rankComet + 1) * 0.5) + " second duration",
					price: Statics.upgradePrices.comet.price,
					price_type: Statics.upgradePrices.comet.price_type,
					progress: Statics.rankComet,
					eventid: Constants.UpgradeCometId
				}, 5);
			} else {
				upgradesCollection.setItemAt({
					icon: "Comet",
					title: "Super Comet", 
					caption: "Current Rank: " + String(3 + Statics.rankComet * 0.5) + " second duration",
					caption2: "",
					price: 0,
					price_type: "coins",
					progress: Statics.rankComet,
					eventid: Constants.UpgradeCometId
				}, 5);
			}
			
			// ability cooldown
			if (Statics.upgradePrices.cooldown != null) {
				upgradesCollection.setItemAt({
					icon: "Focus",
					title: "Focused Regeneration", 
					caption: "Current Rank: " + String(10 - Statics.rankAbilityCooldown * 0.5) + " second ability cooldown",
					caption2: "Next Rank: " + String(10 - (Statics.rankAbilityCooldown + 1) * 0.5) + " second ability cooldown",
					price: Statics.upgradePrices.cooldown.price,
					price_type: Statics.upgradePrices.cooldown.price_type,
					progress: Statics.rankAbilityCooldown,
					eventid: Constants.UpgradeAbilityCooldownId
				}, 6);
			} else {
				upgradesCollection.setItemAt({
					icon: "Focus",
					title: "Focused Regeneration", 
					caption: "Current Rank: " + String(10 - Statics.rankAbilityCooldown * 0.5) + " second ability cooldown",
					caption2: "",
					price: 0,
					price_type: "coins",
					progress: Statics.rankAbilityCooldown,
					eventid: Constants.UpgradeAbilityCooldownId
				}, 6);
			}
			
			// ability launch power
			if (Statics.upgradePrices.ability_power != null) {
				upgradesCollection.setItemAt({
					icon: "Power",
					title: "Power Infusion", 
					caption: "Current Rank: " + String(100 + Statics.rankAbilityPower * 20) + "% ability jump power",
					caption2: "Next Rank: " + String(100 + (Statics.rankAbilityPower + 1) * 20) + "% ability jump power",
					price: Statics.upgradePrices.ability_power.price,
					price_type: Statics.upgradePrices.ability_power.price_type,
					progress: Statics.rankAbilityPower,
					eventid: Constants.UpgradeAbilityPowerId
				}, 7);
			} else {
				upgradesCollection.setItemAt({
					icon: "Power",
					title: "Power Infusion", 
					caption: "Current Rank: " + String(100 + Statics.rankAbilityPower * 20) + "% ability jump power",
					caption2: "",
					price: 0,
					price_type: "coins",
					progress: Statics.rankAbilityPower,
					eventid: Constants.UpgradeAbilityPowerId
				}, 7);
			}
			
			// extra ability
			if (Statics.upgradePrices.extra_ability != null) {
				upgradesCollection.setItemAt({
					icon: "Extra",
					title: "Extra Special Ability", 
					caption: "Current Rank: " + String(2 + Statics.rankExtraAbility * 1) + " ability uses per round",
					caption2: "Next Rank: " + String(2 + (Statics.rankExtraAbility + 1) * 1) + " ability uses per round",
					price: Statics.upgradePrices.extra_ability.price,
					price_type: Statics.upgradePrices.extra_ability.price_type,
					progress: Statics.rankExtraAbility,
					eventid: Constants.UpgradeExtraAbilityId
				}, 8);
			} else {
				upgradesCollection.setItemAt({
					icon: "Extra",
					title: "Extra Special Ability", 
					caption: "Current Rank: " + String(2 + Statics.rankExtraAbility * 1) + " ability uses per round",
					caption2: "",
					price: 0,
					price_type: "coins",
					progress: Statics.rankExtraAbility,
					eventid: Constants.UpgradeExtraAbilityId
				}, 8);
			}
			
			// coin doubler
			if (Statics.upgradePrices.coin_doubler != null) {
				upgradesCollection.setItemAt({
					icon: "Doubler",
					title: "Magical Coin Doubler", 
					caption: "Doubles the amount of coins you collect",
					caption2: "during gameplay. Want to be rich?",
					price: Statics.upgradePrices.coin_doubler.price,
					price_type: Statics.upgradePrices.coin_doubler.price_type,
					progress: Statics.rankCoinDoubler,
					eventid: Constants.UpgradeCoinDoublerId
				}, 9);
			} else {
				upgradesCollection.setItemAt({
					icon: "Doubler",
					title: "Magical Coin Doubler", 
					caption: "Proud Owner of a Shiny Coin Doubler!",
					caption2: "",
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
				Menu(this.owner).showDialogBox("You do not have enough coins, would you like to get more?", showGetCoinsScreen);
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
				Menu(this.owner).showDialogBox("You do not have enough coins, would you like to get more?", showGetCoinsScreen);
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
				Menu(this.owner).showDialogBox("You do not have enough coins, would you like to get more?", showGetCoinsScreen);
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
				Menu(this.owner).showDialogBox("You do not have enough coins, would you like to get more?", showGetCoinsScreen);
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
				Menu(this.owner).showDialogBox("You do not have enough coins, would you like to get more?", showGetCoinsScreen);
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
				Menu(this.owner).showDialogBox("You do not have enough coins, would you like to get more?", showGetCoinsScreen);
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
				Menu(this.owner).showDialogBox("You do not have enough coins, would you like to get more?", showGetCoinsScreen);
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
				Menu(this.owner).showDialogBox("You do not have enough coins, would you like to get more?", showGetCoinsScreen);
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
					Menu(this.owner).showDialogBox("You do not have enough coins, would you like to get more?", showGetCoinsScreen);
					return;
				}
			}
			else if (Statics.upgradePrices.extra_ability.price_type == "gems") {
				if (Statics.upgradePrices.extra_ability.price > Statics.playerGems) { // player can't afford this
					// show get gems prompt
					Menu(this.owner).showDialogBox("You do not have enough gems, would you like to get more?", showGetGemsScreen);
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
				Menu(this.owner).showDialogBox("You do not have enough gems, would you like to get more?", showGetGemsScreen);
				return;
			}
			
			var jsonStr:String = JSON.stringify({
				item: 'coin_doubler'
			});
			Menu(this.owner).displayLoadingNotice("Fabricating Coin Doubler...");
			Menu(this.owner).communicator.addEventListener(NavigationEvent.RESPONSE_RECEIVED, Menu(this.owner).dataReceived);
			Menu(this.owner).communicator.postPurchaseUpgrade(jsonStr);
		}
		
		private function showGetCoinsScreen():void {
			Menu(this.owner).showGetCoinsScreen(null);
		}
		
		private function showGetGemsScreen():void {
			Menu(this.owner).showGetGemsScreen(null);
		}
	}
}