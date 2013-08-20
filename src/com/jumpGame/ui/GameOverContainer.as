package com.jumpGame.ui
{
	import com.jumpGame.customObjects.Font;
	import com.jumpGame.events.NavigationEvent;
	import com.jumpGame.level.Statics;
	
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
		private var messageText:TextField;
		
		// score container
		private var scoreContainer:Sprite;
		
		// distance display
		private var distanceText:TextField;
		
		// coin display
		private var coinText:TextField;
		
		// score display
		private var scoreText:TextField;
		
		// objective boxes
		private var objectiveSprite1:Sprite;
		private var objectiveSprite2:Sprite;
		private var objectiveSprite3:Sprite;
		
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
		
		public function GameOverContainer()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			this.communicator = new Communicator();
		}
		
		/**
		 * On added to stage. 
		 * @param event
		 * 
		 */
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			drawGameOver();
		}
		
		/**
		 * Draw game over screen. 
		 * 
		 */
		private function drawGameOver():void
		{
			// bg quad
			bg = new Quad(stage.stageWidth, stage.stageHeight, 0x000000);
			bg.alpha = 0.75;
			this.addChild(bg);
			
			// big stars
			// center
			starCenter = new Image(Assets.getSprite("AtlasTexture2").getTexture("BigStar0000"));
			starCenter.pivotX = Math.ceil(starCenter.width / 2);
			starCenter.pivotY = Math.ceil(starCenter.height / 2);
			starCenter.x = Constants.StageWidth / 2;
			starCenter.y = 100;
			starCenter.scaleX = 0;
			starCenter.scaleY = 0;
			this.addChild(starCenter);
			// left
			starLeft = new Image(Assets.getSprite("AtlasTexture2").getTexture("BigStar0000"));
			starLeft.pivotX = Math.ceil(starLeft.width / 2);
			starLeft.pivotY = Math.ceil(starLeft.height / 2);
			starLeft.x = Constants.StageWidth / 2 - starLeft.width - 30;
			starLeft.y = 125;
			starLeft.rotation = -15 * Math.PI / 180;
			starLeft.scaleX = 0;
			starLeft.scaleY = 0;
			this.addChild(starLeft);
			// right
			starRight = new Image(Assets.getSprite("AtlasTexture2").getTexture("BigStar0000"));
			starRight.pivotX = Math.ceil(starRight.width / 2);
			starRight.pivotY = Math.ceil(starRight.height / 2);
			starRight.x = Constants.StageWidth / 2 + starRight.width + 30;
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
			messageText = new TextField(stage.stageWidth, 100, "GOOD EFFORT!", fontMessage.fontName, fontMessage.fontSize, 0xf3e75f);
			messageText.vAlign = VAlign.TOP;
			messageText.y = (stage.stageHeight * 30)/100;
			this.addChild(messageText);
			
			// Score container.
			scoreContainer = new Sprite();
			scoreContainer.y = (stage.stageHeight * 40)/100;
			this.addChild(scoreContainer);
			
			distanceText = new TextField(200, 100, "Distance: 0000000", fontScore.fontName, fontScore.fontSize, 0xffffff);
			distanceText.vAlign = VAlign.TOP;
			distanceText.hAlign = HAlign.LEFT;
			distanceText.x = stage.stageWidth / 5;
//			distanceText.border = true;
			scoreContainer.addChild(distanceText);
			
			coinText = new TextField(200, 100, "Coins: 0000000", fontScore.fontName, fontScore.fontSize, 0xffffff);
			coinText.vAlign = VAlign.TOP;
			coinText.hAlign = HAlign.LEFT;
			coinText.x = stage.stageWidth * 3 / 5 + 40;
//			coinText.border = true;
			scoreContainer.addChild(coinText);
			
			scoreText = new TextField(300, 100, "Score: 0000000", fontScore.fontName, fontScore.fontSize, 0xffffff);
			scoreText.vAlign = VAlign.TOP;
			scoreText.hAlign = HAlign.CENTER;
			scoreText.pivotX = scoreText.width / 2;
			scoreText.x = stage.stageWidth / 2;
			scoreText.y = 50;
			//			scoreText.border = true;
			scoreContainer.addChild(scoreText);
			
			// arrow animation
			var arrowAnimation:MovieClip = new MovieClip(Assets.getSprite("AtlasTexture2").getTextures("ArrowBounce"), 20);
			arrowAnimation.pivotX = Math.ceil(arrowAnimation.texture.width  / 2); // center art on registration point
//			arrowAnimation.pivotY = Math.ceil(arrowAnimation.texture.height / 2);
			arrowAnimation.x = stage.stageWidth / 5 - arrowAnimation.texture.width;
			arrowAnimation.y = -10;
			starling.core.Starling.juggler.add(arrowAnimation);
			scoreContainer.addChild(arrowAnimation);
			// coin animation
			var coinAnimation:MovieClip = new MovieClip(Assets.getSprite("AtlasTexturePlatforms").getTextures("Coin"), 40);
			coinAnimation.pivotX = Math.ceil(coinAnimation.texture.width  / 2); // center art on registration point
//			coinAnimation.pivotY = Math.ceil(coinAnimation.texture.height / 2);
			coinAnimation.x = stage.stageWidth * 3 / 5;
			coinAnimation.y = -20;
			starling.core.Starling.juggler.add(coinAnimation);
			scoreContainer.addChild(coinAnimation);
			
			// objectives
			this.createObjectiveBox();
			
			// finish button
			proceedBtn = new Button(Assets.getSprite("AtlasTexture2").getTexture("BtnProceed0000"));
			proceedBtn.pivotX = Math.ceil(proceedBtn.width / 2);
			proceedBtn.x = stage.stageWidth / 2;
			proceedBtn.y = (stage.stageHeight * 71)/100;
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
		
		private function createObjectiveBox():void {
			// objective sprites
			objectiveSprite1 = new Sprite();
			// checkbox
			var checkbox:Image = new Image(Assets.getSprite("AtlasTexture2").getTexture("Checkbox0000"));
			checkbox.pivotX = Math.ceil(checkbox.width / 2);
			checkbox.pivotY = Math.ceil(checkbox.height / 2);
			//			checkbox.x = Constants.StageWidth / 2 + starRight.width + 30;
			//			checkbox.y = 125;
			objectiveSprite1.addChild(checkbox);
			// objective title
			var objectiveText:TextField = new TextField(200, 50, "Bouncy", fontLithos42.fontName, fontLithos42.fontSize, 0xf6ff00);
			objectiveText.vAlign = VAlign.TOP;
			objectiveText.hAlign = HAlign.LEFT;
			objectiveText.x = 55;
			objectiveText.y = -35;
			//			objectiveText.border = true;
			objectiveSprite1.addChild(objectiveText);
			// objective description
			objectiveText = new TextField(400, 50, "Jump 1000 meters in one game", fontVerdana23.fontName, fontVerdana23.fontSize, 0xffdd1e);
			objectiveText.vAlign = VAlign.TOP;
			objectiveText.hAlign = HAlign.LEFT;
			objectiveText.x = 60;
			objectiveText.y = 5;
			//			objectiveText.border = true;
			objectiveSprite1.addChild(objectiveText);
			// checkmark
			var checkmarkAnimation:MovieClip = new MovieClip(Assets.getSprite("AtlasTexture2").getTextures("Checkmark"), 40);
			checkmarkAnimation.pivotX = Math.ceil(checkmarkAnimation.texture.width  / 2); // center art on registration point
			checkmarkAnimation.pivotY = Math.ceil(checkmarkAnimation.texture.height / 2);
			checkmarkAnimation.x = -10;
			checkmarkAnimation.y = -30;
			starling.core.Starling.juggler.add(checkmarkAnimation);
			objectiveSprite1.addChild(checkmarkAnimation);
			//
			objectiveSprite1.x = 200;
			objectiveSprite1.y = (stage.stageHeight * 60)/100;
			this.addChild(objectiveSprite1);
		}
		
//		private function onContinueClick(event:Event):void
//		{
//			if (!Sounds.muted) Sounds.sndMushroom.play();
//			
//			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "continue"}, true));
//		}
//		
//		private function onReturnClick(event:Event):void
//		{
//			if (!Sounds.muted) Sounds.sndMushroom.play();
//			
//			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "menu"}, true));
//		}
		
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
			
			// send new score to backend
			var jsonStr:String = JSON.stringify({
				coins: coinsObtained,
				score: roundScore,
				game_id: Statics.gameId,
				round: Statics.currentRound
			});
			this.communicator.addEventListener(NavigationEvent.RESPONSE_RECEIVED, dataReceived);
			this.communicator.postUserData(jsonStr);
		}
		
		private function dataReceived(event:NavigationEvent):void {
			trace(event.params.data);
			proceedBtn.visible = true;
		}
	}
}