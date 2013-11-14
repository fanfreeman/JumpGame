package com.jumpGame.ui.screens
{
	import com.jumpGame.level.Statics;
	import com.jumpGame.screens.Menu;
	
	import feathers.controls.Button;
	import feathers.controls.Screen;
	import feathers.text.BitmapFontTextFormat;
	
	import starling.display.Image;
	import starling.events.Event;
	
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
			// images first row
			// achievements image
			var wrapperWidth:Number = 660;
			var itemBg1:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("TownItemBg0000"));
			var gap:Number = (wrapperWidth - itemBg1.width * 3) / 4; 
			itemBg1.x = Statics.stageWidth / 2 - wrapperWidth / 2 + gap;
			itemBg1.y = 80;
			this.addChild(itemBg1);
			
			var itemAchievements:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("TownItemAchievements0000"));
			itemAchievements.x = itemBg1.x + 42;
			itemAchievements.y = itemBg1.y + 58;
			this.addChild(itemAchievements);
			
			// rankings image
			var itemBg2:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("TownItemBg0000"));
			itemBg2.x = itemBg1.bounds.right + gap;
			itemBg2.y = itemBg1.y;
			this.addChild(itemBg2);
			
			var itemRankings:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("TownItemRankings0000"));
			itemRankings.x = itemBg2.x + 37;
			itemRankings.y = itemBg2.y + 54;
			this.addChild(itemRankings);
			
			// my profile image
			var itemBg3:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("TownItemBg0000"));
			itemBg3.x = itemBg2.bounds.right + gap;
			itemBg3.y = itemBg1.y;
			this.addChild(itemBg3);
			
			var itemProfile:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("TownItemProfile0000"));
			itemProfile.x = itemBg3.x + 50;
			itemProfile.y = itemBg3.y + 53;
			this.addChild(itemProfile);
			
			// images second row
			// characters image
			var itemBg4:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("TownItemBg0000"));
			itemBg4.x = Statics.stageWidth / 2 - wrapperWidth / 2 + gap;
			itemBg4.y = itemBg1.bounds.bottom - 20;
			this.addChild(itemBg4);
			
			var itemCharacters:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("TownItemCharacters0000"));
			itemCharacters.x = itemBg4.x + 42;
			itemCharacters.y = itemBg4.y + 48;
			this.addChild(itemCharacters);
			
			// get coins image
			var itemBg5:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("TownItemBg0000"));
			itemBg5.x = itemBg4.bounds.right + gap;
			itemBg5.y = itemBg4.y;
			this.addChild(itemBg5);
			
			var itemCoins:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("TownItemCoins0000"));
			itemCoins.x = itemBg5.x + 48;
			itemCoins.y = itemBg5.y + 63;
			this.addChild(itemCoins);
			
			// get gems image
			var itemBg6:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("TownItemBg0000"));
			itemBg6.x = itemBg5.bounds.right + gap;
			itemBg6.y = itemBg4.y;
			this.addChild(itemBg6);
			
			var itemGems:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("TownItemGems0000"));
			itemGems.x = itemBg6.x + 44;
			itemGems.y = itemBg6.y + 46;
			this.addChild(itemGems);
			
			// buttons
			var ctaTextFormat:BitmapFontTextFormat = new BitmapFontTextFormat(Fonts.getBitmapFont("Materhorn25"));
			ctaTextFormat.size = 19;
			
			btnAchievements = new Button();
			btnAchievements.defaultSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("TownItemButton0000"));
			btnAchievements.hoverSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("TownItemButton0000"));
			btnAchievements.downSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("TownItemButton0000"));
			btnAchievements.hoverSkin.filter = Statics.btnBrightnessFilter;
			btnAchievements.downSkin.filter = Statics.btnInvertFilter;
			btnAchievements.useHandCursor = true;
			btnAchievements.addEventListener(Event.TRIGGERED, Menu(this.owner).showAchievementsScreen);
			this.addChild(btnAchievements);
			btnAchievements.x = itemBg1.x + 37;
			btnAchievements.y = itemBg1.y + 200;
			btnAchievements.defaultLabelProperties.textFormat = ctaTextFormat;
			btnAchievements.label = "Achievements";
			
			btnRankings = new Button();
			btnRankings.defaultSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("TownItemButton0000"));
			btnRankings.hoverSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("TownItemButton0000"));
			btnRankings.downSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("TownItemButton0000"));
			btnRankings.hoverSkin.filter = Statics.btnBrightnessFilter;
			btnRankings.downSkin.filter = Statics.btnInvertFilter;
			btnRankings.useHandCursor = true;
			btnRankings.addEventListener(Event.TRIGGERED, Menu(this.owner).showRankingsScreen);
			this.addChild(btnRankings);
			btnRankings.x = itemBg2.x + 37;
			btnRankings.y = itemBg2.y + 200;
			btnRankings.defaultLabelProperties.textFormat = ctaTextFormat;
			btnRankings.label = "Rankings";
			
			btnProfile = new Button();
			btnProfile.defaultSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("TownItemButton0000"));
			btnProfile.hoverSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("TownItemButton0000"));
			btnProfile.downSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("TownItemButton0000"));
			btnProfile.hoverSkin.filter = Statics.btnBrightnessFilter;
			btnProfile.downSkin.filter = Statics.btnInvertFilter;
			btnProfile.useHandCursor = true;
			btnProfile.addEventListener(Event.TRIGGERED, Menu(this.owner).showProfileScreen);
			this.addChild(btnProfile);
			btnProfile.x = itemBg3.x + 37;
			btnProfile.y = itemBg3.y + 200;
			btnProfile.defaultLabelProperties.textFormat = ctaTextFormat;
			btnProfile.label = "My Profile";
			
			btnCharacters = new Button();
			btnCharacters.defaultSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("TownItemButton0000"));
			btnCharacters.hoverSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("TownItemButton0000"));
			btnCharacters.downSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("TownItemButton0000"));
			btnCharacters.hoverSkin.filter = Statics.btnBrightnessFilter;
			btnCharacters.downSkin.filter = Statics.btnInvertFilter;
			btnCharacters.useHandCursor = true;
