package com.jumpGame.ui.popups
{
	import com.jumpGame.customObjects.Font;
	
	import feathers.controls.Button;
	
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class DialogLarge extends Sprite
	{
		private var data:Object;
		private var promptText:TextField;
		private var btnOk:Button;
		private var popupContainer:Sprite;
		
		public function DialogLarge()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			// bg quad
			var bg:Quad = new Quad(stage.stageWidth, stage.stageHeight, 0x000000);
			bg.alpha = 0.2;
			this.addChild(bg);
			
			popupContainer = new Sprite();
			
			// popup artwork
			var popup:Image = new Image(Assets.getSprite("AtlasTexture8").getTexture("DialogLarge0000"));
			popupContainer.addChild(popup);
			popupContainer.pivotX = Math.ceil(popupContainer.width / 2);
			popupContainer.pivotY = Math.ceil(popupContainer.height / 2);
			popupContainer.x = Statics.stageWidth / 2;
			popupContainer.y = Statics.stageHeight / 2;
			this.addChild(popupContainer);
			
			// prompt
			var font:Font = Fonts.getFont("BellGothicBlack25");
			promptText = new TextField(popup.width - 200, 150, "", font.fontName, font.fontSize, 0x9B4B16);
			promptText.hAlign = HAlign.CENTER;
			promptText.vAlign = VAlign.TOP;
			promptText.pivotX = Math.ceil(promptText.width / 2);
			promptText.x = Math.ceil(popupContainer.width / 2);
			promptText.y = 70;
			popupContainer.addChild(promptText);
			
			// ok button
			btnOk = new Button();
			var btnImage:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("PromptButtonOk0000"));
			btnOk.defaultSkin = btnImage;
			btnOk.hoverSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("PromptButtonOk0000"));
			btnOk.downSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("PromptButtonOk0000"));
			btnOk.hoverSkin.filter = Statics.btnBrightnessFilter;
			btnOk.downSkin.filter = Statics.btnInvertFilter;
			btnOk.useHandCursor = true;
			btnOk.pivotX = Math.ceil(btnImage.width / 2);
			btnOk.x = popup.width / 2;
			btnOk.y = popup.height - 85;
			btnOk.addEventListener(Event.TRIGGERED, buttonOkHandler);
			popupContainer.addChild(btnOk);
		}
		
		public function show(promptString:String):void {
			this.visible = true;
			this.promptText.text = promptString;
			
			// popup pop out effect
			popupContainer.scaleX = 0.5;
			popupContainer.scaleY = 0.5;
			Starling.juggler.tween(popupContainer, 0.5, {
				transition: Transitions.EASE_OUT_ELASTIC,
				scaleX: 1,
				scaleY: 1
			});
		}
		
		private function buttonOkHandler(event:Event):void {
			if (!Sounds.sfxMuted) Sounds.sndClick.play();
			this.visible = false;
		}
	}
}