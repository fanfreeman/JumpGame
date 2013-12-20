package com.jumpGame.ui.popups
{
	import com.jumpGame.customObjects.Font;
	import com.jumpGame.screens.Menu;
	
	import feathers.controls.Button;
	import feathers.text.BitmapFontTextFormat;
	
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class ScreenStory extends Sprite
	{
		private var parent:Menu;
		private var popupContainer:Sprite;
		private var story1:TextField;
		private var story2:TextField;
		private var story3:TextField;
		private var story4:TextField;
		private var story5:TextField;
		private var btnEllipsis:Button;
		private var btnNext:Button;
		private var page:uint;
		
		public function ScreenStory(parent:Menu)
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
			
			popupContainer = new Sprite();
			
			// popup artwork
			var popup:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("PopupLarge0000"));
			popupContainer.addChild(popup);
			popupContainer.pivotX = Math.ceil(popupContainer.width / 2);
			popupContainer.pivotY = Math.ceil(popupContainer.height / 2);
			popupContainer.x = Statics.stageWidth / 2;
			popupContainer.y = Statics.stageHeight / 2;
			this.addChild(popupContainer);
			
			// popup header
//			var popupHeader:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("PopupHeaderAchievements0000"));
//			popupHeader.pivotX = Math.ceil(popupHeader.width / 2);
//			popupHeader.x = popupContainer.width / 2;
//			popupHeader.y = popup.bounds.top + 26;
//			popupContainer.addChild(popupHeader);
			
			// popup close button
			var buttonClose:Button = new Button();
			buttonClose.defaultSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ButtonPopupClose0000"));
			buttonClose.hoverSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ButtonPopupClose0000"));
			buttonClose.downSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ButtonPopupClose0000"));
			buttonClose.hoverSkin.filter = Statics.btnBrightnessFilter;
			buttonClose.downSkin.filter = Statics.btnInvertFilter;
			buttonClose.useHandCursor = true;
			buttonClose.addEventListener(Event.TRIGGERED, buttonCloseHandler);
			popupContainer.addChild(buttonClose);
			buttonClose.validate();
			buttonClose.pivotX = buttonClose.width;
			buttonClose.x = popup.bounds.right - 25;
			buttonClose.y = popup.bounds.top + 28;
			
			var fontMessage:Font = Fonts.getFont("Materhorn25");
			story1 = new TextField(popup.width - 200, 80, "", fontMessage.fontName, fontMessage.fontSize, 0xffffff);
			story1.alpha = 0;
			story1.pivotX = Math.ceil(story1.width / 2);
			story1.x = Math.ceil(popupContainer.width / 2);
			story1.y = 100;
			story1.hAlign = HAlign.CENTER;
			story1.vAlign = VAlign.TOP;
			popupContainer.addChild(story1);
			
			story2 = new TextField(popup.width - 200, 80, "", fontMessage.fontName, fontMessage.fontSize, 0xffffff);
			story2.alpha = 0;
			story2.pivotX = Math.ceil(story2.width / 2);
			story2.x = Math.ceil(popupContainer.width / 2);
			story2.y = story1.y + story1.height;
			story2.hAlign = HAlign.CENTER;
			story2.vAlign = VAlign.TOP;
			popupContainer.addChild(story2);
			
			story3 = new TextField(popup.width - 200, 80, "", fontMessage.fontName, fontMessage.fontSize, 0xffffff);
			story3.alpha = 0;
			story3.pivotX = Math.ceil(story3.width / 2);
			story3.x = Math.ceil(popupContainer.width / 2);
			story3.y = story2.y + story2.height;
			story3.hAlign = HAlign.CENTER;
			story3.vAlign = VAlign.TOP;
			popupContainer.addChild(story3);
			
			story4 = new TextField(popup.width - 200, 80, "", fontMessage.fontName, fontMessage.fontSize, 0xffffff);
			story4.alpha = 0;
			story4.pivotX = Math.ceil(story4.width / 2);
			story4.x = Math.ceil(popupContainer.width / 2);
			story4.y = story3.y + story3.height;
			story4.hAlign = HAlign.CENTER;
			story4.vAlign = VAlign.TOP;
			popupContainer.addChild(story4);
			
			story5 = new TextField(popup.width - 200, 80, "", fontMessage.fontName, fontMessage.fontSize, 0xffffff);
			story5.alpha = 0;
			story5.pivotX = Math.ceil(story5.width / 2);
			story5.x = Math.ceil(popupContainer.width / 2);
			story5.y = story4.y + story4.height;
			story5.hAlign = HAlign.CENTER;
			story5.vAlign = VAlign.TOP;
			popupContainer.addChild(story5);
			
			// ellipsis button
			var ctaTextFormat:BitmapFontTextFormat = new BitmapFontTextFormat(Fonts.getBitmapFont("Materhorn25"));
			ctaTextFormat.size = 19;
			
			btnEllipsis = new Button();
			btnEllipsis.defaultSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("TownItemButton0000"));
			btnEllipsis.hoverSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("TownItemButton0000"));
			btnEllipsis.downSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("TownItemButton0000"));
			btnEllipsis.hoverSkin.filter = Statics.btnBrightnessFilter;
			btnEllipsis.downSkin.filter = Statics.btnInvertFilter;
			btnEllipsis.useHandCursor = true;
			btnEllipsis.x = Math.ceil(popup.width / 2) - 77;
			btnEllipsis.y = popup.bounds.bottom - 57;
			popupContainer.addChild(btnEllipsis);
			btnEllipsis.addEventListener(Event.TRIGGERED, buttonEllipsisHandler);
			btnEllipsis.defaultLabelProperties.textFormat = ctaTextFormat;
			btnEllipsis.label = "...";
			
			// next button
			btnNext = new Button();
			btnNext.defaultSkin = new Image(Assets.getSprite("AtlasTexture8").getTexture("InstructionsBtnNext0000"));
			btnNext.hoverSkin = new Image(Assets.getSprite("AtlasTexture8").getTexture("InstructionsBtnNext0000"));
			btnNext.downSkin = new Image(Assets.getSprite("AtlasTexture8").getTexture("InstructionsBtnNext0000"));
			btnNext.hoverSkin.filter = Statics.btnBrightnessFilter;
			btnNext.downSkin.filter = Statics.btnInvertFilter;
			btnNext.useHandCursor = true;
			btnNext.x = Math.ceil(popup.width / 2) - 64;
			btnNext.y = popup.bounds.bottom - 60;
			popupContainer.addChild(btnNext);
			btnNext.addEventListener(Event.TRIGGERED, buttonNextHandler);
		}
		
		public function initialize():void {
			btnNext.visible = false;
			this.page = 1;
			
			story1.text = "A long long time ago, in a galaxy far, far away...";
			story2.text = "There was a dear little girl, pretty and dainty";
			story3.text = "One frigid winter, when she was selling matches in the freezing cold, she met a boy";
			story4.text = "They fell in love, and years later, a sweet baby was born";
			story5.text = "The baby had a lightning shaped scar. They call him 'the chosen one'";
			
			this.visible = true;
			
			// popup pop out effect
			popupContainer.scaleX = 0.5;
			popupContainer.scaleY = 0.5;
			Starling.juggler.tween(popupContainer, 0.5, {
				transition: Transitions.EASE_OUT_ELASTIC,
				scaleX: 1,
				scaleY: 1
			});
			
			this.fadeInStoryTexts();
		}
		
		private function fadeInStoryTexts():void {
			this.btnNext.visible = false;
			this.btnEllipsis.visible = true;
			
			Starling.juggler.removeTweens(story1);
			Starling.juggler.removeTweens(story2);
			Starling.juggler.removeTweens(story3);
			Starling.juggler.removeTweens(story4);
			Starling.juggler.removeTweens(story5);
			story1.alpha = 0;
			story2.alpha = 0;
			story3.alpha = 0;
			story4.alpha = 0;
			story5.alpha = 0;
			
			Starling.juggler.tween(story1, 2, {
				transition: Transitions.LINEAR,
				alpha: 1
			});
			Starling.juggler.tween(story2, 2, {
				delay: 4,
				transition: Transitions.LINEAR,
				alpha: 1
			});
			Starling.juggler.tween(story3, 2, {
				delay: 8,
				transition: Transitions.LINEAR,
				alpha: 1
			});
			Starling.juggler.tween(story4, 2, {
				delay: 12,
				transition: Transitions.LINEAR,
				alpha: 1
			});
			Starling.juggler.tween(story5, 2, {
				delay: 16,
				transition: Transitions.LINEAR,
				alpha: 1,
				onComplete: showButtonNext
			});
		}
		
		private function showButtonNext():void {
			this.btnEllipsis.visible = false;
			this.btnNext.visible = true;
		}
		
		private function buttonEllipsisHandler():void {
			Starling.juggler.removeTweens(story1);
			Starling.juggler.removeTweens(story2);
			Starling.juggler.removeTweens(story3);
			Starling.juggler.removeTweens(story4);
			Starling.juggler.removeTweens(story5);
			story1.alpha = 1;
			story2.alpha = 1;
			story3.alpha = 1;
			story4.alpha = 1;
			story5.alpha = 1;
			
			this.showButtonNext();
		}
		
		private function buttonNextHandler():void {
			if (!Sounds.sfxMuted) Sounds.sndClick.play();
			
			if (this.page == 1) {
				story1.text = "I know what you are thinking. No, this is not that story";
				story2.text = "Anyway, when the baby grew up, he built himself a great wooden boat";
				story3.text = "... and saved three hudred squirrels from imminent doom";
				story4.text = "And with the company of his trusty friends, they went on a distant journey to destroy an object of immense evil";
				story5.text = "Clad in green, our hero fought valiantly";
				this.fadeInStoryTexts();
				this.page = 2;
			}
			else if (this.page == 2) {
				story1.text = "... and they save the world. Eight hundred twenty five times";
				story2.text = "What a moving story";
				story3.text = "... but it's got absolutely nothing to do with us";
				story4.text = "... sorry about that ...";
				story5.text = "Let's start jumping already!";
				this.fadeInStoryTexts();
				this.page = 3;
			}
			else if (this.page == 3) {
				this.visible = false;
				parent.showTutorialPlay();
			}
		}
		
		private function buttonCloseHandler(event:Event):void {
			if (!Sounds.sfxMuted) Sounds.sndClick.play();
			
			this.visible = false;
			parent.showTutorialPlay();
		}
	}
}