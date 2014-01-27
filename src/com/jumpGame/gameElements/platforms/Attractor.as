package com.jumpGame.gameElements.platforms
{
	import com.jumpGame.gameElements.Platform;
	
	import starling.core.Starling;
//	import starling.display.Image;
	import starling.display.MovieClip;
	
	public class Attractor extends Platform
	{
		override protected function createPlatformArt():void
		{
//			platformImage = new Image(Assets.getSprite("AtlasTexturePlatforms").getTexture("Pulsar0000"));
//			platformImage.pivotX = Math.ceil(platformImage.texture.width  / 2); // center art on registration point
//			platformImage.pivotY = Math.ceil(platformImage.texture.height / 2);
//			this.addChild(platformImage);
			
			platformAnimation = new MovieClip(Statics.assets.getTextures("PlasmaBall"), 12);
			platformAnimation.pivotX = Math.ceil(platformAnimation.texture.width  / 2); // center art on registration point
			platformAnimation.pivotY = Math.ceil(platformAnimation.texture.height / 2);
//			platformAnimation.loop = false;
			starling.core.Starling.juggler.add(platformAnimation);
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
//			if (platformAnimation == null && platformImage == null) createPlatformArt();
			this.show();
		}
		
		override public function contact():void { // do nothing
		}
		
		override public function update(timeDiff:Number):void {
			this.gx += this.dx * timeDiff;
			this.gy += this.dy * timeDiff;
			this.platformAnimation.rotation += Math.PI / 72;
		}
		
		override public function touch():Boolean {
			if (!this.isTouched) {
				if (!Sounds.sfxMuted) Statics.assets.playSound("SND_ELECTRICITY");
				this.isTouched = true;
			}

			return true;
		}
	}
}

