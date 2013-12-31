package com.jumpGame.ui.popups
{
	import com.jumpGame.events.NavigationEvent;
	import com.jumpGame.screens.Menu;
	
	import feathers.controls.Button;
	
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Instructions extends Sprite
	{
		private var parent:Menu;
		private var btnNext:Button;
		private var popupContainer:Sprite;
		
		public function Instructions(parent:Menu)
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
			bg.alpha = 0.2;
			this.addChild(bg);
			
			popupContainer = new Sprite();
			
			// popup artwork
			var popup:Image = new Image(Statics.assets.getTexture("InstructionsBg0000"));
			popupContainer.addChild(popup);
			popupContainer.pivotX = Math.ceil(popupContainer.width / 2);
			popupContainer.pivotY = Math.ceil(popupContainer.height / 2);
			popupContainer.x = Statics.stageWidth / 2;
			popupContainer.y = Statics.stageHeight / 2;
			this.addChild(popupContainer);
			
			// popup close button
			var buttonClose:Button = new Button();
			buttonClose.defaultSkin = new Image(Statics.assets.getTexture("ButtonPopupClose0000"));
			buttonClose.hoverSkin = new Image(Statics.assets.getTexture("ButtonPopupClose0000"));
			buttonClose.downSkin = new Image(Statics.assets.getTexture("ButtonPopupClose0000"));
			buttonClose.hoverSkin.filter = Statics.btnBrightnessFilter;
			buttonClose.downSkin.filter = Statics.btnInvertFilter;
			buttonClose.useHandCursor = true;
			buttonClose.addEventListener(Event.TRIGGERED, buttonCloseHandler);
			popupContainer.addChild(buttonClose);
			buttonClose.validate();
			buttonClose.pivotX = buttonClose.width;
			buttonClose.x = popup.bounds.right - 26;
			buttonClose.y = popup.bounds.top + 75;
			
			// next button
			btnNext = new Button();
			btnNext.defaultSkin = new Image(Statics.assets.getTexture("InstructionsBtnNext0000"));
			btnNext.hoverSkin = new Image(Statics.assets.getTexture("InstructionsBtnNext0000"));
			btnNext.downSkin = new Image(Statics.assets.getTexture("InstructionsBtnNext0000"));
			btnNext.hoverSkin.filter = Statics.btnBrightnessFilter;
			btnNext.downSkin.filter = Statics.btnInvertFilter;
			btnNext.useHandCursor = true;
			btnNext.x = popupContainer.width - 180;
			btnNext.y = popupContainer.height - 180;
			btnNext.addEventListener(Event.TRIGGERED, buttonNextHandler);
			popupContainer.addChild(btnNext);
		}
		
		public function show():void {
			this.visible = true;
			
			// popup pop out effect
			popupContainer.scaleX = 0.5;
			popupContainer.scaleY = 0.5;
			Starling.juggler.tween(popupContainer, 0.5, {
				transition: Transitions.EASE_OUT_ELASTIC,
				scaleX: 1,
				scaleY: 1
			});
		}
		
		private function buttonNextHandler(event:Event):void {
			if (!Sounds.sfxMuted) Statics.assets.playSound("SND_START");
			this.parent.hideTutorialPointer();
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "play"}, true));
			this.visible = false;
		}
		
		private function buttonCloseHandler(event:Event):void {
			if (!Sounds.sfxMuted) Statics.assets.playSound("SND_START");
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "play"}, true));
			this.visible = false;
		}
	}
}