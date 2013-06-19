package com.jumpGame.screens
{
	import com.jumpGame.customObjects.Font;
	import com.jumpGame.events.NavigationEvent;
	
	import flash.external.ExternalInterface;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.system.DeviceCapabilities;
	import feathers.themes.MetalWorksMobileTheme;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Menu extends Sprite
	{
		protected var theme:MetalWorksMobileTheme;
		protected var button:Button;
		private var label:Label;
		private var fontBadabb:Font;
		private var communicator:Communicator = null;
		
		public function Menu()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			
			// Javascript Callbacks
			ExternalInterface.addCallback("returnFbId", returnFbId);
			
			this.communicator = new Communicator();
		}
		
		private function dataReceived(event:NavigationEvent):void {
			var data:String = event.params.data;
			trace(event.params.data);
			
			if (event.params.data != null) {
				var dataObj:Object = JSON.parse(data);
				if (dataObj.hasOwnProperty("status")) {
					if (dataObj.status == "found") {
						label.text = "Welcome back, " + dataObj.first_name + ". High Score: " + dataObj.score;
					}
					else if (dataObj.status == "new") {
						label.text = "Welcome, " + dataObj.first_name;
					}
					this.button.visible = true;
				} else {
					trace("Communication error!");
				}
			}
		}
		
		private function returnFbId(fbId:int):void {
			trace("Facebook id: " + fbId);
		}
		
		protected function addedToStageHandler( event:Event ):void
		{
			DeviceCapabilities.dpi = 326; //simulate iPhone Retina resolution
			this.theme = new MetalWorksMobileTheme(this.stage);
			
			// score label
			label = new Label();
			label.text = "Connecting to Game Server...";
			label.width = Constants.StageWidth;
			label.height = 50;
			label.x = (this.stage.stageWidth - label.width) / 2;
			label.y = (this.stage.stageHeight - label.height) / 2 - 100;
			this.addChild( label );
			
			// start button
			this.button = new Button();
			this.button.label = "Play!";
			this.button.width = 200;
			this.button.height = 100;
			this.button.x = (this.stage.stageWidth - this.button.width) / 2;
			this.button.y = (this.stage.stageHeight - this.button.height) / 2;
			this.button.visible = false;
			this.addChild( button );
			this.button.addEventListener( Event.TRIGGERED, button_triggeredHandler );
		}
		
		private function button_triggeredHandler( event:Event ):void
		{
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "play"}, true));
		}
		
		public function initialize():void
		{
			label.text = "Connecting to Game Server...";
			this.button.visible = false;
			this.visible = true;
			
			this.communicator.addEventListener(NavigationEvent.RESPONSE_RECEIVED, dataReceived);
			this.communicator.retrieveUserData();
		}
		
		public function disposeTemporarily():void
		{
			this.visible = false;
		}
	}
}