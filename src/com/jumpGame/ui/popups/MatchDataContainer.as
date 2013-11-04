package com.jumpGame.ui.popups
{
	import com.jumpGame.customObjects.Font;
	import com.jumpGame.events.NavigationEvent;
	import com.jumpGame.level.Statics;
	import com.jumpGame.ui.screens.ScreenMatches;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	
	import feathers.controls.Button;
	import feathers.text.BitmapFontTextFormat;
	
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class MatchDataContainer extends Sprite
	{
		private var popupContainer:Sprite;
		private var contentContainer:Sprite;
		private var player1Name:TextField;
		private var player2Name:TextField;
		private var scoreTextFields:Vector.<TextField>;
		private var player1TotalText:TextField;
		private var player2TotalText:TextField;
		private var btnPlay:Button;
		private var btnResign:Button;
		private var winnerText:TextField;
		private var player1Picture:Image;
		private var player2Picture:Image;
		private var playerPictureLoader:Loader;
		private var opponentPictureLoader:Loader;
		private var playerPictureWidth:uint;
		private var opponentPictureWidth:uint;
		
		public function MatchDataContainer()
		{
			super();
			
			playerPictureWidth = 0;
			opponentPictureWidth = 0;
			
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:starling.events.Event):void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			drawMatchDataPopup();
		}
		
		private function drawMatchDataPopup():void
		{
			// bg quad
			var bg:Quad = new Quad(Statics.stageWidth, Statics.stageHeight, 0x000000);
			bg.alpha = 0.5;
			this.addChild(bg);
			
			contentContainer = new Sprite();
			popupContainer = new Sprite();
			
			// popup artwork
			var popup:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("PopupMatchDetails0000"));
			popupContainer.addChild(popup);
			
			popupContainer.pivotX = Math.ceil(popupContainer.width / 2);
			popupContainer.pivotY = Math.ceil(popupContainer.height / 2);
			popupContainer.x = Statics.stageWidth / 2;
			popupContainer.y = Statics.stageHeight / 2;
			this.addChild(popupContainer);
			
			// popup close button
			var buttonClose:Button = new Button();
			buttonClose.defaultSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ButtonPopupClose0000"));
			buttonClose.hoverSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ButtonPopupClose0000"));
			buttonClose.downSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ButtonPopupClose0000"));
			buttonClose.hoverSkin.filter = Statics.btnBrightnessFilter;
			buttonClose.downSkin.filter = Statics.btnInvertFilter;
			buttonClose.useHandCursor = true;
			buttonClose.addEventListener(starling.events.Event.TRIGGERED, buttonCloseHandler);
			popupContainer.addChild(buttonClose);
			buttonClose.validate();
			buttonClose.pivotX = buttonClose.width;
			buttonClose.x = popup.bounds.right - 8;
			buttonClose.y = popup.bounds.top + 8;
			
			var fontBadabb:Font = Fonts.getFont("Badabb");
			var fontLithosBold44:Font = Fonts.getFont("LithosBold44");
			// player 1 name
			player1Name = new TextField(150, 100, "Player\nName", fontBadabb.fontName, 26, 0xAF5528);
			player1Name.hAlign = HAlign.RIGHT;
			player1Name.vAlign = VAlign.TOP;
			player1Name.pivotX = player1Name.width;
			player1Name.x = 200;
			player1Name.y = 150;
			contentContainer.addChild(player1Name);
			// player 2 name
			player2Name = new TextField(150, 100, "Opponent\nName", fontBadabb.fontName, 26, 0xAF5528);
			player2Name.hAlign = HAlign.LEFT;
			player2Name.vAlign = VAlign.TOP;
			player2Name.x = 545;
			player2Name.y = 150;
			contentContainer.addChild(player2Name);
			
			// player profile pictures
			player1Picture = new Image(Assets.getSprite("AtlasTexturePlatforms").getTexture("Cannonball0000"));
			player1Picture.x = 231;
			player1Picture.y = 139;
			contentContainer.addChild(player1Picture);
			
			var pictureFrame1:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("PictureFrame0000"));
			pictureFrame1.x = 219;
			pictureFrame1.y = 129;
			contentContainer.addChild(pictureFrame1);
			
			player2Picture = new Image(Assets.getSprite("AtlasTexturePlatforms").getTexture("Cannonball0000"));
			player2Picture.x = 444;
			player2Picture.y = 139;
			contentContainer.addChild(player2Picture);
			
			var pictureFrame2:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("PictureFrame0000"));
			pictureFrame2.x = 432;
			pictureFrame2.y = 129;
			contentContainer.addChild(pictureFrame2);
			
			// player scores
			var leftScoreColumnX:Number = 180;
			var rightScoreColumnX:Number = 558;
			scoreTextFields = new Vector.<TextField>();
			// player 1 round 1 score 0xf9ff61
			var player1Round1Score:TextField = new TextField(200, 40, "err", fontLithosBold44.fontName, 33, 0xffffff);
			player1Round1Score.hAlign = HAlign.CENTER;
			player1Round1Score.vAlign = VAlign.TOP;
			player1Round1Score.pivotX = Math.ceil(player1Round1Score.width / 2);
			player1Round1Score.x = leftScoreColumnX;
			player1Round1Score.y = 271;
			contentContainer.addChild(player1Round1Score);
			scoreTextFields.push(player1Round1Score);
			
			// player 2 round 1 score
			var player2Round1Score:TextField = new TextField(200, 40, "err", fontLithosBold44.fontName, 33, 0xffffff);
			player2Round1Score.hAlign = HAlign.CENTER;
			player2Round1Score.vAlign = VAlign.TOP;
			player2Round1Score.pivotX = Math.ceil(player2Round1Score.width / 2);
			player2Round1Score.x = rightScoreColumnX;
			player2Round1Score.y = 271;
			contentContainer.addChild(player2Round1Score);
			scoreTextFields.push(player2Round1Score);
			
			// player 1 round 2 score
			var player1Round2Score:TextField = new TextField(200, 40, "err", fontLithosBold44.fontName, 33, 0xffffff);
			player1Round2Score.hAlign = HAlign.CENTER;
			player1Round2Score.vAlign = VAlign.TOP;
			player1Round2Score.pivotX = Math.ceil(player1Round2Score.width / 2);
			player1Round2Score.x = leftScoreColumnX;
			player1Round2Score.y = 314;
			contentContainer.addChild(player1Round2Score);
			scoreTextFields.push(player1Round2Score);
			
			// player 2 round 2 score
			var player2Round2Score:TextField = new TextField(200, 40, "err", fontLithosBold44.fontName, 33, 0xffffff);
			player2Round2Score.hAlign = HAlign.CENTER;
			player2Round2Score.vAlign = VAlign.TOP;
			player2Round2Score.pivotX = Math.ceil(player2Round2Score.width / 2);
			player2Round2Score.x = rightScoreColumnX;
			player2Round2Score.y = 314;
			contentContainer.addChild(player2Round2Score);
			scoreTextFields.push(player2Round2Score);
			
			// player 1 round 3 score
			var player1Round3Score:TextField = new TextField(200, 40, "err", fontLithosBold44.fontName, 33, 0xffffff);
			player1Round3Score.hAlign = HAlign.CENTER;
			player1Round3Score.vAlign = VAlign.TOP;
			player1Round3Score.pivotX = Math.ceil(player1Round3Score.width / 2);
			player1Round3Score.x = leftScoreColumnX;
			player1Round3Score.y = 353;
			contentContainer.addChild(player1Round3Score);
			scoreTextFields.push(player1Round3Score);
			
			// player 2 round 3 score
			var player2Round3Score:TextField = new TextField(200, 40, "err", fontLithosBold44.fontName, 33, 0xffffff);
			player2Round3Score.hAlign = HAlign.CENTER;
			player2Round3Score.vAlign = VAlign.TOP;
			player2Round3Score.pivotX = Math.ceil(player2Round3Score.width / 2);
			player2Round3Score.x = rightScoreColumnX;
			player2Round3Score.y = 353;
			contentContainer.addChild(player2Round3Score);
			scoreTextFields.push(player2Round3Score);
			
			// player 1 total score
			player1TotalText = new TextField(200, 50, "err", fontLithosBold44.fontName, fontLithosBold44.fontSize, 0xAF5528);
			player1TotalText.hAlign = HAlign.CENTER;
			player1TotalText.vAlign = VAlign.TOP;
			player1TotalText.pivotX = Math.ceil(player1TotalText.width / 2);
			player1TotalText.x = leftScoreColumnX;
			player1TotalText.y = 458;
			contentContainer.addChild(player1TotalText);
			
			// player 2 total score
			player2TotalText = new TextField(200, 50, "err", fontLithosBold44.fontName, fontLithosBold44.fontSize, 0xAF5528);
			player2TotalText.hAlign = HAlign.CENTER;
			player2TotalText.vAlign = VAlign.TOP;
			player2TotalText.pivotX = Math.ceil(player2TotalText.width / 2);
			player2TotalText.x = rightScoreColumnX;
			player2TotalText.y = 458;
			contentContainer.addChild(player2TotalText);
			
			this.addChild(contentContainer);
			
			// play button
			btnPlay = new Button();
			btnPlay.defaultSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ButtonMatchDetailsCta0000"));
			btnPlay.hoverSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ButtonMatchDetailsCta0000"));
			btnPlay.downSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ButtonMatchDetailsCta0000"));
			btnPlay.hoverSkin.filter = Statics.btnBrightnessFilter;
			btnPlay.downSkin.filter = Statics.btnInvertFilter;
			var ctaTextFormat:BitmapFontTextFormat = new BitmapFontTextFormat(Fonts.getBitmapFont("Materhorn24"));
