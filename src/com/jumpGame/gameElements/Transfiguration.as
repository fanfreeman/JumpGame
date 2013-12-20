package com.jumpGame.gameElements
{
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;

	public class Transfiguration extends GameObject
	{
		private var activationBg:MovieClip;
		private var activationIcon:Image; // the actual icon to tween
		private var activationIconBroom:Image;
		private var activationIconVermilion:Image;
		private var activationIconMaster:Image;
		private var activationCaption:Image; // the actual caption to tween
		private var activationCaptionBroom:Image;
		private var activationCaptionVermilion:Image;
		private var activationCaptionMaster:Image;
		private var energyWave:Image;
		private var hero:Hero;
		
		public function Transfiguration(hero:Hero)
		{
			super();
			
			this.touchable = false;
			this.hero = hero;
			
			activationBg = new MovieClip(Assets.getSprite("AtlasTexture5").getTextures("TransfigActivationBg"), 30);
			activationBg.y = Statics.stageHeight;
			activationBg.visible = false;
			this.addChild(activationBg);
			
			activationIconBroom = new Image(Assets.getSprite("AtlasTexture5").getTexture("TransfigActivationIconBroom0000"));
			activationIconBroom.pivotY = Math.ceil(activationIconBroom.height / 2);
			activationIconBroom.x = -activationIconBroom.width;
			activationIconBroom.y = Statics.stageHeight * 2.7 / 5 + activationBg.height / 2;
			activationIconBroom.visible = false;
			addChild(activationIconBroom);
			
			activationIconVermilion = new Image(Assets.getSprite("AtlasTexture5").getTexture("TransfigActivationIconVermilion0000"));
			activationIconVermilion.pivotY = Math.ceil(activationIconVermilion.height / 2);
			activationIconVermilion.x = -activationIconVermilion.width;
			activationIconVermilion.y = Statics.stageHeight * 2.7 / 5 + activationBg.height / 2;
			activationIconVermilion.visible = false;
			addChild(activationIconVermilion);
			
			activationIconMaster = new Image(Assets.getSprite("AtlasTexture5").getTexture("TransfigActivationIconDapan0000"));
			activationIconMaster.pivotY = Math.ceil(activationIconMaster.height / 2);
			activationIconMaster.x = -activationIconMaster.width;
			activationIconMaster.y = Statics.stageHeight * 2.7 / 5 + activationBg.height / 2;
			activationIconMaster.visible = false;
			addChild(activationIconMaster);
			
			activationCaptionBroom = new Image(Assets.getSprite("AtlasTexture5").getTexture("TransfigActivationCaptionBroom0000"));
			activationCaptionBroom.pivotY = Math.ceil(activationCaptionBroom.height / 2);
			activationCaptionBroom.x = Statics.stageWidth;
			activationCaptionBroom.y = Statics.stageHeight * 2.7 / 5 + activationBg.height / 2;
			activationCaptionBroom.visible = false;
			addChild(activationCaptionBroom);
			
			activationCaptionVermilion = new Image(Assets.getSprite("AtlasTexture5").getTexture("TransfigActivationCaptionVermilion0000"));
			activationCaptionVermilion.pivotY = Math.ceil(activationCaptionVermilion.height / 2);
			activationCaptionVermilion.x = Statics.stageWidth;
			activationCaptionVermilion.y = Statics.stageHeight * 2.7 / 5 + activationBg.height / 2;
			activationCaptionVermilion.visible = false;
			addChild(activationCaptionVermilion);
			
			activationCaptionMaster = new Image(Assets.getSprite("AtlasTexture5").getTexture("TransfigActivationCaptionDapan0000"));
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
			starling.core.Starling.juggler.add(activationBg);
			Starling.juggler.tween(activationBg, 0.3, {
				transition: Transitions.EASE_IN,
				y: Statics.stageHeight * 3 / 5,
				nextTween: tweenActivationBgSlowmo
			});
			
			switch (powerup) { // assign an appropriate caption
				case Constants.PowerupExpansion:
					this.activationIcon = this.activationIconBroom;
					this.activationCaption = this.activationCaptionBroom;
					break;
				case Constants.PowerupVermilionBird:
					this.activationIcon = this.activationIconVermilion;
					this.activationCaption = this.activationCaptionVermilion;
					break;
				case Constants.PowerupMasterDapan:
					this.activationIcon = this.activationIconMaster;
					this.activationCaption = this.activationCaptionMaster;
					break;
			}
			
			// bof icon tween
			// tween for activation icon flyout
			var tweenActivationIconFlyout:Tween = new Tween(activationIcon, 0.3, Transitions.EASE_IN);
			tweenActivationIconFlyout.animate("x", Statics.stageWidth);
			
			// tween for activation icon slow motion
			var tweenActivationIconSlowmo:Tween = new Tween(activationIcon, 1.4, Transitions.EASE_OUT);
			tweenActivationIconSlowmo.animate("x", Statics.stageWidth * 0.8 / 5);
			tweenActivationIconSlowmo.nextTween = tweenActivationIconFlyout;
			
			// tween for activation icon flyin
			activationIcon.visible = true;
			Starling.juggler.tween(activationIcon, 0.3, {
				delay: 0.25,
				transition: Transitions.EASE_IN,
				x: Statics.stageWidth * 0.4 / 5,
				nextTween: tweenActivationIconSlowmo
			});
			// eof caption tween
			
			// bof caption tween
			// tween for activation caption flyout
			var tweenActivationCaptionFlyout:Tween = new Tween(activationCaption, 0.3, Transitions.EASE_IN);
			tweenActivationCaptionFlyout.animate("x", -activationCaption.width);
			
			// tween for activation caption slow motion
			var tweenActivationCaptionSlowmo:Tween = new Tween(activationCaption, 1.4, Transitions.EASE_OUT);
			tweenActivationCaptionSlowmo.animate("x", Statics.stageWidth * 2.1 / 5);
			tweenActivationCaptionSlowmo.nextTween = tweenActivationCaptionFlyout;
			
			// tween for activation caption flyin
			activationCaption.visible = true;
			Starling.juggler.tween(activationCaption, 0.3, {
				delay: 0.2,
				transition: Transitions.EASE_IN,
				x: Statics.stageWidth * 2.7 / 5,
				nextTween: tweenActivationCaptionSlowmo
			});
			// eof caption tween
			
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
			starling.core.Starling.juggler.remove(activationBg);
			activationBg.visible = false;
			activationBg.y = Statics.stageHeight;
			
			// icon
			activationIcon.visible = false;
			activationIcon.x = -activationIcon.width;
			activationIcon.y = Statics.stageHeight * 2.7 / 5 + activationBg.height / 2;
			
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