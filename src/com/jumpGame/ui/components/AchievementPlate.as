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
		private var checkmarkAnimation:MovieClip;
		public var coin:MovieClip;
		
		public function AchievementPlate()
		{
			this.createElements();
		}
		
		private function createElements():void {
			var fontLithos42:Font = Fonts.getFont("Lithos42");
			var fontVerdana23:Font = Fonts.getFont("Verdana23");
			
			// checkbox
			var checkbox:Image = new Image(Assets.getSprite("AtlasTexture2").getTexture("Checkbox0000"));
			addChild(checkbox);
			
			// objective title
			title = new TextField(300, 45, "Bouncy", fontLithos42.fontName, fontLithos42.fontSize, 0xffdd1e);
			title.vAlign = VAlign.TOP;
			title.hAlign = HAlign.LEFT;
			title.x = checkbox.bounds.right;
			title.y = 15;
			addChild(title);
			
			// objective description
			description = new TextField(300, 40, "Jump 1000 meters in one game", fontVerdana23.fontName, fontVerdana23.fontSize, 0xffffff);
			description.vAlign = VAlign.TOP;
			description.hAlign = HAlign.LEFT;
			description.x = checkbox.bounds.right + 5;
			description.y = title.bounds.bottom - 5;
			addChild(description);
			
			// checkmark
			checkmarkAnimation = new MovieClip(Assets.getSprite("AtlasTexture2").getTextures("Checkmark"), 40);
			checkmarkAnimation.x = 15;
			checkmarkAnimation.y = -10;
			checkmarkAnimation.loop = false;
			checkmarkAnimation.visible = false;
			checkmarkAnimation.stop();
			starling.core.Starling.juggler.add(checkmarkAnimation);
			addChild(checkmarkAnimation);
			
			// coin reward
			// coin animation
			coin = new MovieClip(Assets.getSprite("AtlasTexturePlatforms").getTextures("Coin"), 40);
			coin.pivotY = Math.ceil(coin.height / 2);
			coin.x = title.bounds.right;
			coin.y = (checkbox.bounds.top + checkbox.bounds.bottom) / 2;
			starling.core.Starling.juggler.add(coin);
			addChild(coin);
			// amount text
			var coinAmountText:TextField = new TextField(100, coin.height, "100", fontLithos42.fontName, fontLithos42.fontSize, 0xffffff);
			coinAmountText.vAlign = VAlign.CENTER;
			coinAmountText.hAlign = HAlign.LEFT;
			coinAmountText.x = coin.bounds.right - 10;
			coinAmountText.y = coin.bounds.top;
			addChild(coinAmountText);
		}
		
		public function initialize(title:String, description:String):void {
			this.title.text = title;
			this.description.text = description;
		}
		
		public function check():void {
			checkmarkAnimation.visible = true;
			checkmarkAnimation.stop();
			checkmarkAnimation.play();
		}
		
		public function uncheck():void {
			checkmarkAnimation.visible = false;
		}
	}
}