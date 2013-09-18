package com.jumpGame.gameElements
{
	import com.jumpGame.level.Statics;
	
	public class Camera
	{
		// camera position in global coordinates
		public static var gx:Number = 0.0;
		public static var gy:Number = 0.0;
		
		// camera velocity
		public static var dx:Number = 0.0;
		public static var dy:Number = 0.0;
		
		// move camera by following hero
		public static function update(heroGx:Number, heroGy:Number):void {
			//var targetX:Number = (Camera.nextPlatformX + heroGx) / 2;
			var targetX:Number = heroGx;
			var targetY:Number = heroGy + Statics.cameraTargetModifierY;
			
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
			if (Statics.gameMode == Constants.ModeBonus) {
				var cameraEasingFactorX:Number = 20 - Math.abs(targetX - Camera.gx) / 10;
				if (cameraEasingFactorX < 5) cameraEasingFactorX = 5;
				var d2x:Number = 0.0; // camera acceleration
				if (targetX >= Camera.gx + Constants.CameraBoundRight) { // move camera right
					d2x = ((targetX - Constants.CameraBoundRight - Camera.gx) - Camera.dx * cameraEasingFactorX) / (0.5 * cameraEasingFactorX * cameraEasingFactorX);
				}
				else if (targetX + Constants.CameraBoundLeft <= Camera.gx) { // move camera left
					d2x = ((targetX + Constants.CameraBoundLeft - Camera.gx) - Camera.dx * cameraEasingFactorX) / (0.5 * cameraEasingFactorX * cameraEasingFactorX);
				}
				else { // bring camera to rest
					d2x = -Camera.dx / cameraEasingFactorX;
				}
				Camera.dx += d2x;
				Camera.gx += Camera.dx;
			}
			
			// y
			var cameraEasingFactorY:Number = 15 - Math.abs(targetY - Camera.gy) / 10;
			if (cameraEasingFactorY < 5) cameraEasingFactorY = 5;
			var d2y:Number = 0.0; // camera acceleration
			if (targetY >= Camera.gy + Constants.CameraBoundTop) { // move camera up
				d2y = ((targetY - Constants.CameraBoundTop - Camera.gy) - Camera.dy * cameraEasingFactorY) / (0.5 * cameraEasingFactorY * cameraEasingFactorY);
			}
			else if (targetY + Constants.CameraBoundBottom <= Camera.gy) { // move camera down
				d2y = ((targetY + Constants.CameraBoundBottom - Camera.gy) - Camera.dy * cameraEasingFactorY) / (0.5 * cameraEasingFactorY * cameraEasingFactorY);
			}
			else { // bring camera to rest
				d2y = -Camera.dy / cameraEasingFactorY;
			}
			Camera.dy += d2y;
			Camera.gy += Camera.dy;
		}
		
		// reset all camera data for game restart
		public static function reset():void {
			Camera.gx = 0.0;
			Camera.gy = 0.0;
			Camera.dx = 0.0;
			Camera.dy = 0.0;
		}
	}
}