package
{
	
	import starling.display.Sprite;
	
	/**
	 * This class represents a game element
	 */
	public class GameObject extends Sprite
	{
		// game coordinate location
		private var _gx:Number;
		private var _gy:Number;
		
		public function GameObject() {
			this.touchable = false;
			this._gx = 0;
			this._gy = 0;
		}
		
		public function get gx():Number
		{
			return this._gx;
		}
		
		public function set gx(value:Number):void
		{
			this._gx = value;
//			this.x = int(Constants.StageWidth / 2 + (value - Camera.gx));
			this.x = int(Constants.StageWidth / 2 + value);
		}
		
		public function get gy():Number
		{
			return this._gy;
		}
		
		public function set gy(value:Number):void
		{
			this._gy = value;
			this.y = int(Constants.StageHeight / 2 - (value - Statics.cameraGy));
		}
	}
}