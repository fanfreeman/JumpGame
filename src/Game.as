package
{
//	import com.adobe.images.JPGEncoder;
	
	import com.jumpGame.events.NavigationEvent;
	import com.jumpGame.level.Statics;
	import com.jumpGame.screens.InGame;
	import com.jumpGame.screens.Menu;
	import com.jumpGame.ui.SoundButton;
	
	import flash.media.SoundMixer;
	import flash.system.Security;
	
	import starling.display.Sprite;
	import starling.events.Event;

//	import flash.utils.ByteArray;
	
	
	/**
	 * This class is the primary Starling Sprite based class
	 * that triggers the different screens. 
	 */
	public class Game extends Sprite
	{
//		private var screenWelcome:Welcome;
		private var screenMenu:Menu;
		private var screenInGame:InGame;
		/** Sound / Mute button. */
		private var soundButton:SoundButton;
		
//		private var jpgEncoder:JPGEncoder;
		
		public function Game()
		{
			super();
			Security.loadPolicyFile("https://fbcdn-profile-a.akamaihd.net/crossdomain.xml");
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
//			this.jpgEncoder = new JPGEncoder();
//			ExternalInterface.addCallback('exportScreenshot', exportScreenshot);
		}
		
		/**
		 * On Game class added to stage. 
		 * @param event
		 * 
		 */
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			Statics.stageWidth = stage.stageWidth;
			Statics.stageHeight = stage.stageHeight;
			Statics.initialize();
			
			// Initialize screens.
			initScreens();
		}
		
		/**
		 * Initialize screens. 
		 * 
		 */
		private function initScreens():void
		{
			this.addEventListener(NavigationEvent.CHANGE_SCREEN, onChangeScreen);
			
			// menu screen
			screenMenu = new Menu();
			this.addChild(screenMenu);
			
			// game screen
			screenInGame = new InGame();
			screenInGame.visible = false;
			this.addChild(screenInGame);
			
			// Create and add Sound/Mute button.
			soundButton = new SoundButton();
			soundButton.x = Statics.stageWidth - 46;
			soundButton.y = Statics.stageHeight - 90;
			soundButton.addEventListener(Event.TRIGGERED, onSoundButtonClick);
			this.addChild(soundButton)
			
			// Initialize the Welcome screen by default. 
			screenMenu.initialize();
			
			// start loading bgm
			Sounds.loadBgm();
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
				
//				if (screenWelcome.visible) Sounds.sndBgMain.play(0, 999);
//				else if (screenInGame.visible) Sounds.sndBgMain.play(0, 999);
				
				soundButton.showUnmuteState();
			}
			else
			{
				Sounds.bgmMuted = true;
				Sounds.sfxMuted = true;
				SoundMixer.stopAll();
				
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
					if (screenInGame) {
//						this.removeChild(screenInGame);
						screenInGame.visible = false;
					}
					screenMenu.initialize();
					break;
				case "play":
					// get rid of in game screen first if it is present
//					if (screenInGame) {
//						this.removeChild(screenInGame);
//					}
					if (!screenMenu.roundBegin()) return; // send round begin notification to backend
					screenMenu.disposeTemporarily();
					
					// initialize in game screen
					screenInGame.initializeNormalMode();
					break;
//				case "continue":
//					
//					break;
//				case "proceed":
//					// get rid of in game screen first if it is present
//					if (screenInGame) {
//						this.removeChild(screenInGame);
//					}
//					screenMenu.disposeTemporarily();
//					
//					// create and initialize in game screen
//					screenInGame = new InGame();
//					screenInGame.addEventListener(NavigationEvent.CHANGE_SCREEN, onChangeScreen);
//					this.addChild(screenInGame);
//					screenInGame.initializeBonusMode();
//					break;
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