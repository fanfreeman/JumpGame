package com.jumpGame.ui
{
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	
	public class SpecialIndicator extends Sprite
	{
		private var indicatorGlow:Image;
		private var indicatorSprite:Sprite;
		private var indicatorNoGlow:Image;
		private var indicatorDark:Image;
		private var sparklesAnimation:MovieClip;
		private var blastAnimation:MovieClip;
		private var spriteClipRect:Rectangle;
		
		public function initialize():void {
			this.visible = false;
			indicatorGlow.visible = true;
			indicatorDark.visible = false;
			indicatorSprite.visible = false;
			sparklesAnimation.visible = false;
			blastAnimation.visible = false;
		}
		
		public function SpecialIndicator()
		{
			super();
			this.createArt();
		}
		
		private function createArt():void
		{
			// glowing indicator
			indicatorGlow = new Image(Assets.getSprite("AtlasTexture4").getTexture("SpecialGlow0000"));
			indicatorGlow.pivotX = Math.ceil(indicatorGlow.texture.width  / 2); // center art on registration point
			indicatorGlow.pivotY = Math.ceil(indicatorGlow.texture.height / 2);
			this.addChild(indicatorGlow);
			
			// dark indicator
			indicatorDark = new Image(Assets.getSprite("AtlasTexture4").getTexture("SpecialDark0000"));
			indicatorDark.pivotX = Math.ceil(indicatorDark.texture.width  / 2); // center art on registration point
			indicatorDark.pivotY = Math.ceil(indicatorDark.texture.height / 2);
			this.addChild(indicatorDark);
			
			// no glow indicator for cooldown effect
			indicatorSprite = new Sprite();
			indicatorNoGlow = new Image(Assets.getSprite("AtlasTexture4").getTexture("SpecialNoGlow0000"));
			indicatorNoGlow.pivotX = Math.ceil(indicatorNoGlow.texture.width  / 2); // center art on registration point
			indicatorNoGlow.pivotY = Math.ceil(indicatorNoGlow.texture.height / 2);
			indicatorSprite.addChild(indicatorNoGlow);
			this.spriteClipRect = indicatorSprite.bounds;
			this.addChild(indicatorSprite);
			
			// sparkles
			sparklesAnimation = new MovieClip(Assets.getSprite("AtlasTexture4").getTextures("SpecialSparkle"), 10);
			sparklesAnimation.pivotX = Math.ceil(sparklesAnimation.texture.width  / 2); // center art on registration point
			sparklesAnimation.pivotY = Math.ceil(sparklesAnimation.texture.height / 2);
			sparklesAnimation.loop = false;
			this.addChild(sparklesAnimation);
			
			// blast
			blastAnimation = new MovieClip(Assets.getSprite("AtlasTexture4").getTextures("Blast"), 30);
			blastAnimation.pivotX = Math.ceil(blastAnimation.texture.width  / 2); // center art on registration point
			blastAnimation.pivotY = Math.ceil(blastAnimation.texture.height / 2);
			blastAnimation.loop = false;
			this.addChild(blastAnimation);
		}
		
		public function blast():void {
			indicatorGlow.visible = false;
			starling.core.Starling.juggler.remove(sparklesAnimation);
			sparklesAnimation.visible = false;
			
			starling.core.Starling.juggler.add(blastAnimation);
			blastAnimation.visible = true;
			blastAnimation.stop();
			blastAnimation.play();
		}
		
		public function turnOff():void {
			indicatorGlow.visible = false;
			indicatorDark.visible = true;
			indicatorSprite.visible = true;
			starling.core.Starling.juggler.remove(sparklesAnimation);
			sparklesAnimation.visible = false;
		}
		
		public function turnOn():void {
			indicatorDark.visible = false;
			indicatorSprite.visible = false;
			indicatorGlow.visible = true;
			starling.core.Starling.juggler.add(sparklesAnimation);
			sparklesAnimation.visible = true;
			sparklesAnimation.stop();
			sparklesAnimation.play();
		}
		
		public function updateClipRectByRatio(ratio:Number):void {
			this.spriteClipRect = indicatorDark.bounds;
			this.spriteClipRect.offset(0, this.spriteClipRect.height * (1 - ratio));
			indicatorSprite.clipRect = this.spriteClipRect;
		}
	}
}