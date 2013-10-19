package com.jumpGame.ui.popups
{
	import com.jumpGame.customObjects.Font;
	import com.jumpGame.screens.Menu;
	import com.jumpGame.ui.components.RankingItemRenderer;
	
	import feathers.controls.Button;
	import feathers.controls.Check;
	import feathers.controls.List;
	import feathers.controls.Scroller;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class ScreenRankings extends Sprite
	{
		public var listGlobal:List;
		public var rankingsGlobal:Array;
		
		private var parent:Menu;
		private var closeButton:Check;
		
		public function ScreenRankings(parent:Menu)
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
			
			var btnGlobal:Button = new Button();
			btnGlobal.width = (scrollQuad.width - 80) / 2;
			btnGlobal.height = 40;
			btnGlobal.x = scrollQuad.bounds.left + 30;
			btnGlobal.y = scrollQuad.bounds.top + 20;
			btnGlobal.label = "Global";
			addChild(btnGlobal);
			btnGlobal.addEventListener(Event.TRIGGERED, Menu(this.parent).refreshRankingsGlobal);
			
			var btnFriends:Button = new Button();
			btnFriends.width = (scrollQuad.width - 80) / 2;
			btnFriends.height = 40;
			btnFriends.x = btnGlobal.bounds.right + 20;
			btnFriends.y = scrollQuad.bounds.top + 20;
			btnFriends.label = "Friends";
			addChild(btnFriends);
			btnFriends.addEventListener(Event.TRIGGERED, Menu(this.parent).refreshRankingsFriends);
			
			var fontLithos42:Font = Fonts.getFont("Lithos42");
			// name header
			var nameHeaderField:TextField = new TextField((scrollQuad.width - 80) / 2, 10, "Name", fontLithos42.fontName, fontLithos42.fontSize, 0xffdd1e);
			nameHeaderField.vAlign = VAlign.TOP;
			nameHeaderField.hAlign = HAlign.LEFT;
			nameHeaderField.x = scrollQuad.bounds.left + 30;
			nameHeaderField.y = btnGlobal.bounds.bottom + 20;
			nameHeaderField.autoSize = "vertical";
			addChild(nameHeaderField);
			
			// high score header
			var highScoreHeaderField:TextField = new TextField((scrollQuad.width - 80) / 2, 10, "High Score", fontLithos42.fontName, fontLithos42.fontSize, 0xffdd1e);
			highScoreHeaderField.vAlign = VAlign.TOP;
			highScoreHeaderField.hAlign = HAlign.LEFT;
			highScoreHeaderField.x = btnFriends.bounds.left;
			highScoreHeaderField.y = btnGlobal.bounds.bottom + 20;
			highScoreHeaderField.autoSize = "vertical";
			addChild(highScoreHeaderField);
			
			// rankings list
			listGlobal = new List();
			listGlobal.width = scrollQuad.width - 60;
			listGlobal.x = scrollQuad.bounds.left + 30;
			listGlobal.y = nameHeaderField.bounds.bottom + 10;
			listGlobal.horizontalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			this.addChild(listGlobal);
			listGlobal.itemRendererType = RankingItemRenderer;
			listGlobal.itemRendererProperties.titleField = "title";
			listGlobal.itemRendererProperties.captionField = "caption";
			listGlobal.itemRendererProperties.pictureField = "picture_url";
			listGlobal.addEventListener(Event.CHANGE, listGlobalChangeHandler);
			
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
		
		private function listGlobalChangeHandler(event:Event):void {
			if (listGlobal.selectedIndex == -1) return;
			Menu(this.parent).showProfileScreenGivenData(rankingsGlobal[listGlobal.selectedIndex]);
			listGlobal.selectedIndex = -1;
		}
		
		public function refresh():void {
			closeButton.isSelected = true; // fix close button
		}
		
		private function buttonCloseHandler(event:Event):void {
			this.visible = false;
		}
	}
}