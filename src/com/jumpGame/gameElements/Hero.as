package com.jumpGame.gameElements
{
	import com.jumpGame.ui.HUD;
	
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
		public var gravity:Number = Constants.Gravity;
		public var canBounce:Boolean = true;
		
		public function Hero()
		{
			super();
			
			this.gx = 0.0;
			this.gy = 0.0;
			
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
			this.createHeroFailAnim();
		}
		
		private function createHeroWalkAnim():void {
			var heroWalkAnim:MovieClip = new MovieClip(Assets.getSprite("SpriteTextureScarecrow").getTextures("walk.swf/"), 24);
			heroWalkAnim.scaleX = 0.6;
			heroWalkAnim.scaleY = 0.6;
			heroWalkAnim.pivotX = Math.ceil(heroWalkAnim.texture.width / 2);
			heroWalkAnim.pivotY = Math.ceil(heroWalkAnim.texture.height / 2);
			starling.core.Starling.juggler.add(heroWalkAnim);
			this.addChild(heroWalkAnim);
			this.heroAnimations[Constants.HeroAnimWalk] = heroWalkAnim;
		}
		
		private function createHeroJumpAnim():void {
			var heroJumpAnim:MovieClip = new MovieClip(Assets.getSprite("SpriteTextureScarecrow").getTextures("jump.swf/"), 24);
			heroJumpAnim.scaleX = 0.6;
			heroJumpAnim.scaleY = 0.6;
			heroJumpAnim.pivotX = Math.ceil(heroJumpAnim.texture.width  / 2);
			heroJumpAnim.pivotY = Math.ceil(heroJumpAnim.texture.height / 2);
			starling.core.Starling.juggler.add(heroJumpAnim);
			this.addChild(heroJumpAnim);
			// hide this by default
			heroJumpAnim.visible = false;
			heroJumpAnim.loop = false;
			this.heroAnimations[Constants.HeroAnimJump] = heroJumpAnim;
		}
		
		private function createHeroFailAnim():void {
			var heroFailAnim:MovieClip = new MovieClip(Assets.getSprite("SpriteTextureScarecrow").getTextures("hurt.swf/"), 24);
			heroFailAnim.scaleX = 0.6;
			heroFailAnim.scaleY = 0.6;
			heroFailAnim.pivotX = Math.ceil(heroFailAnim.texture.width  / 2);
			heroFailAnim.pivotY = Math.ceil(heroFailAnim.texture.height / 2);
			starling.core.Starling.juggler.add(heroFailAnim);
			this.addChild(heroFailAnim);
			// hide this by default
			heroFailAnim.visible = false;
			heroFailAnim.loop = false;
			this.heroAnimations[Constants.HeroAnimFail] = heroFailAnim;
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
		
		// return true if ability triggered
		public function triggerSpecialAbility():Boolean {
			if (this.abilityReady) {
				// activate ability
				this.dy = 1.5;
				Sounds.sndAirjump.play();
				
				this.abilityReady = false;
				this.abilityTimer = new Timer(5000, 1);
				this.abilityTimer.addEventListener(TimerEvent.TIMER_COMPLETE, setAbilityReady);
				this.abilityTimer.start();
				
				return true;
			}
			
			return false;
		}
		
		private function setAbilityReady(event:TimerEvent):void {
			this.abilityTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, setAbilityReady);
			this.abilityReady = true;
			HUD.showMessage("Ability Ready!");
		}
		
		public function bounce(bouncePower:Number):void {
			if (this.canBounce) {
				this.dy = bouncePower;
				this.heroAnimations[Constants.HeroAnimWalk].visible = false;
				this.heroAnimations[Constants.HeroAnimJump].visible = true;
				this.heroAnimations[Constants.HeroAnimJump].stop();
				this.heroAnimations[Constants.HeroAnimJump].play();
			}
		}
		
		public function bounceAndFade(direction:uint, bouncePower:Number):void {
			if (direction == Constants.DirectionUp) {
				this.dy = bouncePower;
			} else {
				this.dy = -bouncePower;
				this.scaleY *= -1;
			}
			
			this.canBounce = false;
			
			// disable collision detection for a while
			var delayTimer:Timer = new Timer(200, 1);
			delayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, restoreCollisionDetection);
			delayTimer.start();
			
			// play sound effect
			var temp:Number = Math.random() * 3;
			if (temp < 1) {
				Sounds.sndBounce1.play();
			} else if (temp >= 1 && temp < 2) {
				Sounds.sndBounce2.play();
			} else if (temp >= 2 && temp < 3) {
				Sounds.sndBounce3.play();
			}
		}
		
		public function restoreCollisionDetection(event:TimerEvent):void {
			if (event != null) {
				event.target.removeEventListener(TimerEvent.TIMER_COMPLETE, restoreCollisionDetection);
			}
			
			if (this.scaleY < 0) this.scaleY *= -1;
			this.canBounce = true;
		}
		
		public function turnLeft():void {
				this.heroAnimations[Constants.HeroAnimJump].scaleX = -0.6;
				this.heroAnimations[Constants.HeroAnimWalk].scaleX = -0.6;
				this.heroAnimations[Constants.HeroAnimJump].pivotX = Math.ceil(this.heroAnimations[Constants.HeroAnimJump].texture.width  / 2);
				this.heroAnimations[Constants.HeroAnimWalk].pivotX = Math.ceil(this.heroAnimations[Constants.HeroAnimWalk].texture.width  / 2);
		}
		
		public function turnRight():void {
				this.heroAnimations[Constants.HeroAnimJump].scaleX = 0.6;
				this.heroAnimations[Constants.HeroAnimWalk].scaleX = 0.6;
				this.heroAnimations[Constants.HeroAnimJump].pivotX = Math.ceil(this.heroAnimations[Constants.HeroAnimJump].texture.width  / 2);
				this.heroAnimations[Constants.HeroAnimWalk].pivotX = Math.ceil(this.heroAnimations[Constants.HeroAnimWalk].texture.width  / 2);
		}
		
		public function failBounce():void {
			this.dy = Constants.NormalBouncePower;
			this.heroAnimations[Constants.HeroAnimWalk].visible = false;
			this.heroAnimations[Constants.HeroAnimJump].visible = false;
			this.heroAnimations[Constants.HeroAnimFail].visible = true;
			this.heroAnimations[Constants.HeroAnimFail].stop();
			this.heroAnimations[Constants.HeroAnimFail].play();
		}
		
		public function fall(timeDiff:Number):void {
				this.dy -= this.gravity * timeDiff;
				if (this.dy < Constants.MaxHeroFallVelocity) {
					this.dy = Constants.MaxHeroFallVelocity;
				}
		}
	}
}