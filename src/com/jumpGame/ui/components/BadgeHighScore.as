package com.jumpGame.ui.components
{
	import com.jumpGame.customObjects.Font;
	
	import flash.external.ExternalInterface;
	
	import feathers.controls.Button;
	
	import starling.animation.IAnimatable;
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	import starling.utils.deg2rad;
	
	public class BadgeHighScore extends Sprite implements IAnimatable
	{
		private var badgeHighScore:Image;
		private var raysHighScore:Image;
		private var promptText:TextField;
		private var btnOk:Button;
		private var btnCancel:Button;
		private var popupContainer:Sprite;
		private var distance:int;
		private var score:int;
		
		public function BadgeHighScore()
		{
			super();
			
			// bg quad
			var bg:Quad = new Quad(Statics.stageWidth, Statics.stageHeight, 0x000000);
			bg.alpha = 0.5;
			this.addChild(bg);
			
			raysHighScore = new Image(Statics.assets.getTexture("RaysHighScore0000"));
			raysHighScore.pivotX = Math.ceil(raysHighScore.texture.width  / 2); // center art on registration point
			raysHighScore.pivotY = Math.ceil(raysHighScore.texture.height / 2);
			raysHighScore.x = Statics.stageWidth / 2;
			raysHighScore.y = Statics.stageHeight / 2 - 100;
			this.addChild(raysHighScore);
			
			badgeHighScore = new Image(Statics.assets.getTexture("BadgeHighScore0000"));
			badgeHighScore.pivotX = Math.ceil(badgeHighScore.texture.width  / 2); // center art on registration point
			badgeHighScore.pivotY = Math.ceil(badgeHighScore.texture.height / 2);
			badgeHighScore.x = Statics.stageWidth / 2;
			badgeHighScore.y = Statics.stageHeight / 2 - 100;
			this.addChild(badgeHighScore);
			
			popupContainer = new Sprite();
			
			// popup artwork
			var popup:Image = new Image(Statics.assets.getTexture("PromptBg0000"));
			popupContainer.addChild(popup);
			popupContainer.pivotX = Math.ceil(popupContainer.width / 2);
			popupContainer.pivotY = Math.ceil(popupContainer.height / 2);
			popupContainer.x = Statics.stageWidth / 2;
			popupContainer.y = Statics.stageHeight / 2 + 150;
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
		
		public function advanceTime(time:Number):void {
			this.raysHighScore.rotation += time;
		}
		
		public function initialize(distance:int, score:int):void {
			this.distance = distance;
			this.score = score;
			
			this.promptText.text = "Share your new personal high score of " + score.toString() + " on Facebook!";
			
			// popup pop out effect
			popupContainer.scaleX = 0.5;
			popupContainer.scaleY = 0.5;
			Starling.juggler.tween(popupContainer, 0.5, {
				transition: Transitions.EASE_OUT_ELASTIC,
				scaleX: 1,
				scaleY: 1
			});
			this.visible = true;
			
			// confetti particles
			Statics.particleConfetti.emitterX = Statics.stageWidth / 2;
			Statics.particleConfetti.emitterY = Statics.stageHeight / 2 - 160;
			Statics.particleConfetti.emitAngle = deg2rad(270);
			Statics.particleConfetti.start();
		}
		
		private function buttonOkHandler(event:Event):void {
			if (!Sounds.sfxMuted) Statics.assets.playSound("SND_CLICK");
			
			if(ExternalInterface.available){
				ExternalInterface.call("shareHighScore", Statics.firstName + " just jumped " + this.distance.toString() + "m and achieved a new high score of " + this.score.toString() + "! Think you can do better?");
			}
			this.dispose();
			
			if (Statics.isAnalyticsEnabled) {
				Statics.mixpanel.track('shared new high score');
			}
		}
		
		private function buttonCancelHandler(event:Event):void {
			if (!Sounds.sfxMuted) Statics.assets.playSound("SND_CLICK");
			
			this.dispose();
			
			if (Statics.isAnalyticsEnabled) {
				Statics.mixpanel.track('declined to share high score');
			}
		}
		
		private function dispose():void {
			Statics.particleConfetti.stop(true);
			this.visible = false;
		}
	}
}