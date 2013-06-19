package
{
	import com.jumpGame.gameElements.Camera;
	
	import starling.display.Sprite;
	
	/**
	 * This class represents a game element
	 */
	public class GameObject extends Sprite
	{
		// game coordinate location
		private var _gx:Number;
		private var _gy:Number;
		
		public function get gx():Number
		{
			return this._gx;
		}
		
		public function set gx(value:Number):void
		{
			this._gx = value;
			this.x = Constants.StageWidth / 2 + (value - Camera.gx);
		}
		
		public function get gy():Number
		{
			return this._gy;
		}
		
		public function set gy(value:Number):void
		{
			this._gy = value;
			this.y = Constants.StageHeight / 2 - (value - Camera.gy);
		}
	}
}