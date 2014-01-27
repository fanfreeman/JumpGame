package com.jumpGame.customObjects
{
	import flash.external.ExternalInterface;

	public class Mixpanel
	{
		public function Mixpanel()
		{
		}
		
		public function track(eventName:String, details:Object = null):void {
			if(ExternalInterface.available) {
				if (details == null)  ExternalInterface.call("mixpanelTrack", eventName, null);
				else ExternalInterface.call("mixpanelTrack", eventName, JSON.stringify(details));
			}
		}
	}
}