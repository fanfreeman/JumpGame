package com.jumpGame.screens
{
	import com.jumpGame.customObjects.Font;
	import com.jumpGame.events.NavigationEvent;
	
	import flash.external.ExternalInterface;
	import flash.text.TextFormat;
	
	import feathers.controls.Button;
	import feathers.controls.Callout;
	import feathers.controls.Label;
	import feathers.controls.text.BitmapFontTextRenderer;
	import feathers.core.ITextRenderer;
	import feathers.system.DeviceCapabilities;
	import feathers.text.BitmapFontTextFormat;
	import feathers.themes.MetalWorksMobileTheme;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.BitmapFont;
	
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
			this.communicator.retrieveUserData();
		}
		
		private function returnFbId(fbId:int):void {
			trace("Facebook id: " + fbId);
		}
		
		protected function addedToStageHandler( event:Event ):void
		{
			DeviceCapabilities.dpi = 326; //simulate iPhone Retina
			//this.fontBadabb = Fonts.getFont("Badabb");
			
			//this.theme = new AeonDesktopTheme( this.stage );
			this.theme = new MetalWorksMobileTheme(this.stage);
			label = new Label();
			label.text = "Connecting to Game Server...";
			label.width = 330;
			label.height = 50;
			label.x = (this.stage.stageWidth - label.width) / 2;
			label.y = (this.stage.stageHeight - label.height) / 2 - 100;
			this.addChild( label );
			
			this.addEventListener(Event.ENTER_FRAME, tick);
		}
		
		private function addStartButton():void {
			this.button = new Button();
			//			this.button.labelFactory = function():ITextRenderer {
			//				var renderer:BitmapFontTextRenderer = new BitmapFontTextRenderer();
			//				
			//				renderer.textFormat = new BitmapFontTextFormat(Fonts.getBitmapFont("Badabb"), NaN, 0xffffff);
			//				return renderer;
			//			}
			//			this.button.defaultLabelProperties.textFormat = new BitmapFontTextFormat(this._font, 50, 0xffffff);
			//			textRendererFactory = function():ITextRenderer {
			//				var renderer : TextFieldTextRenderer = new TextFieldTextRenderer();
			//				renderer.isHTML = true;
			//				//renderer.embedFonts = true;
			//				renderer.textFormat = new TextFormat( "Arial", 24, 0x323232 );
			//				return renderer;
			//			};
			this.button.label = "Play!";
			this.button.width = 200;
			this.button.height = 100;
			this.button.x = (this.stage.stageWidth - this.button.width) / 2;
			this.button.y = (this.stage.stageHeight - this.button.height) / 2;
			
			//			this.button.validate();
			this.addChild( button );
			this.button.addEventListener( Event.TRIGGERED, button_triggeredHandler );
		}
		
		private function tick(event:Event):void {
			// read data from communicator
			var data:String = this.communicator.readData();
			if (data != null) {
				var dataObj:Object = JSON.parse(data);
				if (dataObj.hasOwnProperty("status")) {
					if (dataObj.status == "found") {
						this.addStartButton();
						label.text = "Welcome back, " + dataObj.first_name + " Score: " + dataObj.score;
					}
					else if (dataObj.status == "new") {
						this.addStartButton();
						label.text = "Welcome, " + dataObj.first_name;
					}
				} else {
					trace("Communication error!");
				}
			}
		}
		
		private function button_triggeredHandler( event:Event ):void
		{
//			const label:Label = new Label();
//			label.text = "Hi, I'm Feathers!\nHave a nice day.";
//			Callout.show(label, this.button);
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "play"}, true));
		}
		
		public function initialize():void
		{
			this.visible = true;
		}
		
		public function disposeTemporarily():void
		{
			this.visible = false;
			if (this.hasEventListener(Event.ENTER_FRAME)) this.removeEventListener(Event.ENTER_FRAME, tick);
		}
	}
}