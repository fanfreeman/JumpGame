package com.jumpGame.gameElements
{
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.events.Event;

	public class SofLayer extends GameObject
	{
		private var waveAnim1:MovieClip;
		private var waveAnim2:MovieClip;
		private var flipState:uint = 0;
		private var _parallaxDepth:Number;
		
		public function SofLayer()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			// add two sea of fire waves side by side
			waveAnim1 = new MovieClip(Assets.getSprite("AtlasTexture3").getTextures("Wave"), 24);
			waveAnim2 = new MovieClip(Assets.getSprite("AtlasTexture3").getTextures("Wave"), 24);
			waveAnim1.x = 0;
			waveAnim1.y = 0;
			
			waveAnim2.scaleX = -1;
			waveAnim2.x = (Constants.SofWidth + 1) * 2;
			waveAnim2.y = waveAnim1.y;
			
			starling.core.Starling.juggler.add(waveAnim1);
			starling.core.Starling.juggler.add(waveAnim2);

			this.addChild(waveAnim1);
			this.addChild(waveAnim2);
		}
		
		// flip a <> wave configuration to a >< configuration
		public function flip():void {
			if (this.flipState == 0) {
				waveAnim1.scaleX = -1;
				waveAnim2.scaleX = 1;
				waveAnim1.x = Constants.SofWidth + 1;
				waveAnim2.x = Constants.SofWidth - 1;
				this.flipState = 1;
			} else {
				waveAnim1.scaleX = 1;
				waveAnim2.scaleX = -1;
				waveAnim1.x = 0;
				waveAnim2.x = (Constants.SofWidth + 1) * 2;
				this.flipState = 0;
			}
		}
		
		public function get parallaxDepth():Number { return _parallaxDepth; }
		public function set parallaxDepth(value:Number):void { _parallaxDepth = value; }
	}
}