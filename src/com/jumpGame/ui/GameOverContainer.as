package com.jumpGame.ui
{
	import com.jumpGame.customObjects.Font;
	import com.jumpGame.events.NavigationEvent;
	import com.jumpGame.screens.Menu;
	import com.jumpGame.ui.components.AchievementPlate;
	import com.jumpGame.ui.components.BadgeHighScore;
	
	import flash.external.ExternalInterface;
	
	import feathers.controls.Button;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	import starling.utils.deg2rad;
	import com.jumpGame.screens.InGame;
	
	public class GameOverContainer extends Sprite
	{
		// background quad
		private var bg:Quad;
		
		// stars
		private var starCenterOn:Image;
		private var starLeftOn:Image;
		private var starRightOn:Image;
		
		private var congrats:Image;
		private var scoreContainer:Sprite;
		private var headerAchievementsEarned:Image;
		private var headerAchievementsAim:Image;
		
		private var coinContainer:Sprite;
		
		// distance display
		private var distanceText:TextField;
		
		// base score display
		private var baseScoreText:TextField;
		
		// coin display
		private var coinText:TextField;
		
		// score display
		private var scoreText:TextField;
		
		// buttons
		private var btnNext:Button;
		private var proceedBtn:Button;
		
//		private var communicator:Communicator;
		
		private var distanceTraveled:int;
		private var roundScore:int;
		
		// array to store new achievement ids earned this round
		private var newAchievementsArray:Array = new Array();
		
		private var achievementSetShown:uint;
		
		// achievement plates
		private var achievementPlate1:AchievementPlate;
		private var achievementPlate2:AchievementPlate;
		private var achievementPlate3:AchievementPlate;
		
		private var menu:Menu;
		private var inGame:InGame;
		
		private var roundCoins:Vector.<MovieClip>; // coin fly out effect
		
		private var badgeHighScore:BadgeHighScore;
		
		private var btnPlayAgainSmartMatch:Button;
		
		// coin pools
//		private var roundCoins:Vector.<MovieClip>;
//		private var achievementCoins1:Vector.<MovieClip>;
//		private var achievementCoins2:Vector.<MovieClip>;
//		private var achievementCoins3:Vector.<MovieClip>;
		
		public function GameOverContainer(menu:Menu, inGame:InGame)
		{
			super();
			this.visible = false;
			this.menu = menu;
			this.inGame = inGame;
			this.drawGameOver();
//			this.communicator = new Communicator();
			
			//testing
//			this.addNewAchievement(1);
//			this.addNewAchievement(2);
//			this.addNewAchievement(3);
//			this.addNewAchievement(4);
//			this.addNewAchievement(5);
//			this.addNewAchievement(6);
//			this.addNewAchievement(3);
//			this.addNewAchievement(11);
			this.menu.communicator.addEventListener(NavigationEvent.RESPONSE_RECEIVED, this.dataReceived);
		}
		
		/**
		 * Draw game over screen. 
		 * 
		 */
		private function drawGameOver():void
		{
			// bg quad
			bg = new Quad(Statics.stageWidth, Statics.stageHeight, 0x000000);
			bg.alpha = 0.75;
			this.addChild(bg);
			
			var yModifier:Number = -10;
			
			// big stars (off)
			// center
			var starCenter:Image = new Image(Statics.assets.getTexture("BigStarOff0000"));
			starCenter.pivotX = Math.ceil(starCenter.width / 2);
			starCenter.pivotY = Math.ceil(starCenter.height / 2);
			starCenter.x = Statics.stageWidth / 2;
			starCenter.y = 100 + yModifier;
			this.addChild(starCenter);
			// left
			var starLeft:Image = new Image(Statics.assets.getTexture("BigStarOff0000"));
			starLeft.pivotX = Math.ceil(starLeft.width / 2);
			starLeft.pivotY = Math.ceil(starLeft.height / 2);
			starLeft.x = Statics.stageWidth / 2 - starLeft.width - 15;
			starLeft.y = 125 + yModifier;
			starLeft.rotation = -15 * Math.PI / 180;
			this.addChild(starLeft);
			// right
			var starRight:Image = new Image(Statics.assets.getTexture("BigStarOff0000"));
			starRight.pivotX = Math.ceil(starRight.width / 2);
			starRight.pivotY = Math.ceil(starRight.height / 2);
			starRight.x = Statics.stageWidth / 2 + starRight.width + 15;
			starRight.y = 125 + yModifier;
			starRight.rotation = 15 * Math.PI / 180;
			this.addChild(starRight);
			// eof big stars (off)
			
			// big stars (on)
			// center
			starCenterOn = new Image(Statics.assets.getTexture("BigStarOn0000"));
			starCenterOn.pivotX = Math.ceil(starCenterOn.width / 2);
			starCenterOn.pivotY = Math.ceil(starCenterOn.height / 2);
			starCenterOn.x = Statics.stageWidth / 2;
			starCenterOn.y = 100 + yModifier;
			this.addChild(starCenterOn);
			// left
			starLeftOn = new Image(Statics.assets.getTexture("BigStarOn0000"));
			starLeftOn.pivotX = Math.ceil(starLeftOn.width / 2);
			starLeftOn.pivotY = Math.ceil(starLeftOn.height / 2);
			starLeftOn.x = Statics.stageWidth / 2 - starLeftOn.width - 15;
			starLeftOn.y = 125 + yModifier;
			starLeftOn.rotation = -15 * Math.PI / 180;
			this.addChild(starLeftOn);
			// right
			starRightOn = new Image(Statics.assets.getTexture("BigStarOn0000"));
			starRightOn.pivotX = Math.ceil(starRightOn.width / 2);
			starRightOn.pivotY = Math.ceil(starRightOn.height / 2);
			starRightOn.x = Statics.stageWidth / 2 + starRightOn.width + 15;
			starRightOn.y = 125 + yModifier;
			starRightOn.rotation = 15 * Math.PI / 180;
			this.addChild(starRightOn);
			// eof big stars (on)
			
			// congratulations image
			congrats = new Image(Statics.assets.getTexture("GameOverCongrats0000"));
			congrats.pivotX = Math.ceil(congrats.width  / 2); // center art on registration point
			congrats.x = Statics.stageWidth / 2;
			congrats.y = Statics.stageHeight * 2.6 / 10 + yModifier;
			addChild(congrats);
			
			// score container sprite
			scoreContainer = new Sprite();
			addChild(scoreContainer);
			
			// get fonts for text display
			var fontMaterhorn24:Font = Fonts.getFont("Materhorn24");
			var fontMaterhorn25:Font = Fonts.getFont("Materhorn25");
			var fontTotalScore:Font = Fonts.getFont("Pulsing72");
			
			///////////////////////////////////////////////////////////////////
			// bof total score
			var totalScoreContainer:Sprite = new Sprite();
			
			// score icon
//			var scoreIcon:Image = new Image(Assets.getSprite("AtlasTexturePlatforms").getTexture("StarYellow0000"));
//			totalScoreContainer.addChild(scoreIcon);
			
			// score label
			var scoreLabel:TextField = new TextField(140, 80, "Total Score:", fontMaterhorn25.fontName, fontMaterhorn25.fontSize, 0xffffff);
			scoreLabel.vAlign = VAlign.CENTER;
			scoreLabel.hAlign = HAlign.LEFT;
//			scoreLabel.x = scoreIcon.bounds.right + 20;
			totalScoreContainer.addChild(scoreLabel);
			
			// score value
			scoreText = new TextField(250, 80, "", fontTotalScore.fontName, fontTotalScore.fontSize, 0xffffff);
			scoreText.vAlign = VAlign.CENTER;
			scoreText.hAlign = HAlign.LEFT;
			scoreText.x = scoreLabel.bounds.right + 20;
			totalScoreContainer.addChild(scoreText);
			
//			totalScoreContainer.pivotX = Math.ceil(totalScoreContainer.width / 2);
			totalScoreContainer.x = Statics.stageWidth * 3 / 10 + 2;
			totalScoreContainer.y = Statics.stageHeight * 3.6 / 10 + yModifier;
			scoreContainer.addChild(totalScoreContainer);
			// eof total score
			///////////////////////////////////////////////////////////////////
			
			///////////////////////////////////////////////////////////////////
			// bof distance
			var distanceContainer:Sprite = new Sprite();
			
			// distance icon
			var distanceIcon:Image = new Image(Statics.assets.getTexture("GameOverIconDistance0000"));
			distanceContainer.addChild(distanceIcon);
			
			// distance label
			var distanceLabel:TextField = new TextField(100, distanceIcon.height, "Distance:", fontMaterhorn24.fontName, fontMaterhorn24.fontSize, 0xffffff);
			distanceLabel.vAlign = VAlign.CENTER;
			distanceLabel.hAlign = HAlign.LEFT;
			distanceLabel.x = distanceIcon.bounds.right + 20;
			distanceContainer.addChild(distanceLabel);
			
			// distance value
			distanceText = new TextField(100, distanceIcon.height, "", fontMaterhorn24.fontName, fontMaterhorn24.fontSize, 0xffffff);
			distanceText.vAlign = VAlign.CENTER;
			distanceText.hAlign = HAlign.LEFT;
			distanceText.x = distanceLabel.bounds.right + 20;
			distanceContainer.addChild(distanceText);
			
//			distanceContainer.pivotX = Math.ceil(distanceContainer.width / 2);
			distanceContainer.x = Statics.stageWidth * 3 / 10;
			distanceContainer.y = Statics.stageHeight * 5 / 10 + yModifier;
			scoreContainer.addChild(distanceContainer);
			// eof distance
			///////////////////////////////////////////////////////////////////
			
			///////////////////////////////////////////////////////////////////
			// bof base score
			var baseScoreContainer:Sprite = new Sprite();
			
			// coin icon
			var baseScoreIcon:Image = new Image(Statics.assets.getTexture("GameOverIconBaseScore0000"));
			baseScoreContainer.addChild(baseScoreIcon);
			
			// coin label
			var baseScoreLabel:TextField = new TextField(130, baseScoreIcon.height, "Base Score:", fontMaterhorn24.fontName, fontMaterhorn24.fontSize, 0xffffff);
			baseScoreLabel.vAlign = VAlign.CENTER;
			baseScoreLabel.hAlign = HAlign.LEFT;
			baseScoreLabel.x = baseScoreIcon.bounds.right + 20;
			baseScoreContainer.addChild(baseScoreLabel);
			
			// coin value
			baseScoreText = new TextField(100, baseScoreIcon.height, "", fontMaterhorn24.fontName, fontMaterhorn24.fontSize, 0xffffff);
			baseScoreText.vAlign = VAlign.CENTER;
			baseScoreText.hAlign = HAlign.LEFT;
			baseScoreText.x = baseScoreLabel.bounds.right + 20;
			baseScoreContainer.addChild(baseScoreText);
			
//			baseScoreContainer.pivotX = Math.ceil(baseScoreContainer.width / 2);
			baseScoreContainer.x = Statics.stageWidth * 3 / 10 + 3;
			baseScoreContainer.y = Statics.stageHeight * 6.2 / 10 + yModifier;
			scoreContainer.addChild(baseScoreContainer);
			// eof coins
			///////////////////////////////////////////////////////////////////
			
			///////////////////////////////////////////////////////////////////
			// bof coins
			coinContainer = new Sprite();
			
			// coin icon
			var coinIcon:MovieClip = new MovieClip(Statics.assets.getTextures("CoinLarge"), 40);
			coinIcon.pivotX = Math.ceil(coinIcon.width / 2);
			coinIcon.pivotY = Math.ceil(coinIcon.height / 2);
			coinIcon.rotation = -Math.PI / 8;
			coinIcon.x = Math.ceil(coinIcon.width / 2);
			coinIcon.y = Math.ceil(coinIcon.height / 2);
			starling.core.Starling.juggler.add(coinIcon);
			coinContainer.addChild(coinIcon);
			
			// coin label
			var coinLabel:TextField = new TextField(150, coinIcon.height, "Coins Earned:", fontMaterhorn24.fontName, fontMaterhorn24.fontSize, 0xffffff);
			coinLabel.vAlign = VAlign.CENTER;
			coinLabel.hAlign = HAlign.LEFT;
			coinLabel.x = coinIcon.bounds.right;
			coinContainer.addChild(coinLabel);
			
			// coin value
			coinText = new TextField(120, coinIcon.height, "", fontMaterhorn24.fontName, fontMaterhorn24.fontSize, 0xffffff);
			coinText.vAlign = VAlign.CENTER;
			coinText.hAlign = HAlign.LEFT;
			coinText.x = coinLabel.bounds.right + 20;
			coinContainer.addChild(coinText);
			
//			coinContainer.pivotX = Math.ceil(coinContainer.width / 2);
			coinContainer.x = Statics.stageWidth * 3 / 10 - 10;
			coinContainer.y = Statics.stageHeight * 7.4 / 10 + yModifier - 13;
			scoreContainer.addChild(coinContainer);
			// eof coins
			///////////////////////////////////////////////////////////////////
			
			// earned achievements header
			headerAchievementsEarned = new Image(Statics.assets.getTexture("GameOverHeaderObjEarned0000"));
			headerAchievementsEarned.pivotX = Math.ceil(headerAchievementsEarned.width / 2);
			headerAchievementsEarned.y = Statics.stageHeight * 5.3 / 10 + yModifier + 5;
			addChild(headerAchievementsEarned);
			
			// earned achievements header
			headerAchievementsAim = new Image(Statics.assets.getTexture("GameOverHeaderObjAim0000"));
			headerAchievementsAim.pivotX = Math.ceil(headerAchievementsAim.width / 2);
			headerAchievementsAim.y = Statics.stageHeight * 5.3 / 10 + yModifier + 5;
			addChild(headerAchievementsAim);
			
			// achievements
			this.createAchievementPlates();
			
			// next button
			btnNext = new Button();
			var nextBtnImage:Image = new Image(Statics.assets.getTexture("InstructionsBtnNext0000"));
			btnNext.defaultSkin = nextBtnImage;
			btnNext.hoverSkin = new Image(Statics.assets.getTexture("InstructionsBtnNext0000"));
			btnNext.downSkin = new Image(Statics.assets.getTexture("InstructionsBtnNext0000"));
			btnNext.hoverSkin.filter = Statics.btnBrightnessFilter;
			btnNext.downSkin.filter = Statics.btnInvertFilter;
			btnNext.useHandCursor = true;
			this.addChild(btnNext);
			btnNext.pivotX = Math.ceil(nextBtnImage.width / 2);
			btnNext.x = Statics.stageWidth / 2;
			btnNext.y = Statics.stageHeight - nextBtnImage.height - 35;
			btnNext.addEventListener(Event.TRIGGERED, onNextClick);
			
			// finish button
			proceedBtn = new Button();
			var proceedBtnImage:Image = new Image(Statics.assets.getTexture("GameOverBtnReturn0000"));
			proceedBtn.defaultSkin = proceedBtnImage;
			proceedBtn.hoverSkin = new Image(Statics.assets.getTexture("GameOverBtnReturn0000"));
			proceedBtn.downSkin = new Image(Statics.assets.getTexture("GameOverBtnReturn0000"));
			proceedBtn.hoverSkin.filter = Statics.btnBrightnessFilter;
			proceedBtn.downSkin.filter = Statics.btnInvertFilter;
			proceedBtn.useHandCursor = true;
			this.addChild(proceedBtn);
//			proceedBtn.validate();
			proceedBtn.pivotX = Math.ceil(proceedBtnImage.width / 2);
			proceedBtn.x = Statics.stageWidth / 2;
			proceedBtn.y = Statics.stageHeight - proceedBtnImage.height - 35;
			proceedBtn.visible = false;
			proceedBtn.addEventListener(Event.TRIGGERED, onProceedClick);
			
			// play again smart match button
			this.btnPlayAgainSmartMatch = new Button();
			var btnPlayAgainSmartMatchImage:Image = new Image(Statics.assets.getTexture("PlayAgainMatch0000"));
			btnPlayAgainSmartMatch.defaultSkin = btnPlayAgainSmartMatchImage;
			btnPlayAgainSmartMatch.hoverSkin = new Image(Statics.assets.getTexture("PlayAgainMatch0000"));
			btnPlayAgainSmartMatch.downSkin = new Image(Statics.assets.getTexture("PlayAgainMatch0000"));
			btnPlayAgainSmartMatch.hoverSkin.filter = Statics.btnBrightnessFilter;
			btnPlayAgainSmartMatch.downSkin.filter = Statics.btnInvertFilter;
			btnPlayAgainSmartMatch.useHandCursor = true;
			this.addChild(btnPlayAgainSmartMatch);
			//			proceedBtn.validate();
			btnPlayAgainSmartMatch.x = Statics.stageWidth - btnPlayAgainSmartMatchImage.width - 55;
			btnPlayAgainSmartMatch.y = Statics.stageHeight - btnPlayAgainSmartMatchImage.height - 10;
			btnPlayAgainSmartMatch.addEventListener(Event.TRIGGERED, onPlayAgainSmartMatchClick);
			
			// round coins fly out effect
			roundCoins = new Vector.<MovieClip>();
			var coin:MovieClip;
			for (var i:uint = 0; i < 20; i++) {
				coin = new MovieClip(Statics.assets.getTextures("CoinLarge"), 40);
				roundCoins.push(coin);
			}
			
			// high score badge
			this.badgeHighScore = new BadgeHighScore;
			this.addChild(this.badgeHighScore);
		}
		
		private function createAchievementPlates():void {
			this.achievementPlate1 = new AchievementPlate();
			achievementPlate1.pivotX = Math.ceil(achievementPlate1.width / 2);
			achievementPlate1.y = headerAchievementsEarned.bounds.bottom + 15;
			achievementPlate1.visible = false;
			this.addChild(achievementPlate1);
			
			this.achievementPlate2 = new AchievementPlate();
			achievementPlate2.pivotX = Math.ceil(achievementPlate2.width / 2);
			achievementPlate2.y = achievementPlate1.bounds.bottom - 8;
			achievementPlate2.visible;
			this.addChild(achievementPlate2);
			
			this.achievementPlate3 = new AchievementPlate();
			achievementPlate3.pivotX = Math.ceil(achievementPlate3.width / 2);
			achievementPlate3.y = achievementPlate2.bounds.bottom - 8;
			achievementPlate3.visible = false;
			this.addChild(achievementPlate3);
		}
		
		private function resetAchievementPlates():void {
			achievementPlate1.visible = false;
			achievementPlate1.x = Statics.stageWidth + Math.ceil(achievementPlate1.width / 2);
			achievementPlate1.uncheck();
			
			achievementPlate2.visible = false;
			achievementPlate2.x = Statics.stageWidth + Math.ceil(achievementPlate1.width / 2);
			achievementPlate2.uncheck();
			
			achievementPlate3.visible = false;
			achievementPlate3.x = Statics.stageWidth + Math.ceil(achievementPlate1.width / 2);
			achievementPlate3.uncheck();
		}
		
		private function onNextClick(event:Event):void {
			this.scoreContainer.visible = false;
			
			// initialize achievement plates
//			Starling.juggler.delayCall(checkForNextAchievementSet, 4);
			this.checkForNextAchievementSet();
			this.btnNext.visible = false;
			this.proceedBtn.visible = true;
		}
		
		private function onProceedClick(event:Event):void
		{
			// clean up stuff
			Starling.juggler.remove(Statics.particleConfetti);
			this.removeChild(Statics.particleConfetti);
			Starling.juggler.remove(badgeHighScore);
			
			// clean up coin fly out effect
			for (var i:uint = 0; i < 20; i++) {
				starling.core.Starling.juggler.remove(roundCoins[i]);
				removeChild(roundCoins[i]);
			}
			
			// update and display round details popup
			Statics.roundScores[Statics.currentRound] = roundScore;
			this.menu.showMatchDetailsPopup(true);
			
			// call JS to send a player to player request
			ExternalInterface.call("sendTurnRequest", Statics.opponentFbid, Statics.gameId);
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "menu"}, true));
			
			// show interstitial ad
