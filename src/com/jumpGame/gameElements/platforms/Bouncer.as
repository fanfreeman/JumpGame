package com.jumpGame.gameElements.platforms
{
	import com.jumpGame.gameElements.Platform;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.filters.ColorMatrixFilter;
	
	public class Bouncer extends Platform
	{
		override protected function createPlatformArt():void
		{
			platformAnimation = new MovieClip(Assets.getSprite("AtlasTexturePlatforms").getTextures("Bouncer"), 30);
			platformAnimation.pivotX = Math.ceil(platformAnimation.width  / 2); // center art on registration point
			platformAnimation.pivotY = Math.ceil(platformAnimation.height / 2);
			starling.core.Starling.juggler.add(platformAnimation);
			this.addChild(platformAnimation);
			
			var hueFilter:ColorMatrixFilter = new ColorMatrixFilter();
			hueFilter.adjustHue(-0.7);
			
			bounceAnimation = new MovieClip(Assets.getSprite("AtlasTexturePlatforms").getTextures("PulseRed"), 30);
			bounceAnimation.filter = hueFilter;
			bounceAnimation.pivotX = Math.ceil(bounceAnimation.width  / 2); // center art on registration point
			bounceAnimation.pivotY = Math.ceil(bounceAnimation.height / 2);
			bounceAnimation.stop();
			Starling.juggler.add(this.bounceAnimation);
			bounceAnimation.scaleX = 2;
			bounceAnimation.scaleY = 2;
			bounceAnimation.loop = false;
			bounceAnimation.visible = false;
//			bounceAnimation.stop();
//			starling.core.Starling.juggler.add(bounceAnimation);
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
			if (platformAnimation == null) createPlatformArt();
			this.show();
		}
		
		override public function contact():void {
			if (!Sounds.sfxMuted) Sounds.sndBounce2.play();
			
			platformAnimation.visible = false;
			bounceAnimation.visible = true;
			bounceAnimation.stop();
			bounceAnimation.play();
		}
		
		override public function update(timeDiff:Number):void {
			if (this.bounceAnimation.isComplete) this.platformAnimation.visible = true;
			this.gx += this.dx * timeDiff;
			this.gy += this.dy * timeDiff;
			this.platformAnimation.rotation += Math.PI / 144;
		}
	}
}

