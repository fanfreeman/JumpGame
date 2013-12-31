package com.jumpGame.ui.components
{
	
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.utils.deg2rad;
	
	public class TutorialPointer extends Sprite
	{
		private var pointer:Image;
		
		// masks to prevent clicking
		private var clickMask1:Quad;
		private var clickMask2:Quad;
		private var clickMask3:Quad;
		
		public function TutorialPointer()
		{
			super();
			
			// bg quad
			clickMask1 = new Quad(Statics.stageWidth, 370, 0x000000);
			clickMask1.alpha = 0;
			clickMask1.visible = false;
			this.addChild(clickMask1);
			
			// masks that only allow clicking on Start Game button
			clickMask2 = new Quad(Statics.stageWidth, 145, 0x000000);
			clickMask2.alpha = 0;
			clickMask2.visible = false;
			this.addChild(clickMask2);
			clickMask3 = new Quad(Statics.stageWidth, 435, 0x000000);
			clickMask3.y = 215;
			clickMask3.alpha = 0;
			clickMask3.visible = false;
			this.addChild(clickMask3);
			
			// masks that only allow clicking on Smart Match button
//			clickMask2 = new Quad(Statics.stageWidth, 292, 0x000000);
//			clickMask2.alpha = 0;
//			clickMask2.visible = false;
//			this.addChild(clickMask2);
//			clickMask3 = new Quad(272, Statics.stageHeight, 0x000000);
//			clickMask3.alpha = 0;
//			clickMask3.visible = false;
//			this.addChild(clickMask3);
//			clickMask4 = new Quad(275, Statics.stageHeight, 0x000000);
//			clickMask4.x = 482;
//			clickMask4.alpha = 0;
//			clickMask4.visible = false;
//			this.addChild(clickMask4);
//			clickMask5 = new Quad(Statics.stageWidth, 305, 0x000000);
//			clickMask5.y = 345;
//			clickMask5.alpha = 0;
//			clickMask5.visible = false;
//			this.addChild(clickMask5);
			// eof smart match button mask
			
			pointer = new Image(Statics.assets.getTexture("Arrow0000"));
			pointer.pivotX = Math.ceil(pointer.width / 2);
			pointer.pivotY = Math.ceil(pointer.height / 2);
			pointer.alpha = 0.8;
			this.addChild(pointer);
			this.visible = false;
		}
		
		/**
		 * Point down at something
		 */
		public function pointDownAt(x:Number, y:Number):void {
			this.visible = true;
			pointer.rotation = deg2rad(-90);
			this.pointer.x = x;
			this.pointer.y = y;
			Starling.juggler.tween(pointer, 0.2, {
				transition: Transitions.EASE_IN,
				repeatCount: 0,
				reverse: true,
				y: this.pointer.y - 30
			});
		}
		
		/**
		 * Point up at something
		 */
		public function pointUpAt(x:Number, y:Number):void {
			this.visible = true;
			pointer.rotation = deg2rad(90);
			this.pointer.x = x;
			this.pointer.y = y;
			Starling.juggler.tween(pointer, 0.2, {
				transition: Transitions.EASE_IN,
				repeatCount: 0,
				reverse: true,
				y: this.pointer.y + 30
			});
		}
		
		/**
		 * Point left at something
		 */
		private function pointLeftAt(x:Number, y:Number):void {
			this.visible = true;
			pointer.rotation = 0;
			this.pointer.x = x;
			this.pointer.y = y;
			Starling.juggler.tween(pointer, 0.2, {
				transition: Transitions.EASE_IN,
				repeatCount: 0,
				reverse: true,
				x: this.pointer.x + 30
			});
		}
		
		public function hide():void {
			clickMask1.visible = false;
			clickMask2.visible = false;
			clickMask3.visible = false;
//			clickMask4.visible = false;
//			clickMask5.visible = false;
			
			this.visible = false;
			Starling.juggler.removeTweens(pointer);
		}
		
		public function pointAtPlayBtn():void {
			clickMask1.visible = true;
			this.pointDownAt(Statics.stageWidth / 2, 480);
		}
		
		public function pointAtInstructionsNextBtn():void {
			clickMask1.visible = true;
			this.pointDownAt(585, 375);
		}
		
		public function pointAtStartGameBtn():void {
			clickMask2.visible = true;
			clickMask3.visible = true;
			this.pointUpAt(Statics.stageWidth / 2, 240);
		}
		
		public function pointAtSmartMatchBtn():void {
			this.pointLeftAt(Statics.stageWidth / 2 + 157, 318);
		}
		
		public function pointAtRankingsInvite():void {
			this.pointDownAt(Statics.stageWidth / 2, 480);
		}
	}
}