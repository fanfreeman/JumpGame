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
//		private var _bonusTime:int;
//		private var bonusTimeLabel:TextField;
//		private var bonusTimeText:TextField;
		
		// distance display
		private static var _distance:int;
		private var distanceLabel:TextField;
		private var distanceText:TextField;
		private var prevDistance:int;
		
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
		private var powerupReelVelocity:Number;
		private var isSpinningUp:Boolean;
		private var totalDistanceScrolled:int;
		private var stopDistanceSet:Boolean;
		private var stopDistance:int;
		private var isReelSpinning:Boolean;
		private var sparkleAnimation:starling.display.MovieClip;
		private var iconTween:Tween;
		private static var powerupIconFrame:Image;
		
		// on screen message
		private static var messageText1:TextField;
		private static var messageText2:TextField;
		private static var messageText3:TextField;
		private static var messageExpireTime1:int;
		private static var messageExpireTime2:int;
		private static var messageExpireTime3:int;
		
		// pulsing message
		private static var pulsingText:TextField;
		
		// special ability indicators
		private static var specialIndicatorsList:Vector.<SpecialIndicator>;
		
		// objective achievement effect
		private static var badgeAnimation:MovieClip;
		private static var badgeExpireTime:int;
		private static var badgeText:TextField;
		
		private static var tweenPulsingText:Tween;
		private static var distancePrevTimePeriod:int;
		private static var prevDistanceCalculationTime:int;
		private static var emaVelocity:Number;
		
		public function initialize():void {
			_distance = 0;
			_coins = 0;
			prevDistance = 0;
			powerupReelVelocity = 0;
			isSpinningUp = true;
			totalDistanceScrolled = 0;
			stopDistanceSet = false;
			isReelSpinning = false;
			distancePrevTimePeriod = 0;
			prevDistanceCalculationTime = 0;
			emaVelocity = 0;
			powerupIcons.visible = false;
			messageText1.visible = false;
			messageText2.visible = false;
			messageText3.visible = false;
			pulsingText.scaleX = 0.5;
			pulsingText.scaleY = 0.5;
			pulsingText.visible = false;
			badgeAnimation.visible = false;
			badgeText.visible = false;
			distanceText.text = "0";
			coinsText.text = "0";
			
			// speical ability indicators
			Statics.numSpecials = 2 + Statics.rankExtraAbility * 1;
			var numExistingIndicators:uint = specialIndicatorsList.length;
			if (Statics.numSpecials > numExistingIndicators) { // if purchased extra ability, add more indicators
				for (var i:uint = 0; i < (Statics.numSpecials - numExistingIndicators); i++) {
					var indicator:SpecialIndicator = new SpecialIndicator();
					this.addChild(indicator);
					specialIndicatorsList.push(indicator);
				}
			}
			arrangeSpecialIndicators();
			for (i = 0; i < Statics.numSpecials; i++) { // initialize all indicators
				specialIndicatorsList[i].initialize();
			}
		}
		
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
			coinsLabel = new TextField(150, 20, "C O I N S", fontScoreLabel.fontName, fontScoreLabel.fontSize, 0xffffff);
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
			iconImage = new Image(Assets.getSprite("AtlasTexture4").getTexture("PowerupIcon10000"));
			iconImage.pivotX = Math.ceil(iconImage.width / 2);
			iconImage.pivotY = Math.ceil(iconImage.height);
			iconImage.y = 0;
			powerupIcons.addChild(iconImage);
			this.powerupIconsImages.push(iconImage);
			// reel image 2
			iconImage = new Image(Assets.getSprite("AtlasTexture4").getTexture("PowerupIcon20000"));
			iconImage.pivotX = Math.ceil(iconImage.width / 2);
			iconImage.pivotY = Math.ceil(iconImage.height);
			iconImage.y = -Constants.PowerupIconHeight * 1;
			powerupIcons.addChild(iconImage);
			this.powerupIconsImages.push(iconImage);
			// reel image 3
			iconImage = new Image(Assets.getSprite("AtlasTexture4").getTexture("PowerupIcon30000"));
			iconImage.pivotX = Math.ceil(iconImage.width / 2);
			iconImage.pivotY = Math.ceil(iconImage.height);
			iconImage.y = -Constants.PowerupIconHeight * 2;
			powerupIcons.addChild(iconImage);
			this.powerupIconsImages.push(iconImage);
			// reel image 4
			iconImage = new Image(Assets.getSprite("AtlasTexture4").getTexture("PowerupIcon40000"));
			iconImage.pivotX = Math.ceil(iconImage.width / 2);
			iconImage.pivotY = Math.ceil(iconImage.height);
			iconImage.y = -Constants.PowerupIconHeight * 3;
			powerupIcons.addChild(iconImage);
			this.powerupIconsImages.push(iconImage);
			// reel image 5
			iconImage = new Image(Assets.getSprite("AtlasTexture4").getTexture("PowerupIcon50000"));
			iconImage.pivotX = Math.ceil(iconImage.width / 2);
			iconImage.pivotY = Math.ceil(iconImage.height);
			iconImage.y = -Constants.PowerupIconHeight * 4;
			powerupIcons.addChild(iconImage);
			this.powerupIconsImages.push(iconImage);
			// reel image 6
			iconImage = new Image(Assets.getSprite("AtlasTexture4").getTexture("PowerupIcon60000"));
			iconImage.pivotX = Math.ceil(iconImage.width / 2);
			iconImage.pivotY = Math.ceil(iconImage.height);
			iconImage.y = -Constants.PowerupIconHeight * 5
			powerupIcons.addChild(iconImage);
			this.powerupIconsImages.push(iconImage);
			// reel image 7
			iconImage = new Image(Assets.getSprite("AtlasTexture4").getTexture("PowerupIcon70000"));
			iconImage.pivotX = Math.ceil(iconImage.width / 2);
			iconImage.pivotY = Math.ceil(iconImage.height);
			iconImage.y = -Constants.PowerupIconHeight * 6;
			powerupIcons.addChild(iconImage);
			this.powerupIconsImages.push(iconImage);
			// reel image 8
			iconImage = new Image(Assets.getSprite("AtlasTexture4").getTexture("PowerupIcon80000"));
			iconImage.pivotX = Math.ceil(iconImage.width / 2);
			iconImage.pivotY = Math.ceil(iconImage.height);
			iconImage.y = -Constants.PowerupIconHeight * 7;
			powerupIcons.addChild(iconImage);
			this.powerupIconsImages.push(iconImage);
			// container sprite
			powerupIcons.x = 200;
			powerupIcons.y = 75;
			powerupIcons.clipRect = new Rectangle(-60, 0, 120, -60);
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
			powerupIconFrame = new Image(Assets.getSprite("AtlasTexture4").getTexture("IconFrame0000"));
			powerupIconFrame.pivotX = Math.ceil(powerupIconFrame.width / 2);
			powerupIconFrame.pivotY = Math.ceil(powerupIconFrame.height / 2);
			powerupIconFrame.x = 200;
			powerupIconFrame.y = 45;
			powerupIconFrame.visible = false;
			this.addChild(powerupIconFrame);
			
			// on screen message line 1
			var fontMessage:Font = Fonts.getFont("Badabb");
			messageText1 = new TextField(stage.stageWidth, 50, "", fontMessage.fontName, fontMessage.fontSize, 0xffffff);
			messageText1.hAlign = HAlign.CENTER;
			messageText1.vAlign = VAlign.TOP;
			messageText1.y = (stage.stageHeight * 20)/100;
			this.addChild(messageText1);
			
			// on screen message line 2
			messageText2 = new TextField(stage.stageWidth, 50, "", fontMessage.fontName, fontMessage.fontSize, 0xffffff);
			messageText2.hAlign = HAlign.CENTER;
			messageText2.vAlign = VAlign.TOP;
			messageText2.y = (stage.stageHeight * 20)/100 + 50;
			this.addChild(messageText2);
			
			// on screen message line 3
			messageText3 = new TextField(stage.stageWidth, 50, "", fontMessage.fontName, fontMessage.fontSize, 0xffffff);
			messageText3.hAlign = HAlign.CENTER;
			messageText3.vAlign = VAlign.TOP;
			messageText3.y = (stage.stageHeight * 20)/100 + 100;
			this.addChild(messageText3);
			
			// on screen message line 1
			pulsingText = new TextField(200, 50, "", fontScoreValue.fontName, fontScoreValue.fontSize, 0xf68e56);
			pulsingText.pivotX = Math.ceil(pulsingText.width / 2);
			pulsingText.pivotY = Math.ceil(pulsingText.height / 2);
			pulsingText.hAlign = HAlign.CENTER;
			pulsingText.vAlign = VAlign.CENTER;
			pulsingText.x = Statics.stageWidth / 2;
			pulsingText.y = (Statics.stageHeight * 30)/100;
			this.addChild(pulsingText);
			// tween
			tweenPulsingText = new Tween(pulsingText, 0.2, Transitions.LINEAR);
			
			Statics.numSpecials = 2;
			specialIndicatorsList = new Vector.<SpecialIndicator>();
			for (var i:uint = 0; i < Statics.numSpecials; i++) {
				var indicator:SpecialIndicator = new SpecialIndicator();
				this.addChild(indicator);
				specialIndicatorsList.push(indicator);
			}
			arrangeSpecialIndicators();
			
			// objective achievement effect
			badgeAnimation = new MovieClip(Assets.getSprite("AtlasTexture4").getTextures("BadgeFlash"), 30);
			badgeAnimation.pivotX = Math.ceil(badgeAnimation.width  / 2); // center art on registration point
			badgeAnimation.pivotY = Math.ceil(badgeAnimation.height / 2);
			badgeAnimation.x = Constants.StageWidth / 2;
			badgeAnimation.y = Constants.StageHeight - 130;
			badgeAnimation.loop = false;
			this.addChild(badgeAnimation);
			
			// objective achievement message
			var fontVerdana14:Font = Fonts.getFont("Verdana14");
			badgeText = new TextField(200, 100, "", fontVerdana14.fontName, fontVerdana14.fontSize, 0xffffff);
			badgeText.hAlign = HAlign.CENTER;
			badgeText.vAlign = VAlign.CENTER;
			badgeText.x = stage.stageWidth / 2 - 100;
			badgeText.y = stage.stageHeight - 130 - 53;
			this.addChild(badgeText);
		}
		
		private static function arrangeSpecialIndicators():void {
			for (var i:uint = 0; i < Statics.numSpecials; i++) {
				specialIndicatorsList[i].x = (Constants.StageWidth - 50 * Statics.numSpecials) / 2 + (50 * Statics.numSpecials / (Statics.numSpecials + 1)) * (i + 1);
				specialIndicatorsList[i].y = Constants.StageHeight - 50;
			}
		}
		
		/**
		 * Turn off speical ability indicators after one is used
		 */
		public static function turnOffSpecials():void {
			Statics.numSpecials--;
			// do not remove indicator to suppress garbage collection
			specialIndicatorsList[Statics.numSpecials].blast();
			arrangeSpecialIndicators();
			
			for (var i:uint = 0; i < Statics.numSpecials; i++) {
				specialIndicatorsList[i].turnOff();
			}
		}
		
		/**
		 * Turn on special ability indicators after cooldown
		 */
		public static function turnOnSpecials():void {
			for (var i:uint = 0; i < Statics.numSpecials; i++) {
				specialIndicatorsList[i].turnOn();
			}
		}
		
