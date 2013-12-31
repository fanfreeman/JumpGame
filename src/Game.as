package
{
//	import com.adobe.images.JPGEncoder;
	import com.jumpGame.customObjects.ProgressBar;
	import com.jumpGame.events.NavigationEvent;
	import com.jumpGame.screens.InGame;
	import com.jumpGame.screens.Menu;
	import com.jumpGame.ui.SoundButton;
	
	import flash.system.System;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;

//	import flash.utils.ByteArray;
	
	
	/**
	 * This class is the primary Starling Sprite based class
	 * that triggers the different screens. 
	 */
	public class Game extends Sprite
	{
		private var mLoadingProgress:ProgressBar;
		private var screenMenu:Menu;
		private var screenInGame:InGame;
		private var soundButton:SoundButton;
		
//		private var jpgEncoder:JPGEncoder;
		
		public function Game()
		{
			// nothing to do here -- Startup will call "start" immediately.
//			super();
//			
//			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
//			this.jpgEncoder = new JPGEncoder();
//			ExternalInterface.addCallback('exportScreenshot', exportScreenshot);
		}
		
		public function start(assets:AssetManager):void
		{
			// The background is passed into this method for two reasons:
			// 
			// 1) we need it right away, otherwise we have an empty frame
			// 2) the Startup class can decide on the right image, depending on the device.
			
//			addChild(new Image(background));
			
			// The AssetManager contains all the raw asset data, but has not created the textures
			// yet. This takes some time (the assets might be loaded from disk or even via the
			// network), during which we display a progress indicator. 
			
			mLoadingProgress = new ProgressBar(756, 20);
//			mLoadingProgress.x = (stage.width - mLoadingProgress.width) / 2;
			mLoadingProgress.x = 0;
			mLoadingProgress.y = 650 * 0.7;
			addChild(mLoadingProgress);
			
			assets.loadQueue(function(ratio:Number):void
			{
				mLoadingProgress.ratio = ratio;
				
				// a progress bar should always show the 100% for a while,
				// so we show the main menu only after a short delay. 
				
				if (ratio == 1)
					Starling.juggler.delayCall(function():void
					{
//						mLoadingProgress.removeFromParent(true);
//						mLoadingProgress = null;
						mLoadingProgress.visible = false;
						initialize(assets);
					}, 0.15);
			});
		}
		
		private function initialize(assets:AssetManager):void {
			// initialize static vars
			Statics.stageWidth = stage.stageWidth;
			Statics.stageHeight = stage.stageHeight;
			Statics.initialize(assets);
			
			// start loading bgm
			Sounds.loadBgm();
			
			this.addEventListener(NavigationEvent.CHANGE_SCREEN, onChangeScreen);
			
			// menu screen
			screenMenu = new Menu();
			
			// game screen
			screenInGame = new InGame(screenMenu);
			
			// Create and add Sound/Mute button.
			soundButton = new SoundButton();
			soundButton.x = Statics.stageWidth - 46;
			soundButton.y = Statics.stageHeight - 90;
			soundButton.addEventListener(Event.TRIGGERED, onSoundButtonClick);
			this.addChild(soundButton)
				
			showMainMenu();
		}
		
		private function showMainMenu():void
		{
			if (screenMenu == null) {
				Starling.juggler.delayCall(showMainMenu, 0.5);
				return;
			}
			
			// now would be a good time for a clean-up 
			System.pauseForGCIfCollectionImminent(0);
			System.gc();
			
//			if (screenMenu == null) screenMenu = new Menu();
			if (!this.contains(screenMenu)) this.addChildAt(screenMenu, this.numChildren - 1);
			screenMenu.initialize();
		}
		
		private function showGame():void {
			// now would be a good time for a clean-up 
//			System.pauseForGCIfCollectionImminent(0);
//			System.gc();
			
//			if (screenInGame == null) screenInGame = new InGame();
			if (!this.contains(screenInGame)) this.addChildAt(screenInGame, this.numChildren - 1);
			screenInGame.initializeNormalMode();
		}
		
		/**
		 * On Game class added to stage. 
		 * @param event
		 * 
		 */
//		private function onAddedToStage(event:Event):void
//		{
//			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
//			
//			Statics.stageWidth = stage.stageWidth;
//			Statics.stageHeight = stage.stageHeight;
//			Statics.initialize();
//			
//			// Initialize screens.
//			initScreens();
//		}
		
		/**
		 * Initialize screens. 
		 * 
		 */
		private function initGame():void
		{
			
			
//			screenMenu.initialize();
		}
		
//		/**
//		 * On navigation from different screens. 
//		 * @param event
//		 * MARKED FOR DELETION
//		 */
//		private function onInGameNavigation(event:NavigationEvent):void
//		{
//			switch (event.params.id)
//			{
//				case "about":
//					screenWelcome.initialize();
//					screenWelcome.showAbout();
//					break;
//			}
//		}
		
		/**
		 * On click of the sound/mute button. 
		 * @param event
		 * 
		 */
		private function onSoundButtonClick(event:Event = null):void
		{
			if (Sounds.bgmMuted || Sounds.sfxMuted)
			{
				Sounds.bgmMuted = false;
				Sounds.sfxMuted = false;
				
				Sounds.unmuteBgm();
				
				soundButton.showUnmuteState();
			}
			else
			{
				Sounds.bgmMuted = true;
				Sounds.sfxMuted = true;
//				SoundMixer.stopAll();
				Sounds.muteBgm();
				
				soundButton.showMuteState();
			}
		}
		
		/**
		 * On change of screen. 
		 * @param event
		 * 
		 */
		private function onChangeScreen(event:NavigationEvent):void
		{
			switch (event.params.id)
			{
//				case "welcome":
//					screenWelcome.initialize();
//					break;
				case "menu":
					// get rid of in game screen first if it is present
//					if (screenInGame) {
//						screenInGame.removeFromParent(true);
//						screenInGame = null;
//					}
//					screenMenu.initialize();
					screenInGame.removeFromParent();
					showMainMenu();
					break;
				case "play":
					// get rid of in game screen first if it is present
//					if (screenInGame) {
//						this.removeChild(screenInGame);
//					}
					if (!screenMenu.roundBegin()) return; // send round begin notification to backend
					
					// get rid of menu screen for better performance
//					screenMenu.removeFromParent(true);
//					screenMenu = null;
					
					screenMenu.disposeTemporarily();
					screenMenu.removeFromParent();
					
					// load random sky background image
					Statics.randomSkyNum = int(Math.ceil(Math.random() * 20)).toString();
					Statics.assets.enqueue("http://d3et7r3ga59g4e.cloudfront.net/bg/bg" + Statics.randomSkyNum + ".png");
					mLoadingProgress.visible = true;
					Statics.assets.loadQueue(function(ratio:Number):void {
						mLoadingProgress.ratio = ratio;
						if (ratio == 1.0) {
							mLoadingProgress.visible = false;
							showGame(); // initialize in game screen
						}
					});
					break;
			}
		}
		
		// creates a screenshot of entire stage in JPEG format
//		private function exportScreenshot():String {
//			var result:String = null;
//			var stageBitmapData:BitmapData = stage.drawToBitmapData();
//			
//			var jpgBytes:ByteArray = this.jpgEncoder.encode(stageBitmapData);
//			if (jpgBytes) {
//				var screenshotBase64:String = Base64.encodeByteArray(jpgBytes);
//				if (screenshotBase64) {
//					result = screenshotBase64;
//				}
//			}
//			
//			return result;
//		}
	}
}