//			var ctaTextFormat:BitmapFontTextFormat = new BitmapFontTextFormat(Fonts.getBitmapFont("ScoreValue"));
			ctaTextFormat.size = 25;
			ctaTextFormat.color = 0xB75913;
			btnPlay.defaultLabelProperties.textFormat = ctaTextFormat;
			btnPlay.useHandCursor = true;
			btnPlay.addEventListener(starling.events.Event.TRIGGERED, buttonPlayHandler);
			contentContainer.addChild(btnPlay);
			btnPlay.validate();
			btnPlay.pivotX = Math.ceil(btnPlay.width / 2);
			btnPlay.x = Statics.stageWidth / 2;
			btnPlay.y = 524;
			btnPlay.label = "Return";
			
			// resign button
			btnResign = new Button();
			btnResign.defaultSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ButtonMatchDetailsCta0000"));
			btnResign.hoverSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ButtonMatchDetailsCta0000"));
			btnResign.downSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ButtonMatchDetailsCta0000"));
			btnResign.hoverSkin.filter = Statics.btnBrightnessFilter;
			btnResign.downSkin.filter = Statics.btnInvertFilter;
			btnResign.defaultLabelProperties.textFormat = ctaTextFormat;
			btnResign.useHandCursor = true;
			btnResign.addEventListener(starling.events.Event.TRIGGERED, buttonResignHandler);
			contentContainer.addChild(btnResign);
			btnResign.validate();
			btnResign.pivotX = Math.ceil(btnResign.width / 2);
			btnResign.x = Statics.stageWidth / 2 - Math.ceil(btnResign.width / 2);;
			btnResign.y = 524;
			btnResign.label = "Decline";
			
			// winner text
