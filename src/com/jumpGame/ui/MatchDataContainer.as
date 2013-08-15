package com.jumpGame.ui
{
	import com.jumpGame.customObjects.Font;
	import com.jumpGame.events.NavigationEvent;
	import com.jumpGame.level.Statics;
	import com.jumpGame.ui.screens.ScreenMatches;
	
	import flash.external.ExternalInterface;
	
	import feathers.controls.Button;
	import feathers.controls.Check;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class MatchDataContainer extends Sprite
	{
		private var player1Name:TextField;
		private var player2Name:TextField;
		private var scoreTextFields:Vector.<TextField>;
		private var player1TotalText:TextField;
		private var player2TotalText:TextField;
		private var btnPlay:Button;
		private var btnResign:Button;
		private var closeButton:Check;
		private var winnerText:TextField;
		private var line2:Quad;
		private var parent:Sprite;
		
		public function MatchDataContainer(parent)
		{
			super();
			
			this.parent = parent;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			drawMatchDataPopup();
		}
		
		private function drawMatchDataPopup():void
		{
			// bg quad
			var bg:Quad = new Quad(stage.stageWidth, stage.stageHeight, 0x000000);
			bg.alpha = 0.5;
			this.addChild(bg);
			
			// scroll
			var scrollTop:Image = new Image(Assets.getSprite("AtlasTexture2").getTexture("ScrollLongTop0000"));
			scrollTop.pivotX = Math.ceil(scrollTop.texture.width / 2);
			scrollTop.x = stage.stageWidth / 2;
			scrollTop.y = 20;
			this.addChild(scrollTop);
			
			var scrollBottom:Image = new Image(Assets.getSprite("AtlasTexture2").getTexture("ScrollLongBottom0000"));
			scrollBottom.pivotX = Math.ceil(scrollBottom.texture.width / 2);
			scrollBottom.pivotY = scrollBottom.texture.height;
			scrollBottom.x = stage.stageWidth / 2;
			scrollBottom.y = stage.stageHeight - 20;
			this.addChild(scrollBottom);
			
			var scrollQuad:Quad = new Quad(scrollTop.texture.width - 54, scrollBottom.y - scrollTop.y - scrollTop.texture.height - scrollBottom.texture.height + 2, 0xf1b892);
			scrollQuad.pivotX = Math.ceil(scrollQuad.width / 2);
			scrollQuad.x = stage.stageWidth / 2;
			scrollQuad.y = scrollTop.y + scrollTop.texture.height - 1;
			addChild(scrollQuad);
			// eof scroll
			
			// vs text image
			var vsText:Image = new Image(Assets.getSprite("AtlasTexture2").getTexture("VsText0000"));
			vsText.pivotX = Math.ceil(vsText.texture.width / 2);
			vsText.x = stage.stageWidth / 2;
			vsText.y = scrollQuad.y + 40;
			this.addChild(vsText);
			
			// horizontal line
			var line1:Quad = new Quad(590, 5, 0xf58a6d);
			line1.pivotX = Math.ceil(line1.width / 2);
			line1.x = stage.stageWidth / 2;
			line1.y = vsText.y + vsText.texture.height + 40;
			this.addChild(line1);
			
			var fontBadabb:Font = Fonts.getFont("Badabb");
			var fontLithosBold44:Font = Fonts.getFont("LithosBold44");
			// player 1 name
			player1Name = new TextField(300, 50, "Player N.", fontBadabb.fontName, fontBadabb.fontSize, 0x873623);
			player1Name.hAlign = HAlign.CENTER;
			player1Name.vAlign = VAlign.TOP;
			player1Name.pivotX = Math.ceil(player1Name.width / 2);
			player1Name.x = (vsText.x - vsText.texture.width / 2) / 2 + 20;
			player1Name.y = vsText.y + vsText.texture.height / 2;
			this.addChild(player1Name);
			// player 2 name
			player2Name = new TextField(300, 50, "Opponent N.", fontBadabb.fontName, fontBadabb.fontSize, 0x873623);
			player2Name.hAlign = HAlign.CENTER;
			player2Name.vAlign = VAlign.TOP;
			player2Name.pivotX = Math.ceil(player2Name.width / 2);
			player2Name.x = stage.stageWidth - (vsText.x - vsText.texture.width / 2) / 2 - 20;
			player2Name.y = vsText.y + vsText.texture.height / 2;
			this.addChild(player2Name);
			
			// round 1 text
			var round1Text:TextField = new TextField(200, 40, "Round 1", fontLithosBold44.fontName, 33, 0xffffff);
			round1Text.hAlign = HAlign.CENTER;
			round1Text.vAlign = VAlign.TOP;
			round1Text.pivotX = Math.ceil(round1Text.width / 2);
			round1Text.x = stage.stageWidth / 2;
			round1Text.y = line1.y + 30;
			this.addChild(round1Text);
			
			// round 2 text
			var round2Text:TextField = new TextField(200, 40, "Round 2", fontLithosBold44.fontName, 33, 0xffffff);
			round2Text.hAlign = HAlign.CENTER;
			round2Text.vAlign = VAlign.TOP;
			round2Text.pivotX = Math.ceil(round2Text.width / 2);
			round2Text.x = stage.stageWidth / 2;
			round2Text.y = round1Text.y + round1Text.height + 25;
			this.addChild(round2Text);
			
			// round 3 text
			var round3Text:TextField = new TextField(200, 40, "Round 3", fontLithosBold44.fontName, 33, 0xffffff);
			round3Text.hAlign = HAlign.CENTER;
			round3Text.vAlign = VAlign.TOP;
			round3Text.pivotX = Math.ceil(round3Text.width / 2);
			round3Text.x = stage.stageWidth / 2;
			round3Text.y = round2Text.y + round2Text.height + 25;
			this.addChild(round3Text);
			
			scoreTextFields = new Vector.<TextField>();
			// player 1 round 1 score
			var player1Round1Score:TextField = new TextField(200, 40, "err", fontLithosBold44.fontName, 33, 0xf9ff61);
			player1Round1Score.hAlign = HAlign.CENTER;
			player1Round1Score.vAlign = VAlign.TOP;
			player1Round1Score.pivotX = Math.ceil(player1Round1Score.width / 2);
			player1Round1Score.x = (round1Text.bounds.left - line1.bounds.left) / 2 + line1.bounds.left;
			player1Round1Score.y = line1.y + 30;
			this.addChild(player1Round1Score);
			scoreTextFields.push(player1Round1Score);
			
			// player 2 round 1 score
			var player2Round1Score:TextField = new TextField(200, 40, "err", fontLithosBold44.fontName, 33, 0xf9ff61);
			player2Round1Score.hAlign = HAlign.CENTER;
			player2Round1Score.vAlign = VAlign.TOP;
			player2Round1Score.pivotX = Math.ceil(player2Round1Score.width / 2);
			player2Round1Score.x = line1.bounds.right - (line1.bounds.right - round1Text.bounds.right) / 2;
			player2Round1Score.y = line1.y + 30;
			this.addChild(player2Round1Score);
			scoreTextFields.push(player2Round1Score);
			
			// player 1 round 2 score
			var player1Round2Score:TextField = new TextField(200, 40, "err", fontLithosBold44.fontName, 33, 0xf9ff61);
			player1Round2Score.hAlign = HAlign.CENTER;
			player1Round2Score.vAlign = VAlign.TOP;
			player1Round2Score.pivotX = Math.ceil(player1Round2Score.width / 2);
			player1Round2Score.x = (round1Text.bounds.left - line1.bounds.left) / 2 + line1.bounds.left;
			player1Round2Score.y = round1Text.y + round1Text.height + 25;
			this.addChild(player1Round2Score);
			scoreTextFields.push(player1Round2Score);
			
			// player 2 round 2 score
			var player2Round2Score:TextField = new TextField(200, 40, "err", fontLithosBold44.fontName, 33, 0xf9ff61);
			player2Round2Score.hAlign = HAlign.CENTER;
			player2Round2Score.vAlign = VAlign.TOP;
			player2Round2Score.pivotX = Math.ceil(player2Round2Score.width / 2);
			player2Round2Score.x = line1.bounds.right - (line1.bounds.right - round1Text.bounds.right) / 2;
			player2Round2Score.y = round1Text.y + round1Text.height + 25;
			this.addChild(player2Round2Score);
			scoreTextFields.push(player2Round2Score);
			
			// player 1 round 3 score
			var player1Round3Score:TextField = new TextField(200, 40, "err", fontLithosBold44.fontName, 33, 0xf9ff61);
			player1Round3Score.hAlign = HAlign.CENTER;
			player1Round3Score.vAlign = VAlign.TOP;
			player1Round3Score.pivotX = Math.ceil(player1Round3Score.width / 2);
			player1Round3Score.x = (round1Text.bounds.left - line1.bounds.left) / 2 + line1.bounds.left;
			player1Round3Score.y = round2Text.y + round2Text.height + 25;
			this.addChild(player1Round3Score);
			scoreTextFields.push(player1Round3Score);
			
			// player 2 round 3 score
			var player2Round3Score:TextField = new TextField(200, 40, "err", fontLithosBold44.fontName, 33, 0xf9ff61);
			player2Round3Score.hAlign = HAlign.CENTER;
			player2Round3Score.vAlign = VAlign.TOP;
			player2Round3Score.pivotX = Math.ceil(player2Round3Score.width / 2);
			player2Round3Score.x = line1.bounds.right - (line1.bounds.right - round1Text.bounds.right) / 2;
			player2Round3Score.y = round2Text.y + round2Text.height + 25;
			this.addChild(player2Round3Score);
			scoreTextFields.push(player2Round3Score);
			
			// horizontal line
			line2 = new Quad(590, 5, 0xf58a6d);
			line2.pivotX = Math.ceil(line2.width / 2);
			line2.x = stage.stageWidth / 2;
			line2.y = round3Text.y + round3Text.height + 25;
			this.addChild(line2);
			
			// total text
			var totalText:TextField = new TextField(200, 50, "Total", fontLithosBold44.fontName, fontLithosBold44.fontSize, 0xffffff);
			totalText.hAlign = HAlign.CENTER;
			totalText.vAlign = VAlign.TOP;
			totalText.pivotX = Math.ceil(totalText.width / 2);
			totalText.x = stage.stageWidth / 2;
			totalText.y = line2.y + 30;
			this.addChild(totalText);
			
			// player 1 total score
			player1TotalText = new TextField(200, 50, "err", fontLithosBold44.fontName, fontLithosBold44.fontSize, 0xf9ff61);
			player1TotalText.hAlign = HAlign.CENTER;
			player1TotalText.vAlign = VAlign.TOP;
			player1TotalText.pivotX = Math.ceil(player1TotalText.width / 2);
			player1TotalText.x = (round1Text.bounds.left - line1.bounds.left) / 2 + line1.bounds.left;
			player1TotalText.y = line2.y + 30;
			this.addChild(player1TotalText);
			
			// player 2 total score
			player2TotalText = new TextField(200, 50, "err", fontLithosBold44.fontName, fontLithosBold44.fontSize, 0xf9ff61);
			player2TotalText.hAlign = HAlign.CENTER;
			player2TotalText.vAlign = VAlign.TOP;
			player2TotalText.pivotX = Math.ceil(player2TotalText.width / 2);
			player2TotalText.x = line1.bounds.right - (line1.bounds.right - round1Text.bounds.right) / 2;
			player2TotalText.y = line2.y + 30;
			this.addChild(player2TotalText);
			
			// play button
			btnPlay = new Button();
			btnPlay.width = 328;
			btnPlay.height = 48;
			btnPlay.pivotX = Math.ceil(btnPlay.width / 2);
			btnPlay.x = stage.stageWidth / 2;
			btnPlay.y = totalText.bounds.bottom;
			btnPlay.label = "Return";
			btnPlay.addEventListener(Event.TRIGGERED, buttonPlayHandler);
			this.addChild(btnPlay);
			
			// resign button
			btnResign = new Button();
			btnResign.width = 120;
			btnResign.height = 48;
			btnResign.pivotX = Math.ceil(btnResign.width / 2);
			btnResign.x = 120;
			btnResign.y = totalText.bounds.bottom;
			btnResign.label = "Decline";
			btnResign.addEventListener(Event.TRIGGERED, buttonResignHandler);
			this.addChild(btnResign);
			
			// close button
			closeButton = new Check();
			closeButton.isSelected = true;
			closeButton.x = scrollQuad.x + scrollQuad.width / 2 - 40;
			closeButton.y = scrollQuad.y + 5;
			closeButton.addEventListener(Event.TRIGGERED, buttonCloseHandler);
			this.addChild(closeButton);
			
			// winner text
			winnerText = new TextField(400, 50, "Player 1 Wins!", fontBadabb.fontName, fontLithosBold44.fontSize, 0xff0000);
			winnerText.hAlign = HAlign.CENTER;
			winnerText.vAlign = VAlign.TOP;
			winnerText.pivotX = Math.ceil(winnerText.width / 2);
			winnerText.x = stage.stageWidth / 2;
			winnerText.y = round3Text.bounds.bottom + 5;
			winnerText.visible = false;
			this.addChild(winnerText);
		}
		
		private function buttonPlayHandler(event:Event):void {
			trace("button clicked");
			if (btnPlay.label == "Done") {
				ExternalInterface.call("sendTurnRequest", Statics.opponentFbid, Statics.gameId);
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "menu"}, true));
			} else if (btnPlay.label == "Play") {
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "play"}, true));
			}
			this.visible = false;
		}
		
		private function buttonResignHandler(event:Event):void {
			ScreenMatches(this.parent).resignMatch();
			this.visible = false;
		}
		
		private function buttonCloseHandler(event:Event):void {
			this.visible = false;
		}
		
		public function fixCloseButton():void {
			closeButton.isSelected = true;
		}
		
		public function initialize(isDone:Boolean):void {
			trace("game id: " + Statics.gameId);
			
			closeButton.isSelected = true;
			btnPlay.label = "Return";
			btnResign.visible = false;
			
			if (Statics.isPlayer2) {
				player1Name.text = Statics.opponentName;
				player2Name.text = Statics.playerName;
			} else {
				player1Name.text = Statics.playerName;
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
			trace("val: " + Statics.resignedBy);
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
				line2.visible = false;
				winnerText.visible = true;
				btnPlay.label = "Return";
				return;
			}
			
			
			// resign button
			btnResign.isEnabled = false;
			if (Statics.isPlayer2 && Statics.currentRound == 1) {
				btnResign.visible = true;
				btnResign.isEnabled = true;
			}
			
			// check if game has ended
			line2.visible = true;
			winnerText.visible = false;
			if (Statics.currentRound >= 6) {
				if (player1ScoreTotal > player2ScoreTotal) { // player 1 wins
					winnerText.text = player1Name.text + " Wins!";
				} else if (player2ScoreTotal > player1ScoreTotal) { // player 2 wins
					winnerText.text = player2Name.text + " Wins!";
				} else { // it's a draw
					winnerText.text = "It's a draw!";
				}
				line2.visible = false;
				winnerText.visible = true;
			}
			
			if (isDone) {
				btnPlay.label = "Done";
//				btnPlay.isEnabled = true;
			}
		}
	}
}