package
{
//	import flash.display.Bitmap;
//	import flash.display.DisplayObject;
	import flash.display.MovieClip;
//	import flash.display.Sprite;
//	import flash.display.StageAlign;
//	import flash.display.StageScaleMode;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.UncaughtErrorEvent;
	import flash.external.ExternalInterface;
	import flash.system.Capabilities;
	import flash.system.Security;
//	import flash.ui.ContextMenu;
//	import flash.utils.getDefinitionByName;
	
	import starling.core.Starling;
	import starling.events.Event;
	import starling.utils.AssetManager;
	
	[SWF(width = "756", height = "650", frameRate = "60", backgroundColor = "#4a4137")]
	
	public class JumpGame extends MovieClip
	{
//		private const STARTUP_CLASS:String = "JumpStart";
		private var mStarling:Starling;
		
		public function JumpGame()
		{
			loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, uncaughtErrorHandler);
			Statics.startMixpanel();
			
			// load security policy files
//			Security.loadPolicyFile("https://www.raiderbear.com/crossdomain.xml");
			Security.allowDomain("raiderbear.com");
			Security.allowDomain("www.raiderbear.com");
//			Security.loadPolicyFile("http://d3et7r3ga59g4e.cloudfront.net/");
//			Security.loadPolicyFile("http://profile.ak.fbcdn.net/crossdomain.xml");
			Security.loadPolicyFile("https://fbcdn-profile-a.akamaihd.net/crossdomain.xml");
			
			addEventListener(flash.events.Event.ADDED_TO_STAGE, onAddedToStage);
			stop();
		}
		
		private function uncaughtErrorHandler(event:UncaughtErrorEvent):void {
			if (event.error is Error) {
				var error:Error = event.error as Error;
				var errorString:String = error.getStackTrace();
				if (!errorString) errorString = error.toString();
				if(ExternalInterface.available) ExternalInterface.call("kissTrack", "error: " + errorString);
//				trace("error handler: " + errorString);
			}
			else if (event.error is ErrorEvent) {
				var errorEvent:ErrorEvent = event.error as ErrorEvent;
				if(ExternalInterface.available) ExternalInterface.call("kissTrack", "error event: " + errorEvent.toString());
//				trace("error event handler: " + errorEvent.toString());
			}
			else
			{
				// a non-Error, non-ErrorEvent type was thrown and uncaught
			}
		}
		
		private function onAddedToStage(event:flash.events.Event):void 
		{
//			stage.scaleMode = StageScaleMode.SHOW_ALL;
//			stage.align = StageAlign.TOP_LEFT;
//			
//			var menu:ContextMenu = new ContextMenu();
//			menu.hideBuiltInItems();
//			this.contextMenu = menu;
			
			removeEventListener(flash.events.Event.ADDED_TO_STAGE, onAddedToStage);
			start();
		}
		
		private function start():void
		{
			Starling.multitouchEnabled = true; // for Multitouch Scene
//			Starling.handleLostContext = true; // required on Windows, needs more memory
			
			//			mStarling = new Starling(Game, stage, null, null, Context3DRenderMode.SOFTWARE); // force software rendermode
			mStarling = new Starling(Game, stage);
			mStarling.antiAliasing = 0;
			// bof show starling stats //////////////////////////////////////////////////////
			//			mStarling.showStats = true;
			//			mStarling.showStatsAt("left", "bottom");
			// eof show starling stats //////////////////////////////////////////////////////
			//			mStarling.simulateMultitouch = true;
			mStarling.enableErrorChecking = Capabilities.isDebugger;
			mStarling.start();
			
			// this event is dispatched when stage3D is set up
			mStarling.addEventListener(starling.events.Event.ROOT_CREATED, onRootCreated);
		}
		
		private function onRootCreated(event:starling.events.Event, game:Game):void
		{
			// set framerate to 30 in software mode
			if (mStarling.context.driverInfo.toLowerCase().indexOf("software") != -1)
				mStarling.nativeStage.frameRate = 40;
			
			// define which resources to load
			var assets:AssetManager = new AssetManager();
			//			assets.verbose = Capabilities.isDebugger;
			assets.enqueue(Assets);
			
			// background texture is embedded, because we need it right away!
			//			var bgTexture:Texture = Texture.fromEmbeddedAsset(Background, false);
			
			// game will first load resources, then start menu
			game.start(assets);
		}
	}
}