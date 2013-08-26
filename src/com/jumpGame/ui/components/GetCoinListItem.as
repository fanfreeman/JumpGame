package com.jumpGame.ui.components
{
	import com.jumpGame.customObjects.Font;
	
	import feathers.controls.Button;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class GetCoinListItem extends Sprite
	{
		private var data:Object;
		private var btnAction:Button;
		private var priceLabel:TextField;
		private var subtitle:TextField;
		
		public function GetCoinListItem(data:Object = null)
		{
			super();
			this.height = 80;
			this.data = data;
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function addedToStageHandler(event:Event):void
		{
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
			subtitle = new TextField(370, 20, this.data.subtitle, fontVerdana14.fontName, fontVerdana14.fontSize, 0x873623);
			subtitle.hAlign = HAlign.LEFT;
			subtitle.vAlign = VAlign.TOP;
			subtitle.x = iconQuad.bounds.right + 10;
			subtitle.y = title.bounds.bottom + 2;
			addChild(subtitle);
			
			// price
			priceLabel = new TextField(130, 25, this.data.price, fontVerdana23.fontName, fontVerdana23.fontSize, 0x873623);
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
			btnAction.label = "Buy";
			btnAction.addEventListener(Event.TRIGGERED, this.data.handler);
			addChild(btnAction);
			
//			// price coin graphic
//			var coinAnimation:MovieClip = new MovieClip(Assets.getSprite("AtlasTexturePlatforms").getTextures("Coin"), 40);
//			coinAnimation.scaleX = 0.5;
//			coinAnimation.scaleY = 0.5;
//			coinAnimation.x = btnAction.bounds.left;
//			coinAnimation.y = priceLabel.bounds.top - 5;
//			starling.core.Starling.juggler.add(coinAnimation);
//			this.addChild(coinAnimation);
		}
	}
}