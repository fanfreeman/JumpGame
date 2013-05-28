package
{
	import starling.display.Sprite;
	
	/**
	 * A game element that does not repond to physics
	 */
	public class GameObject extends Sprite
	{
		// custom location
		public var mx:Number;
		public var my:Number;
		
		public function setX(newX:Number):void {			
			this.mx = newX;
			this.x = stage.stageWidth / 2 + newX;
		}
		
		public function setY(newY:Number):void {
			this.my = newY;
			this.y = stage.stageHeight / 2 - newY;
		}
	}
}