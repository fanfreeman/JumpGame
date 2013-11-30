package com.jumpGame.ui
{
	import com.jumpGame.customObjects.Font;
	import com.jumpGame.events.NavigationEvent;
	import com.jumpGame.level.Statics;
	import com.jumpGame.screens.Menu;
	import com.jumpGame.ui.components.AchievementPlate;
	
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
		
		// coin display
		private var coinText:TextField;
		
		// score display
		private var scoreText:TextField;
		
		// buttons
		private var proceedBtn:Button;
		
		// fonts
		private var fontMaterhorn24:Font;
		private var fontMaterhorn25:Font;
		
		private var communicator:Communicator;
		
		private var roundScore:int;
		
		// array to store new achievement ids earned this round
		private var newAchievementsArray:Array = new Array();
		
		private var achievementSetShown:uint = 0;
		
		// achievement plates
		private var achievementPlate1:AchievementPlate;
		private var achievementPlate2:AchievementPlate;
		private var achievementPlate3:AchievementPlate;
		
		private var menu:Menu;
		
		private var roundCoins:Vector.<MovieClip>; // coin fly out effect
		
		// coin pools
//		private var roundCoins:Vector.<MovieClip>;
//		private var achievementCoins1:Vector.<MovieClip>;
//		private var achievementCoins2:Vector.<MovieClip>;
//		private var achievementCoins3:Vector.<MovieClip>;
		
		public function GameOverContainer(menu:Menu)
		{
			super();
			this.menu = menu;
			this.drawGameOver();
			this.communicator = new Communicator();
			
			//testing
//			this.addNewAchievement(1);
//			this.addNewAchievement(2);
//			this.addNewAchievement(3);
//			this.addNewAchievement(4);
//			this.addNewAchievement(5);
//			this.addNewAchievement(6);
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
			var starCenter:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("BigStarOff0000"));
			starCenter.pivotX = Math.ceil(starCenter.width / 2);
			starCenter.pivotY = Math.ceil(starCenter.height / 2);
			starCenter.x = Statics.stageWidth / 2;
			starCenter.y = 100 + yModifier;
			this.addChild(starCenter);
			// left
			var starLeft:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("BigStarOff0000"));
			starLeft.pivotX = Math.ceil(starLeft.width / 2);
			starLeft.pivotY = Math.ceil(starLeft.height / 2);
			starLeft.x = Statics.stageWidth / 2 - starLeft.width - 15;
			starLeft.y = 125 + yModifier;
			starLeft.rotation = -15 * Math.PI / 180;
			this.addChild(starLeft);
			// right
			var starRight:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("BigStarOff0000"));
			starRight.pivotX = Math.ceil(starRight.width / 2);
			starRight.pivotY = Math.ceil(starRight.height / 2);
			starRight.x = Statics.stageWidth / 2 + starRight.width + 15;
			starRight.y = 125 + yModifier;
			starRight.rotation = 15 * Math.PI / 180;
			this.addChild(starRight);
			// eof big stars (off)
			
			// big stars (on)
			// center
			starCenterOn = new Image(Assets.getSprite("AtlasTexture4").getTexture("BigStarOn0000"));
			starCenterOn.pivotX = Math.ceil(starCenterOn.width / 2);
			starCenterOn.pivotY = Math.ceil(starCenterOn.height / 2);
			starCenterOn.x = Statics.stageWidth / 2;
			starCenterOn.y = 100 + yModifier;
			this.addChild(starCenterOn);
			// left
			starLeftOn = new Image(Assets.getSprite("AtlasTexture4").getTexture("BigStarOn0000"));
			starLeftOn.pivotX = Math.ceil(starLeftOn.width / 2);
			starLeftOn.pivotY = Math.ceil(starLeftOn.height / 2);
			starLeftOn.x = Statics.stageWidth / 2 - starLeftOn.width - 15;
			starLeftOn.y = 125 + yModifier;
			starLeftOn.rotation = -15 * Math.PI / 180;
			this.addChild(starLeftOn);
			// right
			starRightOn = new Image(Assets.getSprite("AtlasTexture4").getTexture("BigStarOn0000"));
			starRightOn.pivotX = Math.ceil(starRightOn.width / 2);
			starRightOn.pivotY = Math.ceil(starRightOn.height / 2);
			starRightOn.x = Statics.stageWidth / 2 + starRightOn.width + 15;
			starRightOn.y = 125 + yModifier;
			starRightOn.rotation = 15 * Math.PI / 180;
			this.addChild(starRightOn);
			// eof big stars (on)
			
			// congratulations image
			congrats = new Image(Assets.getSprite("AtlasTexture4").getTexture("GameOverCongrats0000"));
			congrats.pivotX = Math.ceil(congrats.width  / 2); // center art on registration point
			congrats.x = Statics.stageWidth / 2;
			congrats.y = Statics.stageHeight * 2.6 / 10 + yModifier;
			addChild(congrats);
			
			// score container sprite
			scoreContainer = new Sprite();
			addChild(scoreContainer);
			
			// get fonts for text display
			fontMaterhorn24 = Fonts.getFont("Materhorn24");
			fontMaterhorn25 = Fonts.getFont("Materhorn25");
			
			// bof distance
			var distanceContainer:Sprite = new Sprite();
			
			// distance icon
			var distanceIcon:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("GameOverIconDistance0000"));
			distanceContainer.addChild(distanceIcon);
			
			// distance label
			var distanceLabel:TextField = new TextField(100, distanceIcon.height, "Distance:", fontMaterhorn24.fontName, fontMaterhorn24.fontSize, 0xffffff);
			distanceLabel.vAlign = VAlign.CENTER;
			distanceLabel.hAlign = HAlign.LEFT;
			distanceLabel.x = distanceIcon.bounds.right + 20;
			distanceContainer.addChild(distanceLabel);
			
			// distance value
			distanceText = new TextField(70, distanceIcon.height, "", fontMaterhorn24.fontName, fontMaterhorn24.fontSize, 0xffffff);
			distanceText.vAlign = VAlign.CENTER;
			distanceText.hAlign = HAlign.LEFT;
			distanceText.x = distanceLabel.bounds.right + 20;
			distanceContainer.addChild(distanceText);
			
			distanceContainer.pivotX = Math.ceil(distanceContainer.width / 2);
			distanceContainer.x = Statics.stageWidth * 2.5 / 10;
			distanceContainer.y = Statics.stageHeight * 3.4 / 10 + yModifier;
			scoreContainer.addChild(distanceContainer);
			// eof distance
			
			// bof coins
			coinContainer = new Sprite();
			
			// coin icon
			var coinIcon:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("GameOverIconCoin0000"));
			coinContainer.addChild(coinIcon);
			
			// coin label
			var coinLabel:TextField = new TextField(100, coinIcon.height, "Coins:", fontMaterhorn24.fontName, fontMaterhorn24.fontSize, 0xffffff);
			coinLabel.vAlign = VAlign.CENTER;
			coinLabel.hAlign = HAlign.LEFT;
			coinLabel.x = coinIcon.bounds.right + 20;
			coinContainer.addChild(coinLabel);
			
			// coin value
			coinText = new TextField(70, coinIcon.height, "", fontMaterhorn24.fontName, fontMaterhorn24.fontSize, 0xffffff);
			coinText.vAlign = VAlign.CENTER;
			coinText.hAlign = HAlign.LEFT;
			coinText.x = coinLabel.bounds.right + 20;
			coinContainer.addChild(coinText);
			
			coinContainer.pivotX = Math.ceil(coinContainer.width / 2);
			coinContainer.x = Statics.stageWidth * 7.5 / 10;
			coinContainer.y = Statics.stageHeight * 3.4 / 10 + yModifier;
			scoreContainer.addChild(coinContainer);
			// eof coins
			
			// bof total score
			var totalScoreContainer:Sprite = new Sprite();
			
			// score icon
			var scoreIcon:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("GameOverIconDistance0000"));
			totalScoreContainer.addChild(scoreIcon);
			
			// score label
			var scoreLabel:TextField = new TextField(140, scoreIcon.height, "Total Score:", fontMaterhorn25.fontName, fontMaterhorn25.fontSize, 0xffffff);
			scoreLabel.vAlign = VAlign.CENTER;
			scoreLabel.hAlign = HAlign.LEFT;
			scoreLabel.x = scoreIcon.bounds.right + 20;
			totalScoreContainer.addChild(scoreLabel);
			
			// score value
			scoreText = new TextField(100, scoreIcon.height, "", fontMaterhorn25.fontName, fontMaterhorn25.fontSize, 0xffffff);
			scoreText.vAlign = VAlign.CENTER;
			scoreText.hAlign = HAlign.LEFT;
			scoreText.x = scoreLabel.bounds.right + 20;
			totalScoreContainer.addChild(scoreText);
			
			totalScoreContainer.pivotX = Math.ceil(totalScoreContainer.width / 2);
			totalScoreContainer.x = Statics.stageWidth / 2;
			totalScoreContainer.y = Statics.stageHeight * 4.2 / 10 + yModifier;
			scoreContainer.addChild(totalScoreContainer);
			// eof total score
			
			// earned achievements header
			headerAchievementsEarned = new Image(Assets.getSprite("AtlasTexture4").getTexture("GameOverHeaderAchievements0000"));
			headerAchievementsEarned.pivotX = Math.ceil(headerAchievementsEarned.width / 2);
			headerAchievementsEarned.y = Statics.stageHeight * 5.3 / 10 + yModifier + 5;
			addChild(headerAchievementsEarned);
			
			// earned achievements header
			headerAchievementsAim = new Image(Assets.getSprite("AtlasTexture4").getTexture("GameOverHeaderAchievements0000"));
			headerAchievementsAim.pivotX = Math.ceil(headerAchievementsAim.width / 2);
			headerAchievementsAim.y = Statics.stageHeight * 5.3 / 10 + yModifier + 5;
			addChild(headerAchievementsAim);
			
			// achievements
			this.createAchievementPlates();
			
			// finish button
			proceedBtn = new Button();
			var proceedBtnImage:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("GameOverBtnReturn0000"));
			proceedBtn.defaultSkin = proceedBtnImage;
			proceedBtn.hoverSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("GameOverBtnReturn0000"));
			proceedBtn.downSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("GameOverBtnReturn0000"));
			proceedBtn.hoverSkin.filter = Statics.btnBrightnessFilter;
			proceedBtn.downSkin.filter = Statics.btnInvertFilter;
			proceedBtn.useHandCursor = true;
			this.addChild(proceedBtn);
			proceedBtn.validate();
			proceedBtn.pivotX = Math.ceil(proceedBtnImage.width / 2);
			proceedBtn.x = Statics.stageWidth / 2;
			proceedBtn.y = Statics.stageHeight - proceedBtnImage.height - 35;
			proceedBtn.visible = false;
			proceedBtn.addEventListener(Event.TRIGGERED, onProceedClick);
			
			// round coins fly out effect
			roundCoins = new Vector.<MovieClip>();
			var coin:MovieClip;
			for (var i:uint = 0; i < 20; i++) {
				coin = new MovieClip(Assets.getSprite("AtlasTexturePlatforms").getTextures("Coin"), 40);
				roundCoins.push(coin);
			}
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
		
		private function onProceedClick(event:Event):void
		{
			// clean up stuff
			Starling.juggler.remove(Statics.particleConfetti);
			this.removeChild(Statics.particleConfetti);
			
			// clean up coin fly out effect
			for (var i:uint = 0; i < 20; i++) {
				starling.core.Starling.juggler.remove(roundCoins[i]);
				removeChild(roundCoins[i]);
			}
			
			// update and display round details popup
			Statics.roundScores[Statics.currentRound] = roundScore;
			this.menu.showMatchDetailsPopup(true);
			
			// call JS to send notification
			ExternalInterface.call("sendTurnRequest", Statics.opponentFbid, Statics.gameId);
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "menu"}, true));
			
			this.visible = false;
		}
		
		// show scores and post to backend
		public function initialize(coinsObtained:int, distanceTraveled:int):void
		{
			if (!Sounds.sfxMuted) Sounds.sndFanfare.play();
			
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
			scoreContainer.alpha = 0;
			headerAchievementsEarned.x = Statics.stageWidth + headerAchievementsEarned.width / 2;
			headerAchievementsAim.x = Statics.stageWidth + headerAchievementsAim.width / 2;
			
			// reset achievement plates
			resetAchievementPlates();
			
			// calculate total score
			if (Statics.rankCoinDoubler == 1) { // check if coin doubler in possession
				roundScore = int(coinsObtained / 2) + distanceTraveled;
			} else {
				roundScore = coinsObtained + distanceTraveled;
			}
			
			// send new score to backend
			var jsonStr:String = JSON.stringify({
				coins: coinsObtained,
				distance: distanceTraveled,
				score: roundScore,
				game_id: Statics.gameId,
				round: Statics.currentRound,
				achievements: this.newAchievementsArray
			});
			this.communicator.addEventListener(NavigationEvent.RESPONSE_RECEIVED, dataReceived);
			this.communicator.postUserData(jsonStr);
			
			// update score display
			distanceText.text = distanceTraveled.toString();
//			if (Statics.rankCoinDoubler == 1) {
//				coinText.text = coinsObtained.toString() + " x 2 = " + coinsObtainedFinal.toString();
//			} else {
				coinText.text = coinsObtained.toString();
//			}
			scoreText.text = roundScore.toString();
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
			
			// initialize achievement plates
			Starling.juggler.delayCall(checkForNextAchievementSet, 4);
			
			// round coins flyout effect
//			if (coinsObtained > 0) {
				var locationX:Number = coinContainer.x - coinContainer.pivotX;
				var locationY:Number = coinContainer.y - coinContainer.pivotY;
				for (var i:uint = 0; i < 20; i++) {
					roundCoins[i].visible = false;
					starling.core.Starling.juggler.add(roundCoins[i]);
					addChild(roundCoins[i]);
				}
				Starling.juggler.delayCall(nextCoinFlyout, 3, roundCoins, 0, locationX, locationY);
//			}
		}
		
		private function fireConfettiLeft():void {
			if (!Sounds.sfxMuted) Sounds.sndFirework.play();
			
			Statics.particleConfetti.emitterX = starLeftOn.x;
			Statics.particleConfetti.emitterY = starLeftOn.y;
			Statics.particleConfetti.emitAngle = deg2rad(240);
			Statics.particleConfetti.start(0.2);
		}
		
		private function fireConfettiCenter():void {
			if (!Sounds.sfxMuted) Sounds.sndFirework.play();
			
			Statics.particleConfetti.emitterX = starCenterOn.x;
			Statics.particleConfetti.emitterY = starCenterOn.y;
			Statics.particleConfetti.emitAngle = deg2rad(270);
			Statics.particleConfetti.start(0.2);
		}
		
		private function fireConfettiRight():void {
			if (!Sounds.sfxMuted) Sounds.sndFirework.play();
			
			Statics.particleConfetti.emitterX = starRightOn.x;
			Statics.particleConfetti.emitterY = starRightOn.y;
			Statics.particleConfetti.emitAngle = deg2rad(300);
			Statics.particleConfetti.start(0.2);
		}
		
		// make one coin fly out of the screen and schedule the next coin
		private function nextCoinFlyout(coinPool:Vector.<MovieClip>, coinIndex:uint, startLocationX, startLocationY):void {
			if (!Sounds.sfxMuted && coinIndex == 0) Sounds.sndPayout.play();
			
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
				if (!Sounds.sfxMuted) Starling.juggler.delayCall(Sounds.sndFastSwoosh.play, 0.2); // play slide sfx
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
					if (!Sounds.sfxMuted) Starling.juggler.delayCall(Sounds.sndFastSwoosh.play, 0.4); // play slide sfx
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
						if (!Sounds.sfxMuted) Starling.juggler.delayCall(Sounds.sndFastSwoosh.play, 0.6); // play slide sfx
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
				if (!Sounds.sfxMuted) Sounds.sndFastSwoosh.play(); // play slide sfx
				Starling.juggler.tween(achievementPlate1, 0.2, {
					transition: Transitions.EASE_IN,
					x: -Math.ceil(achievementPlate1.width / 2) - 10
				});
				
				if (achievementPlate2.visible) {
					if (!Sounds.sfxMuted) Starling.juggler.delayCall(Sounds.sndFastSwoosh.play, 0.2); // play slide sfx
					Starling.juggler.tween(achievementPlate2, 0.2, {
						transition: Transitions.EASE_IN,
						x: -Math.ceil(achievementPlate2.width / 2) - 10,
						delay: 0.2
					});
					
					if (achievementPlate3.visible) {
						if (!Sounds.sfxMuted) Starling.juggler.delayCall(Sounds.sndFastSwoosh.play, 0.4); // play slide sfx
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
				this.showAchievementAimForSet();
			}
		}
		
		/**
		 * Return the id of the next unearned achievement
		 */
		private function findNextUnearnedAchievement(index:uint):uint {
			var listLength:uint = Statics.achievementsList.length;
			for (var i:uint = index + 1; i < listLength; i++) {
				if (!Statics.achievementsList[i]) return i;
			}
			return 0;
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
			
			var nextUnearnedIndex:uint = this.findNextUnearnedAchievement(0);
			var data:Array = Constants.AchievementsData[nextUnearnedIndex];
			this.achievementPlate1.initialize(data[1], data[2], data[3], data[4]);
			achievementPlate1.visible = true;
			if (!Sounds.sfxMuted) Starling.juggler.delayCall(Sounds.sndFastSwoosh.play, 0.2); // play slide sfx
			Starling.juggler.tween(achievementPlate1, 0.2, {
				transition: Transitions.EASE_OUT,
				x: Statics.stageWidth / 2,
				delay: 0.2
			});
			
			nextUnearnedIndex = this.findNextUnearnedAchievement(nextUnearnedIndex);
			data = Constants.AchievementsData[nextUnearnedIndex];
			this.achievementPlate2.initialize(data[1], data[2], data[3], data[4]);
			achievementPlate2.visible = true;
			if (!Sounds.sfxMuted) Starling.juggler.delayCall(Sounds.sndFastSwoosh.play, 0.4); // play slide sfx
			Starling.juggler.tween(achievementPlate2, 0.2, {
				transition: Transitions.EASE_OUT,
				x: Statics.stageWidth / 2,
				delay: 0.4
			});
			
			nextUnearnedIndex = this.findNextUnearnedAchievement(nextUnearnedIndex);
			data = Constants.AchievementsData[nextUnearnedIndex];
			this.achievementPlate3.initialize(data[1], data[2], data[3], data[4]);
			achievementPlate3.visible = true;
			if (!Sounds.sfxMuted) Starling.juggler.delayCall(Sounds.sndFastSwoosh.play, 0.6); // play slide sfx
			Starling.juggler.tween(achievementPlate3, 0.2, {
				transition: Transitions.EASE_OUT,
				x: Statics.stageWidth / 2,
				delay: 0.6
			});
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
			trace(event.params.data);
			proceedBtn.visible = true;
		}
		
		/**
		 * Add a newly earned achievement to a string, to be sent to the backend
		 */
		public function addNewAchievement(achievementId:uint):void {
			this.newAchievementsArray.push(achievementId);
		}
	}
}