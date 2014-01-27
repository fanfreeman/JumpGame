package com.jumpGame.gameElements.platforms
{
	import com.jumpGame.gameElements.Platform;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.filters.ColorMatrixFilter;
	
	public class Repulsor extends Platform
	{
		override protected function createPlatformArt():void
		{
//			platformImage = new Image(Assets.getSprite("AtlasTexturePlatforms").getTexture("Pulsar0000"));
//			platformImage.pivotX = Math.ceil(platformImage.width  / 2); // center art on registration point
//			platformImage.pivotY = Math.ceil(platformImage.height / 2);
//			this.addChild(platformImage);
			
			platformAnimation = new MovieClip(Statics.assets.getTextures("Repulsor"), 24);
			platformAnimation.pivotX = Math.ceil(platformAnimation.width  / 2); // center art on registration point
			platformAnimation.pivotY = Math.ceil(platformAnimation.height / 2);
			starling.core.Starling.juggler.add(platformAnimation);
			this.addChild(platformAnimation);
			this.platformWidth = platformAnimation.texture.width;
			
			var hueFilter:ColorMatrixFilter = new ColorMatrixFilter();
			hueFilter.adjustHue(0.2);
			
			bounceAnimation = new MovieClip(Statics.assets.getTextures("PulseRed"), 30);
			bounceAnimation.filter = hueFilter;
			bounceAnimation.pivotX = Math.ceil(bounceAnimation.width  / 2); // center art on registration point
			bounceAnimation.pivotY = Math.ceil(bounceAnimation.height / 2);
			bounceAnimation.stop();
			Starling.juggler.add(this.bounceAnimation);
			bounceAnimation.scaleX = 2;
			bounceAnimation.scaleY = 2;
			bounceAnimation.loop = false;
			bounceAnimation.visible = false;
			this.addChild(bounceAnimation);
		}
		
		override public function initialize(gx, gy, size:int, args = null):void {
			this.gx = gx;
			this.gy = gy;
			this.extenderStatus = 0;
			this.extenderParent = null;
			this.dx = 0;
			this.dy = 0;
			this.isTouched = false;
//			if (platformAnimation == null) createPlatformArt();
			this.show();
		}
		
		override public function contact():void {
			if (!Sounds.sfxMuted) Statics.assets.playSound("SND_BOUNCE_2");
			
			platformAnimation.visible = false;
			bounceAnimation.visible = true;
			bounceAnimation.stop();
			bounceAnimation.play();
		}
		
		override public function update(timeDiff:Number):void {
			if (bounceAnimation.visible && this.bounceAnimation.isComplete) {
				bounceAnimation.visible = false;
				this.platformAnimation.visible = true;
			}
			this.gx += this.dx * timeDiff;
			this.gy += this.dy * timeDiff;
			this.platformAnimation.rotation += Math.PI / 72;
		}
	}
}