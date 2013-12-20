package com.jumpGame.ui
{
	import com.jumpGame.customObjects.Font;
	import com.jumpGame.ui.components.Badge;
	
	import flash.geom.Rectangle;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.Color;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * This class handles the Heads Up Display for the game
	 */
	public class HUD extends Sprite
	{
		// distance display
		private var _distance:int;
//		private var distanceLabel:TextField;
//		private var distanceText:TextField;
//		private var prevDistance:int;
		
		// coins display
		private var _coins:int;
		private var coinsLabel:TextField;
		private var coinsText:TextField;
		
		// fonts	
		private var fontScoreLabel:Font;		
		private var fontScoreValue:Font;
		
		// powerup reel
		private var powerupIconsImages:Vector.<Image>;
		private var powerupIcons:Sprite;
		private var powerupReelVelocity:Number;
		private var isSpinningUp:Boolean;
		private var totalDistanceScrolled:int;
		private var stopDistanceSet:Boolean;
		private var stopDistance:int;
		private var isReelSpinning:Boolean;
		private var iconTween:Tween;
		private var powerupIconFrame:Image;
		
		// on screen message
		private var messageText1:TextField;
		private var messageText2:TextField;
		private var messageText3:TextField;
		private var messageExpireTime1:int;
		private var messageExpireTime2:int;
		private var messageExpireTime3:int;
		
		// pulsing message
		private var pulsingText:TextField;
		private var pulsingTextFire:TextField;
		private var pulsingTextActive:TextField;
		
		// special ability indicators
		private var specialIndicatorsList:Vector.<SpecialIndicator>;
		
		// objective achievement effect
		private var badge:Badge;
		
		private var tweenPulsingText:Tween;
		private var distancePrevTimePeriod:int;
		private var prevDistanceCalculationTime:int;
		private var emaVelocity:Number;
		
		private var charmActivationBg:MovieClip;
		private var charmActivationCaption:Image;
		private var charmActivationTeleportation:Texture;
		private var charmActivationAttraction:Texture;
		private var charmActivationProtection:Texture;
		private var charmActivationDuplication:Texture;
		private var charmActivationBarrels:Texture;
		
		public function initialize():void {
			_distance = 0;
			_coins = 0;
//			prevDistance = 0;
			powerupReelVelocity = 0;
			isSpinningUp = true;
			totalDistanceScrolled = 0;
			stopDistanceSet = false;
			isReelSpinning = false;
			distancePrevTimePeriod = 0;
			prevDistanceCalculationTime = 0;
			emaVelocity = 0;
			powerupIconFrame.visible = false;
			powerupIcons.visible = false;
			messageText1.visible = false;
			messageText2.visible = false;
			messageText3.visible = false;
			pulsingText.scaleX = 0.2;
			pulsingText.scaleY = 0.2;
			pulsingText.visible = false;
			pulsingTextFire.scaleX = 0.2;
			pulsingTextFire.scaleY = 0.2;
			pulsingTextFire.visible = false;
//			distanceText.text = "0";
			coinsText.text = "0";
			charmActivationBg.visible = false;
			charmActivationCaption.visible = false;
			powerupToActivate = -1;
			
			// speical ability indicators
			Statics.numSpecials = 3 + Statics.rankExtraAbility * 1;
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
			
			this.touchable = false;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			// get fonts for score labels and values
			fontScoreLabel = Fonts.getFont("ScoreLabel");
			fontScoreValue = Fonts.getFont("ScoreValue");
			
//			// distance label
//			distanceLabel = new TextField(150, 20, "D I S T A N C E", fontScoreLabel.fontName, fontScoreLabel.fontSize, 0xffffff);
//			distanceLabel.hAlign = HAlign.RIGHT;
//			distanceLabel.vAlign = VAlign.TOP;
//			distanceLabel.x = int(stage.stageWidth - distanceLabel.width - 10);
//			distanceLabel.y = 5;
//			this.addChild(distanceLabel);
//			
//			// distance
//			distanceText = new TextField(150, 75, "0", fontScoreValue.fontName, fontScoreValue.fontSize, 0xffffff);
//			distanceText.hAlign = HAlign.RIGHT;
//			distanceText.vAlign = VAlign.TOP;
//			distanceText.width = distanceLabel.width;
//			distanceText.x = int(distanceLabel.x + distanceLabel.width - distanceText.width);
//			distanceText.y = distanceLabel.y + distanceLabel.height;
//			this.addChild(distanceText);
			
			// coins label
			coinsLabel = new TextField(100, 20, "S C O R E", fontScoreLabel.fontName, fontScoreLabel.fontSize, 0xffffff);
			coinsLabel.hAlign = HAlign.RIGHT;
			coinsLabel.vAlign = VAlign.TOP;
			coinsLabel.x = int(Statics.stageWidth - coinsLabel.width - 20);
			coinsLabel.y = 15;
			this.addChild(coinsLabel);
			
			// coins
			coinsText = new TextField(150, 75, "0", fontScoreValue.fontName, fontScoreValue.fontSize, 0xffffff);
			coinsText.hAlign = HAlign.RIGHT;
			coinsText.vAlign = VAlign.TOP;
			coinsText.width = coinsLabel.width;
			coinsText.x = int(coinsLabel.x + coinsLabel.width - coinsText.width);
			coinsText.y = coinsLabel.y + coinsLabel.height;
			this.addChild(coinsText);
			
			// bof charm activation transition
			// charm activation animation
			charmActivationBg = new MovieClip(Assets.getSprite("AtlasTexture7").getTextures("CharmActivationBg"), 20);
			charmActivationBg.pivotX = Math.ceil(charmActivationBg.width  / 2); // center art on registration point
			charmActivationBg.pivotY = Math.ceil(charmActivationBg.height / 2);
			charmActivationBg.scaleX = 2;
			charmActivationBg.scaleY = 2;
			charmActivationBg.x = Statics.stageWidth / 2;
			charmActivationBg.y = Statics.stageHeight * 2 / 5;
			charmActivationBg.loop = false;
			this.addChild(charmActivationBg);
			
			// charm activation captions
			charmActivationTeleportation = Assets.getSprite("AtlasTexture7").getTexture("CharmActivationTeleportation0000");
			charmActivationAttraction = Assets.getSprite("AtlasTexture7").getTexture("CharmActivationAttraction0000");
			charmActivationProtection = Assets.getSprite("AtlasTexture7").getTexture("CharmActivationProtection0000");
			charmActivationDuplication = Assets.getSprite("AtlasTexture7").getTexture("CharmActivationDuplication0000");
			charmActivationBarrels = Assets.getSprite("AtlasTexture7").getTexture("CharmActivationBarrels0000");
			
			charmActivationCaption = new Image(charmActivationTeleportation);
			charmActivationCaption.x = charmActivationBg.x;
			charmActivationCaption.y = charmActivationBg.y;
			charmActivationCaption.visible = false;
			this.addChild(charmActivationCaption);
			// eof charm activation transition
			
			// icon frame
			powerupIconFrame = new Image(Assets.getSprite("AtlasTexture7").getTexture("SlotsFrame0000"));
			powerupIconFrame.pivotX = Math.ceil(powerupIconFrame.width / 2);
			powerupIconFrame.pivotY = Math.ceil(powerupIconFrame.height / 2);
			powerupIconFrame.x = 150;
			powerupIconFrame.y = 45;
			this.addChild(powerupIconFrame);
			
			// powerup reel
			powerupIcons = new Sprite();
			this.powerupIconsImages = new Vector.<Image>();
			var iconImage:Image;
			// reel image 1
			iconImage = new Image(Assets.getSprite("AtlasTexture7").getTexture("PowerupIcon10000"));
			iconImage.pivotX = Math.ceil(iconImage.width / 2);
			iconImage.pivotY = Math.ceil(iconImage.height);
			iconImage.y = 0;
			powerupIcons.addChild(iconImage);
			this.powerupIconsImages.push(iconImage);
			// reel image 2
			iconImage = new Image(Assets.getSprite("AtlasTexture7").getTexture("PowerupIcon20000"));
			iconImage.pivotX = Math.ceil(iconImage.width / 2);
			iconImage.pivotY = Math.ceil(iconImage.height);
			iconImage.y = -Constants.PowerupIconHeight * 1;
			powerupIcons.addChild(iconImage);
			this.powerupIconsImages.push(iconImage);
			// reel image 3
			iconImage = new Image(Assets.getSprite("AtlasTexture7").getTexture("PowerupIcon30000"));
			iconImage.pivotX = Math.ceil(iconImage.width / 2);
			iconImage.pivotY = Math.ceil(iconImage.height);
			iconImage.y = -Constants.PowerupIconHeight * 2;
			powerupIcons.addChild(iconImage);
			this.powerupIconsImages.push(iconImage);
			// reel image 4
			iconImage = new Image(Assets.getSprite("AtlasTexture7").getTexture("PowerupIcon40000"));
			iconImage.pivotX = Math.ceil(iconImage.width / 2);
			iconImage.pivotY = Math.ceil(iconImage.height);
			iconImage.y = -Constants.PowerupIconHeight * 3;
			powerupIcons.addChild(iconImage);
			this.powerupIconsImages.push(iconImage);
			// reel image 5
			iconImage = new Image(Assets.getSprite("AtlasTexture7").getTexture("PowerupIcon50000"));
			iconImage.pivotX = Math.ceil(iconImage.width / 2);
			iconImage.pivotY = Math.ceil(iconImage.height);
			iconImage.y = -Constants.PowerupIconHeight * 4;
			powerupIcons.addChild(iconImage);
			this.powerupIconsImages.push(iconImage);
			// reel image 6
			iconImage = new Image(Assets.getSprite("AtlasTexture7").getTexture("PowerupIcon60000"));
			iconImage.pivotX = Math.ceil(iconImage.width / 2);
			iconImage.pivotY = Math.ceil(iconImage.height);
			iconImage.y = -Constants.PowerupIconHeight * 5
			powerupIcons.addChild(iconImage);
			this.powerupIconsImages.push(iconImage);
			// reel image 7
			iconImage = new Image(Assets.getSprite("AtlasTexture7").getTexture("PowerupIcon70000"));
			iconImage.pivotX = Math.ceil(iconImage.width / 2);
			iconImage.pivotY = Math.ceil(iconImage.height);
			iconImage.y = -Constants.PowerupIconHeight * 6;
			powerupIcons.addChild(iconImage);
			this.powerupIconsImages.push(iconImage);
			// reel image 8
			iconImage = new Image(Assets.getSprite("AtlasTexture7").getTexture("PowerupIcon80000"));
			iconImage.pivotX = Math.ceil(iconImage.width / 2);
			iconImage.pivotY = Math.ceil(iconImage.height);
			iconImage.y = -Constants.PowerupIconHeight * 7;
			powerupIcons.addChild(iconImage);
			this.powerupIconsImages.push(iconImage);
			// reel image 9
			iconImage = new Image(Assets.getSprite("AtlasTexture7").getTexture("PowerupIcon90000"));
			iconImage.pivotX = Math.ceil(iconImage.width / 2);
			iconImage.pivotY = Math.ceil(iconImage.height);
			iconImage.y = -Constants.PowerupIconHeight * 8;
			powerupIcons.addChild(iconImage);
			this.powerupIconsImages.push(iconImage);
			// container sprite
//			powerupIcons.x = 200;
//			powerupIcons.y = 75;
			powerupIcons.x = powerupIconFrame.x - 14;
			powerupIcons.y = powerupIconFrame.y + 37;
			powerupIcons.clipRect = new Rectangle(-60, 0, 120, -60);
			this.addChild(powerupIcons);
			
			// on screen message line 1
			var fontMessage:Font = Fonts.getFont("Badaboom50");
			messageText1 = new TextField(stage.stageWidth, 50, "", fontMessage.fontName, fontMessage.fontSize, 0xffffff);
			messageText1.hAlign = HAlign.CENTER;
			messageText1.vAlign = VAlign.TOP;
			messageText1.y = (stage.stageHeight * 30)/100;
			this.addChild(messageText1);
			
			// on screen message line 2
			messageText2 = new TextField(stage.stageWidth, 50, "", fontMessage.fontName, fontMessage.fontSize, 0xffffff);
			messageText2.hAlign = HAlign.CENTER;
			messageText2.vAlign = VAlign.TOP;
			messageText2.y = (stage.stageHeight * 30)/100 + 50;
			this.addChild(messageText2);
			
			// on screen message line 3
			messageText3 = new TextField(stage.stageWidth, 50, "", fontMessage.fontName, fontMessage.fontSize, 0xffffff);
			messageText3.hAlign = HAlign.CENTER;
			messageText3.vAlign = VAlign.TOP;
			messageText3.y = (stage.stageHeight * 30)/100 + 100;
			this.addChild(messageText3);
			
			// pulsing distance text
			// normal text
			var fontPulsing72:Font = Fonts.getFont("Pulsing72");
			pulsingText = new TextField(300, 80, "", fontPulsing72.fontName, fontPulsing72.fontSize, Color.WHITE);
			pulsingText.pivotX = Math.ceil(pulsingText.width / 2);
			pulsingText.pivotY = Math.ceil(pulsingText.height / 2);
			pulsingText.hAlign = HAlign.CENTER;
			pulsingText.vAlign = VAlign.CENTER;
			pulsingText.x = Statics.stageWidth / 2;
			pulsingText.y = (Statics.stageHeight * 24)/100;
			this.addChild(pulsingText);
			// on fire text
			var fontPulsing72Fire:Font = Fonts.getFont("Pulsing72Fire");
			pulsingTextFire = new TextField(300, 80, "", fontPulsing72Fire.fontName, fontPulsing72Fire.fontSize, Color.WHITE);
			pulsingTextFire.pivotX = Math.ceil(pulsingTextFire.width / 2);
			pulsingTextFire.pivotY = Math.ceil(pulsingTextFire.height / 2);
			pulsingTextFire.hAlign = HAlign.CENTER;
			pulsingTextFire.vAlign = VAlign.CENTER;
			pulsingTextFire.x = pulsingText.x;
			pulsingTextFire.y = pulsingText.y;
			this.addChild(pulsingTextFire);
			// pulsing text tween
			pulsingTextActive = pulsingText;
			tweenPulsingText = new Tween(pulsingTextActive, 0.2, Transitions.LINEAR);
			
			// special ability indicators
			Statics.numSpecials = 2;
			specialIndicatorsList = new Vector.<SpecialIndicator>();
			for (var i:uint = 0; i < Statics.numSpecials; i++) {
				var indicator:SpecialIndicator = new SpecialIndicator();
				this.addChild(indicator);
				specialIndicatorsList.push(indicator);
			}
			arrangeSpecialIndicators();
			
			// objective achievement effect
			this.badge = new Badge();
			this.addChild(this.badge);
		}
		
		private function arrangeSpecialIndicators():void {
			for (var i:uint = 0; i < Statics.numSpecials; i++) {
				specialIndicatorsList[i].x = (Constants.StageWidth - 50 * Statics.numSpecials) / 2 + (50 * Statics.numSpecials / (Statics.numSpecials + 1)) * (i + 1);
				specialIndicatorsList[i].y = Constants.StageHeight - 50;
			}
		}
		
		/**
		 * Turn off speical ability indicators after one is used
		 */
		public function turnOffSpecials():void {
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
		public function turnOnSpecials():void {
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
//				distanceText.text = _distance.toString();
				
				// update pulsing text
				// scale values
				var scaleVal:Number = 0.1 + emaVelocity * 75;
//				trace("scaleVal: " + scaleVal);
				if (scaleVal > 1.04) { // switch to pulsing text on fire
					pulsingTextActive = pulsingTextFire;
					pulsingText.visible = false;
					pulsingTextFire.visible = true;
					
				} else if (scaleVal < 1) { // switch to pulsing text normal
					pulsingTextActive = pulsingText;
					pulsingTextFire.visible = false;
					pulsingText.visible = true;
				}
				if (pulsingText.visible) pulsingText.text = _distance.toString().concat("m");
				else pulsingTextFire.text = _distance.toString().concat("m");
				
				// rerun pulsing text tween
				pulsingTextActive.scaleX = 0.2;
				pulsingTextActive.scaleY = 0.2;
				tweenPulsingText.reset(pulsingTextActive, 0.2, Transitions.EASE_OUT_BACK);
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
		public function showAchievement(message:String):void {
			this.badge.showAchievement(message);
		}
		
		/** 
		 * Display an on screen message
		 * 
		 * @param forceLine forces display on a particular line
		 */
		public function showMessage(message:String, duration:Number = 2000, forceLine:uint = 0):void {
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
		
		public function update():void {
			var gameTime:int = Statics.gameTime;
			if (Statics.calculateEmaVelocity && gameTime > prevDistanceCalculationTime + 200) calculateEMA();
			
			// if a message line expires, hide that line
			if (gameTime > messageExpireTime1) messageText1.visible = false;
			if (gameTime > messageExpireTime2) messageText2.visible = false;
			if (gameTime > messageExpireTime3) messageText3.visible = false;
			
			// update ability indicator clipping
			if (!Statics.specialReady) {
				var ratio:Number = (gameTime - Statics.specialUseTime) / (Statics.specialReadyTime - Statics.specialUseTime);
				for (var i:uint = 0; i < Statics.numSpecials; i++) {
					specialIndicatorsList[i].updateClipRectByRatio(ratio);
				}
			}
		}
		
//		public function updatePulsingText(distance:int):void {
//			pulsingText.visible = true;
//			Starling.juggler.tween(pulsingText, 0.4, {
//				transition: Transitions.LINEAR,
//				scaleX: 1.5,
//				scaleY: 1.5
//			});
//		}
		
		private var powerupToActivate:int;
		public function activateRandomPowerup():void {
//			if (Math.random() < 0.15) { // activate comet
//				this.powerupToActivate = 8;
//				return;
//			}
			
			this.powerupToActivate = Math.floor(Math.random() * this.powerupIconsImages.length)
				
			powerupIconFrame.visible = true;
			powerupIconFrame.alpha = 1;
			powerupIcons.visible = true;
			powerupIcons.alpha = 1;
			
			// reposition powerup icons
			var numImages:uint = this.powerupIconsImages.length;
			for (var i:uint = 0; i < numImages; i++) { // loop through powerup icons
				this.powerupIconsImages[i].y = (i - this.powerupToActivate) * this.powerupIconsImages[i].height;
			}
			
			// icon tween
			Starling.juggler.tween(this.powerupIconsImages[this.powerupToActivate], 0.2, {
				transition: Transitions.EASE_IN_BACK,
				repeatCount: 2,
				reverse: true,
				scaleX: 3.0
			});
			
			// icon frame tween
			Starling.juggler.tween(powerupIconFrame, 0.2, {
				transition: Transitions.EASE_IN_BACK,
				repeatCount: 2,
				reverse: true,
				scaleX: 3.0
			});
		}
		
		public function getPowerupToActivate():int {
			var returnVal:int = this.powerupToActivate;
			this.powerupToActivate = -1;
			return returnVal;
		}
		
//		public function spinPowerupReel():void {
//			if (!isReelSpinning) {
//				powerupIconFrame.visible = true;
//				powerupIconFrame.alpha = 1;
//				powerupIcons.visible = true;
//				powerupIcons.alpha = 1;
//				isReelSpinning = true;
//				
//				if (!Sounds.sfxMuted) Sounds.sndSlots.play();
//			}
//		}
		
		public function clearPowerupReel():void {
			powerupIconFrame.visible = false;
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
//						trace("activating powerup number: " + smallestI);
						
						// icon tween
						Starling.juggler.tween(this.powerupIconsImages[smallestI], 0.2, {
							transition: Transitions.EASE_IN_BACK,
							repeatCount: 2,
							reverse: true,
							scaleX: 3.0
						});
						
						// icon frame tween
						Starling.juggler.tween(powerupIconFrame, 0.2, {
							transition: Transitions.EASE_IN_BACK,
							repeatCount: 2,
							reverse: true,
							scaleX: 3.0
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
		
		public function completionWarning():void {
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
		private function calculateEMA():void {
			var timePeriods:int = 15;
			
			var distanceThisTimePeriod:int = _distance - distancePrevTimePeriod;
			var timeThisTimePeriod:int = Statics.gameTime - prevDistanceCalculationTime;
			
			var velocityThisTimePeriod:Number = distanceThisTimePeriod / timeThisTimePeriod;
			emaVelocity = (velocityThisTimePeriod - emaVelocity) * (2 / (timePeriods + 1)) + emaVelocity;
			
			distancePrevTimePeriod = _distance;
			prevDistanceCalculationTime = Statics.gameTime;
		}
		
		public function showCharmActivation(powerup:uint):void {
			switch (powerup) {
				case Constants.PowerupBlink:
					charmActivationCaption.texture = charmActivationTeleportation;
					break;
				case Constants.PowerupAttractor:
					charmActivationCaption.texture = charmActivationAttraction;
					break;
				case Constants.PowerupLevitation:
					charmActivationCaption.texture = charmActivationProtection;
					break;
				case Constants.PowerupExtender:
					charmActivationCaption.texture = charmActivationDuplication;
					break;
				case Constants.PowerupPyromancy:
					charmActivationCaption.texture = charmActivationBarrels;
					break;
			}
			charmActivationCaption.readjustSize();
			charmActivationCaption.pivotX = Math.ceil(charmActivationCaption.width / 2);
			charmActivationCaption.pivotY = Math.ceil(charmActivationCaption.height / 2);
			charmActivationCaption.alpha = 1;
			charmActivationCaption.visible = true;
			charmActivationCaption.scaleX = 0.5;
			charmActivationCaption.scaleY = 0.5;
			Starling.juggler.tween(charmActivationCaption, 0.3, {
				transition: Transitions.EASE_OUT,
				scaleX: 1,
				scaleY: 1
			});
			
			charmActivationBg.visible = true;
			starling.core.Starling.juggler.add(charmActivationBg);
			charmActivationBg.play();
			
			Starling.juggler.delayCall(fadeOutCharmActivation, 1.5); // reset in a moment
			Starling.juggler.delayCall(resetCharmActivation, 1.7); // reset in a moment
		}
		
		private function fadeOutCharmActivation():void {
			Starling.juggler.tween(charmActivationCaption, 0.2, {
				transition: Transitions.LINEAR,
				alpha: 0
			});
		}
		
		private function resetCharmActivation():void {
			charmActivationBg.stop();
			starling.core.Starling.juggler.remove(charmActivationBg);
			charmActivationBg.visible = false;
			charmActivationCaption.visible = false;
		}
		
		/**
		 * Show special ability indicators on hero launch
		 */
		public function showAbilityIndicators():void {
			for (var i:uint = 0; i < Statics.numSpecials; i++) {
				specialIndicatorsList[i].visible = true;
			}
		}
	}
}