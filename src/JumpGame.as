package
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.system.Security;
	import flash.ui.ContextMenu;
	import flash.utils.getDefinitionByName;
	
	[SWF(width = "756", height = "650", frameRate = "60", backgroundColor = "#4a4137")]
	
	public class JumpGame extends MovieClip
	{
		[Embed(source="../media/graphics/logo.png")]
		private static var brandImage:Class;
		
		[Embed(source="../media/graphics/title/bg.png")]
		private static var titleBgImage:Class;
		
		[Embed(source="../media/graphics/title/logo.png")]
		private static var titleLogoImage:Class;
		
		[Embed(source="../media/graphics/title/boy.png")]
		private static var titleBoyImage:Class;
		
		[Embed(source="../media/graphics/title/girl.png")]
		private static var titleGirlImage:Class;
		
		// logo screen
		private var brandBitmap:Bitmap;
		
		// progress bars
//		private var barSpriteTop:Sprite;
//		private var barSpriteRight:Sprite;
		private var barSpriteBottom:Sprite;
//		private var barSpriteLeft:Sprite;
		
		// game title screen
		private var titleBgBitmap:Bitmap;
		private var titleLogoBitmap:Bitmap;
		private var titleBoyBitmap:Bitmap;
		private var titleGirlBitmap:Bitmap;
		
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
			
			// load security policy files
//			Security.loadPolicyFile("https://www.raiderbear.com/crossdomain.xml");
			Security.allowDomain("raiderbear.com");
			Security.allowDomain("www.raiderbear.com");
			Security.loadPolicyFile("http://profile.ak.fbcdn.net/crossdomain.xml");
			Security.loadPolicyFile("https://fbcdn-profile-a.akamaihd.net/crossdomain.xml");
			
			var menu:ContextMenu = new ContextMenu();
			menu.hideBuiltInItems();
			this.contextMenu = menu;
			
			brandBitmap = new brandImage() as Bitmap;
			brandBitmap.alpha = 0;
			this.addChild(brandBitmap);
			
			titleBgBitmap = new titleBgImage() as Bitmap;
			titleBgBitmap.alpha = 0;
			this.addChild(titleBgBitmap);
			
			titleLogoBitmap = new titleLogoImage() as Bitmap;
			titleLogoBitmap.x = 335;
			titleLogoBitmap.y = -titleLogoBitmap.height;
			this.addChild(titleLogoBitmap);
			
			titleBoyBitmap = new titleBoyImage() as Bitmap;
			titleBoyBitmap.x = 120;
			titleBoyBitmap.y = 650;
			this.addChild(titleBoyBitmap);
			
			titleGirlBitmap = new titleGirlImage() as Bitmap;
			titleGirlBitmap.x = 435;
			titleGirlBitmap.y = 650;
			this.addChild(titleGirlBitmap);
			
			// progress bars
//			barSpriteTop = new Sprite();
//			this.addChild(barSpriteTop);
			
//			barSpriteRight = new Sprite();
//			this.addChild(barSpriteRight);
			
			barSpriteBottom = new Sprite();
			this.addChild(barSpriteBottom);
			
//			barSpriteLeft = new Sprite();
//			this.addChild(barSpriteLeft);
			
			this.stop();
			
			TweenLite.to(brandBitmap, 1, {alpha: 1});
			TweenLite.to(titleBgBitmap, 1, {alpha: 1, delay: 3});
			TweenLite.to(titleBoyBitmap, 0.9, {y: 118, delay: 3.4, onComplete: boyYoyo});
			TweenLite.to(titleGirlBitmap, 0.5, {y: 358, delay: 3.8});
			TweenLite.to(titleLogoBitmap, 0.7, {y: PROGRESS_BAR_HEIGHT, delay: 3.6});
			
			var myTween:TweenLite;
			function boyYoyo():void {
				myTween = new TweenLite(titleBoyBitmap, 0.5, {ease: Linear.easeNone, y :138, onComplete:reverseTween, onReverseComplete:restartTween});
				TweenLite.to(titleGirlBitmap, 0.5, {ease: Linear.easeNone, y: 348});
//				TweenLite.to(titleLogoBitmap, 0.5, {ease: Quad.easeInOut, x: 315});
			}
			function reverseTween():void {
				myTween.reverse();
				TweenLite.to(titleGirlBitmap, 0.5, {ease: Linear.easeNone, y: 358});
//				TweenLite.to(titleLogoBitmap, 0.5, {ease: Quad.easeInOut, x: 335});
			}
			function restartTween():void {
				myTween.restart();
				TweenLite.to(titleGirlBitmap, 0.5, {ease: Linear.easeNone, y: 348});
//				TweenLite.to(titleLogoBitmap, 0.5, {ease: Quad.easeInOut, x: 315});
			}
			
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
			// update progress bars
//			barSpriteTop.graphics.clear();
//			barSpriteTop.graphics.beginFill(0xff6d00);
//			barSpriteTop.graphics.drawRect(0, 0, this.stage.stageWidth * event.bytesLoaded / event.bytesTotal, PROGRESS_BAR_HEIGHT);
//			barSpriteTop.graphics.endFill();
			
//			barSpriteRight.graphics.clear();
//			barSpriteRight.graphics.beginFill(0xff6d00);
//			barSpriteRight.graphics.drawRect(this.stage.stageWidth - PROGRESS_BAR_HEIGHT, 0, PROGRESS_BAR_HEIGHT, this.stage.stageHeight * event.bytesLoaded / event.bytesTotal);
//			barSpriteRight.graphics.endFill();
			
			barSpriteBottom.graphics.clear();
			barSpriteBottom.graphics.beginFill(0xcccccc);
//			barSpriteBottom.graphics.drawRect(this.stage.stageWidth, this.stage.stageHeight - PROGRESS_BAR_HEIGHT, -this.stage.stageWidth * event.bytesLoaded / event.bytesTotal, PROGRESS_BAR_HEIGHT);
			barSpriteBottom.graphics.drawRect(0, this.stage.stageHeight - PROGRESS_BAR_HEIGHT, this.stage.stageWidth * event.bytesLoaded / event.bytesTotal, PROGRESS_BAR_HEIGHT);
			barSpriteBottom.graphics.endFill();
			
//			barSpriteLeft.graphics.clear();
//			barSpriteLeft.graphics.beginFill(0xff6d00);
//			barSpriteLeft.graphics.drawRect(0, this.stage.stageHeight, PROGRESS_BAR_HEIGHT, -this.stage.stageHeight * event.bytesLoaded / event.bytesTotal);
//			barSpriteLeft.graphics.endFill();
		}
		
		/**
		 * The entire SWF has finished loading when this listener is called.
		 */
		private function loaderInfo_completeHandler(event:Event):void
		{
//			return; // for testing loading screen
			
			// kill tweens
			TweenLite.killTweensOf(brandBitmap);
			TweenLite.killTweensOf(titleBgBitmap);
			TweenLite.killTweensOf(titleBoyBitmap);
			TweenLite.killTweensOf(titleGirlBitmap);
			TweenLite.killTweensOf(titleLogoBitmap);
			
			// get rid of the progress bar
//			barSpriteTop.graphics.clear();
//			barSpriteRight.graphics.clear();
			barSpriteBottom.graphics.clear();
//			barSpriteLeft.graphics.clear();
			
			this.removeChild(brandBitmap);
			this.removeChild(titleBgBitmap);
			this.removeChild(titleBoyBitmap);
			this.removeChild(titleGirlBitmap);
			this.removeChild(titleLogoBitmap);
//			this.removeChild(barSpriteTop);
//			this.removeChild(barSpriteRight);
			this.removeChild(barSpriteBottom);
//			this.removeChild(barSpriteLeft);
			brandBitmap = null;
			titleBgBitmap = null;
			titleBoyBitmap = null;
			titleGirlBitmap = null;
			titleLogoBitmap = null;
//			barSpriteTop = null;
//			barSpriteRight = null;
			barSpriteBottom = null;
//			barSpriteLeft = null;
			
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