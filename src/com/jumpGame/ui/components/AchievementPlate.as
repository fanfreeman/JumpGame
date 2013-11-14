package com.jumpGame.ui.components
{
	import com.jumpGame.customObjects.Font;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class AchievementPlate extends Sprite
	{
		private var title:TextField;
		private var description:TextField;
		private var checkmark:Image;
		public var coin:MovieClip;
		private var coinAmountText:TextField;
		
		public function AchievementPlate()
		{
			this.createElements();
		}
		
		private function createElements():void {
			var fontMaterhorn24:Font = Fonts.getFont("Materhorn24");
			var fontMaterhorn25:Font = Fonts.getFont("Materhorn25");
			var fontBellGothicBlack13:Font = Fonts.getFont("BellGothicBlack13");
			var plateHeight:Number = 50;
			
			// checkbox
			var checkbox:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("GameOverCheckbox0000"));
			checkbox.y = (plateHeight - checkbox.height) / 2 + 2;
			addChild(checkbox);
			
			// objective title
			title = new TextField(240, 28, "Bouncy", fontMaterhorn24.fontName, fontMaterhorn24.fontSize, 0xffffff);
			title.vAlign = VAlign.CENTER;
			title.hAlign = HAlign.LEFT;
			title.x = checkbox.bounds.right + 25;
			addChild(title);
			
			// objective description
			description = new TextField(240, plateHeight * 1 / 3, "Jump 1000 meters in one game", fontBellGothicBlack13.fontName, fontBellGothicBlack13.fontSize, 0xc89a07);
			description.vAlign = VAlign.CENTER;
			description.hAlign = HAlign.LEFT;
			description.x = title.x;
			description.y = title.bounds.bottom;
			addChild(description);
			
			// checkmark
			checkmark = new Image(Assets.getSprite("AtlasTexture4").getTexture("GameOverCheckmark0000"));
			checkmark.x = 3;
			checkmark.y = (plateHeight - checkmark.height) / 2;
			checkmark.visible = false;
			addChild(checkmark);
			
			// coin reward
			// coin animation
			coin = new MovieClip(Assets.getSprite("AtlasTexturePlatforms").getTextures("Coin"), 40);
			coin.pivotX = Math.ceil(coin.width / 2);
			coin.pivotY = Math.ceil(coin.height / 2);
			coin.rotation = -Math.PI / 8;
			coin.x = title.bounds.right + coin.width / 2 + 30;
			coin.y = plateHeight / 2;
			starling.core.Starling.juggler.add(coin);
			addChild(coin);
			// amount text
			coinAmountText = new TextField(100, plateHeight, "0", fontMaterhorn25.fontName, fontMaterhorn25.fontSize, 0xffffff);
			coinAmountText.vAlign = VAlign.CENTER;
			coinAmountText.hAlign = HAlign.RIGHT;
			coinAmountText.x = coin.x;
			addChild(coinAmountText);
		}
		
		public function initialize(title:String, description:String, coinReward:uint, gemReward:uint):void {
			this.title.text = title;
			this.description.text = description;
			this.coinAmountText.text = String(coinReward);
		}
		
		public function check():void {
			checkmark.visible = true;
		}
		
		public function uncheck():void {
			checkmark.visible = false;
		}
	}
}