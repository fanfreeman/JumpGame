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
		private var activationCaption:Image; // the actual caption to tween
		private var activationCaptionBroom:Image;
		private var activationCaptionVermilion:Image;
		private var activationCaptionMaster:Image;
		private var energyWave:Image;
		private var hero:Hero;
		
		public function Transfiguration(hero:Hero)
		{
			super();
			
			this.hero = hero;
			
			activationBg = new Image(Assets.getSprite("AtlasTexture2").getTexture("TransfigActivationBg0000"));
			activationBg.y = Statics.stageHeight;
			activationBg.visible = false;
			addChild(activationBg);
			
			activationCaptionBroom = new Image(Assets.getSprite("AtlasTexture2").getTexture("TransfigActivationCaptionBroom0000"));
			activationCaptionBroom.pivotY = Math.ceil(activationCaptionBroom.height / 2);
			activationCaptionBroom.x = Statics.stageWidth;
			activationCaptionBroom.y = Statics.stageHeight * 2.7 / 5 + activationBg.height / 2;
			activationCaptionBroom.visible = false;
			addChild(activationCaptionBroom);
			
			activationCaptionVermilion = new Image(Assets.getSprite("AtlasTexture2").getTexture("TransfigActivationCaptionVermilion0000"));
			activationCaptionVermilion.pivotY = Math.ceil(activationCaptionVermilion.height / 2);
			activationCaptionVermilion.x = Statics.stageWidth;
			activationCaptionVermilion.y = Statics.stageHeight * 2.7 / 5 + activationBg.height / 2;
			activationCaptionVermilion.visible = false;
			addChild(activationCaptionVermilion);
			
			activationCaptionMaster = new Image(Assets.getSprite("AtlasTexture2").getTexture("TransfigActivationCaptionDapan0000"));
			activationCaptionMaster.pivotY = Math.ceil(activationCaptionMaster.height / 2);
			activationCaptionMaster.x = Statics.stageWidth;
			activationCaptionMaster.y = Statics.stageHeight * 2.7 / 5 + activationBg.height / 2;
			activationCaptionMaster.visible = false;
			addChild(activationCaptionMaster);
			
			energyWave = new Image(Assets.getSprite("AtlasTexture2").getTexture("MagicCircle0000"));
			energyWave.pivotX = Math.ceil(energyWave.width / 2);
			energyWave.pivotY = Math.ceil(energyWave.height / 2);
			energyWave.scaleX = 0;
			energyWave.scaleY = 0;
			energyWave.visible = false;
			addChild(energyWave);
		}
		
		public function displayActivation(powerup:uint):void {
			Statics.gamePaused = true;
			hero.isTransfigured = true;
			
			// show poof
			this.hero.showPoof();
			
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
			
			switch (powerup) { // assign an appropriate caption
				case Constants.PowerupExpansion:
					this.activationCaption = this.activationCaptionBroom;
					break;
				case Constants.PowerupVermilionBird:
					this.activationCaption = this.activationCaptionVermilion;
					break;
				case Constants.PowerupMasterDapan:
					this.activationCaption = this.activationCaptionMaster;
					break;
			}
			
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
			Starling.juggler.delayCall(releaseEnergyWave, 2.2);
		}
		
		public function displayDeactivation():void {
			// show poof
			this.hero.showPoof();
			
			hero.isTransfigured = false;
			this.releaseEnergyWave();
		}
		
		private function releaseEnergyWave():void {
			energyWave.x = hero.x;
			energyWave.y = Statics.stageHeight / 2;
			energyWave.visible = true;
			Starling.juggler.tween(energyWave, 0.7, {
				transition: Transitions.EASE_OUT,
				scaleX: 3,
				scaleY: 3,
				alpha: 0
			});
			Starling.juggler.delayCall(resetEnergyWave, 0.7);
		}
		
		private function resetTransfigurationActivation():void {
			// bg
			activationBg.visible = false;
			activationBg.y = Statics.stageHeight;
			
			// caption
			activationCaption.visible = false;
			activationCaption.x = Statics.stageWidth;
			activationCaption.y = Statics.stageHeight * 2.7 / 5 + activationBg.height / 2;
			
			// unpause game
			Statics.gamePaused = false;
			
			// brief push upward
			Statics.particleJet.emitterX = hero.x;
			Statics.particleJet.emitterY = hero.y;
			Statics.particleJet.start(0.2);
		}
		
		private function resetEnergyWave():void {
			// energy wave
			energyWave.visible = false;
			energyWave.scaleX = 0;
			energyWave.scaleY = 0;
			energyWave.alpha = 1;
		}
	}
}