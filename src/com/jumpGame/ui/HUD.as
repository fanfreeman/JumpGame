package com.jumpGame.ui
{
	import com.jumpGame.customObjects.Font;
	import com.jumpGame.level.Statics;
	
	import flash.geom.Rectangle;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
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
		
		// powerup reel
		private var powerupIconsImages:Vector.<Image>;
		private static var powerupIcons:Sprite;
		private var powerupReelVelocity:Number = 0;
		private var isSpinningUp:Boolean = true;
		private var totalDistanceScrolled:int = 0;
		private var stopDistanceSet:Boolean = false;
		private var stopDistance:int;
		private var isReelSpinning:Boolean = false;
		private var sparkleAnimation:starling.display.MovieClip;
		private var iconTween:Tween;
		private static var powerupIconFrame:Image;
		
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
			bonusTimeLabel.x = 250;
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
			
			// powerup reel
			powerupIcons = new Sprite();
			this.powerupIconsImages = new Vector.<Image>();
			var iconImage:Image;
			// reel image 1
			iconImage = new Image(Assets.getSprite("AtlasTexturePlatforms").getTexture("PowerupIcon10000"));
			iconImage.pivotX = Math.ceil(iconImage.width / 2);
			iconImage.pivotY = Math.ceil(iconImage.height);
			iconImage.y = 0;
			powerupIcons.addChild(iconImage);
			this.powerupIconsImages.push(iconImage);
			// reel image 2
			iconImage = new Image(Assets.getSprite("AtlasTexturePlatforms").getTexture("PowerupIcon20000"));
			iconImage.pivotX = Math.ceil(iconImage.width / 2);
			iconImage.pivotY = Math.ceil(iconImage.height);
			iconImage.y = -Constants.PowerupIconHeight * 1;
			powerupIcons.addChild(iconImage);
			this.powerupIconsImages.push(iconImage);
			// reel image 3
			iconImage = new Image(Assets.getSprite("AtlasTexturePlatforms").getTexture("PowerupIcon30000"));
			iconImage.pivotX = Math.ceil(iconImage.width / 2);
			iconImage.pivotY = Math.ceil(iconImage.height);
			iconImage.y = -Constants.PowerupIconHeight * 2;
			powerupIcons.addChild(iconImage);
			this.powerupIconsImages.push(iconImage);
			// reel image 4
			iconImage = new Image(Assets.getSprite("AtlasTexturePlatforms").getTexture("PowerupIcon40000"));
			iconImage.pivotX = Math.ceil(iconImage.width / 2);
			iconImage.pivotY = Math.ceil(iconImage.height);
			iconImage.y = -Constants.PowerupIconHeight * 3;
			powerupIcons.addChild(iconImage);
			this.powerupIconsImages.push(iconImage);
			// reel image 5
			iconImage = new Image(Assets.getSprite("AtlasTexturePlatforms").getTexture("PowerupIcon50000"));
			iconImage.pivotX = Math.ceil(iconImage.width / 2);
			iconImage.pivotY = Math.ceil(iconImage.height);
			iconImage.y = -Constants.PowerupIconHeight * 4;
			powerupIcons.addChild(iconImage);
			this.powerupIconsImages.push(iconImage);
			// reel image 6
			iconImage = new Image(Assets.getSprite("AtlasTexturePlatforms").getTexture("PowerupIcon60000"));
			iconImage.pivotX = Math.ceil(iconImage.width / 2);
			iconImage.pivotY = Math.ceil(iconImage.height);
			iconImage.y = -Constants.PowerupIconHeight * 5
			powerupIcons.addChild(iconImage);
			this.powerupIconsImages.push(iconImage);
			// container sprite
			powerupIcons.x = 200;
			powerupIcons.y = 75;
			powerupIcons.clipRect = new Rectangle(-60, 0, 120, -60);
			powerupIcons.visible = false;
			this.addChild(powerupIcons);
			// sparkle animation
			sparkleAnimation = new MovieClip(Assets.getSprite("AtlasTexturePlatforms").getTextures("Sparkle"), 30);
			sparkleAnimation.pivotX = Math.ceil(sparkleAnimation.width  / 2); // center art on registration point
			sparkleAnimation.pivotY = Math.ceil(sparkleAnimation.height / 2);
			sparkleAnimation.scaleX = 2;
			sparkleAnimation.scaleY = 2;
			sparkleAnimation.x = 200;
			sparkleAnimation.y = 35;
			starling.core.Starling.juggler.add(sparkleAnimation);
			sparkleAnimation.loop = false;
			this.addChild(sparkleAnimation);
			// icon frame
			powerupIconFrame = new Image(Assets.getSprite("AtlasTexturePlatforms").getTexture("IconFrame0000"));
			powerupIconFrame.pivotX = Math.ceil(powerupIconFrame.width / 2);
			powerupIconFrame.pivotY = Math.ceil(powerupIconFrame.height / 2);
			powerupIconFrame.x = 200;
			powerupIconFrame.y = 45;
			powerupIconFrame.visible = false;
			this.addChild(powerupIconFrame);
			
			// on screen message
			var fontMessage:Font = Fonts.getFont("Badabb");
			trace("HUD fontName: " + fontMessage.fontName);
			trace("HUD fontSize: " + fontMessage.fontSize);
			messageText = new TextField(stage.stageWidth, stage.stageHeight * 0.5, "", fontMessage.fontName, fontMessage.fontSize, 0xffffff);
			messageText.hAlign = HAlign.CENTER;
			messageText.vAlign = VAlign.TOP;
			messageText.height = 100;
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
		
		public static function updateMessage():void {
			// if message expires, hide on screen message
			if (Statics.gameTime > messageExpireTime) messageText.visible = false;
		}
		
		public function spinPowerupReel():void {
			powerupIconFrame.visible = true;
			powerupIconFrame.alpha = 1;
			powerupIcons.visible = true;
			powerupIcons.alpha = 1;
			this.isReelSpinning = true;
		}
		
		public static function clearPowerupReel():void {
			powerupIcons.visible = false;
		}
		
		/**
		 * Spin reel and select a random powerup
		 * @return the powerup to activate
		 */
		public function updatePowerupReel(timeDiff:Number):int {
			if (!this.isReelSpinning) return -1;
			
			var numImages:uint = this.powerupIconsImages.length;
			var reelHeight:Number = Constants.PowerupIconHeight * (numImages - 1);
			var i:uint = 0;
			for (i = 0; i < numImages; i++) { // loop through powerup icons
				this.powerupIconsImages[i].y += int(powerupReelVelocity * timeDiff);
				if (this.powerupIconsImages[i].y >= this.powerupIconsImages[i].height) { // move icon back to top
					var distanceOverEdge:Number = this.powerupIconsImages[i].y - this.powerupIconsImages[i].height;
					this.powerupIconsImages[i].y = -(reelHeight - distanceOverEdge);
				}
			}
			this.totalDistanceScrolled += int(powerupReelVelocity * timeDiff);
			
			if (isSpinningUp) {
				if (powerupReelVelocity < 1.5 + (Math.random() * 0.2 - 0.1)) powerupReelVelocity += 0.001 * timeDiff;
				else isSpinningUp = false;
			} else { // spinning down
				if (powerupReelVelocity > 0.1) powerupReelVelocity -= 0.001 * timeDiff;
				else {
					if(!this.stopDistanceSet) {
						this.stopDistance = this.totalDistanceScrolled + Constants.PowerupIconHeight - (this.totalDistanceScrolled % Constants.PowerupIconHeight);
						this.stopDistanceSet = true;
					}
					if (this.totalDistanceScrolled < this.stopDistance) powerupReelVelocity = 0.1;
					else { // stop reel and activate powerup
						powerupReelVelocity = 0;
						var smallestY:Number = 100;
						var smallestI:uint = 999;
						for (i = 0; i < numImages; i++) { // loop through powerup icons
							if (Math.abs(this.powerupIconsImages[i].y) < smallestY) {
								smallestY = Math.abs(this.powerupIconsImages[i].y);
								smallestI = i;
							}
						}
						// activate powerup
						trace("activating powerup number: " + smallestI);
						this.sparkleAnimation.stop();
						this.sparkleAnimation.play();
						
						// icon tween
						Starling.juggler.tween(this.powerupIconsImages[smallestI], 0.2, {
							transition: Transitions.EASE_IN_BACK,
							repeatCount: 2,
							reverse: true,
							scaleX: 2.0
						});
						
						// icon frame
						Starling.juggler.tween(powerupIconFrame, 0.2, {
							transition: Transitions.EASE_IN_BACK,
							repeatCount: 2,
							reverse: true,
							scaleX: 2.0
						});
						
						// reset
						this.resetPowerupReel();
						
						return smallestI; // the powerup index to activate
					}
				}
			}
			
			return -1;
		}
		
		private function resetPowerupReel():void {
			this.powerupReelVelocity = 0;
			this.isSpinningUp = true;
			this.totalDistanceScrolled = 0;
			this.stopDistanceSet = false;
			this.isReelSpinning = false;
		}
		
		public static function completionWarning():void {
			powerupIconFrame.alpha = 0;
			powerupIcons.alpha = 0;
			Starling.juggler.tween(powerupIconFrame, 0.5, {
				transition: Transitions.LINEAR,
				repeatCount: 6,
				reverse: true,
				alpha: 1.0
			});
			Starling.juggler.tween(powerupIcons, 0.5, {
				transition: Transitions.LINEAR,
				repeatCount: 6,
				reverse: true,
				alpha: 1.0
			});
		}
	}
}