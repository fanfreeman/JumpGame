package
{
	import flash.media.Sound;
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
		
		// musical notes
		[Embed(source="../media/sounds/notes/do-00.mp3")]
		public static const SND_NOTE_1:Class;
		
		[Embed(source="../media/sounds/notes/do-01.mp3")]
		public static const SND_NOTE_2:Class;

		[Embed(source="../media/sounds/notes/do-02-high.mp3")]
		public static const SND_NOTE_3:Class;
		
		[Embed(source="../media/sounds/notes/mi-00.mp3")]
		public static const SND_NOTE_4:Class;
		
		[Embed(source="../media/sounds/notes/mi-01.mp3")]
		public static const SND_NOTE_5:Class;
		
		[Embed(source="../media/sounds/notes/fa-00.mp3")]
		public static const SND_NOTE_6:Class;
		
		[Embed(source="../media/sounds/notes/fa-01.mp3")]
		public static const SND_NOTE_7:Class;
		
		[Embed(source="../media/sounds/notes/fa-03.mp3")]
		public static const SND_NOTE_8:Class;
		
		[Embed(source="../media/sounds/notes/fa-04.mp3")]
		public static const SND_NOTE_9:Class;
		
		[Embed(source="../media/sounds/notes/fa-05.mp3")]
		public static const SND_NOTE_10:Class;
		
		[Embed(source="../media/sounds/notes/fa-06-chord.mp3")]
		public static const SND_NOTE_11:Class;
		
		[Embed(source="../media/sounds/notes/fa-07-sharp.mp3")]
		public static const SND_NOTE_12:Class;
		
		[Embed(source="../media/sounds/notes/so-00.mp3")]
		public static const SND_NOTE_13:Class;
		
		[Embed(source="../media/sounds/notes/so-01-low.mp3")]
		public static const SND_NOTE_14:Class;
		
		[Embed(source="../media/sounds/notes/la-00.mp3")]
		public static const SND_NOTE_15:Class;
		
		[Embed(source="../media/sounds/notes/la-01.mp3")]
		public static const SND_NOTE_16:Class;
		
		[Embed(source="../media/sounds/notes/la-02.mp3")]
		public static const SND_NOTE_17:Class;
		
		[Embed(source="../media/sounds/notes/la-03.mp3")]
		public static const SND_NOTE_18:Class;
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
		
		
		// notes
//		public static var sndNote1:Sound = new Sounds.SND_NOTE_1() as Sound;
//		public static var sndNote2:Sound = new Sounds.SND_NOTE_2() as Sound;
//		public static var sndNote3:Sound = new Sounds.SND_NOTE_3() as Sound;
//		public static var sndNote4:Sound = new Sounds.SND_NOTE_4() as Sound;
//		public static var sndNote5:Sound = new Sounds.SND_NOTE_5() as Sound;
//		public static var sndNote6:Sound = new Sounds.SND_NOTE_6() as Sound;
//		public static var sndNote7:Sound = new Sounds.SND_NOTE_7() as Sound;
//		public static var sndNote8:Sound = new Sounds.SND_NOTE_8() as Sound;
//		public static var sndNote9:Sound = new Sounds.SND_NOTE_9() as Sound;
//		public static var sndNote10:Sound = new Sounds.SND_NOTE_10() as Sound;
//		public static var sndNote11:Sound = new Sounds.SND_NOTE_11() as Sound;
//		public static var sndNote12:Sound = new Sounds.SND_NOTE_12() as Sound;
//		public static var sndNote13:Sound = new Sounds.SND_NOTE_13() as Sound;
//		public static var sndNote14:Sound = new Sounds.SND_NOTE_14() as Sound;
//		public static var sndNote15:Sound = new Sounds.SND_NOTE_15() as Sound;
//		public static var sndNote16:Sound = new Sounds.SND_NOTE_16() as Sound;
//		public static var sndNote17:Sound = new Sounds.SND_NOTE_17() as Sound;
//		public static var sndNote18:Sound = new Sounds.SND_NOTE_18() as Sound;
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
												new Sounds.SND_NOTE_18() as Sound,];
		
		// play random musical note
		public static function playRandomNote():void {
			var num:int = Math.floor(Math.random() * 18);
			Sounds.sndNoteArray[num].play();
		}
		
		public static function playBgm():void {
			var sound:Sound=new Sound();
			sound.load(new URLRequest("../media/sounds/bgFunky.mp3"));  
			sound.play(0, 999);  
		}
		
		public static function playBgmFireAura():void {
			var sound:Sound=new Sound();
			sound.load(new URLRequest("../media/sounds/bgFireAura.mp3"));  
			sound.play(0, 999); 
			//sound.addEventListener(IOErrorEvent.IO_ERROR, function(e:IOErrorEvent):void{ trace(e); }); 
		}
		
		/**
		 * Sound mute status. 
		 */
		public static var muted:Boolean = false;
	}
}