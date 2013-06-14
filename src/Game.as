package
{
	import com.jumpGame.events.NavigationEvent;
	import com.jumpGame.screens.InGame;
	import com.jumpGame.screens.Welcome;
	import com.jumpGame.screens.Menu;
	import com.jumpGame.ui.SoundButton;
	
	import flash.media.SoundMixer;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * This class is the primary Starling Sprite based class
	 * that triggers the different screens. 
	 */
	public class Game extends Sprite
	{
		/** Screen - Welcome or Main Menu. */
		private var screenWelcome:Welcome;
		
		private var screenMenu:Menu;
		
		/** Screen - InGame. */
		private var screenInGame:InGame;
		
		/** Sound / Mute button. */
		private var soundButton:SoundButton;
		
		public function Game()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		/**
		 * On Game class added to stage. 
		 * @param event
		 * 
		 */
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
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
			
			// InGame screen.
			screenInGame = new InGame();
			screenInGame.addEventListener(NavigationEvent.CHANGE_SCREEN, onInGameNavigation);
			this.addChild(screenInGame);
			
			// menu screen
			screenMenu = new Menu();
			this.addChild(screenMenu);
			
			// Welcome screen.
			screenWelcome = new Welcome();
			this.addChild(screenWelcome);
			
			// Create and add Sound/Mute button.
			soundButton = new SoundButton();
			soundButton.x = int(soundButton.width * 0.5);
			soundButton.y = int(soundButton.height * 0.5);
			soundButton.addEventListener(Event.TRIGGERED, onSoundButtonClick);
			this.addChild(soundButton)
			
			// Initialize the Welcome screen by default. 
			screenWelcome.initialize();
		}
		
		/**
		 * On navigation from different screens. 
		 * @param event
		 * 
		 */
		private function onInGameNavigation(event:NavigationEvent):void
		{
			switch (event.params.id)
			{
				case "mainMenu":
					screenWelcome.initialize();
					break;
				case "about":
					screenWelcome.initialize();
					screenWelcome.showAbout();
					break;
			}
		}
		
		/**
		 * On click of the sound/mute button. 
		 * @param event
		 * 
		 */
		private function onSoundButtonClick(event:Event = null):void
		{
			if (Sounds.muted)
			{
				Sounds.muted = false;
				
				if (screenWelcome.visible) Sounds.sndBgMain.play(0, 999);
				else if (screenInGame.visible) Sounds.sndBgGame.play(0, 999);
				
				soundButton.showUnmuteState();
			}
			else
			{
				Sounds.muted = true;
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
				case "menu":
					screenWelcome.disposeTemporarily();
					screenMenu.initialize();
					break;
				case "play":
					screenMenu.disposeTemporarily();
					screenInGame.initialize();
					break;
			}
		}
	}
}