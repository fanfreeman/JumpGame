package
{
	import flash.display.Sprite;
	import flash.system.Capabilities;
//	import flash.display3D.Context3DRenderMode;
	
	import starling.core.Starling;
	import starling.events.Event;
	import starling.utils.AssetManager;
	
	public class JumpStart extends Sprite
	{
		private var mStarling:Starling;
		
		public function JumpStart()
		{
			if (stage) start();
			else addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function start():void
		{
			Starling.multitouchEnabled = true; // for Multitouch Scene
			Starling.handleLostContext = true; // required on Windows, needs more memory
			
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
			mStarling.addEventListener(Event.ROOT_CREATED, onRootCreated);
		}
		
		private function onAddedToStage(event:Object):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			start();
		}
		
		private function onRootCreated(event:Event, game:Game):void
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