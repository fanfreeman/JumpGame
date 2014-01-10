package com.jumpGame.screens
{
	import com.jumpGame.customObjects.Font;
	import com.jumpGame.customObjects.PictureLoader;
	import com.jumpGame.events.NavigationEvent;
	import com.jumpGame.gameElements.BgStar;
	import com.jumpGame.ui.components.Badge;
	import com.jumpGame.ui.components.TutorialPointer;
	import com.jumpGame.ui.popups.DialogBox;
	import com.jumpGame.ui.popups.DialogLarge;
	import com.jumpGame.ui.popups.GetLives;
	import com.jumpGame.ui.popups.Instructions;
	import com.jumpGame.ui.popups.MatchDataContainer;
	import com.jumpGame.ui.popups.PurchaseStatus;
	import com.jumpGame.ui.popups.ScreenAchievements;
	import com.jumpGame.ui.popups.ScreenCharacters;
	import com.jumpGame.ui.popups.ScreenGetCoins;
	import com.jumpGame.ui.popups.ScreenGetGems;
	import com.jumpGame.ui.popups.ScreenProfile;
	import com.jumpGame.ui.screens.ScreenMatches;
	import com.jumpGame.ui.screens.ScreenTownSquare;
	import com.jumpGame.ui.screens.ScreenUpgrades;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.utils.getTimer;
	
	import feathers.controls.Button;
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
	
	public class Menu extends ScreenNavigator
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
		public var screenMatches:ScreenMatches;
		private var screenUpgrades:ScreenUpgrades;
		private var screenTownSquare:ScreenTownSquare;
		
		private var screenAchievements:ScreenAchievements;
//		private var screenRankings:ScreenRankings;
		private var screenProfile:ScreenProfile;
		private var screenCharacters:ScreenCharacters;
		private var screenGetCoins:ScreenGetCoins;
		private var screenGetGems:ScreenGetGems;
		private var popupGetLives:GetLives;
		private var popupInstructions:Instructions;
		
		// dialog box
		private var dialogBox1:DialogBox;
		private var dialogBox2:DialogBox;
		
		// objective achievement effect
		private var badge:Badge;
		
		// purchase status popup
		private var purchaseStatus:PurchaseStatus;
		
		// countdown
		private var timeTillLifeCountdown:int = -1;
		private var timeUpdated:int;
		public var lives:int;
		
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
		public var rankingsCollection:ListCollection;
		
		// animated characters
		private var heroIdle:MovieClip;
		
		private var firstClickSoundHidden:Boolean = false; // hide very first click sound because of tab change on game start
		
		private var tutorialPointer:TutorialPointer;
		
		public var dialogLarge:DialogLarge; // large dialog box with just ok button
		
//		private var popupStory:ScreenStory;
		
		// snow
		private var starList:Vector.<BgStar>;
		private var starDx:Number;
		
		private var rankingsDisplayedOnStart:Boolean = false;
		
		public function Menu()
		{
			super();
			
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, addedToStageHandler);
			
			// Javascript Callbacks
//			ExternalInterface.addCallback("returnFbId", returnFbId);
			
			this.communicator = new Communicator();
			this.communicator.addEventListener(NavigationEvent.RESPONSE_RECEIVED, this.dataReceived);
		}
		
		/**
		 * Receive data from backend
		 */
		public function dataReceived(event:NavigationEvent):void {
			trace("data received!");
			
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
//						trace("high score: " + Statics.playerHighScore);
						Statics.playerCoins = int(dataObj.coins);
						Statics.playerGems = int(dataObj.gems);
						Statics.roundsPlayed = int(dataObj.rounds_played);
//						Statics.topFriendsIds = dataObj.top_friends;
						if (Statics.tutorialStep != 4) Statics.tutorialStep = int(dataObj.tutorial_step); // 4 means tutorials completed, so don't show tutorials again
						coinLabel.text = dataObj.coins;
						gemLabel.text = dataObj.gems;
						this.lives = int(dataObj.lives);
						lifeLabel.text = dataObj.lives;
						this.timeTillLifeCountdown = int(dataObj.time_till_next_life);
						this.timeUpdated = getTimer();
						
//						trace("environment: " + dataObj.environment);
						if (dataObj.environment == "prod") {
							Statics.isAnalyticsEnabled = true;
							Statics.mixpanel.people_set({
								"user id": String(dataObj.user_id),
								"first name": dataObj.first_name,
								"last name": dataObj.last_name
							});
							Statics.mixpanel.track('player data received');
						}
						
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
//							trace ("achievement " + int(dataObj.achievements[i].achievement_id) + " earned");
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
								matchesFinishedCollection.addItem({ title: "You resigned match vs " + opponentName, caption: dataObj.matches[i].time_text});
								this.screenMatches.gamesFinished.push(dataObj.matches[i]);
							}
							else if (String(dataObj.matches[i].resigned_by) != "0") { // the opponent resigned this game
								matchesFinishedCollection.addItem({ title: opponentName + " resigned match vs you", caption: dataObj.matches[i].time_text});
								this.screenMatches.gamesFinished.push(dataObj.matches[i]);
							}
							else { // no one resigned this game
								if (roundNumber >= 6) { // matched has ended
									matchesFinishedCollection.addItem({ title: "Match against " + opponentName, caption: dataObj.matches[i].time_text});
									this.screenMatches.gamesFinished.push(dataObj.matches[i]);
								} else { // match not yet ended
									if (Boolean(int(dataObj.matches[i].is_player_2))) { // is player 2
										if (roundNumber == 1) { // my first turn, allow resigning from match
											matchesYourTurnCollection.addItem({ title: opponentName + " challenges you to a match!", caption: dataObj.matches[i].time_text, isnew: true });
											this.screenMatches.gamesMyTurn.push(dataObj.matches[i]);
										} else { // turn 3 or turn 5
											if (roundNumber % 2 == 1) {
												matchesYourTurnCollection.addItem({ title: "Your turn vs " + opponentName, caption: dataObj.matches[i].time_text, isnew: true });
												this.screenMatches.gamesMyTurn.push(dataObj.matches[i]);
											}
											else {
												matchesTheirTurnCollection.addItem({ title: opponentName + "'s turn", caption: dataObj.matches[i].time_text});
												this.screenMatches.gamesTheirTurn.push(dataObj.matches[i]);
											}
										}
									} else { // is player 1
										if (roundNumber % 2 == 0) {
											matchesYourTurnCollection.addItem({ title: "Your turn vs " + opponentName, caption: dataObj.matches[i].time_text, isnew: true });
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
						
						// tutorial
//						if (Statics.tutorialStep == 1 && Statics.roundsPlayed == 0 && this.screenMatches.gamesMyTurn.length > 0) {
						if (Statics.tutorialStep == 1 && Statics.roundsPlayed == 0) {
							// if new player, show match details popup for tutorial match
//							this.screenMatches.listYourTurn.selectedIndex = 0;
							if (this.tutorialPointer == null) {
								this.tutorialPointer = new TutorialPointer();
								this.addChild(this.tutorialPointer);
							}
							this.showTutorialStartGame();
						}
						else if (Statics.tutorialStep == 2) { // tutorial second step: create new match
							if (this.tutorialPointer == null) {
								this.tutorialPointer = new TutorialPointer();
								this.addChild(this.tutorialPointer);
							}
							this.showTutorialStartGame();
						}
//						else if (Statics.roundsPlayed == 3) {
//							if (this.dialogLarge == null) {
//								this.dialogLarge = new DialogLarge();
//								this.addChild(this.dialogLarge);
//							}
//							this.dialogLarge.show("Now it's time to challenge a friend. Click on the 'Start Game' button, and then select 'Challenge Friend'");
//						}
						else if (Statics.roundsPlayed == 2) {
							this.showLargeDialog("Support a fledgling indie developer! Like us by clicking the Like button above. We will never spam you.");
						}
						else if (Statics.roundsPlayed == 3) {
							this.showLargeDialog("Invite some friends! They will be happy you did. Click the Invite button at the top right corner.");
						}
						else if (Statics.roundsPlayed == 5) {
							this.showLargeDialog("Bugs or suggestions? We'd love to hear your feedback! Use the Feedback button on the left to talk to us.");
						}
//						else if (Statics.tutorialStep == 3) { // tutorial second three: friends rankings
//							if (this.tutorialPointer == null) {
//								this.tutorialPointer = new TutorialPointer();
//								this.addChild(this.tutorialPointer);
//							}
//							if (!rankingsDisplayedOnStart) this.showRankingsTutorial();
//						}
//						else { // tutorials are done, just show friends rankings
//							if (!rankingsDisplayedOnStart) this.showRankingsTutorial();
//						}
						this.updateFriendsRankingsList(dataObj); // update friends rankings list
					}
					else if (dataObj.status == "new_match") { // new game created
						// display match data popup
						trace("new match created");
						
//						Statics.opponentName = dataObj.opponent_first_name + " " + dataObj.opponent_last_name.toString().substr(0, 1) + ".";
						Statics.opponentName = dataObj.opponent_first_name + "\n" + dataObj.opponent_last_name;
						Statics.opponentNameOneLine = dataObj.opponent_first_name + " " + dataObj.opponent_last_name;
						Statics.roundScores = [0, 0, 0, 0, 0, 0];
						Statics.isPlayer2 = false;
						Statics.gameId = dataObj.game_id;
						Statics.opponentFbid = dataObj.opponent_fbid;
						Statics.resignedBy = '0';
						Statics.isSupersonic = dataObj.is_supersonic;
						this.showMatchDetailsPopup(false);
						
						if (Statics.tutorialStep == 1 || Statics.tutorialStep == 2) { // tutorial second step: create new match
							this.showTutorialPlay();
						}
					}
//					else if (dataObj.status == "rankings") {
//						this.updateFriendsRankingsList(dataObj);
//					}
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
						
						// show purchase success popup
						setChildIndex(this.purchaseStatus, numChildren - 1);
						this.purchaseStatus.show();
						
						// show upgrade achievement badges (do not save, all saving is done in ScreenUpgrades.as)
						var newAchievements:Array = dataObj.new_achievements as Array;
						var numNewAchievements:uint = newAchievements.length;
						setChildIndex(this.badge, numChildren - 1);
						for (i = 0; i < numNewAchievements; i++) {
							this.badge.showAchievement(Constants.AchievementsData[newAchievements[i]][1]);
						}
					}
					else if (dataObj.status == "purchased_coins") { // successfully purchased coins
						Statics.playerCoins = int(dataObj.coins);
						coinLabel.text = dataObj.coins;
						Statics.playerGems = int(dataObj.gems);
						gemLabel.text = dataObj.gems;
						
						setChildIndex(this.purchaseStatus, numChildren - 1);
						this.purchaseStatus.show();
						
						setChildIndex(this.badge, numChildren - 1);
						this.badge.showAchievement("Bling Bling");
					}
					else if (dataObj.status == "purchased_gems") { // successfully purchased gems
						Statics.playerGems = int(dataObj.gems);
						gemLabel.text = dataObj.gems;
						
						setChildIndex(this.purchaseStatus, numChildren - 1);
						this.purchaseStatus.show();
						
						setChildIndex(this.badge, numChildren - 1);
						this.badge.showAchievement("Shiny!");
					}
					else if (dataObj.status == "purchased_lives") { // successfully purchased lives
						Statics.playerGems = int(dataObj.gems);
						gemLabel.text = dataObj.gems;
						this.lives = 5;
						lifeLabel.text = "5";
						
						setChildIndex(this.purchaseStatus, numChildren - 1);
						this.purchaseStatus.show();
						
						setChildIndex(this.badge, numChildren - 1);
						this.badge.showAchievement("My Life Will Go On");
					}
					else if (dataObj.status == "achievements_saved") { // successfully saved newly earned achievements
						// show upgrade achievement badges (do not save, all saving is done in ScreenUpgrades.as)
						newAchievements = dataObj.new_achievements as Array;
						numNewAchievements = newAchievements.length;
						setChildIndex(this.badge, numChildren - 1);
						for (i = 0; i < numNewAchievements; i++) {
							this.badge.showAchievement(Constants.AchievementsData[newAchievements[i]][1]);
						}
					}
					else if (dataObj.status == "error") { // error message received
//						trace("Error: " + dataObj.reason);
						this.showLargeDialog("An error has occurred: " + dataObj.reason);
					}
				} else {
					this.showLargeDialog("Communication Error #2222");
				}
			}
		} // eof dataReceived()
		
		private function updateFriendsRankingsList(dataObj:Object):void {
			rankingsCollection = new ListCollection();
			var numRankings:int = dataObj.rankings.length;
			var playerItemAdded:Boolean = false;
			for (var i:uint = 0; i < numRankings; i++) { // loop through rankings retrieved
				// read score
				var otherPlayerScore:uint = uint(dataObj.rankings[i].high_score);
				if (!playerItemAdded && Statics.playerHighScore >= otherPlayerScore) { // should insert player item at this location
					var pictureUrl:String = "none";
					loadedUrl = this.pictureLoader.getProfilePictureUrl(Statics.facebookId);
					if (loadedUrl != null) pictureUrl = loadedUrl;
					rankingsCollection.addItem({
						title: Statics.firstName + " " + Statics.lastName, 
						caption: Statics.playerHighScore,
						facebook_id: Statics.facebookId,
						picture_url: pictureUrl,
						picture_width: this.pictureLoader.getProfilePictureWidth(Statics.facebookId)
					});
					playerItemAdded = true;
				}
				
				// add other player to rankings list
				if (dataObj.rankings[i].picture != null) { // picture data available
					rankingsCollection.addItem({
						title: dataObj.rankings[i].firstname + " " + dataObj.rankings[i].lastname, 
						caption: dataObj.rankings[i].high_score,
						facebook_id: dataObj.rankings[i].facebookId,
						picture_url: dataObj.rankings[i].picture.url,
						picture_width: uint(dataObj.rankings[i].picture.width)
					});
				} else { // picture data not available yet
					pictureUrl = "none";
					var pictureWidth:uint = 0;
					// check pictureLoader to see if picture data for this user has already been loaded
					var loadedUrl:String = this.pictureLoader.getProfilePictureUrl(dataObj.rankings[i].facebookId);
					if (loadedUrl != null) {
						pictureUrl = loadedUrl;
						pictureWidth = this.pictureLoader.getProfilePictureWidth(dataObj.rankings[i].facebookId);
					}
					rankingsCollection.addItem({
						title: dataObj.rankings[i].firstname + " " + dataObj.rankings[i].lastname, 
						caption: dataObj.rankings[i].high_score,
						facebook_id: dataObj.rankings[i].facebookId,
						picture_url: pictureUrl,
						picture_width: pictureWidth
					});
				}
			}
			
			// if player score is not higher than anyone else's, or if there are no friends, add player item here
			if (!playerItemAdded) {
				pictureUrl = "none";
				loadedUrl = this.pictureLoader.getProfilePictureUrl(Statics.facebookId);
				if (loadedUrl != null) {
					pictureUrl = loadedUrl;
				}
				rankingsCollection.addItem({
					title: Statics.firstName + " " + Statics.lastName, 
					caption: Statics.playerHighScore,
					facebook_id: Statics.facebookId,
					picture_url: pictureUrl,
					picture_width: this.pictureLoader.getProfilePictureWidth(Statics.facebookId)
				});
				playerItemAdded = true;
			}
			
			this.screenMatches.listRankings.dataProvider = rankingsCollection;
		}
		
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
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, addedToStageHandler);
			
			DeviceCapabilities.dpi = 326; //simulate iPhone Retina resolution
			//			this.theme = new MetalWorksMobileTheme(this.stage);
			
			// bg
			var bgImage:Image = new Image(Statics.assets.getTexture("UiMainBg0000"));
			bgImage.pivotX = Math.ceil(bgImage.texture.width / 2);
			bgImage.x = stage.stageWidth / 2;
			this.addChild(bgImage);
			
			// top bar
			var topBar:Image = new Image(Statics.assets.getTexture("UiMainTop0000"));
			this.addChild(topBar);
			
			// bottom bar
			var bottomBar:Image = new Image(Statics.assets.getTexture("UiMainBottom0000"));
			bottomBar.pivotY = bottomBar.height;
			bottomBar.y = Statics.stageHeight;
			this.addChild(bottomBar);
			
			// rank badge
			var rankBadge:Image = new Image(Statics.assets.getTexture("RankBadge10000"));
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
			buttonAddCoins.defaultSkin = new Image(Statics.assets.getTexture("ButtonMainTopPlus0000"))
			buttonAddCoins.hoverSkin = new Image(Statics.assets.getTexture("ButtonMainTopPlus0000"));
			buttonAddCoins.downSkin = new Image(Statics.assets.getTexture("ButtonMainTopPlus0000"));
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
			buttonAddGems.defaultSkin = new Image(Statics.assets.getTexture("ButtonMainTopPlus0000"))
			buttonAddGems.hoverSkin = new Image(Statics.assets.getTexture("ButtonMainTopPlus0000"));
			buttonAddGems.downSkin = new Image(Statics.assets.getTexture("ButtonMainTopPlus0000"));
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
			buttonAddLives.defaultSkin = new Image(Statics.assets.getTexture("ButtonMainTopPlus0000"))
			buttonAddLives.hoverSkin = new Image(Statics.assets.getTexture("ButtonMainTopPlus0000"));
			buttonAddLives.downSkin = new Image(Statics.assets.getTexture("ButtonMainTopPlus0000"));
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
			buttonInviteFriends.defaultSkin = new Image(Statics.assets.getTexture("ButtonInviteFriends0000"))
			buttonInviteFriends.hoverSkin = new Image(Statics.assets.getTexture("ButtonInviteFriends0000"));
			buttonInviteFriends.downSkin = new Image(Statics.assets.getTexture("ButtonInviteFriends0000"));
			buttonInviteFriends.hoverSkin.filter = Statics.btnBrightnessFilter;
			buttonInviteFriends.downSkin.filter = Statics.btnInvertFilter;
			buttonInviteFriends.x = 597;
			buttonInviteFriends.y = topBarButtonsY;
			buttonInviteFriends.addEventListener(starling.events.Event.TRIGGERED, btnInviteFriendsHandler);
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
				tab.defaultSkin = new Image(Statics.assets.getTexture("TabButtonMiddle0000"));
				tab.hoverSkin = new Image(Statics.assets.getTexture("TabButtonMiddle0000"));
				tab.downSkin = new Image(Statics.assets.getTexture("TabButtonMiddle0000"));
				tab.defaultSelectedSkin = new Image(Statics.assets.getTexture("TabButtonMiddle0000"));
				
				tab.hoverSkin.filter = Statics.btnBrightnessFilter;
				tab.downSkin.filter = Statics.btnInvertFilter;
				tab.defaultSelectedSkin.filter = Statics.btnContrastFilter;
				return tab;
			};
			// left tab button
			tabs.firstTabFactory = function():Button
			{
				var tab:Button = new Button();
				tab.defaultSkin = new Image(Statics.assets.getTexture("TabButtonLeft0000"));
				tab.hoverSkin = new Image(Statics.assets.getTexture("TabButtonLeft0000"));
				tab.downSkin = new Image(Statics.assets.getTexture("TabButtonLeft0000"));
				tab.defaultSelectedSkin = new Image(Statics.assets.getTexture("TabButtonLeft0000"));
				
				tab.hoverSkin.filter = Statics.btnBrightnessFilter;
				tab.downSkin.filter = Statics.btnInvertFilter;
				tab.defaultSelectedSkin.filter = Statics.btnContrastFilter;
				return tab;
			};
			// right tab button
			tabs.lastTabFactory = function():Button
			{
				var tab:Button = new Button();
				tab.defaultSkin = new Image(Statics.assets.getTexture("TabButtonRight0000"));
				tab.hoverSkin = new Image(Statics.assets.getTexture("TabButtonRight0000"));
				tab.downSkin = new Image(Statics.assets.getTexture("TabButtonRight0000"));
				tab.defaultSelectedSkin = new Image(Statics.assets.getTexture("TabButtonRight0000"));
				
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
//			screenRankings = new ScreenRankings(this);
//			screenRankings.visible = false;
//			this.addChild(screenRankings);
			
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
			
			// instructions popup
			popupInstructions = new Instructions(this);
			popupInstructions.visible = false;
			this.addChild(popupInstructions);
			
			// dialog boxes
			dialogBox1 = new DialogBox();
			dialogBox1.visible = false;
			this.addChild(dialogBox1);
			
			dialogBox2 = new DialogBox();
			dialogBox2.visible = false;
			this.addChild(dialogBox2);
			
			// story popup
			//			popupStory = new ScreenStory(this);
			//			popupStory.visible = false;
			//			this.addChild(popupStory);
			
			// objective achievement effect
			this.badge = new Badge();
			this.addChild(this.badge);
			
			// purchase status
			this.purchaseStatus = new PurchaseStatus();
			this.addChild(this.purchaseStatus);
			
			// animated characters
			heroIdle = new MovieClip(Statics.assets.getTextures("CharPrinceIdle"), 40);
			heroIdle.pivotX = Math.ceil(heroIdle.width  / 2); // center art on registration point
			heroIdle.pivotY = heroIdle.height;
			heroIdle.scaleX = 0.6;
			heroIdle.scaleY = 0.6;
			heroIdle.x = 260;
			heroIdle.y = 380;
			this.addChild(heroIdle);
			
			// setup snow
			this.starList = new Vector.<BgStar>();
			for (var i:uint = 0; i < Constants.NumBgFloatingStarsMenu; i++) { // add this many floating stars
				var star:BgStar = new BgStar();
				star.touchable = false;
				this.starList.push(star);
				this.addChild(star);
			}
			
			// large dialog box
			this.dialogLarge = new DialogLarge();
			this.dialogLarge.visible = false;
			this.addChild(this.dialogLarge);
			
			// create picture loader object
			pictureLoader = new PictureLoader();
			pictureLoader.addEventListener("pictureDataLoaded", onPictureLoaded);
		}
		
		/**
		 * Picture loader dispatched event notifying us that a new profile picture has been loaded.
		 * Check if this picture should be placed in rankings list
		 */
		private function onPictureLoaded(event:starling.events.Event, facebookId:String):void
		{
//			trace("picture loaded event received: " + facebookId);
			
			// if is player's picture, pass picture data to match details popup
			if (facebookId == Statics.facebookId) {
				this.matchDataPopup.setPlayerPictureData(pictureLoader.getProfilePictureUrl(facebookId), pictureLoader.getProfilePictureWidth(facebookId));
			}
			else if (facebookId == Statics.opponentFbid) { // or if it's opponent's picture, pass it along as well
				this.matchDataPopup.setOpponentPictureData(pictureLoader.getProfilePictureUrl(facebookId), pictureLoader.getProfilePictureWidth(facebookId));
			}
			
			// pass profile picture data to ranking screen -> rankings list component
			if (rankingsCollection) {
				var rankingsCollectionUpdated:Boolean = false;
				var numRankings:int = rankingsCollection.length;
				for (var i:uint = 0; i < numRankings; i++) { // loop through rankings retrieved
					var rankingsObject:Object = rankingsCollection.getItemAt(i);
					if (rankingsObject.facebook_id == facebookId) {
						// set new data
						rankingsObject.picture_url = pictureLoader.getProfilePictureUrl(facebookId);
						rankingsObject.picture_width = pictureLoader.getProfilePictureWidth(facebookId);
						rankingsCollection.setItemAt(rankingsObject, i); // TODO needed?
						rankingsCollection.updateItemAt(i);
						rankingsCollectionUpdated = true;
					}
				}
				if (rankingsCollectionUpdated) {
					this.screenMatches.listRankings.dataProvider = rankingsCollection; // update list component
				}
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
//			screenRankings.visible = false;
			screenProfile.visible = false;
			screenCharacters.visible = false;
			screenGetCoins.visible = false;
			screenGetGems.visible = false;
			popupGetLives.visible = false;
			popupInstructions.visible = false;
		}
		
		private function tabsChangeHandler(event:starling.events.Event):void
		{
//			trace("tabs change");
			// trigger match data refresh
			
			if (this.tabs.selectedIndex == -1) {
				return;
			}
			
			if (!firstClickSoundHidden) {
				firstClickSoundHidden = true;
			} else {
				if (!Sounds.sfxMuted) Statics.assets.playSound("SND_SLIDE");
			}
			
			// display the selected screen
			this.showScreen(this.tabs.selectedItem.action);
			
			// when displaying the matches screen, refresh matches
			if (this.tabs.selectedItem.action == Constants.ScreenMatches) {
				this.screenMatches.visible = true;
				this.refreshMatches();
//				setChildIndex(screenMatches, this.getChildIndex(this.loadingNotice) - 1);
				
				if (Statics.isAnalyticsEnabled) {
					Statics.mixpanel.track('switched to Matches screen');
				}
			}
			// when displaying the upgrades screen, refresh upgrades
			else if (this.tabs.selectedItem.action == Constants.ScreenUpgrades) {
				this.screenUpgrades.visible = true;
				this.screenUpgrades.refresh();
				
				if (Statics.isAnalyticsEnabled) {
					Statics.mixpanel.track('switched to Upgrades screen');
				}
			}
			// when displaying the town square screen, track this event
			else if (this.tabs.selectedItem.action == Constants.ScreenTownSquare) {
				if (Statics.isAnalyticsEnabled) {
					Statics.mixpanel.track('switched to Town Square screen');
				}
			}
		}
		
		private function createLoadingNotice():void {
			loadingNotice = new Sprite();
			
			// bg quad
			var bg:Quad = new Quad(stage.stageWidth, stage.stageHeight, 0x000000);
			bg.alpha = 0.5;
			loadingNotice.addChild(bg);
			
			// spinning box
			var boxAnimation:MovieClip = new MovieClip(Statics.assets.getTextures("BoxBlue"), 20);
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
			if(ExternalInterface.available) ExternalInterface.call("kissTrack", "initializing menu");
			Statics.mixpanel.track('initializing menu', { "isHardwareRendering": Statics.isHardwareRendering.toString() });
			this.visible = true;
			this.tabs.selectedIndex = -1;
			this.tabs.validate();
			this.tabs.selectedIndex = 0; // trigger match data refresh
			
			// set up achievements, the element at index 0 is not used in order to sync with db ids
			Statics.achievementsList = new Vector.<Boolean>();
			var numAchievements:uint = Constants.AchievementsProgression.length + 1;
			for (var i:uint = 0; i < numAchievements; i++) {
				Statics.achievementsList[i] = false;
			}
			
			this.countdownActive = true;
			this.updateCountdown();
			
			// animated characters
			starling.core.Starling.juggler.add(heroIdle);
			
			// snow
			starDx = (Math.random() - 0.5) * Constants.FloatingStarsBaseVelocity;
			for (i = 0; i < Constants.NumBgFloatingStarsMenu; i++) {
				this.starList[i].initialize();
				this.starList[i].updateWindDx(starDx);
				starling.core.Starling.juggler.add(this.starList[i]);
			}
			// change snow direction
			Starling.juggler.delayCall(updateSnow, 1);
			
			// play menu bgm
			Sounds.stopBgm();
			Sounds.playBgmMenu(); // play bgm regardless of whether bgm is muted
			
			if (Statics.adsShowCount == 0) { // do not show ads on game start
				Statics.adsShowCount = 1;
//				this.refreshMatches();
			} else {
				// show interstitial ad
				this.showInterstitialAd();
			}
		}
		
		private function updateSnow():void {
//			trace("native children: " + Starling.current.nativeOverlay.numChildren);
			
			// update wind dx
			if (Math.random() < 0.6) {
				if (starDx < 0) starDx += 0.02;
				else starDx -= 0.02;
			}
			else {
				if (starDx > 0) starDx += 0.02;
				else starDx -= 0.02;
			}
			for (var i:uint = 0; i < Constants.NumBgFloatingStarsMenu; i++) {
				this.starList[i].updateWindDx(starDx);
			}
			Starling.juggler.delayCall(updateSnow, 1);
		}
		
		private function refreshMatches():void {
			displayLoadingNotice("Refreshing matches...");
//			this.communicator.addEventListener(NavigationEvent.RESPONSE_RECEIVED, dataReceived);
			this.communicator.retrieveUserData();
		}
		
		public function refreshRankingsGlobal():void {
			displayLoadingNotice("Refreshing rankings...");
//			this.communicator.addEventListener(NavigationEvent.RESPONSE_RECEIVED, dataReceived);
			this.communicator.retrieveRankingsGlobal();
		}
		
		public function refreshRankingsFriends():void {
			displayLoadingNotice("Refreshing rankings...");
//			this.communicator.addEventListener(NavigationEvent.RESPONSE_RECEIVED, dataReceived);
			this.communicator.retrieveRankingsFriends();
		}
		
		/**
		 * Hide and remove unneeded stuff
		 */
		public function disposeTemporarily():void
		{
			// stop animated characters
			starling.core.Starling.juggler.remove(heroIdle);
			
			// stop snow
			for (var i:uint = 0; i < Constants.NumBgFloatingStarsMenu; i++) {
				this.starList[i].visible = false;
				starling.core.Starling.juggler.remove(this.starList[i]);
			}
			
			this.visible = false;
		}
		
		public function showMatchDetailsPopup(isDone:Boolean):void {
			if (!Sounds.sfxMuted) Statics.assets.playSound("SND_CLICK");
			
			matchDataPopup.initialize(isDone);
			setChildIndex(matchDataPopup, numChildren - 1);
		}
		
		public function showAchievementsScreen(event:starling.events.Event):void {
			if (!Sounds.sfxMuted) Statics.assets.playSound("SND_CLICK");
			
			setChildIndex(screenAchievements, numChildren - 1);
			screenAchievements.initialize();
			
			if (Statics.isAnalyticsEnabled) {
				Statics.mixpanel.track('displayed Achievements screen');
			}
		}
		
//		public function showRankingsScreen(event:starling.events.Event):void {
//			if (!Sounds.sfxMuted) Statics.assets.playSound("SND_CLICK");
//			
//			this.screenRankings.showRankingsPrevious();
//			setChildIndex(this.loadingNotice, this.numChildren - 1); // TODO: remove when global ranking is implemented
//			setChildIndex(screenRankings, this.getChildIndex(this.loadingNotice) - 1);
//			screenRankings.initialize();
//			
//			if (Statics.isAnalyticsEnabled) {
//				Statics.mixpanel.track('displayed Rankings screen');
//			}
//		}
		
		/**
		 * Simply open the rankings screen to friends rankings
		 */
//		public function showRankingsTutorial():void {
//			rankingsDisplayedOnStart = true;
//			
////			this.screenRankings.showRankingsFriends();
//			this.screenRankings.showRankingsGlobal();
//			setChildIndex(screenRankings, this.getChildIndex(this.loadingNotice) - 1);
//			screenRankings.initialize();
//			
//			if (Statics.isAnalyticsEnabled) {
//				Statics.mixpanel.track('displayed global Rankings screen');
//			}
//		}
		
		/**
		 * Show player's own profile
		 */
		public function showProfileScreen(event:starling.events.Event):void {
			if (!Sounds.sfxMuted) Statics.assets.playSound("SND_CLICK");
			
			setChildIndex(screenProfile, numChildren - 1);
			var playerData:Object = new Object();
			playerData.title = Statics.firstName + " " + Statics.lastName;
			playerData.caption = Statics.playerHighScore.toString();
			playerData.picture_width = this.pictureLoader.getProfilePictureWidth(Statics.facebookId);
			playerData.picture_url = this.pictureLoader.getProfilePictureUrl(Statics.facebookId);;
			screenProfile.initialize(playerData);
			
			if (Statics.isAnalyticsEnabled) {
				Statics.mixpanel.track('displayed Own Profile screen');
			}
		}
		
		/**
		 * Show other player profile
		 */
		public function showProfileScreenGivenData(dataIndexInCollection:int):void {
			if (!Sounds.sfxMuted) Statics.assets.playSound("SND_CLICK");
			
			setChildIndex(screenProfile, numChildren - 1);
			var playerData:Object = this.rankingsCollection.getItemAt(dataIndexInCollection);
			screenProfile.initialize(playerData);
			
			if (Statics.isAnalyticsEnabled) {
				Statics.mixpanel.track('displayed Social Profile screen');
			}
		}
		
		public function showCharactersScreen(event:starling.events.Event):void {
			if (!Sounds.sfxMuted) Statics.assets.playSound("SND_CLICK");
			
			setChildIndex(screenCharacters, numChildren - 1);
			screenCharacters.initialize();
			
			if (Statics.isAnalyticsEnabled) {
				Statics.mixpanel.track('displayed Characters screen');
			}
		}
		
		public function showGetCoinsScreen(event:starling.events.Event):void {
			if (!Sounds.sfxMuted) Statics.assets.playSound("SND_CLICK");
			
			setChildIndex(screenGetCoins, numChildren - 1);
			screenGetCoins.initialize();
			
			if (Statics.isAnalyticsEnabled) {
				Statics.mixpanel.track('displayed Get Coins screen');
			}
		}
		
		public function showGetGemsScreen(event:starling.events.Event = null):void {
			if (!Sounds.sfxMuted) Statics.assets.playSound("SND_CLICK");
			
			setChildIndex(screenGetGems, numChildren - 1);
			screenGetGems.initialize();
			
			if (Statics.isAnalyticsEnabled) {
				Statics.mixpanel.track('displayed Get Gems screen');
			}
		}
		
		private function btnAddLivesHandler(event:starling.events.Event):void {
			if (!Sounds.sfxMuted) Statics.assets.playSound("SND_CLICK");
			
			this.showGetLivesPopup();
		}
		
		private function showGetLivesPopup(isOut:Boolean = false):void {
			setChildIndex(popupGetLives, numChildren - 1);
			popupGetLives.show(isOut);
			
			if (Statics.isAnalyticsEnabled) { // mixpanel
				if (isOut) Statics.mixpanel.track('out of lives, showing get lives popup');
				else Statics.mixpanel.track('clicked on add lives button');
			}
			
			// show interstitial ad on out of lives
//			if (isOut) {
//				this.showInterstitialAd(true);
//			}
		}
		
		public function showInstructionsPopup(isOut:Boolean = false):void {
			setChildIndex(popupInstructions, numChildren - 1);
			popupInstructions.show();
			
			// tutorial pointers
//			if (Statics.tutorialStep == 1 && Statics.roundsPlayed == 0 && this.screenMatches.gamesMyTurn.length > 0) {
			if (Statics.tutorialStep == 1 && Statics.roundsPlayed == 0) {
				this.showTutorialInstructions();
			}
			else if (Statics.tutorialStep == 2) {
				this.showTutorialInstructions();
			}
		}
		
//		public function showStoryPopup():void {
//			setChildIndex(popupStory, numChildren - 1);
//			popupStory.initialize();
//		}
		
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
//				trace("No dialog boxes available");
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
			
//			if (Statics.isAnalyticsEnabled) {
//				Statics.mixpanel.people_increment("games played");
//			}
			
			return true;
		}
		
		// show the apprequests dialog to pick friends to ask for lives
		public function showAskFriendsForLives():void {
			if(ExternalInterface.available){
//				trace("Calling JS...");
				ExternalInterface.call("selectFriendsForLife");
				ExternalInterface.addCallback("returnFriendsForLifeCountToAs", friendsForLifeCountReturnedFromAs);
			} else {
//				trace("External interface unavailabe");
			}
		}
		
		private function friendsForLifeCountReturnedFromAs(inviteCount:uint):void {
			if (Statics.isAnalyticsEnabled) { // mixpanel
				Statics.mixpanel.track('asked friends for life, count: ' + inviteCount);
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
//			this.communicator.addEventListener(NavigationEvent.RESPONSE_RECEIVED, dataReceived);
			this.communicator.postPurchaseLives(jsonStr);
			
			if (Statics.isAnalyticsEnabled) { // mixpanel
				Statics.mixpanel.track('bought lives with gems');
			}
		}
		
		// call js to send life
		private function sendLife():void {
			if(ExternalInterface.available){
//				trace("Calling JS...");
				ExternalInterface.call("sendLife", this.lifeRequests);
			} else {
//				trace("External interface unavailabe");
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
//				trace("Calling JS... " + this.lifeReceipts);
				ExternalInterface.call("sendLife", this.lifeReceipts);
			} else {
//				trace("External interface unavailabe");
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
			if (!Sounds.sfxMuted) Statics.assets.playSound("SND_CLICK");
			
			this.tabs.selectedIndex = -1;
			this.screenMatches.visible = false;
			this.screenUpgrades.visible = false;
			
			if (Statics.isAnalyticsEnabled) { // mixpanel
				Statics.mixpanel.track('closed all popups to display menu background');
			}
		}
		
		public function btnInviteFriendsHandler():void {
			if (!Sounds.sfxMuted) Statics.assets.playSound("SND_CLICK");
			
			if(ExternalInterface.available){
				ExternalInterface.addCallback("returnInviteCount", invitesReturnedFromJs);
				ExternalInterface.call("inviteFriends");
			}
			
			if (Statics.isAnalyticsEnabled) { // mixpanel
				Statics.mixpanel.track('clicked on menu top right invite friends button');
			}
		}
		
		public function btnInviteFriendsPreselectedHandler():void {
			if(ExternalInterface.available){
				ExternalInterface.addCallback("returnInviteCount", invitesReturnedFromJs);
//				ExternalInterface.call("invitePreSelectedFriends", Statics.topFriendsIds);
				ExternalInterface.call("inviteFriends");
			}
			
			if (Statics.isAnalyticsEnabled) { // mixpanel
				Statics.mixpanel.track('clicked on rankings invite friends button');
			}
		}
		
		private function invitesReturnedFromJs(inviteCount:uint):void {
			if (Statics.isAnalyticsEnabled) { // mixpanel
				Statics.mixpanel.track('invited friends, count: ' + inviteCount);
			}
		}
		
		private function formatTime(totalSeconds:int):String {
			var seconds:uint = totalSeconds % 60;
			var minutes:uint = (totalSeconds - seconds) / 60;
			if (seconds < 10) return String(minutes) + ":0" + String(seconds);
			else return String(minutes) + ":" + String(seconds);
		}
		
		public function hideTutorialPointer():void {
			if (this.tutorialPointer != null) {
				this.tutorialPointer.hide();
			}
		}
		
		public function makeTutorialInvisibleTemporarily():void {
			if (this.tutorialPointer != null) {
				this.tutorialPointer.visible = false;
			}
		}
		
		public function showTutorialPlay():void {
			if (this.tutorialPointer != null) {
				this.tutorialPointer.visible = true;
				this.tutorialPointer.hide();
				setChildIndex(tutorialPointer, numChildren - 1);
				this.tutorialPointer.pointAtPlayBtn();
			}
		}
		
		public function showTutorialInstructions():void {
			if (this.tutorialPointer != null) {
				this.tutorialPointer.hide();
				setChildIndex(tutorialPointer, numChildren - 1);
				this.tutorialPointer.pointAtInstructionsNextBtn();
			}
		}
		
		public function showTutorialStartGame():void {
			if (this.tutorialPointer != null) {
				this.tutorialPointer.hide();
//				setChildIndex(tutorialPointer, numChildren - 1);
				this.tutorialPointer.pointAtStartGameBtn();
			}
		}
		
		public function showTutorialChallengeFriend():void {
			if (this.tutorialPointer != null) {
				this.tutorialPointer.hide();
				setChildIndex(tutorialPointer, numChildren - 1);
				this.tutorialPointer.pointAtChallengeFriendBtn();
			}
		}
		
		public function showTutorialSmartMatch():void {
			if (this.tutorialPointer != null) {
				this.tutorialPointer.hide();
				setChildIndex(tutorialPointer, numChildren - 1);
				this.tutorialPointer.pointAtSmartMatchBtn();
			}
		}
		
		public function showTutorialRankingsInvite():void {
			if (this.tutorialPointer != null) {
				this.tutorialPointer.hide();
				setChildIndex(tutorialPointer, numChildren - 1);
				this.tutorialPointer.pointAtRankingsInvite();
			}
		}
		
		public function shakeCamera(shakeValue:Number):void {
			if (shakeValue > 0) {
				shakeValue -= 2;
				this.x = int(Math.random() * shakeValue - shakeValue * 0.5);
				this.y = int(Math.random() * shakeValue - shakeValue * 0.5);
				Starling.juggler.delayCall(shakeCamera, 0.02, shakeValue);
			}
			else if (this.x != 0 || this.y != 0) {
				this.x = 0;
				this.y = 0;
			}
		}
		
		// display an interstitial ad
		private var adLoader:Loader;
		public function showInterstitialAd():void {
			var embedId:String;
//			if (isOutOfLives) embedId = "a438ddad-e9ee-47ad-a955-397b13972895";
//			else {
				if (Statics.adsShowCount == 1) {
					embedId = "a06da227-c848-4798-b1ec-bc6734af38cb";
					adLoader = new Loader();
					adLoader.contentLoaderInfo.addEventListener(flash.events.Event.INIT, function(e:flash.events.Event):void {
						adLoader.x = Statics.stageWidth / 2 - adLoader.contentLoaderInfo.width / 2 + 40;
						adLoader.y = Statics.stageHeight / 2 - adLoader.contentLoaderInfo.height / 2 + 45;
						if (Starling.current.nativeOverlay.numChildren == 0) Starling.current.nativeOverlay.addChild(adLoader);
						else adLoader.visible = true;
					});
				}
				else embedId = "a5a4e92e-d6b8-4b4f-8a12-ecf728199f68";
//			}
			
			adLoader.load(new URLRequest("http://admin.appnext.com/AppNextFlash.swf?id=" + embedId));
			Statics.adsShowCount++;
		}
		
		public function showLargeDialog(message:String):void {
			setChildIndex(this.dialogLarge, numChildren - 1);
			this.dialogLarge.show(message);
		}
	}
}