//		public function get bonusTime():int { return _bonusTime; }
//		public function set bonusTime(value:int):void
//		{
//			_bonusTime = value;
//			bonusTimeText.text = _bonusTime.toString();
//		}
		
		public function get distance():int { return _distance; }
		public function set distance(value:int):void
		{
			if (value > _distance) {
				_distance = value;
				distanceText.text = _distance.toString();
				
				// update pulsing text
				// scale values
				var scaleVal:Number = 0.3 + emaVelocity * 150;
				
				pulsingText.visible = true;
				pulsingText.text = _distance.toString();
				
				// reset pulsing text
				pulsingText.scaleX = 0.2;
				pulsingText.scaleY = 0.2;
				tweenPulsingText.reset(pulsingText, 0.2, Transitions.EASE_OUT_BACK);
				tweenPulsingText.animate("scaleX", scaleVal);
				tweenPulsingText.animate("scaleY", scaleVal);
				Starling.juggler.add(tweenPulsingText);
			}
		}
		
		public function get coins():int { return _coins; }
		public function set coins(value:int):void
		{
			if (_coins != value) {
				_coins = value;
				coinsText.text = _coins.toString();
			}
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
		
		/**
		 * Display an achievement badge
		 */
		public static function showAchievement(message:String):void {
			Statics.displayingBadge = true;
			starling.core.Starling.juggler.add(badgeAnimation);
			badgeAnimation.alpha = 1;
			badgeAnimation.visible = true;
			badgeAnimation.play();
			if (!Sounds.sfxMuted) Sounds.sndGong.play();
			badgeText.text = message;
			badgeText.alpha = 1;
			badgeText.visible = true;
			badgeExpireTime = Statics.gameTime + 4000; // show for three seconds
		}
		
		/** 
		 * Display an on screen message
		 * 
		 * @param forceLine forces display on a particular line
		 */
		public static function showMessage(message:String, duration:Number = 2000, forceLine:uint = 0):void {
			if (forceLine == 0) {
				// display on line 1
				if (!messageText1.visible) {
					messageExpireTime1 = Statics.gameTime + duration;
					messageText1.text = message;
					messageText1.visible = true;
					return;
				}
					
					// display on line 2
				else if (!messageText2.visible) {
					messageExpireTime2 = Statics.gameTime + duration;
					messageText2.text = message;
					messageText2.visible = true;
					return;
				}
					
					// display on line 3
				else if (!messageText3.visible) {
					messageExpireTime3 = Statics.gameTime + duration;
					messageText3.text = message;
					messageText3.visible = true;
					return;
				}
					
				else {
					messageText2.visible = false;
					messageText3.visible = false;
					messageExpireTime1 = Statics.gameTime + duration;
					messageText1.text = message;
					messageText1.visible = true;
					return;
				}
			}
			else if (forceLine == 1) { // force display on line 1
				messageExpireTime1 = Statics.gameTime + duration;
				messageText1.text = message;
				messageText1.visible = true;
				return;
			}
			else if (forceLine == 2) { // force display on line 2
				messageExpireTime2 = Statics.gameTime + duration;
				messageText2.text = message;
				messageText2.visible = true;
				return;
			}
			else if (forceLine == 3) { // force display on line 3
				messageExpireTime3 = Statics.gameTime + duration;
				messageText3.text = message;
				messageText3.visible = true;
				return;
			}
			else {
				throw new Error("Invalid message display line");
			}
		}
		
		public static function update():void {
			if (Statics.calculateEmaVelocity && Statics.gameTime > prevDistanceCalculationTime + 200) calculateEMA();
			
			// if a message line expires, hide that line
			if (Statics.gameTime > messageExpireTime1) messageText1.visible = false;
			if (Statics.gameTime > messageExpireTime2) messageText2.visible = false;
			if (Statics.gameTime > messageExpireTime3) messageText3.visible = false;
			
			// update achievement badge
			if (Statics.displayingBadge && Statics.gameTime > badgeExpireTime) {
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
				Statics.displayingBadge = false;
			}
			
			// update ability indicator clipping
			if (!Statics.specialReady) {
				var ratio:Number = (Statics.gameTime - Statics.specialUseTime) / (Statics.specialReadyTime - Statics.specialUseTime);
				for (var i:uint = 0; i < Statics.numSpecials; i++) {
					specialIndicatorsList[i].updateClipRectByRatio(ratio);
				}
			}
		}
		
//		public static function updatePulsingText(distance:int):void {
//			pulsingText.visible = true;
//			Starling.juggler.tween(pulsingText, 0.4, {
//				transition: Transitions.LINEAR,
//				scaleX: 1.5,
//				scaleY: 1.5
//			});
//		}
		
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
			if (!Sounds.sfxMuted) Sounds.sndClockTick.play();
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
		
		/**
		 * Calculate the Exponential Moving Average of hero's velocity
		 */
		private static function calculateEMA():void {
			var timePeriods:int = 15;
			
			var distanceThisTimePeriod:int = _distance - distancePrevTimePeriod;
			var timeThisTimePeriod:int = Statics.gameTime - prevDistanceCalculationTime;
			
			var velocityThisTimePeriod:Number = distanceThisTimePeriod / timeThisTimePeriod;
			emaVelocity = (velocityThisTimePeriod - emaVelocity) * (2 / (timePeriods + 1)) + emaVelocity;
			
			distancePrevTimePeriod = _distance;
			prevDistanceCalculationTime = Statics.gameTime;
		}
	}
}