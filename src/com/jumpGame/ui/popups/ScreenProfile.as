package com.jumpGame.ui.popups
{
	import com.jumpGame.customObjects.Font;
	import com.jumpGame.screens.Menu;
	
	import feathers.controls.Check;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class ScreenProfile extends Sprite
	{
		private var parent:Menu;
		private var closeButton:Check;
		
		private var nameField:TextField;
		private var highScoreField:TextField;
		
		public function ScreenProfile(parent:Menu)
		{
			super();
			this.parent = parent;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			// bg quad
			var bg:Quad = new Quad(stage.stageWidth, stage.stageHeight, 0x000000);
			bg.alpha = 0.5;
			this.addChild(bg);
			
			// scroll dialog artwork
			var scrollTop:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("ScrollLongTop0000"));
			scrollTop.pivotX = Math.ceil(scrollTop.texture.width / 2);
			scrollTop.x = stage.stageWidth / 2;
			scrollTop.y = 20;
			this.addChild(scrollTop);
			
			var scrollBottom:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("ScrollLongBottom0000"));
			scrollBottom.pivotX = Math.ceil(scrollBottom.texture.width / 2);
			scrollBottom.pivotY = scrollBottom.texture.height;
			scrollBottom.x = stage.stageWidth / 2;
			scrollBottom.y = stage.stageHeight - 30;
			this.addChild(scrollBottom);
			
			var scrollQuad:Quad = new Quad(scrollTop.texture.width - 54, scrollBottom.y - scrollTop.y - scrollTop.texture.height - scrollBottom.texture.height + 2, 0xf1b892);
			scrollQuad.pivotX = Math.ceil(scrollQuad.width / 2);
			scrollQuad.x = stage.stageWidth / 2;
			scrollQuad.y = scrollTop.y + scrollTop.texture.height - 1;
			addChild(scrollQuad);
			// eof scroll dialog artwork
			
			var fontLithos42:Font = Fonts.getFont("Lithos42");
			var fontVerdana23:Font = Fonts.getFont("Verdana23");
			
			// player name field
			nameField = new TextField(scrollQuad.width - 60, 45, "", fontLithos42.fontName, fontLithos42.fontSize, 0xffdd1e);
			nameField.vAlign = VAlign.TOP;
			nameField.hAlign = HAlign.LEFT;
			nameField.x = scrollQuad.bounds.left + 30;
			nameField.y = scrollQuad.bounds.top + 20;
			addChild(nameField);
			
			// high score field
			highScoreField = new TextField(400, 40, "", fontVerdana23.fontName, fontVerdana23.fontSize, 0xffffff);
			highScoreField.vAlign = VAlign.TOP;
			highScoreField.hAlign = HAlign.LEFT;
			highScoreField.x = nameField.bounds.left;
			highScoreField.y = nameField.bounds.bottom + 10;
			addChild(highScoreField);
			
			// close button
			closeButton = new Check();
			closeButton.isSelected = true;
			closeButton.width = 30;
			closeButton.height = 30;
			closeButton.x = scrollQuad.x + scrollQuad.width / 2 - 40;
			closeButton.y = scrollQuad.y - 25;
			closeButton.addEventListener(Event.TRIGGERED, buttonCloseHandler);
			this.addChild(closeButton);
		}
		
		public function refresh(playerData:Object):void {
			closeButton.isSelected = true; // fix close button
			
			nameField.text = playerData.firstname + " " + playerData.lastname;
			highScoreField.text = "High Score: " + playerData.high_score;
		}
		
		private function buttonCloseHandler(event:Event):void {
			this.visible = false;
		}
	}
}