//			winnerText = new TextField(400, 50, "Player 1 Wins!", fontBadabb.fontName, fontLithosBold44.fontSize, 0xff0000);
//			winnerText.hAlign = HAlign.CENTER;
//			winnerText.vAlign = VAlign.TOP;
//			winnerText.pivotX = Math.ceil(winnerText.width / 2);
//			winnerText.x = stage.stageWidth / 2;
//			winnerText.y = round3Text.bounds.bottom + 5;
//			winnerText.visible = false;
//			this.addChild(winnerText);
			
			// external interface
			ExternalInterface.addCallback("returnProfilePictureUrlToAs", pictureUrlReturnedFromJs);
			
			// loader
			playerPictureLoader = new Loader();
			playerPictureLoader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, onPlayerPictureLoadComplete);
			opponentPictureLoader = new Loader();
			opponentPictureLoader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, onOpponentPictureLoadComplete);
		}
		
		private function buttonPlayHandler(event:starling.events.Event):void {
			if (btnPlay.label == "Done") {
				ExternalInterface.call("sendTurnRequest", Statics.opponentFbid, Statics.gameId);
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "menu"}, true));
			} else if (btnPlay.label == "Play") {
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "play"}, true));
			}
			this.visible = false;
		}
		
		private function buttonResignHandler(event:starling.events.Event):void {
			ScreenMatches(this.parent).resignMatch();
			this.visible = false;
		}
		
		private function buttonCloseHandler(event:starling.events.Event):void {
			this.visible = false;
		}
		
		public function initialize(isDone:Boolean):void {
//			trace("game id: " + Statics.gameId);
			
			contentContainer.alpha = 0;
			popupContainer.scaleX = 0.5;
			popupContainer.scaleY = 0.5;
			Starling.juggler.tween(popupContainer, 0.5, {
				transition: Transitions.EASE_OUT_ELASTIC,
				scaleX: 1,
				scaleY: 1
			});
			Starling.juggler.tween(contentContainer, 0.3, {
				delay: 0.2,
				transition: Transitions.LINEAR,
				alpha: 1
			});
			
			btnPlay.label = "Return";
			btnResign.visible = false;
			
			if (Statics.isPlayer2) {
				player1Name.text = Statics.opponentName;
//				player2Name.text = Statics.playerName;
				player2Name.text = Statics.firstName + "\n" + Statics.lastName;
			} else {
//				player1Name.text = Statics.playerName;
				player1Name.text = Statics.firstName + "\n" + Statics.lastName;
				player2Name.text = Statics.opponentName;
			}
			
			var i:uint = 0;
//			trace("scores: " + Statics.roundScores);
			while (i < 6 && Statics.roundScores[i] != 0) {
				scoreTextFields[i].text = Statics.roundScores[i];
				i++;
			}
			Statics.currentRound = 6;
			if (i < 6) {
				if (i % 2 == 0) { // round 1, 3, 5
					if (Statics.isPlayer2) {
						scoreTextFields[i].text = "Their Turn";
					} else {
						scoreTextFields[i].text = "Your Turn";
						btnPlay.label = "Play";
						
					}
				} else { // round 2, 4, 6
					if (Statics.isPlayer2) {
						scoreTextFields[i].text = "Your Turn";
						btnPlay.label = "Play";
					} else {
						scoreTextFields[i].text = "Their Turn";
					}
				}
				Statics.currentRound = i;
				i++;
			}
			while (i < 6) {
				scoreTextFields[i].text = "-";
				i++;
			}
			
			// calculate total scores
			var player1ScoreTotal:uint = Statics.roundScores[0] + Statics.roundScores[2] + Statics.roundScores[4];
			var player2ScoreTotal:uint = Statics.roundScores[1] + Statics.roundScores[3] + Statics.roundScores[5];
			player1TotalText.text = player1ScoreTotal.toString();
			player2TotalText.text = player2ScoreTotal.toString();
			
			// check if a player has resigned
//			trace("resigned by: " + Statics.resignedBy);
			if (Statics.resignedBy != "0") {
				if (Statics.resignedBy == Statics.userId) { // current player resigned this game
					if (Statics.isPlayer2) {
						winnerText.text = player1Name.text + " Wins!";
					} else {
						winnerText.text = player2Name.text + " Wins!";
					}
				}
				else { // the opponent resigned this game
					if (Statics.isPlayer2) {
						winnerText.text = player2Name.text + " Wins!";
					} else {
						winnerText.text = player1Name.text + " Wins!";
					}
				}
				winnerText.visible = true;
				btnPlay.label = "Return";
				return;
			}
			
			
			// resign button
			btnResign.isEnabled = false;
			if (Statics.isPlayer2 && Statics.currentRound == 1) {
				btnPlay.x = Statics.stageWidth / 2 + Math.ceil(btnPlay.width / 2);
				btnResign.visible = true;
				btnResign.isEnabled = true;
			}
			
			// check if game has ended
//			winnerText.visible = false;
//			if (Statics.currentRound >= 6) {
//				if (player1ScoreTotal > player2ScoreTotal) { // player 1 wins
//					winnerText.text = player1Name.text + " Wins!";
//				} else if (player2ScoreTotal > player1ScoreTotal) { // player 2 wins
//					winnerText.text = player2Name.text + " Wins!";
//				} else { // it's a draw
//					winnerText.text = "It's a draw!";
//				}
//				winnerText.visible = true;
//			}
			
			if (isDone) {
				btnPlay.label = "Done";
//				btnPlay.isEnabled = true;
			}
			
			// draw player profile picture
			this.drawPlayerProfilePicture();
			
			// load and draw opponent profile picture
			if (Statics.opponentFbid) {
				this.getProfilePictureUrlFromJs(Statics.opponentFbid);
			}
			
			this.visible = true;
		}
		
		public function getProfilePictureUrlFromJs(facebookId:String):void {
			if(ExternalInterface.available){
				ExternalInterface.call("getProfilePictureUrl", facebookId);
			} else {
				trace("External interface unavailabe");
			}
		}
		
		public function pictureUrlReturnedFromJs(facebookId:String, pictureUrlData:Object):void {
//			trace("returned fbid: " + facebookId);
			if (pictureUrlData.url != null && pictureUrlData.width != null) {
				if (facebookId == Statics.facebookId) {
					playerPictureWidth = uint(pictureUrlData.width);
					playerPictureLoader.load(new URLRequest(pictureUrlData.url));
				}
				else if (facebookId == Statics.opponentFbid) {
					opponentPictureWidth = uint(pictureUrlData.width);
					opponentPictureLoader.load(new URLRequest(pictureUrlData.url));
				}
			}
		}
		
		private function onPlayerPictureLoadComplete(event:flash.events.Event):void {
			Statics.playerPictureBitmap = event.currentTarget.loader.content as Bitmap;
			playerPictureLoader.contentLoaderInfo.removeEventListener(flash.events.Event.COMPLETE, onPlayerPictureLoadComplete);
		}
		
		private function drawPlayerProfilePicture():void {
			if (Statics.playerPictureBitmap == null) return; // do not display if not yet loaded
			
			if (Statics.isPlayer2) {
				this.drawRightProfilePicture(Statics.playerPictureBitmap, playerPictureWidth);
			} else {
				this.drawLeftProfilePicture(Statics.playerPictureBitmap, playerPictureWidth);
			}
		}
		
		private function onOpponentPictureLoadComplete(event:flash.events.Event):void {
			if (Statics.isPlayer2) {
				this.drawLeftProfilePicture(event.currentTarget.loader.content as Bitmap, opponentPictureWidth);
			} else {
				this.drawRightProfilePicture(event.currentTarget.loader.content as Bitmap, opponentPictureWidth);
			}
		}
		
		private function drawLeftProfilePicture(bitmap:Bitmap, pictureWidth:uint):void {
			this.player1Picture.texture = Texture.fromBitmap(bitmap);
			this.player1Picture.readjustSize();
			var pictureScaleFactor:Number = 70 / pictureWidth;
			this.player1Picture.scaleX = pictureScaleFactor;
			this.player1Picture.scaleY = pictureScaleFactor;
		}
		
		private function drawRightProfilePicture(bitmap:Bitmap, pictureWidth:uint):void {
			this.player2Picture.texture = Texture.fromBitmap(bitmap);
			this.player2Picture.readjustSize();
			var pictureScaleFactor:Number = 70 / pictureWidth;
			this.player2Picture.scaleX = pictureScaleFactor;
			this.player2Picture.scaleY = pictureScaleFactor;
		}
	}
}