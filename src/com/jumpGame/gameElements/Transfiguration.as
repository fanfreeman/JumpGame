package com.jumpGame.gameElements
{
	import com.jumpGame.level.Statics;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;

	public class Transfiguration extends GameObject
	{
		private var activationBg:Image;
		private var activationCaption:Image;
		private var energyWave:Image;
		
		public function Transfiguration()
		{
			super();
			
			activationBg = new Image(Assets.getSprite("AtlasTexture2").getTexture("TransfigActivationBg0000"));
			activationBg.y = Statics.stageHeight;
			activationBg.visible = false;
			addChild(activationBg);
			
			activationCaption = new Image(Assets.getSprite("AtlasTexture2").getTexture("TransfigActivationCaptionBroom0000"));
			activationCaption.x = Statics.stageWidth;
			activationCaption.y = Statics.stageHeight * 2.7 / 5 + 10;
			activationCaption.visible = false;
			addChild(activationCaption);
			
			energyWave = new Image(Assets.getSprite("AtlasTexture2").getTexture("MagicCircle0000"));
			energyWave.pivotX = Math.ceil(energyWave.width / 2);
			energyWave.pivotY = Math.ceil(energyWave.height / 2);
			energyWave.scaleX = 0;
			energyWave.scaleY = 0;
			energyWave.visible = false;
			addChild(energyWave);
		}
		
		public function displayActivateBroom(hero:Hero):void {
			Statics.gamePaused = true;
			hero.isTransfigured = true;
			
			// tween for activation bg flyout
			var tweenActivationBgFlyout:Tween = new Tween(activationBg, 0.3, Transitions.EASE_IN);
			tweenActivationBgFlyout.animate("y", -activationBg.height);
			tweenActivationBgFlyout.onComplete = resetTransfigurationActivation;
			
			// tween for activation bg slow motion
			var tweenActivationBgSlowmo:Tween = new Tween(activationBg, 1.8, Transitions.EASE_OUT);
			tweenActivationBgSlowmo.animate("y", Statics.stageHeight * 2.7 / 5);
			tweenActivationBgSlowmo.nextTween = tweenActivationBgFlyout;
			
			// tween for activation bg flyin
			activationBg.visible = true;
			Starling.juggler.tween(activationBg, 0.3, {
				transition: Transitions.EASE_IN,
				y: Statics.stageHeight * 3 / 5,
				nextTween: tweenActivationBgSlowmo
			});
			
			// tween for activation caption flyout
			var tweenActivationCaptionFlyout:Tween = new Tween(activationCaption, 0.3, Transitions.EASE_IN);
			tweenActivationCaptionFlyout.animate("x", -activationCaption.width);
			
			// tween for activation caption slow motion
			var tweenActivationCaptionSlowmo:Tween = new Tween(activationCaption, 1.4, Transitions.EASE_OUT);
			tweenActivationCaptionSlowmo.animate("x", Statics.stageWidth * 2.3 / 5);
			tweenActivationCaptionSlowmo.nextTween = tweenActivationCaptionFlyout;
			
			// tween for activation caption flyin
			activationCaption.visible = true;
			Starling.juggler.tween(activationCaption, 0.3, {
				delay: 0.2,
				transition: Transitions.EASE_IN,
				x: Statics.stageWidth * 2.7 / 5,
				nextTween: tweenActivationCaptionSlowmo
			});
			
			// energy wave tween
			Starling.juggler.delayCall(releaseEnergyWave, 2.2, hero.x, hero.y);
		}
		
		public function displayDeactivateBroom(hero:Hero):void {
			hero.isTransfigured = false;
			this.releaseEnergyWave(hero.x, hero.y);
		}
		
		private function releaseEnergyWave(heroX:Number, heroY:Number):void {
			energyWave.x = heroX;
			energyWave.y = Statics.stageHeight / 2;
			energyWave.visible = true;
			Starling.juggler.tween(energyWave, 0.7, {
				transition: Transitions.EASE_OUT,
				scaleX: 3,
				scaleY: 3,
				alpha: 0
			});
			Starling.juggler.delayCall(resetTransfigurationActivation, 0.7);
		}
		
		private function resetTransfigurationActivation():void {
			// bg
			activationBg.visible = false;
			activationBg.y = Statics.stageHeight;
			
			// caption
			activationCaption.visible = false;
			activationCaption.x = Statics.stageWidth;
			activationCaption.y = Statics.stageHeight * 2.7 / 5 + 10;
			
			// energy wave
			energyWave.visible = false;
			energyWave.scaleX = 0;
			energyWave.scaleY = 0;
			energyWave.alpha = 1;
			
			// unpause game
			Statics.gamePaused = false;
		}
	}
}