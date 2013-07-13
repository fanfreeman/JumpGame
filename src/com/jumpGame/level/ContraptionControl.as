package com.jumpGame.level
{
	public class ContraptionControl
	{
		public var intervals:Array;
		private var expirationTimes:Array;
		private var checkResults:Array;
		
		public var isBellActive:Boolean;
		
//		private var pm:ParkMiller;
		
		public function ContraptionControl() {
			this.intervals = new Array(5);
			this.expirationTimes = new Array(5); // hourglass, train, bell
			this.checkResults = new Array(5);
			this.isBellActive = false;
//			this.pm = new ParkMiller();
		}
		
		public function scheduleNext(contraptionIndex:uint):void {
			//this.pm.seed = Math.random() * Math.floor(int.MAX_VALUE);
			//var interval:Number = pm.standardNormal() * 2 * this.intervals[contraptionIndex]; // interval in number of seconds
			var interval:Number = this.intervals[contraptionIndex];
			if (interval < 5) interval = 5;
			this.expirationTimes[contraptionIndex] = Statics.gameTime + int(interval * 1000);
			trace("scheduling: " + contraptionIndex + " at " + this.expirationTimes[contraptionIndex] + " for " + interval);
		}
		
		// check if a contraption should be launched
		public function checkSchedules():Array {
			this.checkResults[0] = Statics.gameTime > this.expirationTimes[Constants.ContraptionHourglass];
			this.checkResults[1] = Statics.gameTime > this.expirationTimes[Constants.ContraptionTrain];
			this.checkResults[2] = Statics.gameTime > this.expirationTimes[Constants.ContraptionTrainFromLeft];
			this.checkResults[3] = Statics.gameTime > this.expirationTimes[Constants.ContraptionBell];
			this.checkResults[4] = Statics.gameTime > this.expirationTimes[Constants.ContraptionPowerupBoxes];
			return this.checkResults;
		}
	}
}