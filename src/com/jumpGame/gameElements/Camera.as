package com.jumpGame.gameElements
{
	public class Camera
	{
		// camera position in global coordinates
		public static var gx:Number = 0.0;
		public static var gy:Number = 0.0;
		
		// camera velocity
		public static var dx:Number = 0.0;
		public static var dy:Number = 0.0;
		
		// move camera by following hero
		public static function update(heroGy:Number):void {
			// move camera by setting
			// target distance to camera bounds box borders
			// time to a constant
			// initial velocity to camera's current velocity
			// solve for camera acceleration
			
			// if camera is within the camera bounds box
			// solve for camera acceleration given current velocity, zero final velocity, and constant time
			var d2y:Number = 0.0; // camera acceleration
			if (heroGy >= Camera.gy + Constants.CameraBoundTop) {
				d2y = ((heroGy - Constants.CameraBoundTop - Camera.gy) - Camera.dy * Constants.CameraEasingTime) / (0.5 * Constants.CameraEasingTime * Constants.CameraEasingTime);
			}
			else if (heroGy + Constants.CameraBoundBottom <= Camera.gy) {
				d2y = ((heroGy + Constants.CameraBoundBottom - Camera.gy) - Camera.dy * Constants.CameraEasingTime) / (0.5 * Constants.CameraEasingTime * Constants.CameraEasingTime);
			}
			else {
				d2y = -Camera.dy / Constants.CameraEasingTime;
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