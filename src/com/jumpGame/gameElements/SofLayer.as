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
		private var blurValue:uint;
		
		public function SofLayer(blurValue:uint)
		{
			super();
			this.blurValue = blurValue;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			// add two sea of fire waves side by side
			if (this.blurValue == 0) {
				waveAnim1 = new MovieClip(Assets.getSprite("AtlasTexture5").getTextures("WaveBlur0"), 16);
				waveAnim2 = new MovieClip(Assets.getSprite("AtlasTexture5").getTextures("WaveBlur0"), 16);
			}
			else if (this.blurValue == 1) {
				waveAnim1 = new MovieClip(Assets.getSprite("AtlasTexture5").getTextures("WaveBlur1"), 16);
				waveAnim2 = new MovieClip(Assets.getSprite("AtlasTexture5").getTextures("WaveBlur1"), 16);
			}
			else if (this.blurValue == 2) {
				waveAnim1 = new MovieClip(Assets.getSprite("AtlasTexture5").getTextures("WaveBlur2"), 16);
				waveAnim2 = new MovieClip(Assets.getSprite("AtlasTexture5").getTextures("WaveBlur2"), 16);
			}
			
			waveAnim1.pivotX = Math.ceil(waveAnim1.width / 2);
			waveAnim1.pivotY = Math.ceil(waveAnim1.height / 2);
			waveAnim1.x = 0;
			waveAnim1.y = 0;
			
			waveAnim2.pivotX = Math.ceil(waveAnim2.width / 2);
			waveAnim2.pivotY = Math.ceil(waveAnim2.height / 2);
			waveAnim2.scaleX = -1;
			waveAnim2.x = Constants.SofWidth;
			waveAnim2.y = 0;
			
			starling.core.Starling.juggler.add(waveAnim1);
			starling.core.Starling.juggler.add(waveAnim2);

			this.addChild(waveAnim1);
			this.addChild(waveAnim2);
		}
		
		/**
		 * Flip the two wave segments so that they form a continuous line
		 * >< to <> and vice versa
		 */
		public function flip():void {
			if (this.flipState == 0) {
				waveAnim1.scaleX = -1;
				waveAnim2.scaleX = 1;
//				waveAnim1.x = Constants.SofWidth + 1;
//				waveAnim2.x = Constants.SofWidth - 1;
				this.flipState = 1;
			} else {
				waveAnim1.scaleX = 1;
				waveAnim2.scaleX = -1;
//				waveAnim1.x = 0;
//				waveAnim2.x = (Constants.SofWidth + 1) * 2;
				this.flipState = 0;
			}
		}
		
		public function get parallaxDepth():Number { return _parallaxDepth; }
		public function set parallaxDepth(value:Number):void { _parallaxDepth = value; }
	}
}