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
		
		/** Play again button. */
		private var playAgainBtn:Button;
		
		/** Main Menu button. */
		private var mainBtn:Button;
		
		/** About button. */
		private var aboutBtn:Button;
		
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
			messageText.height = messageText.textBounds.height;
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
			mainBtn = new Button(Assets.getAtlas().getTexture("gameOver_mainButton"));
			mainBtn.y = (stage.stageHeight * 70)/100;
			mainBtn.addEventListener(Event.TRIGGERED, onMainClick);
			this.addChild(mainBtn);
			
			playAgainBtn = new Button(Assets.getAtlas().getTexture("gameOver_playAgainButton"));
			playAgainBtn.y = mainBtn.y + mainBtn.height * 0.5 - playAgainBtn.height * 0.5;
			playAgainBtn.addEventListener(Event.TRIGGERED, onPlayAgainClick);
			this.addChild(playAgainBtn);
			
			aboutBtn = new Button(Assets.getAtlas().getTexture("gameOver_aboutButton"));
			aboutBtn.y = playAgainBtn.y + playAgainBtn.height * 0.5 - aboutBtn.height * 0.5;
			//aboutBtn.addEventListener(Event.TRIGGERED, onAboutClick);
			this.addChild(aboutBtn);
			
			mainBtn.x = stage.stageWidth * 0.5 - (mainBtn.width + playAgainBtn.width + aboutBtn.width + 30) * 0.5;
			playAgainBtn.x = mainBtn.bounds.right + 10;
			aboutBtn.x = playAgainBtn.bounds.right + 10;
			
			mainBtn.visible = false;
			playAgainBtn.visible = false;
			aboutBtn.visible = false;
		}
		
		/**
		 * On play-again button click. 
		 * @param event
		 * 
		 */
		private function onPlayAgainClick(event:Event):void
		{
			if (!Sounds.muted) Sounds.sndMushroom.play();
			
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "play"}, true));
		}
		
		/**
		 * On main menu button click. 
		 * @param event
		 * 
		 */
		private function onMainClick(event:Event):void
		{
			if (!Sounds.muted) Sounds.sndMushroom.play();
			
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "menu"}, true));
		}
		
		/**
		 * On about button click. 
		 * @param event
		 * 
		 */
		private function onAboutClick(event:Event):void
		{
			if (!Sounds.muted) Sounds.sndMushroom.play();
			
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "about"}, true));
		}
		
		/**
		 * show game over container and send back score 
		 * @param _score
		 * @param _distance
		 * 
		 */
		public function initialize(score:int, distance:int):void
		{
			distanceText.text = "DISTANCE TRAVELLED: " + distance.toString();
			scoreText.text = "SCORE: " + score.toString();
			
			this.visible = true;
			
			// send new score to backend
			var jsonStr:String = JSON.stringify({
				score: score
			});
			this.communicator.addEventListener(NavigationEvent.RESPONSE_RECEIVED, dataReceived);
			this.communicator.postUserData(jsonStr);
		}
		
		private function dataReceived(event:NavigationEvent):void {
			trace(event.params.data);
			
			mainBtn.visible = true;
			playAgainBtn.visible = true;
			aboutBtn.visible = true;
		}
	}
}