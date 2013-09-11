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
			platformImage.pivotX = Math.ceil(platformImage.texture.width  / 2); // center art on registration point
			platformImage.pivotY = Math.ceil(platformImage.texture.height / 2);
			this.addChild(platformImage);
			
			platformAnimation = new MovieClip(Assets.getSprite("AtlasTexturePlatforms").getTextures("PulseRed"), 30);
			platformAnimation.pivotX = Math.ceil(platformAnimation.texture.width  / 2); // center art on registration point
			platformAnimation.pivotY = Math.ceil(platformAnimation.texture.height / 2);
			platformAnimation.scaleX = 2;
			platformAnimation.scaleY = 2;
			platformAnimation.visible = false;
			platformAnimation.stop();
			starling.core.Starling.juggler.add(platformAnimation);
			platformAnimation.loop = false;
			this.addChild(platformAnimation);
		}
		
		override public function initialize(gx, gy, size:int, args = null):void {
			this.gx = gx;
			this.gy = gy;
			this.extenderStatus = 0;
			this.extenderParent = null;
			this.dx = 0;
			this.dy = 0;
			this.isTouched = false;
			if (platformAnimation == null && platformImage == null) createPlatformArt();
			this.show();
		}
		
		override public function contact():void {
			if (!Sounds.sfxMuted) Sounds.sndBounce2.play();
			platformImage.visible = false;
			platformAnimation.visible = true;
			if (this.platformAnimation != null) {
				this.platformAnimation.stop();
				this.platformAnimation.play();
			}
		}
		
		override public function update(timeDiff:Number):void {
			if (this.platformAnimation.isComplete) this.platformImage.visible = true;
			this.gx += this.dx * timeDiff;
			this.gy += this.dy * timeDiff;
			this.platformImage.rotation += Math.PI / 72;
		}
	}
}