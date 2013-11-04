package com.jumpGame.ui
{
	import feathers.core.DisplayListWatcher;
	
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	
	public class JumpTheme extends DisplayListWatcher
	{
		protected var _scaleToDPI:Boolean;
		
		public function JumpTheme(container:DisplayObjectContainer = null, scaleToDPI:Boolean = true)
		{
			if(!container)
			{
				container = Starling.current.stage;
			}
			super(container)
			this._scaleToDPI = scaleToDPI;
			this.initialize();
		}
		
		protected function initialize():void
		{
//			const scaledDPI:int = DeviceCapabilities.dpi / Starling.contentScaleFactor;
//			this._originalDPI = scaledDPI;
//			if(this._scaleToDPI)
//			{
//				if(DeviceCapabilities.isTablet(Starling.current.nativeStage))
//				{
//					this._originalDPI = ORIGINAL_DPI_IPAD_RETINA;
//				}
//				else
//				{
//					this._originalDPI = ORIGINAL_DPI_IPHONE_RETINA;
//				}
//			}
//			
//			this.scale = scaledDPI / this._originalDPI;
			
		}
	}
}