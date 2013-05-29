package
{
	import starling.display.Sprite;
	
	/**
	 * A game element
	 */
	public class GameObject extends Sprite
	{
		public function setX(mX:Number):void {
			this.x = stage.stageWidth / 2 + mX * Constants.M_TO_PX;
		}
		
		public function setY(mY:Number):void {
			this.y = stage.stageHeight / 2 - mY * Constants.M_TO_PX;
		}
	}
}