//			btnCharacters.addEventListener(Event.TRIGGERED, Menu(this.owner).showCharactersScreen);
			this.addChild(btnCharacters);
			btnCharacters.x = itemBg4.x + 37;
			btnCharacters.y = itemBg4.y + 200;
			btnCharacters.defaultLabelProperties.textFormat = ctaTextFormat;
			btnCharacters.label = "Characters";
			
			btnGetCoins = new Button();
			btnGetCoins.defaultSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("TownItemButton0000"));
			btnGetCoins.hoverSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("TownItemButton0000"));
			btnGetCoins.downSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("TownItemButton0000"));
			btnGetCoins.hoverSkin.filter = Statics.btnBrightnessFilter;
			btnGetCoins.downSkin.filter = Statics.btnInvertFilter;
			btnGetCoins.useHandCursor = true;
			btnGetCoins.addEventListener(Event.TRIGGERED, Menu(this.owner).showGetCoinsScreen);
			this.addChild(btnGetCoins);
			btnGetCoins.x = itemBg5.x + 37;
			btnGetCoins.y = itemBg5.y + 200;
			btnGetCoins.defaultLabelProperties.textFormat = ctaTextFormat;
			btnGetCoins.label = "Get Coins";
			
			btnGetGems = new Button();
			btnGetGems.defaultSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("TownItemButton0000"));
			btnGetGems.hoverSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("TownItemButton0000"));
			btnGetGems.downSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("TownItemButton0000"));
			btnGetGems.hoverSkin.filter = Statics.btnBrightnessFilter;
			btnGetGems.downSkin.filter = Statics.btnInvertFilter;
			btnGetGems.useHandCursor = true;
			btnGetGems.addEventListener(Event.TRIGGERED, Menu(this.owner).showGetGemsScreen);
			this.addChild(btnGetGems);
			btnGetGems.x = itemBg6.x + 37;
			btnGetGems.y = itemBg6.y + 200;
			btnGetGems.defaultLabelProperties.textFormat = ctaTextFormat;
			btnGetGems.label = "Get Gems";
		}
	}
}