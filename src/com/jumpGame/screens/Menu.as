package com.jumpGame.screens
{
	import com.jumpGame.customObjects.Font;
	import com.jumpGame.events.NavigationEvent;
	import com.jumpGame.level.Statics;
	import com.jumpGame.ui.popups.DialogBox;
	import com.jumpGame.ui.popups.ScreenAchievements;
	import com.jumpGame.ui.popups.ScreenGetCoins;
	import com.jumpGame.ui.popups.ScreenGetGems;
	import com.jumpGame.ui.popups.ScreenProfile;
	import com.jumpGame.ui.popups.ScreenRankings;
	import com.jumpGame.ui.screens.ScreenMatches;
	import com.jumpGame.ui.screens.ScreenTownSquare;
	import com.jumpGame.ui.screens.ScreenUpgrades;
	
	import flash.external.ExternalInterface;
	import flash.utils.getTimer;
	
	import feathers.controls.Label;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.controls.TabBar;
	import feathers.data.ListCollection;
	import feathers.motion.transitions.TabBarSlideTransitionManager;
	import feathers.system.DeviceCapabilities;
	import feathers.themes.MetalWorksMobileTheme;
	
	import starling.animation.Transitions;
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
		private var coinLabel:Label;
		private var gemLabel:Label;
		private var rankLabel:Label;
		private var countdownLabel:Label;
		private var fontBadabb:Font;
		public var communicator:Communicator = null;
		
		private var loadingNotice:Sprite;
		private var loadingNoticeText:TextField;
		
		private var tabs:TabBar;
		private var transitionManager:TabBarSlideTransitionManager;
		
		// screens
		private var screenMatches:ScreenMatches;
		private var screenUpgrades:ScreenUpgrades;
		private var screenTownSquare:ScreenTownSquare;
		
		private var screenAchievements:ScreenAchievements;
		private var screenRankings:ScreenRankings;
		private var screenProfile:ScreenProfile;
		private var screenGetCoins:ScreenGetCoins;
		private var screenGetGems:ScreenGetGems;
		
		// dialog box
		private var dialogBox:DialogBox;
		
		// objective achievement effect
		private var badgeAnimation:MovieClip;
		private var badgeText:TextField;
		
		// countdown
		private var timeTillLifeCountdown:int = -1;
		private var timeUpdated:int;
		private var lives:int;
		
		// life giving
		private var lifeRequests:String; // incoming requests for life
		private var lifeReceipts:String; // received life from these
//		private var numLifeReceived:uint; // number of lives received
		
		private var countdownActive:Boolean;
		
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
						Statics.firstName = dataObj.first_name;
						Statics.lastName = dataObj.last_name;
						Statics.playerName = dataObj.first_name + " " + dataObj.last_name.substr(0, 1) + ".";
						Statics.playerHighScore = dataObj.high_score;
						
						// get player details
						// score
//						if (int(dataObj.high_score) > 0) { // existing player
//							label.text = "Welcome, " + dataObj.first_name + "! Your High Score: " + dataObj.high_score;
//						} else { // this is a new player
//							label.text = "Welcome to You Jump I Jump, " + dataObj.first_name + "!";
//						}
						Statics.playerCoins = int(dataObj.coins);
						Statics.playerGems = int(dataObj.gems);
						coinLabel.text = "Coins: " + dataObj.coins;
						gemLabel.text = "Gems: " + dataObj.gems;
						this.lives = int(dataObj.lives);
						rankLabel.text = "Lives: " + dataObj.lives;
						this.timeTillLifeCountdown = int(dataObj.time_till_next_life);
						this.timeUpdated = getTimer();
						
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
						Statics.rankExtraAbility = int(dataObj.rank_extra_ability);
						Statics.rankCoinDoubler = int(dataObj.rank_coin_doubler);
						
						// upgrade prices
						Statics.upgradePrices = dataObj.prices;
						
						var i:uint;
						// get earned achievements
						var numAchievements:int = dataObj.achievements.length;
						for (i = 0; i < numAchievements; i++) { // loop through matches retrieved
							Statics.achievementsList[int(dataObj.achievements[i].achievement_id)] = true;
							trace ("achievement " + int(dataObj.achievements[i].achievement_id) + " earned");
						}
						// update achievements screen
						this.screenAchievements.updateAchievementPlates();
						
						// parse player matches
						var matchesYourTurnCollection:ListCollection = new ListCollection();
						var matchesTheirTurnCollection:ListCollection = new ListCollection();
						var matchesFinishedCollection:ListCollection = new ListCollection();
						this.screenMatches.gamesMyTurn = new Array();
						this.screenMatches.gamesTheirTurn = new Array();
						this.screenMatches.gamesFinished = new Array();
						var numMatches:uint = dataObj.matches.length;
						for (i = 0; i < numMatches; i++) { // loop through matches retrieved
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
								matchesFinishedCollection.addItem({ title: "You resigned match against " + opponentName, caption: dataObj.matches[i].time_text});
								this.screenMatches.gamesFinished.push(dataObj.matches[i]);
							}
							else if (String(dataObj.matches[i].resigned_by) != "0") { // the opponent resigned this game
								matchesFinishedCollection.addItem({ title: opponentName + " resigned match against you", caption: dataObj.matches[i].time_text});
								this.screenMatches.gamesFinished.push(dataObj.matches[i]);
							}
							else { // no one resigned this game
								if (roundNumber >= 6) { // matched has ended
									matchesFinishedCollection.addItem({ title: "Match against " + opponentName, caption: dataObj.matches[i].time_text});
									this.screenMatches.gamesFinished.push(dataObj.matches[i]);
								} else { // match not yet ended
									if (Boolean(int(dataObj.matches[i].is_player_2))) { // is player 2
										if (roundNumber == 1) { // my first turn, allow resigning from match
											matchesYourTurnCollection.addItem({ title: opponentName + " has challenged you to a match!", caption: dataObj.matches[i].time_text});
											this.screenMatches.gamesMyTurn.push(dataObj.matches[i]);
										} else { // turn 3 or turn 5
											if (roundNumber % 2 == 1) {
												matchesYourTurnCollection.addItem({ title: "Your turn against " + opponentName, caption: dataObj.matches[i].time_text});
												this.screenMatches.gamesMyTurn.push(dataObj.matches[i]);
											}
											else {
												matchesTheirTurnCollection.addItem({ title: opponentName + "'s turn", caption: dataObj.matches[i].time_text});
												this.screenMatches.gamesTheirTurn.push(dataObj.matches[i]);
											}
										}
									} else { // is player 1
										if (roundNumber % 2 == 0) {
											matchesYourTurnCollection.addItem({ title: "Your turn against " + opponentName, caption: dataObj.matches[i].time_text });
											this.screenMatches.gamesMyTurn.push(dataObj.matches[i]);
										}
										else {
											matchesTheirTurnCollection.addItem({ title: opponentName + "'s turn", caption: dataObj.matches[i].time_text });
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
						
						// show start game button
						this.screenMatches.startGamePicker.visible = true;
						
						// process life requests
						var numLifeRequests:uint = dataObj.life_requests.length;
						var nameString:String = "";
						this.lifeRequests = "";
						if (numLifeRequests > 0) {
							for (i = 0; i < numLifeRequests; i++) { // loop through life requests
								nameString = nameString + dataObj.life_requests[i].name + " ";
								if (this.lifeRequests == "") this.lifeRequests += dataObj.life_requests[i].id;
								else this.lifeRequests = this.lifeRequests + "," + dataObj.life_requests[i].id;
//								trace("request id: " + dataObj.life_requests[i].id + " name: " + dataObj.life_requests[i].name);
							}
							if (numLifeRequests > 1) this.showDialogBox(nameString + "have asked you for a life, help them out?", true, sendLife); // plural
							else this.showDialogBox(nameString + "has asked you for a life, help them out?", true, sendLife); // singular
						}
						
						// process life receipts
						var numLifeReceipts:uint = dataObj.life_receipts.length;
//						this.numLifeReceived = numLifeReceipts;
						this.lifeReceipts = "";
						if (numLifeReceipts > 0) {
							for (i = 0; i < numLifeReceipts; i++) { // loop through life receipts
								nameString = nameString + dataObj.life_receipts[i].name + " ";
								if (this.lifeReceipts == "") this.lifeReceipts += dataObj.life_receipts[i].id;
								else this.lifeReceipts = this.lifeReceipts + "," + dataObj.life_receipts[i].id;
							}
							this.showDialogBox(nameString + "sent you a life. Accept and return the favor?", true, returnLife);
						}
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
					else if (dataObj.status == "rankings") {
						var rankingsGlobalCollection:ListCollection = new ListCollection();
						this.screenRankings.rankingsGlobal = new Array();
						var numRankings:int = dataObj.rankings.length;
						for (i = 0; i < numRankings; i++) { // loop through rankings retrieved
							rankingsGlobalCollection.addItem({ title: dataObj.rankings[i].firstname + " " + dataObj.rankings[i].lastname, 
								caption: dataObj.rankings[i].high_score,
								picture_url: dataObj.rankings[i].picture_url
							});
							this.screenRankings.rankingsGlobal.push(dataObj.rankings[i]);
						}
						this.screenRankings.listGlobal.dataProvider = rankingsGlobalCollection;
						
						this.screenRankings.refresh();
					}
					else if (dataObj.status == "purchased_upgrade") { // successfully purchased upgrade
						Statics.playerCoins = int(dataObj.coins);
						coinLabel.text = "Coins: " + dataObj.coins;
						Statics.playerGems = int(dataObj.gems);
						gemLabel.text = "Gems: " + dataObj.gems;
						Statics.rankTeleportation = int(dataObj.rank_teleportation);
						Statics.rankAttraction = int(dataObj.rank_attraction);
						Statics.rankDuplication = int(dataObj.rank_duplication);
						Statics.rankSafety = int(dataObj.rank_safety);
						Statics.rankBarrels = int(dataObj.rank_barrels);
						Statics.rankCannonballs = int(dataObj.rank_cannonballs);
						Statics.rankComet = int(dataObj.rank_comet);
						Statics.rankAbilityCooldown = int(dataObj.rank_ability_cooldown);
						Statics.rankAbilityPower = int(dataObj.rank_ability_power);
						Statics.rankExtraAbility = int(dataObj.rank_extra_ability);
						Statics.rankCoinDoubler = int(dataObj.rank_coin_doubler);
						Statics.upgradePrices = dataObj.prices;
						this.screenUpgrades.refresh();
						this.showAchievement("Self Improvement");
					}
					else if (dataObj.status == "purchased_coins") { // successfully purchased coins
						Statics.playerCoins = int(dataObj.coins);
						coinLabel.text = "Coins: " + dataObj.coins;
						Statics.playerGems = int(dataObj.gems);
						gemLabel.text = "Gems: " + dataObj.gems;
						this.showAchievement("Bling Bling");
					}
					else if (dataObj.status == "purchased_gems") { // successfully purchased gems
						Statics.playerGems = int(dataObj.gems);
						gemLabel.text = "Gems: " + dataObj.gems;
						this.showAchievement("Shiny!");
					}
					else if (dataObj.status == "purchased_lives") { // successfully purchased lives
						Statics.playerGems = int(dataObj.gems);
						gemLabel.text = "Gems: " + dataObj.gems;
						this.lives = 5;
						rankLabel.text = "Lives: 5";
						this.showAchievement("My Life Will Go On");
					}
					else if (dataObj.status == "error") { // error message received
						trace("Error: " + dataObj.reason);
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
			var bgImage:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("UiMainBg0000"));
			bgImage.pivotX = Math.ceil(bgImage.texture.width / 2);
			bgImage.x = stage.stageWidth / 2;
			this.addChild(bgImage);
			
			// top bar
			var topBar:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("UiMainTop0000"));
			this.addChild(topBar);
			
			// coin label
			coinLabel = new Label();
			coinLabel.text = "Coins: ";
			coinLabel.width = 160;
			coinLabel.height = 30;
			coinLabel.x = 180;
			coinLabel.y = 7;
			this.addChild(coinLabel);
			
			// gem label
			gemLabel = new Label();
			gemLabel.text = "Gems: ";
			gemLabel.width = 160;
			gemLabel.height = 30;
			gemLabel.x = coinLabel.bounds.right + 20;
			gemLabel.y = 7;
			this.addChild(gemLabel);
			
			// rank label
			rankLabel = new Label();
			rankLabel.text = "Lives: ";
			rankLabel.width = 80;
			rankLabel.height = 30;
			rankLabel.x = gemLabel.bounds.right + 20;
			rankLabel.y = 7;
			this.addChild(rankLabel);
			
			// time till next life label
			countdownLabel = new Label();
			countdownLabel.width = 160;
			countdownLabel.height = 30;
			countdownLabel.x = rankLabel.bounds.right + 20;
			countdownLabel.y = 7;
			this.addChild(countdownLabel);
			
			// loading screen
			createLoadingNotice();
			
			// screens
			this.screenMatches = new ScreenMatches();
			this.screenUpgrades = new ScreenUpgrades();
			this.screenTownSquare = new ScreenTownSquare();
			
			this.addEventListener(Event.CHANGE, navigatorChangeHandler);
			this.addScreen(Constants.ScreenMatches, new ScreenNavigatorItem(screenMatches));
			this.addScreen(Constants.ScreenUpgrades, new ScreenNavigatorItem(screenUpgrades));
			this.addScreen(Constants.ScreenTownSquare, new ScreenNavigatorItem(screenTownSquare));
			
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
					{ label: "Town Square", action: Constants.ScreenTownSquare }
				]);
			tabs.addEventListener( Event.CHANGE, tabsChangeHandler );
			this.addChild(tabs);
			
			// screen transitions
			this.transitionManager = new TabBarSlideTransitionManager(this, this.tabs);
			this.transitionManager.duration = 0.4;
			
			// custom screens
			// achievements screen
			screenAchievements = new ScreenAchievements(this);
			screenAchievements.visible = false;
			this.addChild(screenAchievements);
			
			// rankings screen
			screenRankings = new ScreenRankings(this);
			screenRankings.visible = false;
			this.addChild(screenRankings);
			
			// profile screen
			screenProfile = new ScreenProfile(this);
			screenProfile.visible = false;
			this.addChild(screenProfile);
			
			// get coins screen
			screenGetCoins = new ScreenGetCoins(this);
			screenGetCoins.visible = false;
			this.addChild(screenGetCoins);
			
			// get gems screen
			screenGetGems = new ScreenGetGems(this);
			screenGetGems.visible = false;
			this.addChild(screenGetGems);
			
			// dialog box
			dialogBox = new DialogBox(this);
			dialogBox.visible = false;
			this.addChild(dialogBox);
			
			// objective achievement effect
			badgeAnimation = new MovieClip(Assets.getSprite("AtlasTexture4").getTextures("BadgeFlash"), 30);
			badgeAnimation.pivotX = Math.ceil(badgeAnimation.width  / 2); // center art on registration point
			badgeAnimation.pivotY = Math.ceil(badgeAnimation.height / 2);
			badgeAnimation.x = Constants.StageWidth / 2;
			badgeAnimation.y = Constants.StageHeight - 130;
			badgeAnimation.loop = false;
			badgeAnimation.visible = false;
			this.addChild(badgeAnimation);
			
			// objective achievement message
			var fontVerdana14:Font = Fonts.getFont("Verdana14");
			badgeText = new TextField(200, 100, "", fontVerdana14.fontName, fontVerdana14.fontSize, 0xffffff);
			badgeText.hAlign = HAlign.CENTER;
			badgeText.vAlign = VAlign.CENTER;
			badgeText.x = stage.stageWidth / 2 - 100;
			badgeText.y = stage.stageHeight - 130 - 53;
			badgeText.visible = false;
			this.addChild(badgeText);
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
			
			// hide custom screens
			screenAchievements.visible = false;
			screenRankings.visible = false;
			screenProfile.visible = false;
			screenGetCoins.visible = false;
			screenGetGems.visible = false;
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
			
			// set up achievements, the element at index 0 is not used in order to sync with db ids
			Statics.achievementsList = new Vector.<Boolean>();
			for (var i:uint = 0; i < 36; i++) {
				Statics.achievementsList[i] = false;
			}
			
			this.countdownActive = true;
			this.updateCountdown();
		}
		
		private function refreshMatches():void {
			displayLoadingNotice("Refreshing matches...");
			this.communicator.addEventListener(NavigationEvent.RESPONSE_RECEIVED, dataReceived);
			this.communicator.retrieveUserData();
		}
		
		public function refreshRankingsGlobal():void {
			displayLoadingNotice("Refreshing rankings...");
			this.communicator.addEventListener(NavigationEvent.RESPONSE_RECEIVED, dataReceived);
			this.communicator.retrieveRankingsGlobal();
		}
		
		public function refreshRankingsFriends():void {
			displayLoadingNotice("Refreshing rankings...");
			this.communicator.addEventListener(NavigationEvent.RESPONSE_RECEIVED, dataReceived);
			this.communicator.retrieveRankingsFriends();
		}
		
		public function disposeTemporarily():void
		{
			this.visible = false;
		}
		
		/**
		 * Display achievement badge
		 */
		public function showAchievement(message:String):void {
			// bring achievement badge to front
			setChildIndex(badgeAnimation, numChildren - 1);
			setChildIndex(badgeText, numChildren - 1);
			
			starling.core.Starling.juggler.add(badgeAnimation);
			badgeAnimation.alpha = 1;
			badgeAnimation.visible = true;
			badgeAnimation.play();
			if (!Sounds.sfxMuted) Sounds.sndGong.play();
			badgeText.text = message;
			badgeText.alpha = 1;
			badgeText.visible = true;
			Starling.juggler.delayCall(fadeOutAchievement, 3);
		}
		
		/**
		 * Fade out the achievement badge
		 */
		private function fadeOutAchievement():void {
			badgeAnimation.stop();
			starling.core.Starling.juggler.remove(badgeAnimation);
			Starling.juggler.tween(badgeAnimation, 1, {
				transition: Transitions.LINEAR,
				alpha: 0
			});
			Starling.juggler.tween(badgeText, 1, {
				transition: Transitions.LINEAR,
				alpha: 0
			});
			Starling.juggler.delayCall(hideAchievement, 1);
		}
		
		/**
		 * Hide the achievement badge
		 */
		private function hideAchievement():void {
			badgeAnimation.visible = false;
			badgeText.visible = false;
		}
		
		public function showAchievementsScreen(event:Event):void {
			screenAchievements.refresh();
			screenAchievements.visible = true;
			setChildIndex(screenAchievements, numChildren - 1);
		}
		
		public function showRankingsScreen(event:Event):void {
			this.refreshRankingsGlobal();
			screenRankings.visible = true;
			setChildIndex(screenRankings, this.getChildIndex(this.loadingNotice) - 1);
		}
		
		public function showProfileScreen(event:Event):void {
			screenProfile.visible = true;
			setChildIndex(screenProfile, numChildren - 1);
			var playerData:Object = new Object();
			playerData.firstname = Statics.firstName;
			playerData.lastname = Statics.lastName;
			playerData.high_score = Statics.playerHighScore;
			screenProfile.refresh(playerData);
		}
		
		public function showProfileScreenGivenData(playerData:Object):void {
			screenProfile.visible = true;
			setChildIndex(screenProfile, numChildren - 1);
			screenProfile.refresh(playerData);
		}
		
		public function showGetCoinsScreen(event:Event):void {
			screenGetCoins.refresh();
			screenGetCoins.visible = true;
			setChildIndex(screenGetCoins, numChildren - 1);
		}
		
		public function showGetGemsScreen(event:Event):void {
			screenGetGems.refresh();
			screenGetGems.visible = true;
			setChildIndex(screenGetGems, numChildren - 1);
		}
		
		public function showDialogBox(prompt:String, isTwoButton:Boolean, callbackFunction = null):void {
			trace("showing dialog box...");
			dialogBox.show(prompt, isTwoButton, callbackFunction);
			setChildIndex(dialogBox, numChildren - 1);
		}
		
		public function dialogCloseHandler(event:Event):void {
			dialogBox.visible = false;
		}
		
		public function dialogCancelHandler(event:Event):void {
			dialogBox.removeOkButtonListeners(); // remove extra event listeners on the OK button
			dialogBox.visible = false;
		}
		
		public function hideDialogBox():void {
			dialogBox.visible = false;
		}
		
		public function roundBegin():Boolean {
			if (this.lives < 1) {
				//this.showDialogBox("You do not have enough lives, would you like to ask friends for more?", true, showAskFriendsForLives);
				this.showDialogBox("You do not have enough lives, would you like to purchase a full set for " + Constants.SetOfLivesCost + " gems?", true, purchaseLivesWithGems);
				return false;
			}
			
			// disable life countdown
			this.deactivateCountdown();
			
			// heart fly out animation
			this.lives--;
//			rankLabel.text = "Lives: " + String(this.lives);
			
			this.communicator.sendRoundBegin();
			return true;
		}
		
		// show the apprequests dialog to pick friends to ask for lives
		private function showAskFriendsForLives():void {
			if(ExternalInterface.available){
				trace("Calling JS...");
				ExternalInterface.call("selectFriendsForLife");
//				ExternalInterface.addCallback("returnFriendsForLifeToAs", friendsForLifeReturnedFromAs);
			} else {
				trace("External interface unavailabe");
			}
			
			this.hideDialogBox();
		}
		
		// show the facebook dialog to purchase a full set of lives with gems
		private function purchaseLivesWithGems():void {
			this.hideDialogBox();
			
			if (Statics.playerGems < Constants.SetOfLivesCost) { // player can't afford this
				// show get gems prompt
				this.showDialogBox("You do not have enough gems,\n would you like to get more?", true, showGetGemsScreen);
				return;
			}
			
			var jsonStr:String = JSON.stringify({
				item: 'lives'
			});
			this.displayLoadingNotice("Conjuring some lives...");
			this.communicator.addEventListener(NavigationEvent.RESPONSE_RECEIVED, dataReceived);
			this.communicator.postPurchaseLives(jsonStr);
		}
		
		// call js to send life
		private function sendLife():void {
			if(ExternalInterface.available){
				trace("Calling JS...");
				ExternalInterface.call("sendLife", this.lifeRequests);
			} else {
				trace("External interface unavailabe");
			}
			
			this.hideDialogBox();
		}
		
		// call js to return the favor of sending a life
		private function returnLife():void {
			// add lives received to current lives (this is already done in backend)
//			this.lives += this.numLifeReceived;
//			if (this.lives > 5) this.lives = 5;
//			rankLabel.text = "Lives: " + String(this.lives);
			
			if(ExternalInterface.available){
				trace("Calling JS... " + this.lifeReceipts);
				ExternalInterface.call("sendLife", this.lifeReceipts);
			} else {
				trace("External interface unavailabe");
			}
			
			this.hideDialogBox();
		}
		
		public function updateCountdown():void {
			if (this.timeTillLifeCountdown != -1 && this.lives < 5) {
				var timeCurrent:int = getTimer() - this.timeUpdated;
				var elapsedSeconds:int = int(timeCurrent / 1000);
				var remainingSeconds:int = this.timeTillLifeCountdown - elapsedSeconds;
				if (remainingSeconds <= 0) {
					this.timeTillLifeCountdown += Constants.SecondsPerLife;
					this.lives++;
					rankLabel.text = "Lives: " + String(this.lives);
				}
				
				if (this.lives == 5 && remainingSeconds <= 0) countdownLabel.text = ""; // hide '0' on full life
				else countdownLabel.text = String(remainingSeconds);
			} else {
				countdownLabel.text = "";
			}
			
			if (this.countdownActive) Starling.juggler.delayCall(updateCountdown, 1);
		}
		
		public function deactivateCountdown():void {
			this.countdownActive = false;
		}
	}
}