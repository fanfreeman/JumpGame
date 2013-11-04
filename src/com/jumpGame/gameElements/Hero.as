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
		public var dx:Number;
		public var dy:Number;
		private var dxPrev:Number;
		private var dyPrev:Number;
		
		public var canBounce:Boolean;
		public var isDynamic:Boolean;
		public var gravity:Number;
		
		private var animationJump:MovieClip;
		private var animationHurt:MovieClip;
		private var animationBrace:MovieClip;
		private var animationSuper:MovieClip;
		private var animationPoof:MovieClip;
		
		private var rotationSpeed:Number;
		private var canBounceTime:int;
		
		private var nextBouncePower:Number;
		
		public var d2x:Number;
		
		public var isTransfigured:Boolean;
		
		public var controlRestoreTime:int;
		
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
			
			this.createHeroArt();
		}
		
		public function initialize():void {
			this.visible = false;
			this.gx = Constants.HERO_INITIAL_X;
			this.gy = Constants.HERO_INITIAL_Y;
			this.nextBouncePower = 0;
			dx = 0.0;
			dy = Constants.HeroInitialVelocityY;
			dxPrev = 0.0;
			dyPrev = 0.0;
			canBounce = true;
			isDynamic = true;
			gravity = Constants.Gravity;
			rotationSpeed = 0.0;
			d2x = 0;
			isTransfigured = false;
			controlRestoreTime = 0;
			animationJump.visible = true;
			animationBrace.visible = false;
			animationHurt.visible = false;
			animationSuper.visible = false;
			animationPoof.visible = false;
		}
		
		private function createHeroArt():void {
			animationJump = new MovieClip(Assets.getSprite("AtlasTexture2").getTextures("CharBoyJump"), 10);
			animationJump.pivotX = Math.ceil(animationJump.texture.width  / 2);
			animationJump.pivotY = Math.ceil(animationJump.texture.height / 2);
			animationJump.loop = false;
			starling.core.Starling.juggler.add(animationJump);
			this.addChild(animationJump);
			
			animationBrace = new MovieClip(Assets.getSprite("AtlasTexture2").getTextures("CharBoyBrace"), 10);
			animationBrace.pivotX = Math.ceil(animationBrace.texture.width  / 2);
			animationBrace.pivotY = Math.ceil(animationBrace.texture.height / 2);
			animationBrace.loop = false;
			starling.core.Starling.juggler.add(animationBrace);
			this.addChild(animationBrace);
			
			animationHurt = new MovieClip(Assets.getSprite("AtlasTexture2").getTextures("CharBoyHurt"), 24);
			animationHurt.pivotX = Math.ceil(animationHurt.width  / 2);
			animationHurt.pivotY = Math.ceil(animationHurt.height / 2);
			animationHurt.loop = false;
			this.addChild(animationHurt);
			
			animationSuper = new MovieClip(Assets.getSprite("AtlasTexture2").getTextures("CharBoySuper"), 24);
			animationSuper.pivotX = Math.ceil(animationSuper.width  / 2);
			animationSuper.pivotY = Math.ceil(animationSuper.height / 2);
			this.addChild(animationSuper);
			
			animationPoof = new MovieClip(Assets.getSprite("AtlasTexture2").getTextures("TransfigAnimPoof"), 24);
			animationPoof.pivotX = Math.ceil(animationPoof.width  / 2); // center art on registration point
			animationPoof.pivotY = Math.ceil(animationPoof.height / 2);
			animationPoof.loop = false;
			this.addChild(animationPoof);
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
				this.dy = 1.7 + Statics.rankAbilityPower * 0.1;
				Statics.particleCharge.start(0.2);
				Statics.particleJet.start(1);
				if (!Sounds.sfxMuted) Sounds.sndAirjump.play();
				
				Statics.specialReady = false;
				Statics.specialUseTime = Statics.gameTime;
				Statics.specialReadyTime = Statics.gameTime + 10000 - Statics.rankAbilityCooldown * 500;
				
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
				
				// jump animation
				animationBrace.stop();
				animationBrace.visible = false;
				animationJump.visible = true;
				animationJump.stop();
				animationJump.play();
				
				// rotate hero
				if (this.dx > 0.2) this.rotationSpeed = Math.PI / 27;
				else if (this.dx < -0.2) this.rotationSpeed = -Math.PI / 27;
			}
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
			
			// find average velocities
			var dxAvg:Number = (this.dxPrev + this.dx) / 2;
			var dyAvg:Number = (this.dyPrev + this.dy) / 2;
			
			// move hero
			this.gx += timeDiff * dxAvg;
			this.gy += timeDiff * dyAvg;
			
			// save previous velocities
			this.dxPrev = this.dx;
			this.dyPrev = this.dy;
			
			// stop bounce rotation after a full spin
			var prevRotation:Number = animationJump.rotation;
			animationJump.rotation += this.rotationSpeed;
			animationBrace.rotation += this.rotationSpeed;
			if ((prevRotation < 0 && animationJump.rotation >= 0 || 
				prevRotation > 0 && animationJump.rotation <= 0) &&
				Math.abs(prevRotation) < 1) {
				animationJump.rotation = 0;
				animationBrace.rotation = 0;
				this.rotationSpeed = 0;
			}
			
			// hide poof
			if (animationPoof.isComplete) {
				this.hidePoof();
			}
			
			// show brace animation
			if (dyAvg < 0 && Statics.checkWinLose) { // don't show brace animation again for fail bounce
				animationJump.visible = false;
				animationBrace.visible = true;
				animationBrace.play();
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
			if (animationSuper.visible) {
				animationSuper.scaleX = -1;
				animationSuper.pivotX = Math.ceil(animationSuper.texture.width  / 2);
			} else {
				animationJump.scaleX = -1;
				animationJump.pivotX = Math.ceil(animationJump.texture.width  / 2);
				
				animationBrace.scaleX = -1;
				animationBrace.pivotX = Math.ceil(animationBrace.texture.width  / 2);
			}
		}
		
		public function turnRight():void {
			if (animationSuper.visible) {
				animationSuper.scaleX = 1;
				animationSuper.pivotX = Math.ceil(animationSuper.texture.width  / 2);
			} else {
				animationJump.scaleX = 1;
				animationJump.pivotX = Math.ceil(animationJump.texture.width  / 2);
				
				animationBrace.scaleX = 1;
				animationBrace.pivotX = Math.ceil(animationJump.texture.width  / 2);
			}
		}
		
		public function failBounce():void {
			this.dy = Constants.BoostBouncePower;
			animationJump.visible = false;
			animationBrace.visible = false;
			animationHurt.visible = true;
			starling.core.Starling.juggler.add(animationHurt);
			animationHurt.stop();
			animationHurt.play();
		}
		
		public function showSuper():void {
			animationJump.visible = false;
			animationBrace.visible = false;
			animationSuper.visible = true;
			starling.core.Starling.juggler.add(animationSuper);
			animationSuper.play();
		}
		
		public function hideSuper():void {
			starling.core.Starling.juggler.remove(animationSuper);
			animationSuper.visible = false;
			animationJump.visible = true;
		}
		
		public function show():void {
			animationJump.visible = true;
		}
		
		public function hide():void {
			animationJump.visible = false;
			animationBrace.visible = false;
			animationSuper.visible = false;
		}
		
		/**
		 * Pushing away by a repulsor
		 */
		public function repulse(repulsorGx:Number, repulsorGy:Number):void {
//			var fx:Number = this.gx - repulsorGx;
//			var fy:Number = this.gy - repulsorGy;
//			// constant force regardless of distance from center
//			var angle:Number = Statics.vectorAngle(repulsorGx, repulsorGy, this.gx, this.gy);
//			this.dx = Math.cos(angle) * 0.75;
			if (this.gx > repulsorGx + 10) this.dx = 0.75;
			else if (this.gx < repulsorGx - 10) this.dx = -0.75;
//			if (this.dy < 1.5) this.dy += (1.5 - this.dy);
		}
		
		public function repulseOffBouncer(repulsorGx:Number, repulsorGy:Number):void {
			if (this.gx > repulsorGx + 10) this.dx = 1.35;
			else if (this.gx < repulsorGx - 10) this.dx = -1.35;
			if (this.dy < 1.65) this.dy += (1.65 - this.dy);
		}
		
		/**
		 * Attraction by an attractor platform
		 */
		public function attract(timeDiff:Number, attractorGx:Number, attractorGy:Number):void {
			var fx:Number = attractorGx - this.gx;
			var fy:Number = attractorGy - this.gy;
			
			if (fx > 0) fx = (775 - fx) / 3;
			else if (fx < 0) fx = (-775 - fx) / 3;
			
			if (Math.abs(this.dx) < 1) this.dx += fx * timeDiff * 0.00002;
			if (fy > 0 && this.dy < 1.5) this.dy += 30 * timeDiff * 0.00005;
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
		
		/**
		 * Show tranfiguration poof animation
		 */
		public function showPoof():void {
			this.hide();
			animationPoof.visible = true;
			starling.core.Starling.juggler.add(animationPoof);
			animationPoof.play();
		}
		
		/**
		 * Hide transfiguration poof animation
		 */
		private function hidePoof():void {
			animationPoof.stop();
			starling.core.Starling.juggler.remove(animationPoof);
			animationPoof.visible = false;
			this.show();
		}
	}
}