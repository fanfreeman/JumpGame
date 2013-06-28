package com.jumpGame.events
{
	import starling.events.Event;
	
	/**
	 * This class defines custom events for navigation in the game.
	 */
	public class NavigationEvent extends Event
	{
		// change of screen		
		public static const CHANGE_SCREEN:String = "changeScreen";
		
		// communicator data received
		public static const RESPONSE_RECEIVED:String = "responseReceived";
		
		// summon hourglass
		public static const HOURGLASS_SUMMON:String = "hourglassSummon";
		
		// launch train
		public static const TRAIN_LAUNCH:String = "trainLaunch";
		
		// drop bell
		public static const DROP_BELL:String = "dropBell";
		
		/** Custom object to pass parameters to the screens. */
		public var params:Object;
		
		public function NavigationEvent(type:String, _params:Object, bubbles:Boolean=false)
		{
			super(type, bubbles);
			params = _params;
		}
	}
}