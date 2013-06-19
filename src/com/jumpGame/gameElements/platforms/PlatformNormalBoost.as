package com.jumpGame.gameElements.platforms
{
	import starling.display.Image;

	public class PlatformNormalBoost extends PlatformNormal
	{
		public function PlatformNormalBoost(size:int)
		{
			super(size);
		}
		
		override protected function createPlatformArt():void {
			super.createPlatformArt();
			var image:Image = new Image(Assets.getSprite("AtlasTexturePlatforms").getTexture("NormalTriangle"));
			image.scaleX = this.size / Constants.PlatformMaxSize;
			image.scaleY = this.size / Constants.PlatformMaxSize;
			image.x = Math.ceil(-image.width/2); // center art on registration point
			image.y = Math.ceil(-image.height/2);
			this.addChild(image);
		}
		
		override public function getBouncePower():Number {
			return Constants.BoostBouncePower;
		}
	}
}