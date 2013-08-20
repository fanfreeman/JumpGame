package com.jumpGame.screens
{
	import com.jumpGame.customObjects.Font;
	import com.jumpGame.events.NavigationEvent;
	import com.jumpGame.level.Statics;
	import com.jumpGame.ui.screens.ScreenAchievements;
	import com.jumpGame.ui.screens.ScreenMatches;
	import com.jumpGame.ui.screens.ScreenUpgrades;
	
	import feathers.controls.Label;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.controls.TabBar;
	import feathers.data.ListCollection;
	import feathers.motion.transitions.TabBarSlideTransitionManager;
	import feathers.system.DeviceCapabilities;
	import feathers.themes.MetalWorksMobileTheme;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class Menu  extends ScreenNavigator
	{
		protected var theme:MetalWorksMobileTheme;
		private var label:Label;
		private var fontBadabb:Font;
		public var communicator:Communicator = null;
		
		private var loadingNotice:Sprite;
		private var loadingNoticeText:TextField;
		
		private var tabs:TabBar;
		private var transitionManager:TabBarSlideTransitionManager;
		
		private var screenMatches:ScreenMatches;
		private var screenUpgrades:ScreenUpgrades;
		private var screenAchievements:ScreenAchievements;
		
		public function Menu()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			
			// Javascript Callbacks
//			ExternalInterface.addCallback("returnFbId", returnFbId);
			
			this.communicator = new Communicator();
		}
		
		/**
		 * Receive data from backend
		 */
		public function dataReceived(event:NavigationEvent):void {
			dismissLoadingNotice();
			
			var data:String = event.params.data;
			
			if (event.params.data != null) {
				var dataObj:Object = JSON.parse(data);
				if (dataObj.hasOwnProperty("status")) {
					if (dataObj.status == "found") { // found existing player
						// get basic player info
						Statics.userId = String(dataObj.user_id);
						Statics.playerName = dataObj.first_name + " " + dataObj.last_name.substr(0, 1) + ".";
						
						// get player details
						// score
//						if (int(dataObj.high_score) > 0) { // existing player
//							label.text = "Welcome, " + dataObj.first_name + "! Your High Score: " + dataObj.high_score;
//						} else { // this is a new player
//							label.text = "Welcome to You Jump I Jump, " + dataObj.first_name + "!";
//						}
						Statics.playerCoins = int(dataObj.coins);
						label.text = "Coins: " + dataObj.coins;
						// upgrade ranks
						Statics.rankTeleportation = int(dataObj.rank_teleportation);
						Statics.rankAttraction = int(dataObj.rank_attraction);
						Statics.rankDuplication = int(dataObj.rank_duplication);
						Statics.rankSafety = int(dataObj.rank_safety);
						Statics.rankBarrels = int(dataObj.rank_barrels);
						Statics.rankCannonballs = int(dataObj.rank_cannonballs);
						Statics.rankComet = int(dataObj.rank_comet);
						Statics.rankAbilityCooldown = int(dataObj.rank_ability_cooldown);
						Statics.rankAbilityPower = int(dataObj.rank_ability_power);
						
						// upgrade prices
						Statics.upgradePrices = dataObj.prices;
						
						// parse player matches
						var matchesYourTurnCollection:ListCollection = new ListCollection();
						var matchesTheirTurnCollection:ListCollection = new ListCollection();
						var matchesFinishedCollection:ListCollection = new ListCollection();
						this.screenMatches.gamesMyTurn = new Array();
						this.screenMatches.gamesTheirTurn = new Array();
						this.screenMatches.gamesFinished = new Array();
						for (var i:uint = 0; i < dataObj.matches.length; i++) { // loop through matches retrieved
							// get round number
							var roundScoresArray:Array = [	int(dataObj.matches[i].player1_round1_score),
															int(dataObj.matches[i].player2_round1_score),
															int(dataObj.matches[i].player1_round2_score),
															int(dataObj.matches[i].player2_round2_score),
															int(dataObj.matches[i].player1_round3_score),
															int(dataObj.matches[i].player2_round3_score)];
//							trace("round scores: " + roundScoresArray);
//							this.traceObject(dataObj.matches[i]);
							dataObj.matches[i].roundScores = roundScoresArray;
							var roundNumber:uint = this.getCurrentRoundFromScores(roundScoresArray);
							dataObj.matches[i].roundNumber = roundNumber;
							var opponentName:String = dataObj.matches[i].opponent_first_name + " " + dataObj.matches[i].opponent_last_name;
							
							// check if game has been resigned
							if (String(dataObj.matches[i].resigned_by) == Statics.userId) { // current player resigned this game
								matchesFinishedCollection.addItem({ text: "You resigned match against " + opponentName + "\n" + dataObj.matches[i].time_text});
								this.screenMatches.gamesFinished.push(dataObj.matches[i]);
							}
							else if (String(dataObj.matches[i].resigned_by) != "0") { // the opponent resigned this game
								matchesFinishedCollection.addItem({ text: opponentName + " resigned match against you" + "\n" + dataObj.matches[i].time_text});
								this.screenMatches.gamesFinished.push(dataObj.matches[i]);
							}
							else { // no one resigned this game
								if (roundNumber >= 6) { // matched has ended
									matchesFinishedCollection.addItem({ text: "Match against " + opponentName + "\n" + dataObj.matches[i].time_text});
									this.screenMatches.gamesFinished.push(dataObj.matches[i]);
								} else { // match not yet ended
									if (Boolean(int(dataObj.matches[i].is_player_2))) { // is player 2
										if (roundNumber == 1) { // my first turn, allow resigning from match
											matchesYourTurnCollection.addItem({ text: opponentName + " has challenged you to a match!" + "\n" + dataObj.matches[i].time_text});
											this.screenMatches.gamesMyTurn.push(dataObj.matches[i]);
										} else { // turn 3 or turn 5
											if (roundNumber % 2 == 1) {
												matchesYourTurnCollection.addItem({ text: "Your turn against " + opponentName + "\n" + dataObj.matches[i].time_text});
												this.screenMatches.gamesMyTurn.push(dataObj.matches[i]);
											}
											else {
												matchesTheirTurnCollection.addItem({ text: opponentName + "'s turn" + "\n" + dataObj.matches[i].time_text});
												this.screenMatches.gamesTheirTurn.push(dataObj.matches[i]);
											}
										}
									} else { // is player 1
										if (roundNumber % 2 == 0) {
											matchesYourTurnCollection.addItem({ text: "Your turn against " + opponentName + "\n" + dataObj.matches[i].time_text });
											this.screenMatches.gamesMyTurn.push(dataObj.matches[i]);
										}
										else {
											matchesTheirTurnCollection.addItem({ text: opponentName + "'s turn" + "\n" + dataObj.matches[i].time_text });
											this.screenMatches.gamesTheirTurn.push(dataObj.matches[i]);
										}
									}
								} // eof match not yet ended
							} // eof no one resigned this game
						} // eof loop through matches retrieved
						this.screenMatches.listYourTurn.dataProvider = matchesYourTurnCollection;
						this.screenMatches.listTheirTurn.dataProvider = matchesTheirTurnCollection;
						this.screenMatches.listFinished.dataProvider = matchesFinishedCollection;
						this.screenMatches.updateLists();
						
						this.screenMatches.startGamePicker.visible = true;
					}
					else if (dataObj.status == "new_match") { // new game created
						// display match data popup
						Statics.opponentName = dataObj.opponent_first_name + " " + dataObj.opponent_last_name.toString().substr(0, 1) + ".";
						Statics.roundScores = [0, 0, 0, 0, 0, 0];
						Statics.isPlayer2 = false;
						Statics.gameId = dataObj.game_id;
						Statics.opponentFbid = dataObj.opponent_fbid;
						Statics.resignedBy = '0';
						this.screenMatches.matchDataPopup.initialize(false);
						this.screenMatches.matchDataPopup.visible = true;
					}
					else if (dataObj.status == "purchased") { // successfully made purchase
						Statics.playerCoins = int(dataObj.coins);
						label.text = "Coins: " + dataObj.coins;
						Statics.rankTeleportation = int(dataObj.rank_teleportation);
						Statics.rankAttraction = int(dataObj.rank_attraction);
						Statics.rankDuplication = int(dataObj.rank_duplication);
						Statics.rankSafety = int(dataObj.rank_safety);
						Statics.rankBarrels = int(dataObj.rank_barrels);
						Statics.rankCannonballs = int(dataObj.rank_cannonballs);
						Statics.rankComet = int(dataObj.rank_comet);
						Statics.rankAbilityCooldown = int(dataObj.rank_ability_cooldown);
						Statics.rankAbilityPower = int(dataObj.rank_ability_power);
						Statics.upgradePrices = dataObj.prices;
						this.screenUpgrades.refresh();
					}
					else if (dataObj.status == "error") { // error message received
						label.text = "Error: " + dataObj.reason;
					}
				} else {
					this.displayLoadingNotice("Communication Error #2222");
				}
			}
		} // eof dataReceived()
		
		private function getCurrentRoundFromScores(scores:Array):uint {
			var i:uint = 0;
			while (i < 6 && scores[i] != 0) {
				i++;
			}
			if (i < 6) {
				return i;
			}
			return 6; // match ended
		}
		
//		private function returnFbId(fbId:int):void {
//			trace("Facebook id: " + fbId);
//		}
		
		private function addedToStageHandler(event:Event):void
		{
			DeviceCapabilities.dpi = 326; //simulate iPhone Retina resolution
			this.theme = new MetalWorksMobileTheme(this.stage);
			
			// bg
			var bgImage:Image = new Image(Assets.getSprite("AtlasTexture2").getTexture("UiMainBg0000"));
			bgImage.pivotX = Math.ceil(bgImage.texture.width / 2);
			bgImage.x = stage.stageWidth / 2;
			this.addChild(bgImage);
			
			// top bar
			var topBar:Image = new Image(Assets.getSprite("AtlasTexture2").getTexture("UiMainTop0000"));
			this.addChild(topBar);
			
			// score label
			label = new Label();
			label.text = "Loading...";
			label.width = Constants.StageWidth;
			label.height = 50;
			label.x = 250;
			label.y = 7;
			this.addChild(label);
			
			// loading screen
			createLoadingNotice();
			
			// screens
			this.screenMatches = new ScreenMatches();
			this.screenUpgrades = new ScreenUpgrades();
			this.screenAchievements = new ScreenAchievements();
			this.addEventListener(Event.CHANGE, navigatorChangeHandler);
			this.addScreen(Constants.ScreenMatches, new ScreenNavigatorItem(screenMatches));
			this.addScreen(Constants.ScreenUpgrades, new ScreenNavigatorItem(screenUpgrades));
			this.addScreen(Constants.ScreenAchievements, new ScreenNavigatorItem(screenAchievements));
			
			// tab bar
			tabs = new TabBar();
			tabs.width = stage.stageWidth;
			tabs.height = 60;
			tabs.pivotY = tabs.height;
			tabs.y = stage.stageHeight;
			tabs.dataProvider = new ListCollection(
				[
					{ label: "Matches", action: Constants.ScreenMatches },
					{ label: "Upgrades", action: Constants.ScreenUpgrades },
					{ label: "Achievements", action: Constants.ScreenAchievements }
				]);
			tabs.addEventListener( Event.CHANGE, tabsChangeHandler );
			this.addChild(tabs);
			
			// screen transitions
			this.transitionManager = new TabBarSlideTransitionManager(this, this.tabs);
			this.transitionManager.duration = 0.4;
		}
		
		private function traceObject(o:Object):void{
			trace('\n');
			for(var val:* in o){
				trace('   [' + typeof(o[val]) + '] ' + val + ' => ' + o[val]);
			}
			trace('\n');
		}
		
		private function navigatorChangeHandler(event:Event):void
		{
			// when screen changes, also update tab bar selection
			const dataProvider:ListCollection = this.tabs.dataProvider;
			const itemCount:int = dataProvider.length;
			for(var i:int = 0; i < itemCount; i++)
			{
				var item:Object = dataProvider.getItemAt(i);
				if(this.activeScreenID == item.action)
				{
					this.tabs.selectedIndex = i;
					break;
				}
			}
		}
		
		private function tabsChangeHandler(event:Event):void
		{
			// trigger match data refresh
			if (this.tabs.selectedIndex == -1) {
				this.tabs.selectedIndex = 0;
				return;
			}
			
			// display the selected screen
			this.showScreen(this.tabs.selectedItem.action);
			
			// when displaying the matches screen, refresh matches
			if (this.tabs.selectedItem.action == Constants.ScreenMatches) {
				this.refreshMatches();
			}
			// when displaying the upgrades screen, refresh upgrades
			else if (this.tabs.selectedItem.action == Constants.ScreenUpgrades) {
				this.screenUpgrades.refresh();
			}
		}
		
		private function createLoadingNotice():void {
			loadingNotice = new Sprite();
			
			// bg quad
			var bg:Quad = new Quad(stage.stageWidth, stage.stageHeight, 0x000000);
			bg.alpha = 0.5;
			loadingNotice.addChild(bg);
			
			// spinning box
			var boxAnimation:MovieClip = new MovieClip(Assets.getSprite("AtlasTexturePlatforms").getTextures("BoxBlue"), 20);
			boxAnimation.pivotX = Math.ceil(boxAnimation.texture.width  / 2); // center art on registration point
			boxAnimation.pivotY = Math.ceil(boxAnimation.texture.height / 2);
			boxAnimation.x = stage.stageWidth / 2 - 200;
			boxAnimation.y = stage.stageHeight / 2;
			Starling.juggler.add(boxAnimation);
			loadingNotice.addChild(boxAnimation);
			
			// message
			var fontMessage:Font = Fonts.getFont("Badabb");
			loadingNoticeText = new TextField(500, 100, "Testing", fontMessage.fontName, fontMessage.fontSize, 0xffffff);
			loadingNoticeText.hAlign = HAlign.LEFT;
			loadingNoticeText.vAlign = VAlign.CENTER;
			loadingNoticeText.x = stage.stageWidth / 2 - 130;
			loadingNoticeText.y = stage.stageHeight / 2;
			loadingNoticeText.pivotY = loadingNoticeText.height / 2;
			loadingNotice.addChild(loadingNoticeText);
			
			loadingNotice.visible = false;
			this.addChild(loadingNotice);
		}
		
		public function displayLoadingNotice(message:String):void {
			loadingNoticeText.text = message;
			this.setChildIndex(loadingNotice, this.numChildren-1);
			loadingNotice.visible = true;
		}
		
		private function dismissLoadingNotice():void {
			loadingNotice.visible = false;
		}
		
		public function initialize():void
		{
			this.visible = true;
			this.tabs.selectedIndex = -1; // trigger match data refresh
		}
		
		private function refreshMatches():void {
			label.text = "Connecting to Game Server...";
			displayLoadingNotice("Refreshing matches...");
			this.communicator.addEventListener(NavigationEvent.RESPONSE_RECEIVED, dataReceived);
			this.communicator.retrieveUserData();
		}
		
		public function disposeTemporarily():void
		{
			this.visible = false;
		}
	}
}