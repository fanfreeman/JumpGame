package com.jumpGame.level
{
	import com.jumpGame.customObjects.ParkMiller;

	public class ContraptionControl
	{
		public var intervals:Array;
		private var expirationTimes:Array;
		private var checkResults:Array;
		
		public var isBellActive:Boolean;
		
		private var pm:ParkMiller;
		
		public function ContraptionControl() {
			this.intervals = new Array(3);
			this.expirationTimes = new Array(3); // hourglass, train, bell
			this.checkResults = new Array(3);
			this.isBellActive = false;
			this.pm = new ParkMiller();
		}
		
		public function scheduleNext(contraptionIndex:uint):void {
			this.pm.seed = Math.random() * Math.floor(int.MAX_VALUE);
			var interval:Number = pm.standardNormal() * 2 * this.intervals[contraptionIndex]; // interval in number of seconds
			if (interval < 5) interval = 5;
			this.expirationTimes[contraptionIndex] = Statics.gameTime + int(interval * 1000);
			trace("scheduling: " + contraptionIndex + " at " + this.expirationTimes[contraptionIndex] + " for " + interval);
		}
		
		// check if a contraption should be launched
		public function checkSchedules():Array {
			this.checkResults[0] = Statics.gameTime > this.expirationTimes[Constants.ContraptionHourglass];
			this.checkResults[1] = Statics.gameTime > this.expirationTimes[Constants.ContraptionTrain];
			this.checkResults[2] = Statics.gameTime > this.expirationTimes[Constants.ContraptionBell];
			return this.checkResults;
		}
		
//		/** hourglass */
//		public function scheduleNextHourglass():void {
//			this.pm.seed = Math.random() * Math.floor(int.MAX_VALUE);
//			var interval:Number = pm.standardNormal() * 2 * this.hourglassInterval; // interval in number of seconds
//			trace ("next hourglass interval: " + interval);
//			if (interval < 5) interval = 5;
//			var delayTimer:Timer = new Timer(interval * 1000, 1);
//			delayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, activateHourglass);
//			delayTimer.start();
//		}
//		
//		protected function activateHourglass(event:TimerEvent):void {
//			if (event != null) {
//				event.target.removeEventListener(TimerEvent.TIMER_COMPLETE, activateHourglass);
//			}
//			this.dispatchEvent(new NavigationEvent(NavigationEvent.HOURGLASS_SUMMON, null, true));
//		}
//		/** eof hourglass */
//		
//		/** train */
//		public function scheduleNextTrain():void {
//			//var interval:Number = Math.random() * (maxInterval - minInterval) + minInterval;
//			this.pm.seed = Math.random() * Math.floor(int.MAX_VALUE);
//			var interval:Number = pm.standardNormal() * 2 * this.trainInterval; // interval in number of seconds
//			trace ("next train interval: " + interval);
//			if (interval < 5) interval = 5;
//			var delayTimer:Timer = new Timer(interval * 1000, 1);
//			delayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, activateTrain);
//			delayTimer.start();
//		}
//		
//		protected function activateTrain(event:TimerEvent):void {
//			if (event != null) {
//				event.target.removeEventListener(TimerEvent.TIMER_COMPLETE, activateTrain);
//			}
//			this.dispatchEvent(new NavigationEvent(NavigationEvent.TRAIN_LAUNCH, null, true));
//		}
		/** eof train */
	}
}