package com.jumpGame.ui
{
	import com.jumpGame.customObjects.Font;
	import com.jumpGame.events.NavigationEvent;
	
	import starling.display.Button;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.VAlign;
	
	public class GameOverContainer extends Sprite
	{
		/** Background image. */
		private var bg:Quad;
		
		/** Message text field. */
		private var messageText:TextField;
		
		/** Score container. */
		private var scoreContainer:Sprite;
		
		/** Score display - distance. */
		private var distanceText:TextField;
		
		/** Score display - score. */
		private var scoreText:TextField;
		
		// buttons
		private var continueBtn:Button;
		private var returnBtn:Button;
		private var proceedBtn:Button;
		
		/** Font - score display. */
		private var fontScore:Font;
		
		/** Font - message display. */
		private var fontMessage:Font;
		
		private var communicator:Communicator;
		
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
			// Get fonts for text display.
			fontMessage = Fonts.getFont("Badabb");
			fontScore = Fonts.getFont("ScoreLabel");
			
			// Background quad.
			bg = new Quad(stage.stageWidth, stage.stageHeight, 0x000000);
			bg.alpha = 0.75;
			this.addChild(bg);
			
			trace("fontName: " + fontMessage.fontName);
			trace("fontSize: " + fontMessage.fontSize);
			// Message text field
			messageText = new TextField(stage.stageWidth, stage.stageHeight * 0.5, "GOOD EFFORT!", fontMessage.fontName, fontMessage.fontSize, 0xf3e75f);
			messageText.vAlign = VAlign.TOP;
			messageText.height = 100;
			messageText.y = (stage.stageHeight * 20)/100;
			this.addChild(messageText);
			
			// Score container.
			scoreContainer = new Sprite();
			scoreContainer.y = (stage.stageHeight * 40)/100;
			this.addChild(scoreContainer);
			
			distanceText = new TextField(stage.stageWidth, 100, "DISTANCE TRAVELLED: 0000000", fontScore.fontName, fontScore.fontSize, 0xffffff);
			distanceText.vAlign = VAlign.TOP;
			distanceText.height = distanceText.textBounds.height;
			scoreContainer.addChild(distanceText);
			
			scoreText = new TextField(stage.stageWidth, 100, "SCORE: 0000000", fontScore.fontName, fontScore.fontSize, 0xffffff);
			scoreText.vAlign = VAlign.TOP;
			scoreText.height = scoreText.textBounds.height;
			scoreText.y = distanceText.bounds.bottom + scoreText.height * 0.5;
			scoreContainer.addChild(scoreText);
			
			// Navigation buttons.
			returnBtn = new Button(Assets.getSprite("AtlasTexture2").getTexture("BtnReturn0000"));
			returnBtn.y = (stage.stageHeight * 70)/100;
			returnBtn.addEventListener(Event.TRIGGERED, onReturnClick);
			this.addChild(returnBtn);
			
			continueBtn = new Button(Assets.getSprite("AtlasTexture2").getTexture("BtnContinue0000"));
			continueBtn.y = (stage.stageHeight * 70)/100;
			continueBtn.addEventListener(Event.TRIGGERED, onContinueClick);
			this.addChild(continueBtn);
			
			proceedBtn = new Button(Assets.getSprite("AtlasTexture2").getTexture("BtnProceed0000"));
			proceedBtn.y = (stage.stageHeight * 70)/100;
			proceedBtn.addEventListener(Event.TRIGGERED, onProceedClick);
			this.addChild(proceedBtn);
			
			returnBtn.x = stage.stageWidth * 0.5 - (returnBtn.width + continueBtn.width + proceedBtn.width + 30) * 0.5;
			continueBtn.x = returnBtn.x = stage.stageWidth * 0.5 - (continueBtn.width + proceedBtn.width + 20) * 0.5;
			proceedBtn.x = continueBtn.bounds.right + 10;
			
			returnBtn.visible = false;
			continueBtn.visible = false;
			proceedBtn.visible = false;
		}
		
		private function onContinueClick(event:Event):void
		{
			if (!Sounds.muted) Sounds.sndMushroom.play();
			
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "continue"}, true));
		}
		
		private function onReturnClick(event:Event):void
		{
			if (!Sounds.muted) Sounds.sndMushroom.play();
			
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "menu"}, true));
		}
		
		private function onProceedClick(event:Event):void
		{
			if (!Sounds.muted) Sounds.sndMushroom.play();
			
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "proceed"}, true));
		}
		
		// show scores and post to backend
		public function initialize(score:int, distance:int):void
		{
			distanceText.text = "DISTANCE TRAVELLED: " + distance.toString();
			scoreText.text = "SCORE: " + score.toString();
			
			this.visible = true;
			
			// send new score to backend
			var jsonStr:String = JSON.stringify({
				score: distance
			});
			this.communicator.addEventListener(NavigationEvent.RESPONSE_RECEIVED, dataReceived);
			this.communicator.postUserData(jsonStr);
		}
		
		private function dataReceived(event:NavigationEvent):void {
			trace(event.params.data);
			
			returnBtn.visible = false;
			continueBtn.visible = true;
			proceedBtn.visible = true;
		}
	}
}