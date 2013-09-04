package com.jumpGame.ui
{
	import com.jumpGame.customObjects.Font;
	import com.jumpGame.events.NavigationEvent;
	import com.jumpGame.gameElements.platforms.Coin;
	import com.jumpGame.level.Statics;
	import com.jumpGame.ui.components.AchievementPlate;
	import com.jumpGame.ui.popups.MatchDataContainer;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class GameOverContainer extends Sprite
	{
		// background quad
		private var bg:Quad;
		
		// stars
		private var starCenter:Image;
		private var starLeft:Image;
		private var starRight:Image;
		
		// message text field
//		private var messageText:TextField;
		
		// score container
		private var scoreContainer:Sprite;
		
		private var coinAnimation:MovieClip;
		
		// distance display
		private var distanceText:TextField;
		
		// coin display
		private var coinText:TextField;
		
		// score display
		private var scoreText:TextField;
		
		// buttons
		private var proceedBtn:Button;
		
		// fonts
		private var fontScore:Font;
		private var fontMessage:Font;
		private var fontLithos42:Font;
		private var fontVerdana23:Font;
		
		private var communicator:Communicator;
		
		private var matchDataPopup:MatchDataContainer;
		private var roundScore:int;
		private var matchDataPopupInitialized:Boolean;
		
		// array to store new achievement ids earned this round
		private var newAchievementsArray:Array = new Array();
		
		private var achievementSetShown:uint = 0;
		
		// achievement plates
		private var achievementPlate1:AchievementPlate;
		private var achievementPlate2:AchievementPlate;
		private var achievementPlate3:AchievementPlate;
		
		// coin pools
//		private var roundCoins:Vector.<MovieClip>;
//		private var achievementCoins1:Vector.<MovieClip>;
//		private var achievementCoins2:Vector.<MovieClip>;
//		private var achievementCoins3:Vector.<MovieClip>;
		
		public function GameOverContainer()
		{
			super();
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
			
			// big stars
			// center
			starCenter = new Image(Assets.getSprite("AtlasTexture2").getTexture("BigStar0000"));
			starCenter.pivotX = Math.ceil(starCenter.width / 2);
			starCenter.pivotY = Math.ceil(starCenter.height / 2);
			starCenter.x = Statics.stageWidth / 2;
			starCenter.y = 100;
			starCenter.scaleX = 0;
			starCenter.scaleY = 0;
			this.addChild(starCenter);
			// left
			starLeft = new Image(Assets.getSprite("AtlasTexture2").getTexture("BigStar0000"));
			starLeft.pivotX = Math.ceil(starLeft.width / 2);
			starLeft.pivotY = Math.ceil(starLeft.height / 2);
			starLeft.x = Statics.stageWidth / 2 - starLeft.width - 30;
			starLeft.y = 125;
			starLeft.rotation = -15 * Math.PI / 180;
			starLeft.scaleX = 0;
			starLeft.scaleY = 0;
			this.addChild(starLeft);
			// right
			starRight = new Image(Assets.getSprite("AtlasTexture2").getTexture("BigStar0000"));
			starRight.pivotX = Math.ceil(starRight.width / 2);
			starRight.pivotY = Math.ceil(starRight.height / 2);
			starRight.x = Statics.stageWidth / 2 + starRight.width + 30;
			starRight.y = 125;
			starRight.rotation = 15 * Math.PI / 180;
			starRight.scaleX = 0;
			starRight.scaleY = 0;
			this.addChild(starRight);
			// eof big stars
			
			// Get fonts for text display.
			fontMessage = Fonts.getFont("Badabb");
			fontScore = Fonts.getFont("Lithos24");
			fontLithos42 = Fonts.getFont("Lithos42");
			fontVerdana23 = Fonts.getFont("Verdana23");
			
			// Message text field
//			messageText = new TextField(Statics.stageWidth, 100, "GOOD EFFORT!", fontMessage.fontName, fontMessage.fontSize, 0xf3e75f);
//			messageText.vAlign = VAlign.TOP;
//			messageText.y = (Statics.stageHeight * 30)/100;
//			this.addChild(messageText);
			
			// Score container.
			scoreContainer = new Sprite();
			scoreContainer.y = (Statics.stageHeight * 30)/100;
			this.addChild(scoreContainer);
			
			distanceText = new TextField(300, 100, "Distance: 0000000", fontScore.fontName, fontScore.fontSize, 0xffffff);
			distanceText.vAlign = VAlign.TOP;
			distanceText.hAlign = HAlign.LEFT;
			distanceText.x = Statics.stageWidth / 5;
//			distanceText.border = true;
			scoreContainer.addChild(distanceText);
			
			coinText = new TextField(300, 100, "Coins: 0000000", fontScore.fontName, fontScore.fontSize, 0xffffff);
			coinText.vAlign = VAlign.TOP;
			coinText.hAlign = HAlign.LEFT;
			coinText.x = Statics.stageWidth * 3 / 5 + 40;
//			coinText.border = true;
			scoreContainer.addChild(coinText);
			
			scoreText = new TextField(400, 100, "Score: 0000000", fontLithos42.fontName, fontLithos42.fontSize, 0xff0000);
			scoreText.vAlign = VAlign.TOP;
			scoreText.hAlign = HAlign.CENTER;
			scoreText.pivotX = scoreText.width / 2;
			scoreText.x = Statics.stageWidth / 2;
			scoreText.y = 50;
			//			scoreText.border = true;
			scoreContainer.addChild(scoreText);
			
			// arrow animation
			var arrowAnimation:MovieClip = new MovieClip(Assets.getSprite("AtlasTexture2").getTextures("ArrowBounce"), 20);
			arrowAnimation.pivotX = Math.ceil(arrowAnimation.texture.width  / 2); // center art on registration point
//			arrowAnimation.pivotY = Math.ceil(arrowAnimation.texture.height / 2);
			arrowAnimation.x = Statics.stageWidth / 5 - arrowAnimation.texture.width;
			arrowAnimation.y = -10;
			starling.core.Starling.juggler.add(arrowAnimation);
			scoreContainer.addChild(arrowAnimation);
			// coin animation
			coinAnimation = new MovieClip(Assets.getSprite("AtlasTexturePlatforms").getTextures("Coin"), 40);
			coinAnimation.pivotX = Math.ceil(coinAnimation.texture.width  / 2); // center art on registration point
//			coinAnimation.pivotY = Math.ceil(coinAnimation.texture.height / 2);
			coinAnimation.x = Statics.stageWidth * 3 / 5;
			coinAnimation.y = -20;
			starling.core.Starling.juggler.add(coinAnimation);
			scoreContainer.addChild(coinAnimation);
			
			// objectives
			this.createAchievementPlates();
			
			// finish button
			proceedBtn = new Button(Assets.getSprite("AtlasTexture2").getTexture("BtnProceed0000"));
			proceedBtn.pivotX = proceedBtn.width;
			proceedBtn.pivotY = proceedBtn.height;
			proceedBtn.scaleX = 0.3;
			proceedBtn.scaleY = 0.3;
			proceedBtn.x = Statics.stageWidth - 20;
			proceedBtn.y = Statics.stageHeight - 20;
			proceedBtn.visible = false;
			this.addChild(proceedBtn);
			proceedBtn.addEventListener(Event.TRIGGERED, onProceedClick);
			
			drawMatchDataPopup();
		}
		
		private function drawMatchDataPopup():void
		{
			matchDataPopup = new MatchDataContainer(this);
			matchDataPopup.visible = false;
			this.addChild(matchDataPopup);
		}
		
		private function createAchievementPlates():void {
			this.achievementPlate1 = new AchievementPlate();
			achievementPlate1.pivotX = Math.ceil(achievementPlate1.width / 2);
			achievementPlate1.x = Statics.stageWidth + Math.ceil(achievementPlate1.width / 2);
			achievementPlate1.y = (Statics.stageHeight * 45)/100;
			achievementPlate1.visible = false;
			this.addChild(achievementPlate1);
			
			this.achievementPlate2 = new AchievementPlate();
			achievementPlate2.pivotX = Math.ceil(achievementPlate2.width / 2);
			achievementPlate2.x = Statics.stageWidth + Math.ceil(achievementPlate1.width / 2);
			achievementPlate2.y = achievementPlate1.bounds.bottom;
			achievementPlate2.visible;
			this.addChild(achievementPlate2);
			
			this.achievementPlate3 = new AchievementPlate();
			achievementPlate3.pivotX = Math.ceil(achievementPlate3.width / 2);
			achievementPlate3.x = Statics.stageWidth + Math.ceil(achievementPlate1.width / 2);
			achievementPlate3.y = achievementPlate2.bounds.bottom;
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
			if (!Sounds.muted) Sounds.sndMushroom.play();
			
			// display match data popup
			if (!matchDataPopupInitialized) { // do not initialize match data popup more than once
				Statics.roundScores[Statics.currentRound] = roundScore;
				matchDataPopup.initialize(true);
				matchDataPopupInitialized = true;
			}
			matchDataPopup.fixCloseButton();
			matchDataPopup.visible = true;
//			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "proceed"}, true));
		}
		
		// show scores and post to backend
		public function initialize(coinsObtained:int, distanceTraveled:int):void
		{
			matchDataPopupInitialized = false;
			roundScore = coinsObtained + distanceTraveled;
			
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
			distanceText.text = "Distance: " + distanceTraveled.toString();
			coinText.text = "Coins: " + coinsObtained.toString();
			scoreText.text = "Total Score: " + roundScore.toString();
			this.visible = true;
			
			// big star tweens
			var tweenRightStar:Tween = new Tween(starRight, 0.2, Transitions.EASE_OUT_BACK);
			tweenRightStar.animate("scaleX", 1);
			tweenRightStar.animate("scaleY", 1);
			
			var tweenLeftStar:Tween = new Tween(starLeft, 0.2, Transitions.EASE_OUT_BACK);
			tweenLeftStar.animate("scaleX", 1);
			tweenLeftStar.animate("scaleY", 1);
			tweenLeftStar.nextTween = tweenRightStar;
			
			Starling.juggler.tween(starCenter, 0.2, {
				transition: Transitions.EASE_OUT_BACK,
				scaleX: 1,
				scaleY: 1,
				delay: 1,
				nextTween: tweenLeftStar
			});
			
			// initialize achievement plates
			Starling.juggler.delayCall(checkForNextAchievementSet, 2);
			
			// round coins flyout effect
			var roundCoins:Vector.<MovieClip> = new Vector.<MovieClip>();
			var i:uint;
			var coin:MovieClip;
			for (i = 0; i < 20; i++) {
				coin = new MovieClip(Assets.getSprite("AtlasTexturePlatforms").getTextures("Coin"), 40);
				coin.pivotX = Math.ceil(coin.texture.width  / 2);
				coin.x = scoreContainer.x + coinAnimation.x;
				coin.y = scoreContainer.y + coinAnimation.y;
				starling.core.Starling.juggler.add(coin);
				addChild(coin);
				roundCoins.push(coin);
			}
			this.nextCoinFlyout(roundCoins, 0);
		}
		
		// make one coin fly out of the screen and schedule the next coin
		private function nextCoinFlyout(coinPool:Vector.<MovieClip>, coinIndex:uint):void {
			if (coinIndex >= coinPool.length) return;
			Starling.juggler.tween(coinPool[coinIndex], 0.2, {
				transition: Transitions.EASE_IN,
				x: Statics.stageWidth * 3 / 5,
				y: -coinPool[coinIndex].height
			});
			Starling.juggler.delayCall(nextCoinFlyout, 0.05, coinPool, coinIndex + 1);
		}
		
		/**
		 * Display a set of three achievements earned this round
		 */
		private function showAchievementSet():void {
			this.resetAchievementPlates();
			if (this.newAchievementsArray[this.achievementSetShown * 3] != null) {
				var data:Array = Constants.AchievementsData[this.newAchievementsArray[this.achievementSetShown * 3]];
				this.achievementPlate1.initialize(data[1], data[2]);
				achievementPlate1.visible = true;
				Starling.juggler.tween(achievementPlate1, 0.2, {
					transition: Transitions.EASE_OUT,
					x: Statics.stageWidth / 2
				});
				Starling.juggler.delayCall(achievementPlateCheck, 0.5, 1);
				// coins flyout effect
				var achievementCoins1:Vector.<MovieClip> = new Vector.<MovieClip>();
				var i:uint;
				var coin:MovieClip;
				for (i = 0; i < 20; i++) {
					coin = new MovieClip(Assets.getSprite("AtlasTexturePlatforms").getTextures("Coin"), 40);
					coin.pivotX = Math.ceil(coin.texture.width  / 2);
					coin.x = Statics.stageWidth / 2;
					coin.y = achievementPlate1.y + achievementPlate1.coin.y;
					starling.core.Starling.juggler.add(coin);
					addChild(coin);
					achievementCoins1.push(coin);
				}
				Starling.juggler.delayCall(nextCoinFlyout, 0.5, achievementCoins1, 0);
				
				if (this.newAchievementsArray[this.achievementSetShown * 3 + 1] != null) {
					data = Constants.AchievementsData[this.newAchievementsArray[this.achievementSetShown * 3 + 1]];
					this.achievementPlate2.initialize(data[1], data[2]);
					achievementPlate2.visible = true;
					Starling.juggler.tween(achievementPlate2, 0.2, {
						transition: Transitions.EASE_OUT,
						x: Statics.stageWidth / 2,
						delay: 0.2
					});
					Starling.juggler.delayCall(achievementPlateCheck, 1, 2);
					// coins flyout effect
					var achievementCoins2:Vector.<MovieClip> = new Vector.<MovieClip>();
					for (i = 0; i < 20; i++) {
						coin = new MovieClip(Assets.getSprite("AtlasTexturePlatforms").getTextures("Coin"), 40);
						coin.pivotX = Math.ceil(coin.texture.width  / 2);
						coin.x = Statics.stageWidth / 2 + achievementPlate1.coin.x;
						coin.y = achievementPlate2.y + achievementPlate1.coin.y;
						starling.core.Starling.juggler.add(coin);
						addChild(coin);
						achievementCoins2.push(coin);
					}
					Starling.juggler.delayCall(nextCoinFlyout, 1, achievementCoins2, 0);
					
					if (this.newAchievementsArray[this.achievementSetShown * 3 + 2] != null) {
						data = Constants.AchievementsData[this.newAchievementsArray[this.achievementSetShown * 3 + 2]];
						this.achievementPlate3.initialize(data[1], data[2]);
						achievementPlate3.visible = true;
						Starling.juggler.tween(achievementPlate3, 0.2, {
							transition: Transitions.EASE_OUT,
							x: Statics.stageWidth / 2,
							delay: 0.4
						});
						Starling.juggler.delayCall(achievementPlateCheck, 1.5, 3);
						// coins flyout effect
						var achievementCoins3:Vector.<MovieClip> = new Vector.<MovieClip>();
						for (i = 0; i < 20; i++) {
							coin = new MovieClip(Assets.getSprite("AtlasTexturePlatforms").getTextures("Coin"), 40);
							coin.pivotX = Math.ceil(coin.texture.width  / 2);
							coin.x = Statics.stageWidth / 2 + achievementPlate1.coin.x;
							coin.y = achievementPlate3.y + achievementPlate1.coin.y;
							starling.core.Starling.juggler.add(coin);
							addChild(coin);
							achievementCoins3.push(coin);
						}
						Starling.juggler.delayCall(nextCoinFlyout, 1, achievementCoins3, 0);
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
				Starling.juggler.tween(achievementPlate1, 0.2, {
					transition: Transitions.EASE_IN,
					x: -Math.ceil(achievementPlate1.width / 2)
				});
				
				if (achievementPlate2.visible) {
					Starling.juggler.tween(achievementPlate2, 0.2, {
						transition: Transitions.EASE_IN,
						x: -Math.ceil(achievementPlate2.width / 2),
						delay: 0.2
					});
					
					if (achievementPlate3.visible) {
						Starling.juggler.tween(achievementPlate3, 0.2, {
							transition: Transitions.EASE_IN,
							x: -Math.ceil(achievementPlate3.width / 2),
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
			
			var nextUnearnedIndex:uint = this.findNextUnearnedAchievement(0);
			var data:Array = Constants.AchievementsData[nextUnearnedIndex];
			this.achievementPlate1.initialize(data[1], data[2]);
			achievementPlate1.visible = true;
			Starling.juggler.tween(achievementPlate1, 0.2, {
				transition: Transitions.EASE_OUT,
				x: Statics.stageWidth / 2
			});
			
			nextUnearnedIndex = this.findNextUnearnedAchievement(nextUnearnedIndex);
			data = Constants.AchievementsData[nextUnearnedIndex];
			this.achievementPlate2.initialize(data[1], data[2]);
			achievementPlate2.visible = true;
			Starling.juggler.tween(achievementPlate2, 0.2, {
				transition: Transitions.EASE_OUT,
				x: Statics.stageWidth / 2,
				delay: 0.2
			});
			
			nextUnearnedIndex = this.findNextUnearnedAchievement(nextUnearnedIndex);
			data = Constants.AchievementsData[nextUnearnedIndex];
			this.achievementPlate3.initialize(data[1], data[2]);
			achievementPlate3.visible = true;
			Starling.juggler.tween(achievementPlate3, 0.2, {
				transition: Transitions.EASE_OUT,
				x: Statics.stageWidth / 2,
				delay: 0.4
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