package com.oaxoa.fx {
	import flash.display.Sprite;
	import com.oaxoa.fx.Lightning;
	import flash.filters.GlowFilter;
	
	public class MyLightning extends Sprite {
		
		private var lightning:Lightning;
		private var glow:GlowFilter;
		
		public function MyLightning() {
			
			lightning = new Lightning();
			addChild(lightning);
			
			glow = new GlowFilter();
			glow.strength = 3.5;
			glow.quality = 3;
			glow.blurX = glow.blurY = 10;
//			lightning.filters = [glow];
			
//			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
//			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		public function init(_startX:int, _startY:int, _endX:int, _endY:int, _type:String = 'discharge', _color:uint = 0xddeeff):void {
//			lightning.color = _color;
			lightning.startX = _startX;
			lightning.startY = _startY;
			lightning.endX = _endX;
			lightning.endY = _endY;
			
			glow.color = _color;
			lightning.filters = [glow];
			
			LightningType.setType(lightning, _type);
		}
		
		public function updatePosition(_startX:int, _startY:int, _endX:int, _endY:int):void {
			lightning.startX = _startX;
			lightning.startY = _startY;
			lightning.endX = _endX;
			lightning.endY = _endY;
			lightning.update();
		}
		
//		private function onAddedToStage(event:Event):void{
//			addEventListener(Event.ENTER_FRAME, onFrame);
//		}
//		
//		private function onRemovedFromStage(event:Event):void{
//			removeEventListener(Event.ENTER_FRAME, onFrame);
//		}
//		
//		private function onFrame(event:Event):void {
//			lightning.update();
//		}
	}
}