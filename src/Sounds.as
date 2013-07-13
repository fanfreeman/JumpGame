package
{
	import com.jumpGame.level.Statics;
	
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	
	/**
	 * This class holds all the sound embeds and objects that are used in the game.
	 */
	public class Sounds
	{
		/**
		 * demo sounds 
		 */
		[Embed(source="../media/sounds/bgWelcome.mp3")]
		public static const SND_BG_MAIN:Class;
		
		[Embed(source="../media/sounds/eat.mp3")]
		public static const SND_EAT:Class;
		
		[Embed(source="../media/sounds/coffee.mp3")]
		public static const SND_COFFEE:Class;
		
		[Embed(source="../media/sounds/mushroom.mp3")]
		public static const SND_MUSHROOM:Class;
		
		[Embed(source="../media/sounds/hit.mp3")]
		public static const SND_HIT:Class;
		
		[Embed(source="../media/sounds/hurt.mp3")]
		public static const SND_HURT:Class;
		
		[Embed(source="../media/sounds/lose.mp3")]
		public static const SND_LOSE:Class;
		
		// sound effects
		[Embed(source="../media/sounds/scratch.mp3")]
		public static const SND_SCRATCH:Class;
		
		[Embed(source="../media/sounds/bounce1.mp3")]
		public static const SND_BOUNCE_1:Class;
		
		[Embed(source="../media/sounds/bounce2.mp3")]
		public static const SND_BOUNCE_2:Class;
		
		[Embed(source="../media/sounds/bounce3.mp3")]
		public static const SND_BOUNCE_3:Class;
		
		[Embed(source="../media/sounds/airjump.mp3")]
		public static const SND_AIRJUMP:Class;
		
		[Embed(source="../media/sounds/train_hit.mp3")]
		public static const SND_TRAIN_HIT:Class;
		
		[Embed(source="../media/sounds/got_hourglass.mp3")]
		public static const SND_GOT_HOURGLASS:Class;
		
		[Embed(source="../media/sounds/bling.mp3")]
		public static const SND_BLING:Class;
		
		[Embed(source="../media/sounds/bell.mp3")]
		public static const SND_BELL:Class;
		
		[Embed(source="../media/sounds/boost_bounce.mp3")]
		public static const SND_BOOST_BOUNCE:Class;
		
		[Embed(source="../media/sounds/boom.mp3")]
		public static const SND_BOOM:Class;
		
		[Embed(source="../media/sounds/train.mp3")]
		public static const SND_TRAIN:Class;
		
		[Embed(source="../media/sounds/train_warning.mp3")]
		public static const SND_TRAIN_WARNING:Class;
		
		////////////////////////////////////////////////////////////////////////////////
		// voice clips
		[Embed(source="../media/sounds/voice/ah.mp3")]
		public static const SND_VOICE_AH:Class;
		
		////////////////////////////////////////////////////////////////////////////////
		// musical notes
		[Embed(source="../media/sounds/notes/notes_marimba_01.mp3")]
		public static const SND_NOTE_1:Class;
		
		[Embed(source="../media/sounds/notes/notes_marimba_02.mp3")]
		public static const SND_NOTE_2:Class;
		
		[Embed(source="../media/sounds/notes/notes_marimba_03.mp3")]
		public static const SND_NOTE_3:Class;
		
		[Embed(source="../media/sounds/notes/notes_marimba_04.mp3")]
		public static const SND_NOTE_4:Class;
		
		[Embed(source="../media/sounds/notes/notes_marimba_05.mp3")]
		public static const SND_NOTE_5:Class;
		
		[Embed(source="../media/sounds/notes/notes_marimba_06.mp3")]
		public static const SND_NOTE_6:Class;
		
		[Embed(source="../media/sounds/notes/notes_marimba_07.mp3")]
		public static const SND_NOTE_7:Class;
		
		[Embed(source="../media/sounds/notes/notes_marimba_08.mp3")]
		public static const SND_NOTE_8:Class;
		
		[Embed(source="../media/sounds/notes/notes_marimba_09.mp3")]
		public static const SND_NOTE_9:Class;
		
		[Embed(source="../media/sounds/notes/notes_marimba_10.mp3")]
		public static const SND_NOTE_10:Class;
		
		[Embed(source="../media/sounds/notes/notes_marimba_11.mp3")]
		public static const SND_NOTE_11:Class;
		
		[Embed(source="../media/sounds/notes/notes_marimba_12.mp3")]
		public static const SND_NOTE_12:Class;
		
		[Embed(source="../media/sounds/notes/notes_marimba_13.mp3")]
		public static const SND_NOTE_13:Class;
		
		[Embed(source="../media/sounds/notes/notes_marimba_14.mp3")]
		public static const SND_NOTE_14:Class;
		
		[Embed(source="../media/sounds/notes/notes_marimba_15.mp3")]
		public static const SND_NOTE_15:Class;
		
		[Embed(source="../media/sounds/notes/notes_marimba_16.mp3")]
		public static const SND_NOTE_16:Class;
		
		[Embed(source="../media/sounds/notes/notes_marimba_17.mp3")]
		public static const SND_NOTE_17:Class;
		
		[Embed(source="../media/sounds/notes/notes_marimba_18.mp3")]
		public static const SND_NOTE_18:Class;
		
		[Embed(source="../media/sounds/notes/notes_marimba_19.mp3")]
		public static const SND_NOTE_19:Class;
		
		[Embed(source="../media/sounds/notes/notes_marimba_20.mp3")]
		public static const SND_NOTE_20:Class;
		
		[Embed(source="../media/sounds/notes/notes_marimba_21.mp3")]
		public static const SND_NOTE_21:Class;
		
		[Embed(source="../media/sounds/notes/notes_marimba_22.mp3")]
		public static const SND_NOTE_22:Class;
		
		[Embed(source="../media/sounds/notes/notes_marimba_23.mp3")]
		public static const SND_NOTE_23:Class;
		
		[Embed(source="../media/sounds/notes/notes_marimba_24.mp3")]
		public static const SND_NOTE_24:Class;
		
		[Embed(source="../media/sounds/notes/notes_marimba_25.mp3")]
		public static const SND_NOTE_25:Class;
		
		[Embed(source="../media/sounds/notes/notes_marimba_26.mp3")]
		public static const SND_NOTE_26:Class;
		
		[Embed(source="../media/sounds/notes/notes_marimba_27.mp3")]
		public static const SND_NOTE_27:Class;
		
		[Embed(source="../media/sounds/notes/notes_marimba_28.mp3")]
		public static const SND_NOTE_28:Class;
		
		[Embed(source="../media/sounds/notes/notes_marimba_29.mp3")]
		public static const SND_NOTE_29:Class;
		
		[Embed(source="../media/sounds/notes/notes_marimba_30.mp3")]
		public static const SND_NOTE_30:Class;
		
		[Embed(source="../media/sounds/notes/notes_marimba_31.mp3")]
		public static const SND_NOTE_31:Class;
		
		[Embed(source="../media/sounds/notes/notes_marimba_32.mp3")]
		public static const SND_NOTE_32:Class;
		
		[Embed(source="../media/sounds/notes/notes_marimba_33.mp3")]
		public static const SND_NOTE_33:Class;
		
		[Embed(source="../media/sounds/notes/notes_marimba_34.mp3")]
		public static const SND_NOTE_34:Class;
		
		[Embed(source="../media/sounds/notes/notes_marimba_35.mp3")]
		public static const SND_NOTE_35:Class;
		
		[Embed(source="../media/sounds/notes/notes_marimba_36.mp3")]
		public static const SND_NOTE_36:Class;
		/** eof notes */
		
		/**
		 * Initialized Sound objects. 
		 */		
		public static var sndBgMain:Sound = new Sounds.SND_BG_MAIN() as Sound;
		public static var sndEat:Sound = new Sounds.SND_EAT() as Sound;
		public static var sndCoffee:Sound = new Sounds.SND_COFFEE() as Sound;
		public static var sndMushroom:Sound = new Sounds.SND_MUSHROOM() as Sound;
		public static var sndHit:Sound = new Sounds.SND_HIT() as Sound;
		public static var sndHurt:Sound = new Sounds.SND_HURT() as Sound;
		public static var sndLose:Sound = new Sounds.SND_LOSE() as Sound;
		public static var sndScratch:Sound = new Sounds.SND_SCRATCH() as Sound;
		public static var sndBounce1:Sound = new Sounds.SND_BOUNCE_1() as Sound;
		public static var sndBounce2:Sound = new Sounds.SND_BOUNCE_2() as Sound;
		public static var sndBounce3:Sound = new Sounds.SND_BOUNCE_3() as Sound;
		public static var sndAirjump:Sound = new Sounds.SND_AIRJUMP() as Sound;
		public static var sndTrainHit:Sound = new Sounds.SND_TRAIN_HIT() as Sound;
		public static var sndGotHourglass:Sound = new Sounds.SND_GOT_HOURGLASS() as Sound;
		public static var sndBling:Sound = new Sounds.SND_BLING() as Sound;
		public static var sndBell:Sound = new Sounds.SND_BELL() as Sound;
		public static var sndBoostBounce:Sound = new Sounds.SND_BOOST_BOUNCE() as Sound;
		public static var sndBoom:Sound = new Sounds.SND_BOOM() as Sound;
		public static var sndTrain:Sound = new Sounds.SND_TRAIN() as Sound;
		public static var sndTrainWarning:Sound = new Sounds.SND_TRAIN_WARNING() as Sound;
		public static var sndVoiceAh:Sound = new Sounds.SND_VOICE_AH() as Sound;
		
		
		// notes
		public static var sndNoteArray:Array = [new Sounds.SND_NOTE_1() as Sound,
												new Sounds.SND_NOTE_2() as Sound,
												new Sounds.SND_NOTE_3() as Sound,
												new Sounds.SND_NOTE_4() as Sound,
												new Sounds.SND_NOTE_5() as Sound,
												new Sounds.SND_NOTE_6() as Sound,
												new Sounds.SND_NOTE_7() as Sound,
												new Sounds.SND_NOTE_8() as Sound,
												new Sounds.SND_NOTE_9() as Sound,
												new Sounds.SND_NOTE_10() as Sound,
												new Sounds.SND_NOTE_11() as Sound,
												new Sounds.SND_NOTE_12() as Sound,
												new Sounds.SND_NOTE_13() as Sound,
												new Sounds.SND_NOTE_14() as Sound,
												new Sounds.SND_NOTE_15() as Sound,
												new Sounds.SND_NOTE_16() as Sound,
												new Sounds.SND_NOTE_17() as Sound,
												new Sounds.SND_NOTE_18() as Sound,
												new Sounds.SND_NOTE_19() as Sound,
												new Sounds.SND_NOTE_20() as Sound,
												new Sounds.SND_NOTE_21() as Sound,
												new Sounds.SND_NOTE_22() as Sound,
												new Sounds.SND_NOTE_23() as Sound,
												new Sounds.SND_NOTE_24() as Sound,
												new Sounds.SND_NOTE_25() as Sound,
												new Sounds.SND_NOTE_26() as Sound,
												new Sounds.SND_NOTE_27() as Sound,
												new Sounds.SND_NOTE_28() as Sound,
												new Sounds.SND_NOTE_29() as Sound,
												new Sounds.SND_NOTE_30() as Sound,
												new Sounds.SND_NOTE_31() as Sound,
												new Sounds.SND_NOTE_32() as Sound,
												new Sounds.SND_NOTE_33() as Sound,
												new Sounds.SND_NOTE_34() as Sound,
												new Sounds.SND_NOTE_35() as Sound,
												new Sounds.SND_NOTE_36() as Sound];
		
		// sound channels
		public static var channelBgm:SoundChannel;
		
		// play random musical note
		public static function playRandomNote():void {
			var num:int = Math.floor(Math.random() * 18);
			Sounds.sndNoteArray[num].play();
		}
		
		public static function playNextNote():void {
			Sounds.sndNoteArray[Statics.nextStarNote].play();
			Statics.nextStarNote++;
			if (Statics.nextStarNote == 36) Statics.nextStarNote = 0;
		}
		
		public static function playBgm():void {
			var sound:Sound=new Sound();
			sound.load(new URLRequest("https://s3-us-west-2.amazonaws.com/youjumpijump/bgFunky.mp3"));  
			channelBgm = sound.play(0, 999);  
		}
		
		public static function stopBgm():void {
			channelBgm.stop();
		}
		
		public static function playBgmFireAura():void {
			var sound:Sound=new Sound();
			sound.load(new URLRequest("https://s3-us-west-2.amazonaws.com/youjumpijump/bgFireAura.mp3"));  
			sound.play(0, 999); 
			//sound.addEventListener(IOErrorEvent.IO_ERROR, function(e:IOErrorEvent):void{ trace(e); }); 
		}
		
		/**
		 * Sound mute status. 
		 */
		public static var muted:Boolean = false;
	}
}