package com.jumpGame.screens
{
	import com.jumpGame.customObjects.Font;
	import com.jumpGame.customObjects.PictureLoader;
	import com.jumpGame.events.NavigationEvent;
	import com.jumpGame.level.Statics;
	import com.jumpGame.ui.popups.DialogBox;
	import com.jumpGame.ui.popups.GetLives;
	import com.jumpGame.ui.popups.MatchDataContainer;
	import com.jumpGame.ui.popups.ScreenAchievements;
	import com.jumpGame.ui.popups.ScreenCharacters;
	import com.jumpGame.ui.popups.ScreenGetCoins;
	import com.jumpGame.ui.popups.ScreenGetGems;
	import com.jumpGame.ui.popups.ScreenProfile;
	import com.jumpGame.ui.popups.ScreenRankings;
	import com.jumpGame.ui.screens.ScreenMatches;
	import com.jumpGame.ui.screens.ScreenTownSquare;
	import com.jumpGame.ui.screens.ScreenUpgrades;
	
	import flash.external.ExternalInterface;
	import flash.utils.getTimer;
	
	import feathers.controls.Button;
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
		private var coinLabel:TextField;
		private var gemLabel:TextField;
		private var lifeLabel:TextField;
		private var countdownLabel:TextField;
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
		private var screenCharacters:ScreenCharacters;
		private var screenGetCoins:ScreenGetCoins;
		private var screenGetGems:ScreenGetGems;
		private var popupGetLives:GetLives;
		
		// dialog box
		private var dialogBox1:DialogBox;
		private var dialogBox2:DialogBox;
		
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
		
		// profile picture loader
		public var pictureLoader:PictureLoader;
		
		// match details popup
		public var matchDataPopup:MatchDataContainer;
		
		// rankings data
		private var rankingsCollection:ListCollection;
		
		public function Menu()
		{
			super();
			
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, addedToStageHandler);
			
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
						Statics.facebookId = dataObj.facebook_id;
						Statics.firstName = dataObj.first_name;
						Statics.lastName = dataObj.last_name;
						Statics.playerName = dataObj.first_name + " " + dataObj.last_name.substr(0, 1) + ".";
						Statics.playerHighScore = int(dataObj.high_score);
						Statics.playerCoins = int(dataObj.coins);
						Statics.playerGems = int(dataObj.gems);
						coinLabel.text = dataObj.coins;
						gemLabel.text = dataObj.gems;
						this.lives = int(dataObj.lives);
						lifeLabel.text = dataObj.lives;
						this.timeTillLifeCountdown = int(dataObj.time_till_next_life);
						this.timeUpdated = getTimer();
						
						// get player profile picture
//						if (Statics.playerPictureBitmap == null && dataObj.picture != "none") {
//							Statics.playerPictureWidth = uint(dataObj.picture_width);
//							loader.load(new URLRequest(dataObj.picture));
//							loader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, onPictureLoadComplete);
//						}
						if (Statics.playerPictureBitmap == null) {
							matchDataPopup.getProfilePictureUrlFromJs(dataObj.facebook_id);
//							Statics.playerPictureWidth = uint(dataObj.picture_width);
//							loader.load(new URLRequest(dataObj.picture));
//							loader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, onPictureLoadComplete);
						}
						
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
											matchesYourTurnCollection.addItem({ title: opponentName + " challenges you to a match!", caption: dataObj.matches[i].time_text});
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
							if (numLifeRequests > 1) this.showDialogBox(nameString + "have asked you for a life, help them out?", sendLife); // plural
							else this.showDialogBox(nameString + "has asked you for a life, help them out?", sendLife); // singular
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
							this.showDialogBox(nameString + "sent you a life. Accept and return the favor?", returnLife);
						}
					}
					else if (dataObj.status == "new_match") { // new game created
						// display match data popup
//						Statics.opponentName = dataObj.opponent_first_name + " " + dataObj.opponent_last_name.toString().substr(0, 1) + ".";
						Statics.opponentName = dataObj.opponent_first_name + "\n" + dataObj.opponent_last_name;
						Statics.roundScores = [0, 0, 0, 0, 0, 0];
						Statics.isPlayer2 = false;
						Statics.gameId = dataObj.game_id;
						Statics.opponentFbid = dataObj.opponent_fbid;
						Statics.resignedBy = '0';
						this.showMatchDetailsPopup(false);
					}
					else if (dataObj.status == "rankings") {
						rankingsCollection = new ListCollection();
						this.screenRankings.rankingsArray.length = 0;
						var numRankings:int = dataObj.rankings.length;
						for (i = 0; i < numRankings; i++) { // loop through rankings retrieved
							if (dataObj.rankings[i].picture != null) { // picture available
								rankingsCollection.addItem({
									title: dataObj.rankings[i].firstname + " " + dataObj.rankings[i].lastname, 
									caption: dataObj.rankings[i].high_score,
									facebook_id: dataObj.rankings[i].facebookId,
									picture_url: dataObj.rankings[i].picture.url,
									picture_width: uint(dataObj.rankings[i].picture.width)
								});
							} else { // no picture
								rankingsCollection.addItem({
									title: dataObj.rankings[i].firstname + " " + dataObj.rankings[i].lastname, 
									caption: dataObj.rankings[i].high_score,
									facebook_id: dataObj.rankings[i].facebookId,
									picture_url: "none",
									picture_width: 0
								});
							}
							this.screenRankings.rankingsArray.push(dataObj.rankings[i]);
						}
						this.screenRankings.listRankings.dataProvider = rankingsCollection;
					}
					else if (dataObj.status == "purchased_upgrade") { // successfully purchased upgrade
						Statics.playerCoins = int(dataObj.coins);
						coinLabel.text = dataObj.coins;
						Statics.playerGems = int(dataObj.gems);
						gemLabel.text = dataObj.gems;
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
						coinLabel.text = dataObj.coins;
						Statics.playerGems = int(dataObj.gems);
						gemLabel.text = dataObj.gems;
						this.showAchievement("Bling Bling");
					}
					else if (dataObj.status == "purchased_gems") { // successfully purchased gems
						Statics.playerGems = int(dataObj.gems);
						gemLabel.text = dataObj.gems;
						this.showAchievement("Shiny!");
					}
					else if (dataObj.status == "purchased_lives") { // successfully purchased lives
						Statics.playerGems = int(dataObj.gems);
						gemLabel.text = dataObj.gems;
						this.lives = 5;
						lifeLabel.text = "5";
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
		
		private function addedToStageHandler(event:starling.events.Event):void
		{
			DeviceCapabilities.dpi = 326; //simulate iPhone Retina resolution
//			this.theme = new MetalWorksMobileTheme(this.stage);
			
			// bg
			var bgImage:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("UiMainBg0000"));
			bgImage.pivotX = Math.ceil(bgImage.texture.width / 2);
			bgImage.x = stage.stageWidth / 2;
			this.addChild(bgImage);
			
			// top bar
			var topBar:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("UiMainTop0000"));
			this.addChild(topBar);
			
			// bottom bar
			var bottomBar:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("UiMainBottom0000"));
			bottomBar.pivotY = bottomBar.height;
			bottomBar.y = Statics.stageHeight;
			this.addChild(bottomBar);
			
			// rank badge
			var rankBadge:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("RankBadge10000"));
			rankBadge.x = 15;
			rankBadge.y = 5;
			this.addChild(rankBadge);
			
			// top bar label font
			var fontVerdana23:Font = Fonts.getFont("Badaboom25");
			var topBarLabelsY:Number = 24;
			var topBarButtonsY:Number = 20;
			
			// coin label
			coinLabel = new TextField(120, 25, "", fontVerdana23.fontName, fontVerdana23.fontSize, 0xffffff);
			coinLabel.hAlign = HAlign.LEFT;
			coinLabel.vAlign = VAlign.TOP;
			coinLabel.x = 120;
			coinLabel.y = topBarLabelsY;
			this.addChild(coinLabel);
			
			// add coins button
			var buttonAddCoins:Button = new Button();
			buttonAddCoins.useHandCursor = true;
			buttonAddCoins.defaultSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ButtonMainTopPlus0000"))
			buttonAddCoins.hoverSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ButtonMainTopPlus0000"));
			buttonAddCoins.downSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ButtonMainTopPlus0000"));
			buttonAddCoins.hoverSkin.filter = Statics.btnBrightnessFilter;
			buttonAddCoins.downSkin.filter = Statics.btnInvertFilter;
			buttonAddCoins.x = 212;
			buttonAddCoins.y = topBarButtonsY;
			buttonAddCoins.addEventListener(starling.events.Event.TRIGGERED, showGetCoinsScreen);
			this.addChild(buttonAddCoins);
			
			// gem label
			gemLabel = new TextField(120, 25, "", fontVerdana23.fontName, fontVerdana23.fontSize, 0xffffff);
			gemLabel.hAlign = HAlign.LEFT;
			gemLabel.vAlign = VAlign.TOP;
			gemLabel.x = 289;
			gemLabel.y = topBarLabelsY;
			this.addChild(gemLabel);
			
			// add gems button
			var buttonAddGems:Button = new Button();
			buttonAddGems.useHandCursor = true;
			buttonAddGems.defaultSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ButtonMainTopPlus0000"))
			buttonAddGems.hoverSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ButtonMainTopPlus0000"));
			buttonAddGems.downSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ButtonMainTopPlus0000"));
			buttonAddGems.hoverSkin.filter = Statics.btnBrightnessFilter;
			buttonAddGems.downSkin.filter = Statics.btnInvertFilter;
			buttonAddGems.x = 379;
			buttonAddGems.y = topBarButtonsY;
			buttonAddGems.addEventListener(starling.events.Event.TRIGGERED, showGetGemsScreen);
			this.addChild(buttonAddGems);
			
			// rank label
			lifeLabel = new TextField(15, 25, "", fontVerdana23.fontName, fontVerdana23.fontSize, 0xffffff);
			lifeLabel.hAlign = HAlign.LEFT;
			lifeLabel.vAlign = VAlign.TOP;
			lifeLabel.x = 431;
			lifeLabel.y = topBarLabelsY;
			this.addChild(lifeLabel);
			
			// add lives button
			var buttonAddLives:Button = new Button();
			buttonAddLives.useHandCursor = true;
			buttonAddLives.defaultSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ButtonMainTopPlus0000"))
			buttonAddLives.hoverSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ButtonMainTopPlus0000"));
			buttonAddLives.downSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ButtonMainTopPlus0000"));
			buttonAddLives.hoverSkin.filter = Statics.btnBrightnessFilter;
			buttonAddLives.downSkin.filter = Statics.btnInvertFilter;
			buttonAddLives.x = 545;
			buttonAddLives.y = topBarButtonsY;
			buttonAddLives.addEventListener(starling.events.Event.TRIGGERED, btnAddLivesHandler);
			this.addChild(buttonAddLives);
			
			// time till next life label
			countdownLabel = new TextField(80, 25, "", fontVerdana23.fontName, fontVerdana23.fontSize, 0xffffff);
			countdownLabel.hAlign = HAlign.LEFT;
			countdownLabel.vAlign = VAlign.TOP;
			countdownLabel.x = lifeLabel.bounds.right + 20;
			countdownLabel.y = topBarLabelsY;
			this.addChild(countdownLabel);
			
			// invite friends button
			var buttonInviteFriends:Button = new Button();
			buttonInviteFriends.useHandCursor = true;
			buttonInviteFriends.defaultSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ButtonInviteFriends0000"))
			buttonInviteFriends.hoverSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ButtonInviteFriends0000"));
			buttonInviteFriends.downSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ButtonInviteFriends0000"));
			buttonInviteFriends.hoverSkin.filter = Statics.btnBrightnessFilter;
			buttonInviteFriends.downSkin.filter = Statics.btnInvertFilter;
			buttonInviteFriends.x = 597;
			buttonInviteFriends.y = topBarButtonsY;
			buttonInviteFriends.addEventListener(starling.events.Event.TRIGGERED, inviteFriends);
			this.addChild(buttonInviteFriends);
			
			// loading screen
			createLoadingNotice();
			
			// screens
			this.screenMatches = new ScreenMatches();
			this.screenUpgrades = new ScreenUpgrades();
			this.screenTownSquare = new ScreenTownSquare();
			
			this.addEventListener(starling.events.Event.CHANGE, navigatorChangeHandler);
			this.addScreen(Constants.ScreenMatches, new ScreenNavigatorItem(screenMatches));
			this.addScreen(Constants.ScreenUpgrades, new ScreenNavigatorItem(screenUpgrades));
			this.addScreen(Constants.ScreenTownSquare, new ScreenNavigatorItem(screenTownSquare));
			
			// tab bar
			tabs = new TabBar();
			tabs.useHandCursor = true;
			// middle tab button
			tabs.tabFactory = function():Button
			{
				var tab:Button = new Button();
				tab.defaultSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("TabButtonMiddle0000"));
				tab.hoverSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("TabButtonMiddle0000"));
				tab.downSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("TabButtonMiddle0000"));
				tab.defaultSelectedSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("TabButtonMiddle0000"));
				
				tab.hoverSkin.filter = Statics.btnBrightnessFilter;
				tab.downSkin.filter = Statics.btnInvertFilter;
				tab.defaultSelectedSkin.filter = Statics.btnContrastFilter;
				return tab;
			};
			// left tab button
			tabs.firstTabFactory = function():Button
			{
				var tab:Button = new Button();
				tab.defaultSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("TabButtonLeft0000"));
				tab.hoverSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("TabButtonLeft0000"));
				tab.downSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("TabButtonLeft0000"));
				tab.defaultSelectedSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("TabButtonLeft0000"));
				
				tab.hoverSkin.filter = Statics.btnBrightnessFilter;
				tab.downSkin.filter = Statics.btnInvertFilter;
				tab.defaultSelectedSkin.filter = Statics.btnContrastFilter;
				return tab;
			};
			// right tab button
			tabs.lastTabFactory = function():Button
			{
				var tab:Button = new Button();
				tab.defaultSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("TabButtonRight0000"));
				tab.hoverSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("TabButtonRight0000"));
				tab.downSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("TabButtonRight0000"));
				tab.defaultSelectedSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("TabButtonRight0000"));
				
				tab.hoverSkin.filter = Statics.btnBrightnessFilter;
				tab.downSkin.filter = Statics.btnInvertFilter;
				tab.defaultSelectedSkin.filter = Statics.btnContrastFilter;
				return tab;
			};
			tabs.width = stage.stageWidth;
			tabs.height = 48;
			tabs.pivotY = tabs.height;
			tabs.y = stage.stageHeight;
			tabs.dataProvider = new ListCollection(
				[
					{ label: "Matches", action: Constants.ScreenMatches },
					{ label: "Upgrades", action: Constants.ScreenUpgrades },
					{ label: "Town Square", action: Constants.ScreenTownSquare }
				]);
			tabs.addEventListener(starling.events.Event.CHANGE, tabsChangeHandler);
			this.addChild(tabs);
			
			// screen transitions
			this.transitionManager = new TabBarSlideTransitionManager(this, this.tabs);
			this.transitionManager.duration = 0.4;
			
			// custom screens
			// match details popup
			matchDataPopup = new MatchDataContainer(this);
			matchDataPopup.visible = false;
			this.addChild(matchDataPopup);
			
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
			
			// characters screen
			screenCharacters = new ScreenCharacters(this);
			screenCharacters.visible = false;
			this.addChild(screenCharacters);
			
			// get coins screen
			screenGetCoins = new ScreenGetCoins(this);
			screenGetCoins.visible = false;
			this.addChild(screenGetCoins);
			
			// get gems screen
			screenGetGems = new ScreenGetGems(this);
			screenGetGems.visible = false;
			this.addChild(screenGetGems);
			
			// get lives popup
			popupGetLives = new GetLives(this);
			popupGetLives.visible = false;
			this.addChild(popupGetLives);
			
			// dialog boxes
			dialogBox1 = new DialogBox(this);
			dialogBox1.visible = false;
			this.addChild(dialogBox1);
			
			dialogBox2 = new DialogBox(this);
			dialogBox2.visible = false;
			this.addChild(dialogBox2);
			
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
			
			// create picture loader object
			pictureLoader = new PictureLoader();
			pictureLoader.addEventListener("newPictureLoaded", onPictureLoaded);
		}
		
		private function onPictureLoaded(event:Event, data:String):void
		{
			trace("picture loaded event received: " + data);
			if (rankingsCollection) {
				var numRankings:int = rankingsCollection.length;
				for (var i:uint = 0; i < numRankings; i++) { // loop through rankings retrieved
					var rankingsObject:Object = rankingsCollection.getItemAt(i);
					if (rankingsObject.facebook_id == data) {
						trace("yes!!");
					}
				}
//				this.screenRankings.listRankings.dataProvider = rankingsCollection;
			}
		}
		
		private function traceObject(o:Object):void{
			trace('\n');
			for(var val:* in o){
				trace('   [' + typeof(o[val]) + '] ' + val + ' => ' + o[val]);
			}
			trace('\n');
		}
		
		private function navigatorChangeHandler(event:starling.events.Event):void
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
			screenCharacters.visible = false;
			screenGetCoins.visible = false;
			screenGetGems.visible = false;
			popupGetLives.visible = false;
		}
		
		private function tabsChangeHandler(event:starling.events.Event):void
		{
			trace("tabs change");
			// trigger match data refresh
			
			if (this.tabs.selectedIndex == -1) {
				return;
			}
			
			// display the selected screen
			this.showScreen(this.tabs.selectedItem.action);
			
			// when displaying the matches screen, refresh matches
			if (this.tabs.selectedItem.action == Constants.ScreenMatches) {
				this.screenMatches.visible = true;
				this.refreshMatches();
			}
			// when displaying the upgrades screen, refresh upgrades
			else if (this.tabs.selectedItem.action == Constants.ScreenUpgrades) {
				this.screenUpgrades.visible = true;
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
			this.setChildIndex(loadingNotice, numChildren - 1);
			this.setChildIndex(matchDataPopup, numChildren - 1);
			loadingNotice.visible = true;
		}
		
		private function dismissLoadingNotice():void {
			loadingNotice.visible = false;
		}
		
		public function initialize():void
		{
			this.visible = true;
			this.tabs.selectedIndex = -1;
			this.tabs.validate();
			this.tabs.selectedIndex = 0; // trigger match data refresh
			
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
		
		public function showMatchDetailsPopup(isDone:Boolean):void {
			matchDataPopup.initialize(isDone);
			setChildIndex(matchDataPopup, numChildren - 1);
		}
		
		public function showAchievementsScreen(event:starling.events.Event):void {
			setChildIndex(screenAchievements, numChildren - 1);
			screenAchievements.initialize();
		}
		
		public function showRankingsScreen(event:starling.events.Event):void {
			this.refreshRankingsGlobal();
			setChildIndex(screenRankings, this.getChildIndex(this.loadingNotice) - 1);
			screenRankings.initialize();
		}
		
		public function showProfileScreen(event:starling.events.Event):void {
			setChildIndex(screenProfile, numChildren - 1);
			var playerData:Object = new Object();
			playerData.firstname = Statics.firstName;
			playerData.lastname = Statics.lastName;
			playerData.high_score = Statics.playerHighScore.toString();
			screenProfile.initialize(playerData);
		}
		
		public function showProfileScreenGivenData(playerData:Object):void {
			setChildIndex(screenProfile, numChildren - 1);
			screenProfile.initialize(playerData);
		}
		
		public function showCharactersScreen(event:starling.events.Event):void {
			setChildIndex(screenCharacters, numChildren - 1);
			screenCharacters.initialize();
		}
		
		public function showGetCoinsScreen(event:starling.events.Event):void {
			setChildIndex(screenGetCoins, numChildren - 1);
			screenGetCoins.initialize();
		}
		
		public function showGetGemsScreen(event:starling.events.Event = null):void {
			setChildIndex(screenGetGems, numChildren - 1);
			screenGetGems.initialize();
		}
		
		private function btnAddLivesHandler(event:starling.events.Event):void {
			this.showGetLivesPopup();
		}
		
		private function showGetLivesPopup(isOut:Boolean = false):void {
			setChildIndex(popupGetLives, numChildren - 1);
			popupGetLives.show(isOut);
		}
		
		public function showBuyLivesDialog():void {
			this.showDialogBox("Would you like to purchase a full set of lives for " + Constants.SetOfLivesCost + " gems?", purchaseLivesWithGems);
		}
		
//		public function showAskForLivesDialog():void {
//			this.showDialogBox("Would you like to ask friends for more?", showAskFriendsForLives);
//		}
		
		public function showDialogBox(prompt:String, callbackFunction = null):void {
			if (!dialogBox1.isInUse) {
				dialogBox1.show(prompt, callbackFunction);
				setChildIndex(dialogBox1, numChildren - 1);
			}
			else if (!dialogBox2.isInUse) {
				dialogBox2.show(prompt, callbackFunction);
				setChildIndex(dialogBox2, numChildren - 1);
			}
			else {
				trace("No dialog boxes available");
			}
		}
		
//		public function dialogCloseHandler(event:starling.events.Event):void {
//			dialogBox.visible = false;
//		}
		
//		public function dialogCancelHandler(event:starling.events.Event):void {
//			dialogBox.removeOkButtonListeners(); // remove extra event listeners on the OK button
//			dialogBox.visible = false;
//		}
		
//		public function hideDialogBox():void {
//			dialogBox.visible = false;
//		}
		
		public function roundBegin():Boolean {
			if (this.lives < 1) {
				this.showGetLivesPopup(true); // show get lives popup with out of lives header
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
		public function showAskFriendsForLives():void {
			if(ExternalInterface.available){
				trace("Calling JS...");
				ExternalInterface.call("selectFriendsForLife");
//				ExternalInterface.addCallback("returnFriendsForLifeToAs", friendsForLifeReturnedFromAs);
			} else {
				trace("External interface unavailabe");
			}
		}
		
		// show the facebook dialog to purchase a full set of lives with gems
		private function purchaseLivesWithGems():void {
			if (Statics.playerGems < Constants.SetOfLivesCost) { // player can't afford this
				// show get gems prompt
				this.showDialogBox("You do not have enough gems, would you like to get more?", showGetGemsScreen);
				return;
			}
			
			var jsonStr:String = JSON.stringify({
				item: 'lives'
			});
			this.displayLoadingNotice("Cooking up some lives...");
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
			
//			this.hideDialogBox();
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
			
//			this.hideDialogBox();
		}
		
		public function updateCountdown():void {
			if (this.timeTillLifeCountdown != -1 && this.lives < 5) {
				var timeCurrent:int = getTimer() - this.timeUpdated;
				var elapsedSeconds:int = int(timeCurrent / 1000);
				var remainingSeconds:int = this.timeTillLifeCountdown - elapsedSeconds;
				if (remainingSeconds <= 0) {
					this.timeTillLifeCountdown += Constants.SecondsPerLife;
					this.lives++;
					lifeLabel.text = String(this.lives);
				}
				
				if (this.lives == 5 && remainingSeconds <= 0) countdownLabel.text = "full"; // hide '0' on full life
				else countdownLabel.text = this.formatTime(remainingSeconds);
			} else {
				countdownLabel.text = "full";
			}
			
			if (this.countdownActive) Starling.juggler.delayCall(updateCountdown, 1);
		}
		
		public function deactivateCountdown():void {
			this.countdownActive = false;
		}
		
		public function buttonClosePopupHandler(event:starling.events.Event):void {
			this.tabs.selectedIndex = -1;
			this.screenMatches.visible = false;
			this.screenUpgrades.visible = false;
		}
		
		private function inviteFriends():void {
			if(ExternalInterface.available){
				trace("Calling JS...");
				ExternalInterface.call("inviteFriends");
			} else {
				trace("External interface unavailabe");
			}
			
//			this.hideDialogBox();
		}
		
		private function formatTime(totalSeconds:int):String {
			var seconds:uint = totalSeconds % 60;
			var minutes:uint = (totalSeconds - seconds) / 60;
			if (seconds < 10) return String(minutes) + ":0" + String(seconds);
			else return String(minutes) + ":" + String(seconds);
		}
	}
}