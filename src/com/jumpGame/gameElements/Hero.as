package com.jumpGame.gameElements
{
	import com.jumpGame.level.Statics;
	import com.jumpGame.ui.HUD;
	
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
		public var gravity:Number = Constants.Gravity;
		
		private var animationJump:MovieClip;
		private var animationHurt:MovieClip;
		
		private var rotationSpeed:Number = 0.0;
		private var canBounceTime:int;
		
		private var nextBouncePower:Number;
		
		public var d2x:Number = 0;
		
		public var isTransfigured:Boolean = false;
		
		public var controlRestoreTime:int = 0;
		
		public function Hero()
		{
			super();
			
			this.gx = 0.0;
			this.gy = 0.0;
			this.nextBouncePower = 0;
			
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
			if (Statics.numSpecials <= 0) {
				HUD.showMessage("No More Specials");
			}
			else if (Statics.specialReady) {
				HUD.turnOffSpecials();
				
				// activate ability
				this.dy = 2.0;
				Statics.particleCharge.start(0.2);
				Statics.particleJet.start(1);
				if (!Sounds.sfxMuted) Sounds.sndAirjump.play();
				
				Statics.specialReady = false;
				Statics.specialUseTime = Statics.gameTime;
				Statics.specialReadyTime = Statics.gameTime + 5000;
				
				return true;
			}
			else {
				HUD.showMessage("Special still in Cooldown");
			}
			
			return false;
		}
		
		private function setAbilityReady():void {
			Statics.specialReady = true;
			HUD.turnOnSpecials()
			HUD.showMessage("Ability Ready!");
		}
		
		public function bounce(bouncePower:Number):void {
			if (this.canBounce) {
				if (bouncePower > Constants.MaxHeroBouncePower) this.dy = Constants.MaxHeroBouncePower;
				else {
					if (bouncePower > this.dy) this.dy = bouncePower;
					else if (bouncePower <= 0) this.dy += bouncePower;
				}
				animationJump.stop();
				animationJump.play();
			}
			
			if (this.dx > 0.2) this.rotationSpeed = Math.PI / 27;
			else if (this.dx < -0.2) this.rotationSpeed = -Math.PI / 27;
		}
		
		/* enable the following to allow hero to bounce against multiple platforms
		public function bounce(bouncePower:Number):void {
			if (this.canBounce) {
				if (bouncePower > Constants.MaxHeroBouncePower) this.nextBouncePower = Constants.MaxHeroBouncePower;
				else {
					if (bouncePower > this.dy) this.nextBouncePower = bouncePower;
					else if (bouncePower <= 0) this.nextBouncePower += bouncePower;
				}
			}
		}
		
		// called at the beginning of each enter frame loop
		public function prepareBounce():void {
			this.nextBouncePower = this.dy;
		}
		
		// called at the end of each enter frame loop to update the hero's dy
		public function doBounce():void {
			if (this.nextBouncePower != this.dy) {
				this.dy = this.nextBouncePower;
				animationJump.stop();
				animationJump.play();
				
				if (this.dx > 0.2) this.rotationSpeed = Math.PI / 27;
				else if (this.dx < -0.2) this.rotationSpeed = -Math.PI / 27;
			}
		}
		*/
		
		public function update(timeDiff:Number):void {
			// check if ability is ready
			if (!Statics.specialReady && Statics.numSpecials > 0 && Statics.gameTime > Statics.specialReadyTime) {
				this.setAbilityReady();
			}
			
			// check if bouncing should be restored
			if (!this.canBounce && Statics.gameTime > this.canBounceTime) {
				this.restoreCollisionDetection();
			}
			
			// fall down due to gravity
			if (this.isDynamic) {
				this.dy -= this.gravity * timeDiff;
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
//				this.dy = -bouncePower;
				this.dy = 0;
				this.scaleY *= -1;
			}
			
			// play sound effect
//			var temp:Number = Math.random() * 3;
//			if (temp < 1) {
//				Sounds.sndBounce1.play();
//			} else if (temp >= 1 && temp < 2) {
//				Sounds.sndBounce2.play();
//			} else if (temp >= 2 && temp < 3) {
//				Sounds.sndBounce3.play();
//			}
			if (!Sounds.sfxMuted) Sounds.sndBoostBounce.play();
			
			// disable collision detection for a while
			this.canBounce = false;
			this.canBounceTime = Statics.gameTime + 200;
		}
		
		public function restoreCollisionDetection():void {
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
			this.dy = Constants.BoostBouncePower;
			animationJump.visible = false;
			animationHurt.visible = true;
			animationHurt.stop();
			animationHurt.play();
		}
		
		public function hide():void {
			this.animationJump.visible = false;
		}
		
		public function show():void {
			this.animationJump.visible = true;
		}
		
		/**
		 * Pushed away by a repulsor
		 */
		public function repulse(repulsorGx:Number, repulsorGy:Number):void {
			var fx:Number = this.gx - repulsorGx;
			var fy:Number = this.gy - repulsorGy;
//			trace ("fx: " + fx + " fy: " + fy);
//			this.dx += fx / 50;
//			this.dy += fy / 50;
			
			// constant force regardless of distance from center
			var angle:Number = Statics.vectorAngle(repulsorGx, repulsorGy, this.gx, this.gy);
			this.dx = Math.cos(angle) * 0.75;
//			this.dy = Math.sin(angle) * 0.5;
//			if (this.dy < 0) this.dy = 0;
//			if (this.dy > 0) this.dy *= 3;
		}
		
		public function repulseCannonball(isVertical:Boolean, isFromLeft:Boolean):void {
			if (isVertical) {
				this.dy -= 1.0;
			} else {
				if (isFromLeft) this.dx += 0.5;
				else this.dx -= 0.5;
			}
		}
		
		public function repulseSpikyBomb():void {
			this.dy -= 2.0;
			this.controlRestoreTime = Statics.gameTime + 500;
		}
	}
}