package com.jumpGame.ui.popups
{
	import com.jumpGame.customObjects.Font;
	import com.jumpGame.screens.Menu;
	
	import feathers.controls.Button;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class DialogBox extends Sprite
	{
		private var parent:Menu;
		private var data:Object;
		private var promptText:TextField;
		
		// one button dialog
		private var btnClose:Button;
		
		// two button dialog
		private var btnOk:Button;
		private var btnCancel:Button;
		
		public function DialogBox(parent:Menu)
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
			bg.alpha = 0.01;
			this.addChild(bg);
			
			// scroll dialog artwork
			var scrollTop:Image = new Image(Assets.getSprite("AtlasTexture2").getTexture("ScrollLongTop0000"));
			scrollTop.pivotX = Math.ceil(scrollTop.texture.width / 2);
			scrollTop.scaleX = 0.6;
			scrollTop.scaleY = 0.6;
			scrollTop.x = stage.stageWidth / 2;
			scrollTop.y = 160;
			this.addChild(scrollTop);
			
			var scrollBottom:Image = new Image(Assets.getSprite("AtlasTexture2").getTexture("ScrollLongBottom0000"));
			scrollBottom.pivotX = Math.ceil(scrollBottom.texture.width / 2);
			scrollBottom.pivotY = scrollBottom.texture.height;
			scrollBottom.scaleX = 0.6;
			scrollBottom.scaleY = 0.6;
			scrollBottom.x = stage.stageWidth / 2;
			scrollBottom.y = stage.stageHeight - 250;
			this.addChild(scrollBottom);
			
			var scrollQuad:Quad = new Quad(scrollTop.width - 32, scrollBottom.bounds.bottom - scrollTop.bounds.top, 0xf1b892);
			scrollQuad.pivotX = Math.ceil(scrollQuad.width / 2);
			scrollQuad.x = stage.stageWidth / 2;
			scrollQuad.y = scrollTop.bounds.top;
			addChild(scrollQuad);
			setChildIndex(scrollQuad, this.getChildIndex(scrollTop));
			// eof scroll dialog artwork
			
			// prompt
			var fontVerdana23:Font = Fonts.getFont("Verdana23");
			promptText = new TextField(scrollQuad.width - 10, 60, "", fontVerdana23.fontName, fontVerdana23.fontSize, 0x873623);
			promptText.hAlign = HAlign.CENTER;
			promptText.vAlign = VAlign.TOP;
			promptText.pivotX = Math.ceil(promptText.width / 2);
			promptText.x = stage.stageWidth / 2;
			promptText.y = scrollTop.bounds.bottom + 30;
			addChild(promptText);
			
			// close button
			btnClose = new Button();
			btnClose.width = 200;
			btnClose.height = 40;
			btnClose.pivotX = Math.ceil(btnClose.width / 2);
			btnClose.pivotY = btnClose.height;
			btnClose.x = stage.stageWidth / 2;
			btnClose.y = scrollBottom.bounds.top - 20;
			btnClose.label = "Close";
			btnClose.addEventListener(Event.TRIGGERED, Menu(this.parent).dialogCloseHandler);
			addChild(btnClose);
			
			// cancel button
			btnCancel = new Button();
			btnCancel.width = 150;
			btnCancel.height = 40;
			btnCancel.pivotX = Math.ceil(btnCancel.width);
			btnCancel.pivotY = btnCancel.height;
			btnCancel.x = stage.stageWidth / 2 - 15;
			btnCancel.y = scrollBottom.bounds.top - 20;
			btnCancel.label = "Cancel";
			btnCancel.addEventListener(Event.TRIGGERED, Menu(this.parent).dialogCancelHandler);
			btnCancel.visible = false;
			addChild(btnCancel);
			
			// ok button
			btnOk = new Button();
			btnOk.width = 150;
			btnOk.height = 40;
			btnOk.pivotY = btnOk.height;
			btnOk.x = stage.stageWidth / 2 + 15;
			btnOk.y = scrollBottom.bounds.top - 20;
			btnOk.label = "OK";
			btnOk.visible = false;
			addChild(btnOk);
		}
		
		public function show(promptString:String, isTwoButton:Boolean, callbackFunction):void {
			this.visible = true;
			this.promptText.text = promptString;
			if (isTwoButton) {
				btnCancel.visible = true;
				btnOk.visible = true;
				btnClose.visible = false;
				btnOk.addEventListener(Event.TRIGGERED, callbackFunction);
			} else {
				btnClose.visible = true;
				btnCancel.visible = false;
				btnOk.visible = false;
				
			}
		}
		
		public function removeOkButtonListeners():void {
			btnOk.removeEventListeners(Event.TRIGGERED);
		}
	}
}