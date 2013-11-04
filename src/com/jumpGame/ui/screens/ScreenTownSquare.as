package com.jumpGame.ui.screens
{
	import com.jumpGame.customObjects.Font;
	import com.jumpGame.screens.Menu;
	import com.jumpGame.level.Statics;
	
	import feathers.controls.Screen;
	
	import starling.text.TextField;
	import starling.events.Event;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	import feathers.controls.Button;
	
	public class ScreenTownSquare extends Screen
	{
		private var btnAchievements:Button;
		private var btnRankings:Button;
		private var btnProfile:Button;
		private var btnCharacters:Button;
		private var btnGetCoins:Button;
		private var btnGetGems:Button;
		
		public function ScreenTownSquare()
		{
		}
		
		override protected function initialize():void
		{
			// buttons first row
			var sideLength:Number = 120;
			// achievements button
			btnAchievements = new Button();
			btnAchievements.width = sideLength;
			btnAchievements.height = sideLength;
			btnAchievements.x = Statics.stageWidth / 2 - 300 + 60;
			btnAchievements.y = 150;
			addChild(btnAchievements);
			btnAchievements.addEventListener(Event.TRIGGERED, Menu(this.owner).showAchievementsScreen);
			
			// rankings button
			btnRankings = new Button();
			btnRankings.width = sideLength;
			btnRankings.height = sideLength;
			btnRankings.x = btnAchievements.bounds.right + 60;
			btnRankings.y = btnAchievements.y;
			addChild(btnRankings);
			btnRankings.addEventListener(Event.TRIGGERED, Menu(this.owner).showRankingsScreen);
			
			// profile button
			btnProfile = new Button();
			btnProfile.width = sideLength;
			btnProfile.height = sideLength;
			btnProfile.x = btnRankings.bounds.right + 60;
			btnProfile.y = btnAchievements.y;
			addChild(btnProfile);
			btnProfile.addEventListener(Event.TRIGGERED, Menu(this.owner).showProfileScreen);
			
			// button labels
			var fontVerdana23:Font = Fonts.getFont("Verdana23");
			var iconLabel1:TextField = new TextField(sideLength, 25, "Achievements", fontVerdana23.fontName, fontVerdana23.fontSize, 0x873623);
			iconLabel1.hAlign = HAlign.CENTER;
			iconLabel1.vAlign = VAlign.TOP;
			iconLabel1.x = btnAchievements.bounds.left;
			iconLabel1.y = btnAchievements.bounds.bottom + 5;
			addChild(iconLabel1);
			
			var iconLabel2:TextField = new TextField(sideLength, 25, "Rankings", fontVerdana23.fontName, fontVerdana23.fontSize, 0x873623);
			iconLabel2.hAlign = HAlign.CENTER;
			iconLabel2.vAlign = VAlign.TOP;
			iconLabel2.x = btnRankings.bounds.left;
			iconLabel2.y = iconLabel1.y;
			addChild(iconLabel2);
			
			var iconLabel3:TextField = new TextField(sideLength, 25, "My Profile", fontVerdana23.fontName, fontVerdana23.fontSize, 0x873623);
			iconLabel3.hAlign = HAlign.CENTER;
			iconLabel3.vAlign = VAlign.TOP;
			iconLabel3.x = btnProfile.bounds.left;
			iconLabel3.y = iconLabel1.y;
			addChild(iconLabel3);
			
			// buttons second row
			// characters button
			btnCharacters = new Button();
			btnCharacters.width = sideLength;
			btnCharacters.height = sideLength;
			btnCharacters.x = btnAchievements.bounds.left;
			btnCharacters.y = iconLabel1.bounds.bottom + 30;
			addChild(btnCharacters);
//			btnCharacters.addEventListener(Event.TRIGGERED, Menu(this.owner).showCharactersScreen);
			
			var iconLabel4:TextField = new TextField(sideLength, 25, "Characters", fontVerdana23.fontName, fontVerdana23.fontSize, 0x873623);
			iconLabel4.hAlign = HAlign.CENTER;
			iconLabel4.vAlign = VAlign.TOP;
			iconLabel4.x = btnCharacters.bounds.left;
			iconLabel4.y = btnCharacters.bounds.bottom + 5;
			addChild(iconLabel4);
			
			// get coins button
			btnGetCoins = new Button();
			btnGetCoins.width = sideLength;
			btnGetCoins.height = sideLength;
			btnGetCoins.x = btnRankings.bounds.left;
			btnGetCoins.y = btnCharacters.y;
			addChild(btnGetCoins);
			btnGetCoins.addEventListener(Event.TRIGGERED, Menu(this.owner).showGetCoinsScreen);
			
			var iconLabel5:TextField = new TextField(sideLength, 25, "Get Coins", fontVerdana23.fontName, fontVerdana23.fontSize, 0x873623);
			iconLabel5.hAlign = HAlign.CENTER;
			iconLabel5.vAlign = VAlign.TOP;
			iconLabel5.x = btnGetCoins.bounds.left;
			iconLabel5.y = btnGetCoins.bounds.bottom + 5;
			addChild(iconLabel5);
			
			// get gems button
			btnGetGems = new Button();
			btnGetGems.width = sideLength;
			btnGetGems.height = sideLength;
			btnGetGems.x = btnProfile.bounds.left;
			btnGetGems.y = btnCharacters.y;
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