package
{
	import com.jumpGame.level.Statics;
	
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	import starling.core.Starling;
	
	/**
	 * This class holds all the sound embeds and objects that are used in the game.
	 */
	public class Sounds
	{
		/**
		 * demo sounds 
		 */
//		[Embed(source="../media/sounds/mushroom.mp3")]
//		public static const SND_MUSHROOM:Class;
		// sound effects
		[Embed(source="../media/sounds/scratch.mp3")]
		public static const SND_SCRATCH:Class;
		
//		[Embed(source="../media/sounds/bounce1.mp3")]
//		public static const SND_BOUNCE_1:Class;
//		
		[Embed(source="../media/sounds/bounce2.mp3")]
		public static const SND_BOUNCE_2:Class;
//		
//		[Embed(source="../media/sounds/bounce3.mp3")]
//		public static const SND_BOUNCE_3:Class;
		
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
		
		[Embed(source="../media/sounds/cannonball_hit.mp3")]
		public static const SND_CANNONBALL_HIT:Class;
		
		[Embed(source="../media/sounds/power_down.mp3")]
		public static const SND_CRASH:Class;
		
//		[Embed(source="../media/sounds/cannon_fire.mp3")]
//		public static const SND_CANNON_FIRE:Class;
		
		[Embed(source="../media/sounds/gong.mp3")]
		public static const SND_GONG:Class;
		
		[Embed(source="../media/sounds/ingame/powerup2.mp3")]
		public static const SND_POWERUP:Class;
		
		[Embed(source="../media/sounds/clock_tick.mp3")]
		public static const SND_CLOCK_TICK:Class;
		
		[Embed(source="../media/sounds/distant_explosion.mp3")]
		public static const SND_DISTANT_EXPLOSION:Class;
		
		[Embed(source="../media/sounds/ingame/douse.mp3")]
		public static const SND_DOUSE_FIRE:Class;
		
		[Embed(source="../media/sounds/candidates/slots.mp3")]
		public static const SND_SLOTS:Class;
		
		[Embed(source="../media/sounds/candidates/catch_fire.mp3")]
		public static const SND_CATCH_FIRE:Class;
		
		[Embed(source="../media/sounds/candidates/comet.mp3")]
		public static const SND_COMET:Class;
		
		[Embed(source="../media/sounds/candidates/crumble2.mp3")]
		public static const SND_CRUMBLE:Class;
		
		[Embed(source="../media/sounds/candidates/wing_flap.mp3")]
		public static const SND_WING_FLAP:Class;
		
		[Embed(source="../media/sounds/candidates/electricity.mp3")]
		public static const SND_ELECTRICITY:Class;
		
		[Embed(source="../media/sounds/candidates/swoosh.mp3")]
		public static const SND_SWOOSH:Class;
		
		[Embed(source="../media/sounds/candidates/drum1.mp3")]
		public static const SND_DRUM1:Class;
		
		[Embed(source="../media/sounds/candidates/drum2.mp3")]
		public static const SND_DRUM2:Class;
		
		[Embed(source="../media/sounds/candidates/drum3.mp3")]
		public static const SND_DRUM3:Class;
		
		[Embed(source="../media/sounds/candidates/master_shout_1.mp3")]
		public static const SND_MASTER_SHOUT1:Class;
		
		[Embed(source="../media/sounds/candidates/master_shout_2.mp3")]
		public static const SND_MASTER_SHOUT2:Class;
		
		[Embed(source="../media/sounds/candidates/fail.mp3")]
		public static const SND_FAIL:Class;
		
		[Embed(source="../media/sounds/candidates/blink.mp3")]
		public static const SND_BLINK:Class;
		
		[Embed(source="../media/sounds/candidates/blink_fast.mp3")]
		public static const SND_BLINK_FAST:Class;
		
		[Embed(source="../media/sounds/candidates/bubble_pop.mp3")]
		public static const SND_CLICK:Class;
		
		[Embed(source="../media/sounds/candidates/slide_woosh.mp3")]
		public static const SND_SLIDE:Class;
		
		[Embed(source="../media/sounds/candidates/vanish.mp3")]
		public static const SND_VANISH:Class;
		
		[Embed(source="../media/sounds/candidates/firework.mp3")]
		public static const SND_FIREWORK:Class;
		
		[Embed(source="../media/sounds/candidates/fanfare.mp3")]
		public static const SND_FANFARE:Class;
		
		[Embed(source="../media/sounds/candidates/payout2.mp3")]
		public static const SND_PAYOUT:Class;
		
		[Embed(source="../media/sounds/candidates/fast_swoosh.mp3")]
		public static const SND_FAST_SWOOSH:Class;
		
		[Embed(source="../media/sounds/candidates/start2.mp3")]
		public static const SND_START:Class;
		
		////////////////////////////////////////////////////////////////////////////////
		// voice clips
//		[Embed(source="../media/sounds/voice/ah.mp3")]
//		public static const SND_VOICE_AH:Class;
		
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
		
		// embed bgms
		[Embed(source="../media/sounds/bgm/magical_waltz2.mp3")]
		public static const SND_BGM_MENU:Class;
		
		[Embed(source="../media/sounds/bgm/chaoz_airflow.mp3")]
		public static const SND_BGM_INGAME:Class;
		
		/**
		 * Initialized Sound objects. 
		 */
//		public static var sndMushroom:Sound = new Sounds.SND_MUSHROOM() as Sound;
		public static var sndScratch:Sound = new Sounds.SND_SCRATCH() as Sound;
//		public static var sndBounce1:Sound = new Sounds.SND_BOUNCE_1() as Sound;
		public static var sndBounce2:Sound = new Sounds.SND_BOUNCE_2() as Sound;
//		public static var sndBounce3:Sound = new Sounds.SND_BOUNCE_3() as Sound;
		public static var sndAirjump:Sound = new Sounds.SND_AIRJUMP() as Sound;
		public static var sndTrainHit:Sound = new Sounds.SND_TRAIN_HIT() as Sound;
		public static var sndGotHourglass:Sound = new Sounds.SND_GOT_HOURGLASS() as Sound;
		public static var sndBling:Sound = new Sounds.SND_BLING() as Sound;
		public static var sndBell:Sound = new Sounds.SND_BELL() as Sound;
		public static var sndBoostBounce:Sound = new Sounds.SND_BOOST_BOUNCE() as Sound;
		public static var sndBoom:Sound = new Sounds.SND_BOOM() as Sound;
		public static var sndTrain:Sound = new Sounds.SND_TRAIN() as Sound;
		public static var sndCannonballHit:Sound = new Sounds.SND_CANNONBALL_HIT() as Sound;
		public static var sndCrash:Sound = new Sounds.SND_CRASH() as Sound;
//		public static var sndCannonFire:Sound = new Sounds.SND_CANNON_FIRE() as Sound;
		public static var sndGong:Sound = new Sounds.SND_GONG() as Sound;
		public static var sndPowerup:Sound = new Sounds.SND_POWERUP() as Sound;
		public static var sndClockTick:Sound = new Sounds.SND_CLOCK_TICK() as Sound;
		public static var sndDistantExplosion:Sound = new Sounds.SND_DISTANT_EXPLOSION() as Sound;
		public static var sndDouseFire:Sound = new Sounds.SND_DOUSE_FIRE() as Sound;
		public static var sndSlots:Sound = new Sounds.SND_SLOTS() as Sound;
		public static var sndCatchFire:Sound = new Sounds.SND_CATCH_FIRE() as Sound;
		public static var sndComet:Sound = new Sounds.SND_COMET() as Sound;
		public static var sndCrumble:Sound = new Sounds.SND_CRUMBLE() as Sound;
		public static var sndWingFlap:Sound = new Sounds.SND_WING_FLAP() as Sound;
		public static var sndElectricity:Sound = new Sounds.SND_ELECTRICITY() as Sound;
		public static var sndSwoosh:Sound = new Sounds.SND_SWOOSH() as Sound;
		public static var sndDrum1:Sound = new Sounds.SND_DRUM1() as Sound;
		public static var sndDrum2:Sound = new Sounds.SND_DRUM2() as Sound;
		public static var sndDrum3:Sound = new Sounds.SND_DRUM3() as Sound;
		public static var sndMasterShout1:Sound = new Sounds.SND_MASTER_SHOUT1() as Sound;
		public static var sndMasterShout2:Sound = new Sounds.SND_MASTER_SHOUT2() as Sound;
		public static var sndFail:Sound = new Sounds.SND_FAIL() as Sound; // TODO Unused
		public static var sndBlink:Sound = new Sounds.SND_BLINK() as Sound;
		public static var sndBlinkFast:Sound = new Sounds.SND_BLINK_FAST() as Sound;
		public static var sndClick:Sound = new Sounds.SND_CLICK() as Sound;
		public static var sndSlide:Sound = new Sounds.SND_SLIDE() as Sound;
		public static var sndVanish:Sound = new Sounds.SND_VANISH() as Sound; // TODO Unused
		public static var sndFirework:Sound = new Sounds.SND_FIREWORK() as Sound;
		public static var sndFanfare:Sound = new Sounds.SND_FANFARE() as Sound;
		public static var sndPayout:Sound = new Sounds.SND_PAYOUT() as Sound;
		public static var sndFastSwoosh:Sound = new Sounds.SND_FAST_SWOOSH() as Sound;
		public static var sndStart:Sound = new Sounds.SND_START() as Sound;
//		public static var sndVoiceAh:Sound = new Sounds.SND_VOICE_AH() as Sound;
		
		
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
		
		// play random musical note
		public static function playRandomNote():void {
			var num:int = Math.floor(Math.random() * 18);
			Sounds.sndNoteArray[num].play();
		}
		
		public static function playNextNote():void {
			Sounds.sndNoteArray[Statics.nextStarNote].play();
			Statics.nextStarNote++;
			if (Statics.nextStarNote == 24) Statics.nextStarNote = 0;
		}
		
//		private static var sndBgmMenu:Sound = new Sounds.SND_BGM_MENU() as Sound;
//		private static var sndBgmInGame:Sound = new Sounds.SND_BGM_INGAME() as Sound;
		private static var bgmMenu:Object;
		private static var bgmInGame:Object;
//		private static var bgmSoundInitial:Sound;
//		private static var bgmSoundFadeout:Sound;
//		private static var bgmSoundUnderscoreLoop:Sound;
		
		// sound channels
//		public static var channelBgmMenu:SoundChannel;
//		public static var channelBgmIngame:SoundChannel;
		
		// bgm volumes
//		private static var volumeBgmMenu:Number = 1;
//		private static var volumeBgmIngame:Number = 1;
		
		private static var soundTransform:SoundTransform = new SoundTransform();
		
		public static function loadBgm():void {
			//bgmSound.load(new URLRequest("https://s3-us-west-2.amazonaws.com/youjumpijump/bgFunky.mp3"));
//			bgmSoundInitial = new Sound();
//			bgmSoundInitial.load(new URLRequest("https://s3-us-west-2.amazonaws.com/youjumpijump/ghostCircus.mp3"));
//			
//			bgmSoundFadeout = new Sound();
//			bgmSoundFadeout.load(new URLRequest("https://s3-us-west-2.amazonaws.com/youjumpijump/ghostCircusFadeout.mp3"));
//			
//			bgmSoundUnderscoreLoop = new Sound();
//			bgmSoundUnderscoreLoop.load(new URLRequest("https://s3-us-west-2.amazonaws.com/youjumpijump/ghostCircusUnderscoreLoop.mp3"));
			
//			var bgmMenuSound:Sound = new Sound();
//			bgmMenuSound.load(new URLRequest("https://s3-us-west-2.amazonaws.com/youjumpijump/magical_waltz2.mp3"));
			bgmMenu = new Object();
			bgmMenu.sound = new Sounds.SND_BGM_MENU() as Sound;
			bgmMenu.volume = 1;
			
//			var bgmInGameSound:Sound = new Sound();
//			bgmInGameSound.load(new URLRequest("https://s3-us-west-2.amazonaws.com/youjumpijump/chaoz_airflow.mp3"));
			bgmInGame = new Object();
			bgmInGame.sound = new Sounds.SND_BGM_INGAME() as Sound;
			bgmInGame.volume = 1;
		}
		
		public static function playBgmMenu():void {
			var channelBgmMenu:SoundChannel = bgmMenu.sound.play(0, 999);
			bgmMenu.channel = channelBgmMenu;
			bgmMenu.volume = 1;
			if (bgmMuted) {
				// mute menu bgm
				soundTransform.volume = 0;
				bgmMenu.channel.soundTransform = soundTransform;
			}
		}
		
		public static function playBgmIngame():void {
//			channelBgm = bgmSoundInitial.play(); 
//			channelBgm.addEventListener(Event.SOUND_COMPLETE, playBgmFadeout);
			
			var channelBgmIngame:SoundChannel = bgmInGame.sound.play(0, 999);
			bgmInGame.channel = channelBgmIngame;
			bgmInGame.volume = 1;
			if (bgmMuted) {
				// mute in game bgm
				soundTransform.volume = 0;
				bgmInGame.channel.soundTransform = soundTransform;
			} else {
				// fade out menu bgm
				if (bgmMenu.volume != 0) {
					Starling.juggler.tween(bgmMenu, 2, {
						volume: 0,
						onUpdate: function():void {
							soundTransform.volume = bgmMenu.volume;
							bgmMenu.channel.soundTransform = soundTransform;
						}
					});
				}
			}
		}
		
//		public static function playBgmFadeout(event:Event):void {
//			bgmSoundFadeout.play();
//			channelBgm = bgmSoundUnderscoreLoop.play(0, 999);
//			event.target.removeEventListener(event.type, playBgmFadeout);
//		}
		
		public static function stopBgm():void {
			if (bgmMenu.channel != null) bgmMenu.channel.stop();
			if (bgmInGame.channel != null) bgmInGame.channel.stop();
		}
		
		public static function muteBgm():void {
			soundTransform.volume = 0;
			if (bgmMenu.channel != null) bgmMenu.channel.soundTransform = soundTransform;
			if (bgmInGame.channel != null) bgmInGame.channel.soundTransform = soundTransform;
		}
		
		public static function unmuteBgm():void {
			soundTransform.volume = bgmMenu.volume;
			if (bgmMenu.channel != null) bgmMenu.channel.soundTransform = soundTransform;
			
			soundTransform.volume = bgmInGame.volume;
			if (bgmInGame.channel != null) bgmInGame.channel.soundTransform = soundTransform;
		}
		
//		public static function playBgmFireAura():void {
//			var sound:Sound=new Sound();
//			sound.load(new URLRequest("https://s3-us-west-2.amazonaws.com/youjumpijump/bgFireAura.mp3"));  
//			sound.play(0, 999); 
//			//sound.addEventListener(IOErrorEvent.IO_ERROR, function(e:IOErrorEvent):void{ trace(e); }); 
//		}
		
		// sound mute status
		public static var bgmMuted:Boolean = false;
		public static var sfxMuted:Boolean = false;
	}
}