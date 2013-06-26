package com.jumpGame.ui
{
	import com.jumpGame.customObjects.Font;
	import com.jumpGame.level.Statics;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * This class handles the Heads Up Display for the game
	 */
	public class HUD extends Sprite
	{
		// bonus time display
		private var _bonusTime:int;
		private var bonusTimeLabel:TextField;
		private var bonusTimeText:TextField;
		
		// distance display
		private var _distance:int;
		private var distanceLabel:TextField;
		private var distanceText:TextField;
		
		// coins display
		private var _coins:int;
		private var coinsLabel:TextField;
		private var coinsText:TextField;
		
		// fonts	
		private var fontScoreLabel:Font;		
		private var fontScoreValue:Font;
		
		// on screen message
		private static var messageText:TextField;
		private static var messageExpireTime:int;
		
		public function HUD()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			// get fonts for score labels and values
			fontScoreLabel = Fonts.getFont("ScoreLabel");
			fontScoreValue = Fonts.getFont("ScoreValue");
			
			// bonus time label
			bonusTimeLabel = new TextField(150, 20, "L I V E S", fontScoreLabel.fontName, fontScoreLabel.fontSize, 0xffffff);
			bonusTimeLabel.hAlign = HAlign.RIGHT;
			bonusTimeLabel.vAlign = VAlign.TOP;
			bonusTimeLabel.x = 150;
			bonusTimeLabel.y = 5;
			this.addChild(bonusTimeLabel);
			
			// bonus time
			bonusTimeText = new TextField(150, 75, "5", fontScoreValue.fontName, fontScoreValue.fontSize, 0xffffff);
			bonusTimeText.hAlign = HAlign.RIGHT;
			bonusTimeText.vAlign = VAlign.TOP;
			bonusTimeText.width = bonusTimeLabel.width;
			bonusTimeText.x = int(bonusTimeLabel.x + bonusTimeLabel.width - bonusTimeText.width);
			bonusTimeText.y = bonusTimeLabel.y + bonusTimeLabel.height;
			this.addChild(bonusTimeText);
			
			// distance label
			distanceLabel = new TextField(150, 20, "D I S T A N C E", fontScoreLabel.fontName, fontScoreLabel.fontSize, 0xffffff);
			distanceLabel.hAlign = HAlign.RIGHT;
			distanceLabel.vAlign = VAlign.TOP;
			distanceLabel.x = int(stage.stageWidth - distanceLabel.width - 10);
			distanceLabel.y = 5;
			this.addChild(distanceLabel);
			
			// distance
			distanceText = new TextField(150, 75, "0", fontScoreValue.fontName, fontScoreValue.fontSize, 0xffffff);
			distanceText.hAlign = HAlign.RIGHT;
			distanceText.vAlign = VAlign.TOP;
			distanceText.width = distanceLabel.width;
			
			distanceText.x = int(distanceLabel.x + distanceLabel.width - distanceText.width);
			distanceText.y = distanceLabel.y + distanceLabel.height;
			this.addChild(distanceText);
			
			// coins label
			coinsLabel = new TextField(150, 20, "S C O R E", fontScoreLabel.fontName, fontScoreLabel.fontSize, 0xffffff);
			coinsLabel.hAlign = HAlign.RIGHT;
			coinsLabel.vAlign = VAlign.TOP;
			
			coinsLabel.x = int(distanceLabel.x - coinsLabel.width - 50);
			coinsLabel.y = 5;
			this.addChild(coinsLabel);
			
			// coins
			coinsText = new TextField(150, 75, "0", fontScoreValue.fontName, fontScoreValue.fontSize, 0xffffff);
			coinsText.hAlign = HAlign.RIGHT;
			coinsText.vAlign = VAlign.TOP;
			coinsText.width = coinsLabel.width;
			coinsText.x = int(coinsLabel.x + coinsLabel.width - coinsText.width);
			coinsText.y = coinsLabel.y + coinsLabel.height;
			this.addChild(coinsText);
			
			// on screen message
			var fontMessage:Font = Fonts.getFont("Badabb");
			trace("HUD fontName: " + fontMessage.fontName);
			trace("HUD fontSize: " + fontMessage.fontSize);
			messageText = new TextField(stage.stageWidth, stage.stageHeight * 0.5, "", fontMessage.fontName, fontMessage.fontSize, 0xffffff);
			messageText.vAlign = VAlign.TOP;
			messageText.height = messageText.textBounds.height;
			messageText.y = (stage.stageHeight * 20)/100;
			messageText.visible = false;
			this.addChild(messageText);
		}
		
		public function get bonusTime():int { return _bonusTime; }
		public function set bonusTime(value:int):void
		{
			_bonusTime = value;
			bonusTimeText.text = _bonusTime.toString();
		}
		
		public function get distance():int { return _distance; }
		public function set distance(value:int):void
		{
			_distance = value;
			distanceText.text = _distance.toString();
		}
		
		public function get coins():int { return _coins; }
		public function set coins(value:int):void
		{
			_coins = value;
			coinsText.text = _coins.toString();
		}
		
		/**
		 * Add leading zeros to the score numbers
		 */
		private function addZeros(value:int):String {
			var ret:String = String(value);
			while (ret.length < 7) {
				ret = "0" + ret;
			}
			return ret;
		}
		
		// display an on screen message
		public static function showMessage(message:String, duration:Number = 2000):void {
			messageExpireTime = Statics.gameTime + duration;
			messageText.text = message;
			messageText.visible = true;
		}
		
		// hide on screen message
		public static function updateMessageDisplay():void {
			if (Statics.gameTime > messageExpireTime) messageText.visible = false;
		}
	}
}