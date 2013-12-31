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
	
	public class DialogBox extends Sprite
	{
		public var isInUse:Boolean = false;
		
		private var data:Object;
		private var promptText:TextField;
		
		private var btnOk:Button;
		private var btnCancel:Button;
		
		private var popupContainer:Sprite;
		
		private var callback:Function = null;
		
		public function DialogBox()
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
			var popup:Image = new Image(Statics.assets.getTexture("PromptBg0000"));
			popupContainer.addChild(popup);
			popupContainer.pivotX = Math.ceil(popupContainer.width / 2);
			popupContainer.pivotY = Math.ceil(popupContainer.height / 2);
			popupContainer.x = Statics.stageWidth / 2;
			popupContainer.y = Statics.stageHeight / 2;
			this.addChild(popupContainer);
			
			// prompt
			var font:Font = Fonts.getFont("BellGothicBlack25");
			promptText = new TextField(popup.width - 160, 100, "", font.fontName, font.fontSize, 0x9B4B16);
			promptText.hAlign = HAlign.CENTER;
			promptText.vAlign = VAlign.TOP;
			promptText.pivotX = Math.ceil(promptText.width / 2);
			promptText.x = Math.ceil(popupContainer.width / 2);
			promptText.y = 50;
			popupContainer.addChild(promptText);
			
			// cancel button
			btnCancel = new Button();
			btnCancel.defaultSkin = new Image(Statics.assets.getTexture("PromptButtonCancel0000"));
			btnCancel.hoverSkin = new Image(Statics.assets.getTexture("PromptButtonCancel0000"));
			btnCancel.downSkin = new Image(Statics.assets.getTexture("PromptButtonCancel0000"));
			btnCancel.hoverSkin.filter = Statics.btnBrightnessFilter;
			btnCancel.downSkin.filter = Statics.btnInvertFilter;
			btnCancel.useHandCursor = true;
			btnCancel.x = 86;
			btnCancel.y = 180;
			btnCancel.addEventListener(Event.TRIGGERED, buttonCancelHandler);
			popupContainer.addChild(btnCancel);
			
			// ok button
			btnOk = new Button();
			btnOk.defaultSkin = new Image(Statics.assets.getTexture("PromptButtonOk0000"));
			btnOk.hoverSkin = new Image(Statics.assets.getTexture("PromptButtonOk0000"));
			btnOk.downSkin = new Image(Statics.assets.getTexture("PromptButtonOk0000"));
			btnOk.hoverSkin.filter = Statics.btnBrightnessFilter;
			btnOk.downSkin.filter = Statics.btnInvertFilter;
			btnOk.useHandCursor = true;
			btnOk.x = popupContainer.width - 207;
			btnOk.y = 180;
			btnOk.addEventListener(Event.TRIGGERED, buttonOkHandler);
			popupContainer.addChild(btnOk);
		}
		
		public function show(promptString:String, callbackFunction:Function):void {
			if (this.isInUse) return;
			this.isInUse = true;
			this.visible = true;
			this.promptText.text = promptString;
			this.callback = callbackFunction;
			
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
//			if (!Sounds.sfxMuted) Sounds.sndClick.play();
			
			if (this.callback != null) {
				this.callback();
			}
			this.visible = false;
			this.isInUse = false;
		}
		
		private function buttonCancelHandler(event:Event):void {
			if (!Sounds.sfxMuted) Statics.assets.playSound("SND_CLICK");
			
			this.visible = false;
			this.isInUse = false;
		}
	}
}