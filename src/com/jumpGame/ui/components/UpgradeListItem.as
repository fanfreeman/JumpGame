package com.jumpGame.ui.components
{
	import com.jumpGame.customObjects.Font;
	import com.jumpGame.ui.screens.ScreenUpgrades;
	
	import feathers.controls.Button;
	import feathers.controls.ProgressBar;

	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class UpgradeListItem extends Sprite
	{
		private var parent:ScreenUpgrades;
		private var data:Object;
		private var progress:ProgressBar;
		private var btnAction:Button;
		private var priceLabel:TextField;
		private var subtitle:TextField;
		private var coinAnimation:MovieClip;
		
		public function UpgradeListItem(parent:ScreenUpgrades, data:Object = null)
		{
			super();
			this.height = 80;
			this.parent = parent;
			this.data = data;
			this.createElements();
		}
		
		private function createElements():void {
			// bg quad
			var scrollQuad:Quad = new Quad(640, 80, 0xffffff);
			scrollQuad.pivotX = Math.ceil(scrollQuad.width / 2);
			addChild(scrollQuad);
			
			// icon
			var iconQuad:Quad = new Quad(80, 80, 0xff0000);
			iconQuad.x = -Math.ceil(scrollQuad.width / 2)
			addChild(iconQuad);
			
			// label line 1
			var fontVerdana23:Font = Fonts.getFont("Verdana23");
			var title:TextField = new TextField(370, 25, this.data.title, fontVerdana23.fontName, fontVerdana23.fontSize, 0x873623);
			title.hAlign = HAlign.LEFT;
			title.vAlign = VAlign.TOP;
			title.x = iconQuad.bounds.right + 10;
			title.y = 10;
			addChild(title);
			
			// label line 2
			var fontVerdana14:Font = Fonts.getFont("Verdana14");
			subtitle = new TextField(370, 20, "", fontVerdana14.fontName, fontVerdana14.fontSize, 0x873623);
			subtitle.hAlign = HAlign.LEFT;
			subtitle.vAlign = VAlign.TOP;
			subtitle.x = iconQuad.bounds.right + 10;
			subtitle.y = title.bounds.bottom + 2;
			addChild(subtitle);
			
			// progress bar
			progress = new ProgressBar();
			progress.minimum = 0;
			progress.maximum = this.data.totalProgress;
			progress.width = 380;
			progress.height = 10;
			progress.x = subtitle.x;
			progress.y = subtitle.bounds.bottom + 2;
			this.addChild(progress);
			
			// price
			priceLabel = new TextField(130, 25, "0", fontVerdana23.fontName, fontVerdana23.fontSize, 0x873623);
			priceLabel.hAlign = HAlign.RIGHT;
			priceLabel.vAlign = VAlign.TOP;
			priceLabel.pivotX = Math.ceil(priceLabel.width);
			priceLabel.x = Math.ceil(scrollQuad.width / 2) - 10;
			priceLabel.y = 10;
			addChild(priceLabel);
			
			// action button
			btnAction = new Button();
			btnAction.width = 130;
			btnAction.height = 34;
			btnAction.pivotX = Math.ceil(btnAction.width);
			btnAction.x = Math.ceil(scrollQuad.width / 2) - 10;
			btnAction.y = priceLabel.bounds.bottom;
			btnAction.label = "Upgrade";
			btnAction.addEventListener(Event.TRIGGERED, this.data.handler);
			addChild(btnAction);
			
			// price coin graphic
			coinAnimation = new MovieClip(Assets.getSprite("AtlasTexturePlatforms").getTextures("Coin"), 40);
			coinAnimation.scaleX = 0.5;
			coinAnimation.scaleY = 0.5;
			coinAnimation.x = btnAction.bounds.left;
			coinAnimation.y = priceLabel.bounds.top - 5;
			this.addChild(coinAnimation);
		}
		
		public function refreshProperties(progressValue:uint, price:String, subtitle:String):void {
			// update progress bar
			this.progress.value = progressValue;
			if (progressValue >= this.data.totalProgress) { // hide button if fully upgraded
				this.btnAction.visible = false;
				this.priceLabel.text = "";
				this.subtitle.text = "Max rank reached. Woohoo!";
				this.coinAnimation.visible = false;
			} else {
				// upgrade price
				this.priceLabel.text = price;
				
				// upgrade subtitle
				this.subtitle.text = subtitle;
			}
		}
	}
}