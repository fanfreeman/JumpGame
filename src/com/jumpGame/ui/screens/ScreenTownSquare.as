package com.jumpGame.ui.screens
{
	import com.jumpGame.customObjects.Font;
	import com.jumpGame.screens.Menu;
	
	import feathers.controls.Screen;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.text.TextField;
	import starling.events.Event;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	import feathers.controls.Button;
	
	public class ScreenTownSquare extends Screen
	{
		private var btnAchievements:Button;
		private var btnGetCoins:Button;
		private var btnGetGems:Button;
		
		public function ScreenTownSquare()
		{
		}
		
		override protected function initialize():void
		{
			// scroll dialog artwork
			var scrollTop:Image = new Image(Assets.getSprite("AtlasTexture2").getTexture("ScrollLongTop0000"));
			scrollTop.pivotX = Math.ceil(scrollTop.texture.width / 2);
			scrollTop.x = stage.stageWidth / 2;
			scrollTop.y = 60;
			this.addChild(scrollTop);
			
			var scrollBottom:Image = new Image(Assets.getSprite("AtlasTexture2").getTexture("ScrollLongBottom0000"));
			scrollBottom.pivotX = Math.ceil(scrollBottom.texture.width / 2);
			scrollBottom.pivotY = scrollBottom.texture.height;
			scrollBottom.x = stage.stageWidth / 2;
			scrollBottom.y = stage.stageHeight - 70;
			this.addChild(scrollBottom);
			
			var scrollQuad:Quad = new Quad(scrollTop.texture.width - 54, scrollBottom.y - scrollTop.y - scrollTop.texture.height - scrollBottom.texture.height + 2, 0xf1b892);
			scrollQuad.pivotX = Math.ceil(scrollQuad.width / 2);
			scrollQuad.x = stage.stageWidth / 2;
			scrollQuad.y = scrollTop.y + scrollTop.texture.height - 1;
			addChild(scrollQuad);
			// eof scroll dialog artwork
			
			// icons
			var sideLength:Number = (scrollQuad.width - 240) / 3;
			btnAchievements = new Button();
			btnAchievements.width = sideLength;
			btnAchievements.height = sideLength;
			btnAchievements.x = scrollQuad.bounds.left + 60;
			btnAchievements.y = scrollQuad.bounds.top + 30;
			addChild(btnAchievements);
			btnAchievements.addEventListener(Event.TRIGGERED, Menu(this.owner).showAchievementsScreen);
			
			var iconQuad2:Quad = new Quad(sideLength, sideLength, 0xff0000);
			iconQuad2.x = btnAchievements.bounds.right + 60;
			iconQuad2.y = btnAchievements.y;
			addChild(iconQuad2);
			
			var iconQuad3:Quad = new Quad(sideLength, sideLength, 0xff0000);
			iconQuad3.x = iconQuad2.bounds.right + 60;
			iconQuad3.y = btnAchievements.y;
			addChild(iconQuad3);
			
			// icon labels
			var fontVerdana23:Font = Fonts.getFont("Verdana23");
			var iconLabel1:TextField = new TextField(sideLength, 25, "Achievements", fontVerdana23.fontName, fontVerdana23.fontSize, 0x873623);
			iconLabel1.hAlign = HAlign.CENTER;
			iconLabel1.vAlign = VAlign.TOP;
			iconLabel1.x = btnAchievements.bounds.left;
			iconLabel1.y = btnAchievements.bounds.bottom + 5;
			addChild(iconLabel1);
			
			var iconLabel2:TextField = new TextField(sideLength, 25, "Social", fontVerdana23.fontName, fontVerdana23.fontSize, 0x873623);
			iconLabel2.hAlign = HAlign.CENTER;
			iconLabel2.vAlign = VAlign.TOP;
			iconLabel2.x = iconQuad2.bounds.left;
			iconLabel2.y = iconLabel1.y;
			addChild(iconLabel2);
			
			var iconLabel3:TextField = new TextField(sideLength, 25, "My Profile", fontVerdana23.fontName, fontVerdana23.fontSize, 0x873623);
			iconLabel3.hAlign = HAlign.CENTER;
			iconLabel3.vAlign = VAlign.TOP;
			iconLabel3.x = iconQuad3.bounds.left;
			iconLabel3.y = iconLabel1.y;
			addChild(iconLabel3);
			
			// icons second row
			var iconQuad4:Quad = new Quad(sideLength, sideLength, 0xff0000);
			iconQuad4.x = btnAchievements.bounds.left;
			iconQuad4.y = iconLabel1.bounds.bottom + 30;
			addChild(iconQuad4);
			
			var iconLabel4:TextField = new TextField(sideLength, 25, "Characters", fontVerdana23.fontName, fontVerdana23.fontSize, 0x873623);
			iconLabel4.hAlign = HAlign.CENTER;
			iconLabel4.vAlign = VAlign.TOP;
			iconLabel4.x = iconQuad4.bounds.left;
			iconLabel4.y = iconQuad4.bounds.bottom + 5;
			addChild(iconLabel4);
			
//			var iconQuad5:Quad = new Quad(sideLength, sideLength, 0xff0000);
//			iconQuad5.x = iconQuad2.bounds.left;
//			iconQuad5.y = iconQuad4.y;
//			addChild(iconQuad5);
			
			btnGetCoins = new Button();
			btnGetCoins.width = sideLength;
			btnGetCoins.height = sideLength;
			btnGetCoins.x = iconQuad2.bounds.left;
			btnGetCoins.y = iconQuad4.y;
			addChild(btnGetCoins);
			btnGetCoins.addEventListener(Event.TRIGGERED, Menu(this.owner).showGetCoinsScreen);
			
			var iconLabel5:TextField = new TextField(sideLength, 25, "Get Coins", fontVerdana23.fontName, fontVerdana23.fontSize, 0x873623);
			iconLabel5.hAlign = HAlign.CENTER;
			iconLabel5.vAlign = VAlign.TOP;
			iconLabel5.x = btnGetCoins.bounds.left;
			iconLabel5.y = btnGetCoins.bounds.bottom + 5;
			addChild(iconLabel5);
			
			btnGetGems = new Button();
			btnGetGems.width = sideLength;
			btnGetGems.height = sideLength;
			btnGetGems.x = iconQuad3.bounds.left;
			btnGetGems.y = iconQuad4.y;
			addChild(btnGetGems);
			btnGetGems.addEventListener(Event.TRIGGERED, Menu(this.owner).showGetGemsScreen);
			
			var iconLabel6:TextField = new TextField(sideLength, 25, "Get Gems", fontVerdana23.fontName, fontVerdana23.fontSize, 0x873623);
			iconLabel6.hAlign = HAlign.CENTER;
			iconLabel6.vAlign = VAlign.TOP;
			iconLabel6.x = btnGetGems.bounds.left;
			iconLabel6.y = btnGetGems.bounds.bottom + 5;
			addChild(iconLabel6);
		}
	}
}