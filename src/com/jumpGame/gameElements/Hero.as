package com.jumpGame.gameElements
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.events.Event;
	
	/**
	 * This class is the hero character.
	 */
	public class Hero extends GameObject
	{
		/** Hero character animation. */
		private var heroAnimations:Vector.<MovieClip> = new Vector.<MovieClip>();

		public var dx:Number = 0.0;
		public var dy:Number = 0.0;
		private var abilityTimer:Timer;
		private var abilityReady:Boolean = true;
		
		public function Hero()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		/**
		 * On added to stage. 
		 * @param event
		 * 
		 */
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			this.createHeroWalkAnim();
			this.createHeroJumpAnim();
		}
		
		private function createHeroWalkAnim():void {
			var heroWalkAnim:MovieClip = new MovieClip(Assets.getSprite("SpriteTextureScarecrow").getTextures("walk.swf/"), 24);
			heroWalkAnim.pivotX = Math.ceil(heroWalkAnim.texture.width / 2);
			heroWalkAnim.pivotY = Math.ceil(heroWalkAnim.texture.height / 2);
			heroWalkAnim.scaleX = 0.6;
			heroWalkAnim.scaleY = 0.6;
			starling.core.Starling.juggler.add(heroWalkAnim);
			this.addChild(heroWalkAnim);
			this.heroAnimations[Constants.HeroAnimWalk] = heroWalkAnim;
		}
		
		private function createHeroJumpAnim():void {
			var heroJumpAnim:MovieClip = new MovieClip(Assets.getSprite("SpriteTextureScarecrow").getTextures("jump.swf/"), 24);
			heroJumpAnim.pivotX = Math.ceil(heroJumpAnim.texture.width  / 2);
			heroJumpAnim.pivotY = Math.ceil(heroJumpAnim.texture.height / 2);
			heroJumpAnim.scaleX = 0.6;
			heroJumpAnim.scaleY = 0.6;
			starling.core.Starling.juggler.add(heroJumpAnim);
			this.addChild(heroJumpAnim);
			// hide this by default
			heroJumpAnim.visible = false;
			heroJumpAnim.loop = false;
			this.heroAnimations[Constants.HeroAnimJump] = heroJumpAnim;
		}
		
		/**
		 * Set hero animation speed. 
		 * @param speed
		 * 
		 */
		public function setHeroAnimationSpeed(speed:int):void {
			if (speed == 0) this.heroAnimations[Constants.HeroAnimWalk].fps = 60;
			else this.heroAnimations[Constants.HeroAnimWalk].fps = 60;
		}
		
		override public function get width():Number
		{
			if (this.heroAnimations[Constants.HeroAnimWalk]) return this.heroAnimations[Constants.HeroAnimWalk].texture.width * 0.6;
			else return NaN;
		}
		
		override public function get height():Number
		{
			if (this.heroAnimations[Constants.HeroAnimWalk]) return this.heroAnimations[Constants.HeroAnimWalk].texture.height * 0.6;
			else return NaN;
		}
		
//		override public function setX(newX:Number):void {
//			// enable left and right border warp
//			if (newX < -1 * stage.stageWidth / 2) {
//				newX += stage.stageWidth;
//			}
//			else if (newX >= stage.stageWidth / 2) {
//				newX -= stage.stageWidth;
//			}
//			
//			this.mx = newX;
//			this.x = stage.stageWidth / 2 + newX;
//		}
		
		public function triggerSpecialAbility():void {
			if (this.abilityReady) {
				// activate ability
				this.dy = 1.5;
				//rgo.soundControl.playBoom();
				
				this.abilityReady = false;
				this.abilityTimer = new Timer(5000, 1);
				this.abilityTimer.addEventListener(TimerEvent.TIMER_COMPLETE, setAbilityReady);
				this.abilityTimer.start();
			}
		}
		
		private function setAbilityReady(event:TimerEvent):void {
			this.abilityTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, setAbilityReady);
			this.abilityReady = true;
			//this.rgo.showMessage("Ability Ready!");
		}
		
		public function bounce():void {
			this.dy = 0.8;
			this.heroAnimations[Constants.HeroAnimWalk].visible = false;
			this.heroAnimations[Constants.HeroAnimJump].visible = true;
			this.heroAnimations[Constants.HeroAnimJump].stop();
			this.heroAnimations[Constants.HeroAnimJump].play();
			//this.heroAnimations[Constants.HeroAnimJump].addEventListener(Event.COMPLETE, onFinishJumping);
			//if (!Sounds.muted) Sounds.playRandomNote();
		}
		
		private function onFinishJumping():void {
			this.heroAnimations[Constants.HeroAnimJump].removeEventListener(Event.COMPLETE, onFinishJumping);
			this.heroAnimations[Constants.HeroAnimJump].visible = false;
			this.heroAnimations[Constants.HeroAnimWalk].visible = true;
		}
		
		public function turnLeft():void {
				this.heroAnimations[Constants.HeroAnimJump].scaleX = -0.6;
				this.heroAnimations[Constants.HeroAnimWalk].scaleX = -0.6;
		}
		
		public function turnRight():void {
				this.heroAnimations[Constants.HeroAnimJump].scaleX = 0.6;
				this.heroAnimations[Constants.HeroAnimWalk].scaleX = 0.6;
		}
	}
}