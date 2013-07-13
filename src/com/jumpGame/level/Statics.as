package com.jumpGame.level
{
	import starling.extensions.PDParticleSystem;

	public class Statics
	{
		// particle emitters
		public static var particleLeaf:PDParticleSystem;
		public static var particleCharge:PDParticleSystem;
		public static var particleWind:PDParticleSystem;
		
		// normal/bonus/preparation mode
		public static var gameMode:uint;
		
		// preparation step
		public static var preparationStep:uint;
		
		// game time since start in milliseconds
		public static var gameTime:int;
		
		// number of seconds of bonus mode time available
		public static var bonusTime:int;
		
		// number of milliseconds of bonus mode time left
		public static var bonusTimeLeft:int;
		
		// next musical note to play when a star is touched
		public static var nextStarNote:int;
		
		// whether game is rendering through hardware
		public static var isHardwareRendering:Boolean;
		
		// camera shake duration and intensity
		public static var cameraShake:Number;
		
		// position of next platform
		public static var nextPlatformX:Number;
		public static var nextPlatformY:Number;
		
		// allows disabling of powerups when one is in progress
		public static var powerupsEnabled:Boolean
		
		// attractor power indicator
		public static var attractorOn:Boolean;
	}
}