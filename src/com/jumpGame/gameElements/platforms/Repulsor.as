package com.jumpGame.gameElements.platforms
{
	import com.jumpGame.gameElements.Platform;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	
	public class Repulsor extends Platform
	{
		override protected function createPlatformArt():void
		{
			platformImage = new Image(Assets.getSprite("AtlasTexturePlatforms").getTexture("Pulsar0000"));
			platformImage.pivotX = Math.ceil(platformImage.width  / 2); // center art on registration point
			platformImage.pivotY = Math.ceil(platformImage.height / 2);
			this.addChild(platformImage);
			
			bounceAnimation = new MovieClip(Assets.getSprite("AtlasTexturePlatforms").getTextures("PulseRed"), 30);
			bounceAnimation.pivotX = Math.ceil(bounceAnimation.width  / 2); // center art on registration point
			bounceAnimation.pivotY = Math.ceil(bounceAnimation.height / 2);
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
			if (platformAnimation == null) createPlatformArt();
			this.show();
		}
		
		override public function contact():void {
			if (!Sounds.sfxMuted) Sounds.sndBounce2.play();
			
			platformImage.visible = false;
			bounceAnimation.visible = true;
			Starling.juggler.add(this.bounceAnimation);
			bounceAnimation.play();
		}
		
		override public function update(timeDiff:Number):void {
			if (this.bounceAnimation.isComplete) this.platformImage.visible = true;
			this.gx += this.dx * timeDiff;
			this.gy += this.dy * timeDiff;
			this.platformImage.rotation += Math.PI / 72;
		}
	}
}