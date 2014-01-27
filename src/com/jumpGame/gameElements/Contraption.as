package com.jumpGame.gameElements
{
	public class Contraption extends GameObject implements IPoolable
	{
		protected var _destroyed:Boolean = true; // required by interface
		
		public function Contraption() {
			this.createArt();
		}
		
		protected function createArt():void {}
		
		public function initialize():void {}
		
		public function update(timeDiff:Number):void {
			this.gx = this.gx;
			this.gy = this.gy;
		}
		
		protected function hide():void
		{
			this.visible = false;
		}
		
		protected function show():void
		{
			this.visible = true;
		}
		
		// methods required by interface
		
		public function get destroyed():Boolean
		{
			return _destroyed;
		}
		
		public function renew():void
		{
			if (!_destroyed) { return; }
			_destroyed = false;
		}
		
		public function destroy():void
		{
			if (_destroyed) { return; }
			_destroyed = true;
			this.hide();
		}
	}
}