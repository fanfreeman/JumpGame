package com.jumpGame.gameElements
{
	
	public class Camera
	{
		// camera position in global coordinates
		public var gx:Number;
		public var gy:Number;
		
		// camera velocity
		public var dx:Number;
		public var dy:Number;
		
		private var boundTop:Number;
		private var boundBottom:Number;
		
		public function initialize():void {
			gx = 0;
			gy = 0;
			dx = 0;
			dy = 0;
			boundTop = 0;
			boundBottom = 150;
		}
		
		// move camera by following hero
		public function update(heroGx:Number, heroGy:Number, heroDy):void {
			//var targetX:Number = (Camera.nextPlatformX + heroGx) / 2;
			var targetX:Number = heroGx;
			var targetY:Number = heroGy + Statics.cameraTargetModifierY;
			
			if (heroDy < -0.7) this.boundBottom = 0;
//			else if (heroDy < -0.3) this.boundBottom = 50;
			else this.boundBottom = 150;
			
			// move camera by setting
			// target distance to camera bounds box borders
			// time to a constant
			// initial velocity to camera's current velocity
			// solve for camera acceleration
			
			// if camera is within the camera bounds box
			// solve for camera acceleration given current velocity, zero final velocity, and constant time
			// easing factor is the time it takes to get there
			// d = vt + 0.5 * at^2
			
			// x
//			if (Statics.gameMode == Constants.ModeBonus) {
//				var cameraEasingFactorX:Number = 20 - Math.abs(targetX - Camera.gx) / 10;
//				if (cameraEasingFactorX < 5) cameraEasingFactorX = 5;
//				var d2x:Number = 0.0; // camera acceleration
//				if (targetX >= Camera.gx + Constants.CameraBoundRight) { // move camera right
//					d2x = ((targetX - Constants.CameraBoundRight - Camera.gx) - Camera.dx * cameraEasingFactorX) / (0.5 * cameraEasingFactorX * cameraEasingFactorX);
//				}
//				else if (targetX + Constants.CameraBoundLeft <= Camera.gx) { // move camera left
//					d2x = ((targetX + Constants.CameraBoundLeft - Camera.gx) - Camera.dx * cameraEasingFactorX) / (0.5 * cameraEasingFactorX * cameraEasingFactorX);
//				}
//				else { // bring camera to rest
//					d2x = -Camera.dx / cameraEasingFactorX;
//				}
//				Camera.dx += d2x;
//				Camera.gx += Camera.dx;
//			}
			
			// y
			var cameraEasingFactorY:Number = 15 - Math.abs(targetY - gy) / 10;
			if (cameraEasingFactorY < 5) cameraEasingFactorY = 5;
			var d2y:Number = 0.0; // camera acceleration
			if (targetY >= gy + boundTop) { // move camera up
				d2y = ((targetY - boundTop - gy) - dy * cameraEasingFactorY) / (0.5 * cameraEasingFactorY * cameraEasingFactorY);
			}
			else if (targetY + boundBottom <= gy) { // move camera down
				d2y = ((targetY + boundBottom - gy) - dy * cameraEasingFactorY) / (0.5 * cameraEasingFactorY * cameraEasingFactorY);
			}
			else { // bring camera to rest
				d2y = -dy / cameraEasingFactorY;
			}
			dy += d2y;
			gy += dy;
			
			Statics.cameraGy = this.gy;
		}
	}
}