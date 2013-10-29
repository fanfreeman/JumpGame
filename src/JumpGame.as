package
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.utils.getDefinitionByName;
	import flash.ui.ContextMenu;
//	import flash.display3D.Context3DRenderMode;
//	import flash.display3D.Context3DProfile;
	
	[SWF(width = "756", height = "650", frameRate = "60", backgroundColor = "#4a4137")]
	
	public class JumpGame extends MovieClip
	{
		[Embed(source="../media/graphics/logo.png")]
		private static var logoImage:Class;
		
		private var logoBitmap:Bitmap;
		private var barSprite:Sprite;
		
//		private var myStarling:Starling;
		private static const PROGRESS_BAR_HEIGHT:Number = 20;
		
		/**.k   
		 * This is typed as Object so that the compiler doesn't include the
		 * starling.core.Starling class in frame 1. We'll access the Starling
		 * class dynamically once the SWF is completely loaded.
		 */
		private var _starling:Object;
		
		public function JumpGame()
		{
//			super();
//			
//			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			var menu:ContextMenu = new ContextMenu();
			menu.hideBuiltInItems();
			this.contextMenu = menu;
			
			logoBitmap = new logoImage() as Bitmap;
			this.addChild(logoBitmap);
			
			barSprite = new Sprite();
			this.addChild(barSprite);
			
			this.stop();
			
			//the two most important events for preloading
			this.loaderInfo.addEventListener(ProgressEvent.PROGRESS, loaderInfo_progressHandler);
			this.loaderInfo.addEventListener(Event.COMPLETE, loaderInfo_completeHandler);
		}
		
		/**
		 * You'll get occasional progress updates here. event.bytesLoaded / event.bytesTotal
		 * will give you a value between 0 and 1. Multiply by 100 to get a value
		 * between 0 and 100.
		 */
		private function loaderInfo_progressHandler(event:ProgressEvent):void
		{
			//this example draws a basic progress bar
			barSprite.graphics.clear();
			barSprite.graphics.beginFill(0xcccccc);
			barSprite.graphics.drawRect(0, (this.stage.stageHeight - PROGRESS_BAR_HEIGHT),
				this.stage.stageWidth * event.bytesLoaded / event.bytesTotal, PROGRESS_BAR_HEIGHT);
			barSprite.graphics.endFill();
		}
		
		/**
		 * The entire SWF has finished loading when this listener is called.
		 */
		private function loaderInfo_completeHandler(event:Event):void
		{
			//get rid of the progress bar
			barSprite.graphics.clear();
			
			this.removeChild(logoBitmap);
			this.removeChild(barSprite);
			logoBitmap = null;
			barSprite = null;
			
			//go to frame two because that's where the classes we need are located
			this.gotoAndStop(2);
			
			//getDefinitionByName() will let us access the classes without importing
			const StarlingType:Class = getDefinitionByName("starling.core.Starling") as Class;
			const GameType:Class = getDefinitionByName("Game") as Class;
			this._starling = new StarlingType(GameType, this.stage); // baseline_constrained
//			this._starling = new StarlingType(GameType, this.stage, null, null, Context3DRenderMode.AUTO, Context3DProfile.BASELINE_EXTENDED);
			this._starling.antiAliasing = 1;
			this._starling.showStats = true;
			this._starling.showStatsAt("left", "bottom");
			this._starling.start();
		}
		
//		protected function onAddedToStage(event:Event):void
//		{
//			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
//			
//			// Initialize Starling object.
//			myStarling = new Starling(Game, stage);
//			
//			// Define basic anti aliasing.
//			myStarling.antiAliasing = 1;
//			
//			// Show statistics for memory usage and fps.
//			myStarling.showStats = true;
//			
//			// Position stats.
//			myStarling.showStatsAt("left", "bottom");
//			
//			// Start Starling Framework.
//			myStarling.start();
//		}
	}
}