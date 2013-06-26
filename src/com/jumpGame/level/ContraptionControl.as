package com.jumpGame.level
{
	import com.jumpGame.customObjects.ParkMiller;
	import com.jumpGame.events.NavigationEvent;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import starling.events.EventDispatcher;

	public class ContraptionControl extends EventDispatcher
	{
		public var trainInterval:Number = 10;
		public var hourglassInterval:Number = 10;
		public var bellInterval:Number = 30;
		
		private var pm:ParkMiller;
		
		public function ContraptionControl() {
			this.pm = new ParkMiller();
		}
		
		/** hourglass */
		public function scheduleNextHourglass():void {
			this.pm.seed = Math.random() * Math.floor(int.MAX_VALUE);
			var interval:Number = pm.standardNormal() * 2 * this.hourglassInterval; // interval in number of seconds
			trace ("next hourglass interval: " + interval);
			if (interval < 5) interval = 5;
			var delayTimer:Timer = new Timer(interval * 1000, 1);
			delayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, activateHourglass);
			delayTimer.start();
		}
		
		protected function activateHourglass(event:TimerEvent):void {
			if (event != null) {
				event.target.removeEventListener(TimerEvent.TIMER_COMPLETE, activateHourglass);
			}
			this.dispatchEvent(new NavigationEvent(NavigationEvent.HOURGLASS_SUMMON, null, true));
			//this.scheduleNextHourglass();
		}
		/** eof hourglass */
		
		/** train */
		public function scheduleNextTrain():void {
			//var interval:Number = Math.random() * (maxInterval - minInterval) + minInterval;
			this.pm.seed = Math.random() * Math.floor(int.MAX_VALUE);
			var interval:Number = pm.standardNormal() * 2 * this.trainInterval; // interval in number of seconds
			trace ("next train interval: " + interval);
			if (interval < 5) interval = 5;
			var delayTimer:Timer = new Timer(interval * 1000, 1);
			delayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, activateTrain);
			delayTimer.start();
		}
		
		protected function activateTrain(event:TimerEvent):void {
			if (event != null) {
				event.target.removeEventListener(TimerEvent.TIMER_COMPLETE, activateTrain);
			}
			this.dispatchEvent(new NavigationEvent(NavigationEvent.TRAIN_LAUNCH, null, true));
			//this.scheduleNextTrain();
		}
		/** eof train */
	}
}