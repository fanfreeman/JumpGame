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
		public var dx:Number = 0.0;
		public var dy:Number = 0.0;
		public var canBounce:Boolean = true;
		public var isDynamic:Boolean = true;
		
//		private var heroAnimations:Vector.<MovieClip> = new Vector.<MovieClip>();
		private var animationJump:MovieClip;
		private var animationHurt:MovieClip;
		
		private var abilityTimer:Timer;
		private var abilityReady:Boolean = true;
		private var rotationSpeed:Number = 0.0;
		
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
			
//			this.createHeroWalkAnim();
			this.createHeroJumpAnim();
			this.createHeroFailAnim();
		}
		
//		private function createHeroWalkAnim():void {
//			var heroWalkAnim:MovieClip = new MovieClip(Assets.getSprite("SpriteTextureScarecrow").getTextures("walk.swf/"), 24);
//			heroWalkAnim.scaleX = 0.6;
//			heroWalkAnim.scaleY = 0.6;
//			heroWalkAnim.pivotX = Math.ceil(heroWalkAnim.texture.width / 2);
//			heroWalkAnim.pivotY = Math.ceil(heroWalkAnim.texture.height / 2);
//			starling.core.Starling.juggler.add(heroWalkAnim);
//			this.addChild(heroWalkAnim);
//			this.heroAnimations[Constants.HeroAnimWalk] = heroWalkAnim;
//		}
		
		private function createHeroJumpAnim():void {
			animationJump = new MovieClip(Assets.getSprite("AtlasTexturePlatforms").getTextures("HeroJump"), 24);
			animationJump.scaleX = 0.6;
			animationJump.scaleY = 0.6;
			animationJump.pivotX = Math.ceil(animationJump.texture.width  / 2);
			animationJump.pivotY = Math.ceil(animationJump.texture.height / 2);
			starling.core.Starling.juggler.add(animationJump);
			this.addChild(animationJump);
			// hide this by default
			animationJump.loop = false;
		}
		
		private function createHeroFailAnim():void {
			animationHurt = new MovieClip(Assets.getSprite("AtlasTexturePlatforms").getTextures("HeroHurt"), 24);
			animationHurt.scaleX = 0.6;
			animationHurt.scaleY = 0.6;
			animationHurt.pivotX = Math.ceil(animationHurt.width  / 2);
			animationHurt.pivotY = Math.ceil(animationHurt.height / 2);
			starling.core.Starling.juggler.add(animationHurt);
			this.addChild(animationHurt);
			// hide this by default
			animationHurt.visible = false;
			animationHurt.loop = false;
		}
		
		override public function get width():Number
		{
			if (animationJump) return animationJump.width;
			else return NaN;
		}
		
		override public function get height():Number
		{
			if (animationJump) return animationJump.height;
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
				this.dy = 2.0;
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
				animationJump.stop();
				animationJump.play();
			}
			
			if (this.dx > 0.2) this.rotationSpeed = Math.PI / 27;
			else if (this.dx < -0.2) this.rotationSpeed = -Math.PI / 27;
		}
		
		public function update(timeDiff:Number):void {
			// fall down due to gravity
			if (this.isDynamic) {
				this.dy -= Constants.Gravity * timeDiff;
				if (this.dy < Constants.MaxHeroFallVelocity) {
					this.dy = Constants.MaxHeroFallVelocity;
				}
			}
			
			// move hero
			this.gx += timeDiff * this.dx;
			this.gy += timeDiff * this.dy;
			
			// stop bounce rotation after a full spin
			var prevRotation:Number = animationJump.rotation;
			animationJump.rotation += this.rotationSpeed;
			if ((prevRotation < 0 && animationJump.rotation >= 0 || 
				prevRotation > 0 && animationJump.rotation <= 0) &&
				Math.abs(prevRotation) < 1) {
				animationJump.rotation = 0;
				this.rotationSpeed = 0;
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
			animationJump.scaleX = -0.6;
			animationJump.pivotX = Math.ceil(animationJump.texture.width  / 2);
		}
		
		public function turnRight():void {
			animationJump.scaleX = 0.6;
			animationJump.pivotX = Math.ceil(animationJump.texture.width  / 2);
		}
		
		public function failBounce():void {
			this.dy = Constants.NormalBouncePower;
			animationJump.visible = false;
			animationHurt.visible = true;
			animationHurt.stop();
			animationHurt.play();
		}
	}
}