//			this.menu.showInterstitialAd();
			
			this.visible = false;
		}
		
		// send scores to backend
		public function sendRoundData(baseScore:int, distanceTraveled:int):void
		{
			// hide buttons
			this.btnPlayAgainSmartMatch.visible = false;
			btnNext.visible = false;
			proceedBtn.visible = false;
			
			// calculate total score
			this.distanceTraveled = distanceTraveled;
			roundScore = baseScore + distanceTraveled * 3;
			var coinsObtained:int = Math.round(roundScore / 5);
			var coinsObtainedFinal:int = coinsObtained;
			if (Statics.rankCoinDoubler == 1) {
				coinsObtainedFinal = coinsObtained * 2;
			}
			
			// send new score to backend
			var jsonStr:String = JSON.stringify({
				distance: distanceTraveled,
				base_score: baseScore,
				score: roundScore,
				coins: coinsObtained,
				game_id: Statics.gameId,
				round: Statics.currentRound,
				achievements: this.newAchievementsArray
			});
			this.menu.communicator.postUserData(jsonStr);
			trace("json string: " + jsonStr);
			
			// update score display
			distanceText.text = distanceTraveled.toString();
			baseScoreText.text = baseScore.toString();
			scoreText.text = roundScore.toString();
			if (Statics.rankCoinDoubler == 1) {
				coinText.text = coinsObtained.toString() + " x 2 = " + coinsObtainedFinal.toString();
			} else {
				coinText.text = coinsObtained.toString();
			}
			
			// call JS to send app to player notification
			if(ExternalInterface.available) {
				ExternalInterface.call("sendTurnNotification", Statics.opponentFbid);
			}
		}
		
		// display fanfare animation
		public function initialize():void
		{
			trace("initializing game over screen");
			
			if (!Sounds.sfxMuted) Statics.assets.playSound("SND_FANFARE");
			
			// ready confetti particles
			Starling.juggler.add(Statics.particleConfetti);
			this.addChild(Statics.particleConfetti);
			
			// reset big stars
			starCenterOn.scaleX = 0;
			starCenterOn.scaleY = 0;
			starLeftOn.scaleX = 0;
			starLeftOn.scaleY = 0;
			starRightOn.scaleX = 0;
			starRightOn.scaleY = 0;
			
			// reset other elements
			congrats.scaleX = 0;
			scoreContainer.visible = true;
			scoreContainer.alpha = 0;
			headerAchievementsEarned.x = Statics.stageWidth + headerAchievementsEarned.width / 2;
			headerAchievementsAim.x = Statics.stageWidth + headerAchievementsAim.width / 2;
			
			// reset achievement plates
			resetAchievementPlates();
			achievementSetShown = 0;
			
			this.visible = true;
			
			// animated tweens
			// left big star tween
			Starling.juggler.tween(starLeftOn, 0.5, {
				transition: Transitions.EASE_OUT_ELASTIC,
				scaleX: 1,
				scaleY: 1,
				delay: 1
			});
			Starling.juggler.delayCall(fireConfettiLeft, 1); // confetti
			var congratsTweenDelay:Number = 1.5;
			if (roundScore > Statics.playerHighScore * 1 / 3) {
				// center big star tween
				Starling.juggler.tween(starCenterOn, 0.5, {
					transition: Transitions.EASE_OUT_ELASTIC,
					scaleX: 1.1,
					scaleY: 1.1,
					delay: 1.5
				});
				Starling.juggler.delayCall(fireConfettiCenter, 1.5);
				congratsTweenDelay = 2;
			}
			if (roundScore > Statics.playerHighScore * 2 / 3) {
				// right big star tween
				Starling.juggler.tween(starRightOn, 0.5, {
					transition: Transitions.EASE_OUT_ELASTIC,
					scaleX: 1,
					scaleY: 1,
					delay: 2
				});
				Starling.juggler.delayCall(fireConfettiRight, 2);
				congratsTweenDelay = 2.5;
			}
			
			// scoreContainer tween
			var tweenScoreContainer:Tween = new Tween(scoreContainer, 0.5, Transitions.LINEAR);
			tweenScoreContainer.animate("alpha", 1);
			
			// congrats text tween
			Starling.juggler.tween(congrats, 0.5, {
				transition: Transitions.EASE_OUT_ELASTIC,
				scaleX: 1,
				delay: congratsTweenDelay,
				nextTween: tweenScoreContainer
			});
			
			// round coins flyout effect
			var locationX:Number = coinContainer.x + 11;
			var locationY:Number = coinContainer.y + 11;
			for (var i:uint = 0; i < 20; i++) {
				roundCoins[i].visible = false;
				starling.core.Starling.juggler.add(roundCoins[i]);
				addChild(roundCoins[i]);
			}
			Starling.juggler.delayCall(nextCoinFlyout, 3, roundCoins, 0, locationX, locationY);
			
			// high score badge
			badgeHighScore.visible = false;
			if (roundScore > Statics.playerHighScore) {
				starling.core.Starling.juggler.add(badgeHighScore);
				badgeHighScore.initialize(this.distanceTraveled, this.roundScore);
			}
		}
		
		private function fireConfettiLeft():void {
			if (!Sounds.sfxMuted) Statics.assets.playSound("SND_FIREWORK");
			
			Statics.particleConfetti.emitterX = starLeftOn.x;
			Statics.particleConfetti.emitterY = starLeftOn.y;
			Statics.particleConfetti.emitAngle = deg2rad(240);
			Statics.particleConfetti.start(0.2);
		}
		
		private function fireConfettiCenter():void {
			if (!Sounds.sfxMuted) Statics.assets.playSound("SND_FIREWORK");
			
			Statics.particleConfetti.emitterX = starCenterOn.x;
			Statics.particleConfetti.emitterY = starCenterOn.y;
			Statics.particleConfetti.emitAngle = deg2rad(270);
			Statics.particleConfetti.start(0.2);
		}
		
		private function fireConfettiRight():void {
			if (!Sounds.sfxMuted) Statics.assets.playSound("SND_FIREWORK");
			
			Statics.particleConfetti.emitterX = starRightOn.x;
			Statics.particleConfetti.emitterY = starRightOn.y;
			Statics.particleConfetti.emitAngle = deg2rad(300);
			Statics.particleConfetti.start(0.2);
		}
		
		// make one coin fly out of the screen and schedule the next coin
		private function nextCoinFlyout(coinPool:Vector.<MovieClip>, coinIndex:uint, startLocationX, startLocationY):void {
			if (!Sounds.sfxMuted && coinIndex == 0) Statics.assets.playSound("SND_PAYOUT");
			
			if (coinIndex >= coinPool.length) return;
			coinPool[coinIndex].x = startLocationX;
			coinPool[coinIndex].y = startLocationY;
			coinPool[coinIndex].visible = true;
			Starling.juggler.tween(coinPool[coinIndex], 0.3, {
				transition: Transitions.EASE_IN,
				x: Statics.stageWidth,
				y: -coinPool[coinIndex].height
			});
			Starling.juggler.delayCall(nextCoinFlyout, 0.05, coinPool, coinIndex + 1, startLocationX, startLocationY);
		}
		
		/**
		 * Display a set of three achievements earned this round
		 */
		private function showAchievementSet():void {
			this.resetAchievementPlates();
			
			// achievements header tween
			Starling.juggler.tween(headerAchievementsEarned, 0.3, {
				transition: Transitions.EASE_OUT,
				x: Statics.stageWidth / 2
			});
			
			if (this.newAchievementsArray[this.achievementSetShown * 3] != null) {
				var data:Array = Constants.AchievementsData[this.newAchievementsArray[this.achievementSetShown * 3]];
				this.achievementPlate1.initialize(data[1], data[2], data[3], data[4]);
				achievementPlate1.visible = true;
				Starling.juggler.tween(achievementPlate1, 0.2, {
					transition: Transitions.EASE_OUT,
					x: Statics.stageWidth / 2,
					delay: 0.2
				});
				if (!Sounds.sfxMuted) Starling.juggler.delayCall(Statics.assets.playSound, 0.2, "SND_FAST_SWOOSH");; // play slide sfx
				Starling.juggler.delayCall(achievementPlateCheck, 0.5, 1);
				// coins flyout effect
				var locationX:Number = Statics.stageWidth / 2 - achievementPlate1.pivotX + achievementPlate1.coin.x - achievementPlate1.coin.pivotX;
				var locationY:Number = achievementPlate1.y - achievementPlate1.pivotY + achievementPlate1.coin.y - achievementPlate1.coin.pivotY;
				Starling.juggler.delayCall(nextCoinFlyout, 0.5, roundCoins, 0, locationX, locationY);
				
				if (this.newAchievementsArray[this.achievementSetShown * 3 + 1] != null) {
					data = Constants.AchievementsData[this.newAchievementsArray[this.achievementSetShown * 3 + 1]];
					this.achievementPlate2.initialize(data[1], data[2], data[3], data[4]);
					achievementPlate2.visible = true;
					Starling.juggler.tween(achievementPlate2, 0.2, {
						transition: Transitions.EASE_OUT,
						x: Statics.stageWidth / 2,
						delay: 0.4
					});
					if (!Sounds.sfxMuted) Starling.juggler.delayCall(Statics.assets.playSound, 0.4, "SND_FAST_SWOOSH"); // play slide sfx
					Starling.juggler.delayCall(achievementPlateCheck, 1, 2);
					// coins flyout effect
					var location2X:Number = Statics.stageWidth / 2 - achievementPlate2.pivotX + achievementPlate2.coin.x - achievementPlate2.coin.pivotX;
					var location2Y:Number = achievementPlate2.y - achievementPlate2.pivotY + achievementPlate2.coin.y - achievementPlate2.coin.pivotY;
					Starling.juggler.delayCall(nextCoinFlyout, 1, roundCoins, 0, location2X, location2Y);
					
					if (this.newAchievementsArray[this.achievementSetShown * 3 + 2] != null) {
						data = Constants.AchievementsData[this.newAchievementsArray[this.achievementSetShown * 3 + 2]];
						this.achievementPlate3.initialize(data[1], data[2], data[3], data[4]);
						achievementPlate3.visible = true;
						Starling.juggler.tween(achievementPlate3, 0.2, {
							transition: Transitions.EASE_OUT,
							x: Statics.stageWidth / 2,
							delay: 0.6
						});
						if (!Sounds.sfxMuted) Starling.juggler.delayCall(Statics.assets.playSound, 0.6, "SND_FAST_SWOOSH"); // play slide sfx
						Starling.juggler.delayCall(achievementPlateCheck, 1.5, 3);
						// coins flyout effect
						var location3X:Number = Statics.stageWidth / 2 - achievementPlate3.pivotX + achievementPlate3.coin.x - achievementPlate3.coin.pivotX;
						var location3Y:Number = achievementPlate3.y - achievementPlate3.pivotY + achievementPlate3.coin.y - achievementPlate3.coin.pivotY;
						Starling.juggler.delayCall(nextCoinFlyout, 1.5, roundCoins, 0, location3X, location3Y);
					}
				}
			}
			Starling.juggler.delayCall(achievementPlatesFlyout, 4.5);
		}
		
		/**
		 * Make the achievement plates fly out of the stage
		 */
		private function achievementPlatesFlyout():void {
			if (achievementPlate1.visible) {
				if (!Sounds.sfxMuted) Statics.assets.playSound("SND_FAST_SWOOSH"); // play slide sfx
				Starling.juggler.tween(achievementPlate1, 0.2, {
					transition: Transitions.EASE_IN,
					x: -Math.ceil(achievementPlate1.width / 2) - 10
				});
				
				if (achievementPlate2.visible) {
					if (!Sounds.sfxMuted) Starling.juggler.delayCall(Statics.assets.playSound, 0.2, "SND_FAST_SWOOSH"); // play slide sfx
					Starling.juggler.tween(achievementPlate2, 0.2, {
						transition: Transitions.EASE_IN,
						x: -Math.ceil(achievementPlate2.width / 2) - 10,
						delay: 0.2
					});
					
					if (achievementPlate3.visible) {
						if (!Sounds.sfxMuted) Starling.juggler.delayCall(Statics.assets.playSound, 0.4, "SND_FAST_SWOOSH"); // play slide sfx
						Starling.juggler.tween(achievementPlate3, 0.2, {
							transition: Transitions.EASE_IN,
							x: -Math.ceil(achievementPlate3.width / 2) - 10,
							delay: 0.4
						});
					}
				}
			}
			Starling.juggler.delayCall(checkForNextAchievementSet, 1);
		}
		
		private function checkForNextAchievementSet():void {
			// check if we should show the next set
			if (this.newAchievementsArray.length > this.achievementSetShown * 3) {
				this.showAchievementSet();
				this.achievementSetShown++;
			} else { // show the aim for set
				this.newAchievementsArray.length = 0;
				this.showAchievementAimForSet();
			}
		}
		
		/**
		 * Return the id of the next unearned achievement
		 */
		private function findNextUnearnedAchievement(index:uint):int {
//			var listLength:uint = Statics.achievementsList.length;
//			for (var i:uint = index + 1; i < listLength; i++) {
//				if (!Statics.achievementsList[i]) return i;
//			}
//			return 0;
			
			var listLength:uint = Constants.AchievementsProgression.length;
			for (var i:uint = index; i < listLength; i++) {
				if (!Statics.achievementsList[Constants.AchievementsProgression[i]]) return i;
			}
			return -1;
		}
		
		/**
		 * Show the set of achievements to aim for
		 */
		private function showAchievementAimForSet():void {
			this.resetAchievementPlates();
			
			// achievements header tween
			Starling.juggler.tween(headerAchievementsEarned, 0.3, {
				transition: Transitions.EASE_OUT,
				x: -headerAchievementsEarned.width / 2
			});
			Starling.juggler.tween(headerAchievementsAim, 0.3, {
				transition: Transitions.EASE_OUT,
				x: Statics.stageWidth / 2
			});
			
			var nextUnearnedProgressIndex:int = this.findNextUnearnedAchievement(0);
			if (nextUnearnedProgressIndex != -1) {
				var data:Array = Constants.AchievementsData[Constants.AchievementsProgression[nextUnearnedProgressIndex]];
				this.achievementPlate1.initialize(data[1], data[2], data[3], data[4]);
				achievementPlate1.visible = true;
				if (!Sounds.sfxMuted) Starling.juggler.delayCall(Statics.assets.playSound, 0.2, "SND_FAST_SWOOSH"); // play slide sfx
				Starling.juggler.tween(achievementPlate1, 0.2, {
					transition: Transitions.EASE_OUT,
					x: Statics.stageWidth / 2,
					delay: 0.2
				});
			}
			
			nextUnearnedProgressIndex = this.findNextUnearnedAchievement(nextUnearnedProgressIndex + 1);
			if (nextUnearnedProgressIndex != -1) {
				data = Constants.AchievementsData[Constants.AchievementsProgression[nextUnearnedProgressIndex]];
				this.achievementPlate2.initialize(data[1], data[2], data[3], data[4]);
				achievementPlate2.visible = true;
				if (!Sounds.sfxMuted) Starling.juggler.delayCall(Statics.assets.playSound, 0.4, "SND_FAST_SWOOSH"); // play slide sfx
				Starling.juggler.tween(achievementPlate2, 0.2, {
					transition: Transitions.EASE_OUT,
					x: Statics.stageWidth / 2,
					delay: 0.4
				});
			}
			
			nextUnearnedProgressIndex = this.findNextUnearnedAchievement(nextUnearnedProgressIndex + 1);
			if (nextUnearnedProgressIndex != -1) {
				data = Constants.AchievementsData[Constants.AchievementsProgression[nextUnearnedProgressIndex]];
				this.achievementPlate3.initialize(data[1], data[2], data[3], data[4]);
				achievementPlate3.visible = true;
				if (!Sounds.sfxMuted) Starling.juggler.delayCall(Statics.assets.playSound, 0.6, "SND_FAST_SWOOSH"); // play slide sfx
				Starling.juggler.tween(achievementPlate3, 0.2, {
					transition: Transitions.EASE_OUT,
					x: Statics.stageWidth / 2,
					delay: 0.6
				});
			}
		}
		
		/**
		 * Add checkmark to an achievement plate
		 */
		private function achievementPlateCheck(index:uint):void {
			switch (index) {
				case 1:
					this.achievementPlate1.check();
					break;
				case 2:
					this.achievementPlate2.check();
					break;
				case 3:
					this.achievementPlate3.check();
					break;
			}
		}
		
		private function dataReceived(event:NavigationEvent):void {
//			trace(event.params.data);
//			this.menu.dataReceived(event); // pass return data to main response receiver for processing
			if (this.menu.lives >= 1) {
				this.btnPlayAgainSmartMatch.visible = true;
			}
			btnNext.visible = true;
		}
		
		/**
		 * Add a newly earned achievement to a string, to be sent to the backend
		 */
		public function addNewAchievement(achievementId:uint):void {
			this.newAchievementsArray.push(achievementId);
		}
		
		private function onPlayAgainSmartMatchClick():void {
			if (!Sounds.sfxMuted) Statics.assets.playSound("SND_CLICK");
			
			trace("num matches: " + this.menu.screenMatches.listYourTurn.dataProvider.length);
			var numPlayableMatches:int = this.menu.screenMatches.listYourTurn.dataProvider.length;
			
			if (numPlayableMatches > 0) {
				trace("playing existing match");
				this.menu.screenMatches.listYourTurn.selectedIndex = 0;
				this.menu.communicator.sendRoundBegin();
			} else {
				trace("creating new match");
				Statics.gameId = 0;
				this.menu.communicator.findSmartMatch(true); // do not sendRoundBegin separately
			}
			this.inGame.initializeNormalMode();
			
			if (Statics.isAnalyticsEnabled) { // mixpanel
				Statics.mixpanel.track('clicked on Play Again Smart Match button');
			}
		}
	}
}