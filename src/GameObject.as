package
{
	import starling.display.Sprite;
	
	/**
	 * This class represents a game element
	 */
	public class GameObject extends Sprite
	{
		// custom location
		public var mx:Number;
		public var my:Number;
		
		public function setX(newX:Number):void {			
			this.mx = newX;
			this.x = Constants.StageWidth / 2 + newX;
		}
		
		public function setY(newY:Number):void {
			this.my = newY;
			this.y = Constants.StageHeight / 2 - newY;
		}
	}
}