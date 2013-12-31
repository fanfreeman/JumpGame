package
{
	/**
	 * This class holds all embedded textures, fonts and sounds and other embedded files.  
	 * By using static access methods, only one instance of the asset file is instantiated. This 
	 * means that all Image types that use the same bitmap will use the same Texture on the video card.
	 */
	public class Assets
	{
		/**
		 * Texture Atlases
		 */
		// atlas 1: platforms
		[Embed(source="../media/graphics/platforms.png")]
		public static const platforms:Class;
		[Embed(source="../media/graphics/platforms.xml", mimeType="application/octet-stream")]
		public static const platforms_xml:Class;
		
		// atlas 2: gameplay elements
		[Embed(source="../media/graphics/atlas2.png")]
		public static const atlas2:Class;
		[Embed(source="../media/graphics/atlas2.xml", mimeType="application/octet-stream")]
		public static const atlas2_xml:Class;
		
		// atlas 3: gameplay background elements
		[Embed(source="../media/graphics/atlas3.png")]
		public static const atlas3:Class;
		[Embed(source="../media/graphics/atlas3.xml", mimeType="application/octet-stream")]
		public static const atlas3_xml:Class;
		
		// atlas 4: UI elements
		[Embed(source="../media/graphics/atlas4.png")]
		public static const atlas4:Class;
		[Embed(source="../media/graphics/atlas4.xml", mimeType="application/octet-stream")]
		public static const atlas4_xml:Class;
		
		// atlas 5: gameplay foreground elements
		[Embed(source="../media/graphics/atlas5_fg.png")]
		public static const atlas5_fg:Class;
		[Embed(source="../media/graphics/atlas5_fg.xml", mimeType="application/octet-stream")]
		public static const atlas5_fg_xml:Class;
		
		// atlas 6: background dragon/stingray
		[Embed(source="../media/graphics/atlas6_drgn.png")]
		public static const atlas6_drgn:Class;
		[Embed(source="../media/graphics/atlas6_drgn.xml", mimeType="application/octet-stream")]
		public static const atlas6_drgn_xml:Class;
		
		// atlas 7: character idle/hurt animations
		[Embed(source="../media/graphics/atlas7_char.png")]
		public static const atlas7_char:Class;
		[Embed(source="../media/graphics/atlas7_char.xml", mimeType="application/octet-stream")]
		public static const atlas7_char_xml:Class;
		
		// atlas 8: miscellaneous
		[Embed(source="../media/graphics/atlas8.png")]
		public static const atlas8:Class;
		[Embed(source="../media/graphics/atlas8.xml", mimeType="application/octet-stream")]
		public static const atlas8_xml:Class;
		
		/**
		 * Background Images
		 */
		// layer 0
		[Embed(source="../media/graphics/layer0_ground.png")]
		public static const layer0_ground:Class;
		
		[Embed(source="../media/graphics/layer0_sky.png")]
		public static const layer0_sky:Class;
		
		[Embed(source="../media/graphics/new_png_src/bg_test/bg6.png")]
		public static const bg6:Class;
		
		/**
		 * Sounds
		 */
		////////////////////////////////////////////////////////////////////////////////
		// sound effects
		[Embed(source="../media/sounds/bounce2.mp3")]
		public static const SND_BOUNCE_2:Class;
		
		[Embed(source="../media/sounds/airjump.mp3")]
		public static const SND_AIRJUMP:Class;
		
		[Embed(source="../media/sounds/train_hit.mp3")]
		public static const SND_TRAIN_HIT:Class;
		
		[Embed(source="../media/sounds/got_hourglass.mp3")]
		public static const SND_GOT_HOURGLASS:Class;
		
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
		
		[Embed(source="../media/sounds/candidates/comet_deep.mp3")]
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
		
		[Embed(source="../media/sounds/candidates/magic_explosion.mp3")]
		public static const SND_MAGIC_EXPLOSION:Class;
		
		[Embed(source="../media/sounds/candidates/bling_low.mp3")]
		public static const SND_BLING_LOW:Class;
		
		[Embed(source="../media/sounds/candidates/bling_mid.mp3")]
		public static const SND_BLING_MID:Class;
		
		[Embed(source="../media/sounds/candidates/bling_high.mp3")]
		public static const SND_BLING_HIGH:Class;
		
		[Embed(source="../media/sounds/candidates/bling_bubble.mp3")]
		public static const SND_BLING_BUBBLE:Class;
		
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
		
//		[Embed(source="../media/sounds/notes/notes_marimba_29.mp3")]
//		public static const SND_NOTE_29:Class;
//		
//		[Embed(source="../media/sounds/notes/notes_marimba_30.mp3")]
//		public static const SND_NOTE_30:Class;
//		
//		[Embed(source="../media/sounds/notes/notes_marimba_31.mp3")]
//		public static const SND_NOTE_31:Class;
//		
//		[Embed(source="../media/sounds/notes/notes_marimba_32.mp3")]
//		public static const SND_NOTE_32:Class;
//		
//		[Embed(source="../media/sounds/notes/notes_marimba_33.mp3")]
//		public static const SND_NOTE_33:Class;
//		
//		[Embed(source="../media/sounds/notes/notes_marimba_34.mp3")]
//		public static const SND_NOTE_34:Class;
//		
//		[Embed(source="../media/sounds/notes/notes_marimba_35.mp3")]
//		public static const SND_NOTE_35:Class;
		
		////////////////////////////////////////////////////////////////////////////////
		// background music
		[Embed(source="../media/sounds/bgm/magical_waltz.mp3")]
		public static const SND_BGM_MENU:Class;
		
		[Embed(source="../media/sounds/bgm/chaoz_airflow.mp3")]
		public static const SND_BGM_INGAME:Class;
		
		
		/**
		 * NOTE: No longer using the code below; Using AssetManager instead
		 * Texture Cache
		 */
//		private static var gameTextures:Dictionary = new Dictionary();
//		private static var gameTextureAtlas:TextureAtlas;
//		private static var gameSprites:Dictionary = new Dictionary();
		
		/**
		 * Returns a texture from this class based on a string key.
		 * 
		 * @param name A key that matches a static constant of Bitmap type.
		 * @return a starling texture.
		 */
//		public static function getTexture(name:String):Texture
//		{
//			if (gameTextures[name] == undefined)
//			{
//				var bitmap:Bitmap = new Assets[name]();
//				gameTextures[name]=Texture.fromBitmap(bitmap);
//			}
//			
//			return gameTextures[name];
//		}
//		
//		public static function getSprite(name:String):TextureAtlas
//		{
//			if (gameSprites[name] == undefined)
//			{
//				var texture:Texture = getTexture(name);
//				var xml:XML;
//				switch(name)
//				{
//					case "AtlasTexturePlatforms":
//						xml = XML(new AtlasXmlPlatforms());
//						break;
//					case "AtlasTexture2":
//						xml = XML(new AtlasXml2());
//						break;
//					case "AtlasTexture3":
//						xml = XML(new AtlasXml3());
//						break;
//					case "AtlasTexture4":
//						xml = XML(new AtlasXml4());
//						break;
//					case "AtlasTexture5":
//						xml = XML(new AtlasXml5());
//						break;
//					case "AtlasTexture6":
//						xml = XML(new AtlasXml6());
//						break;
//					case "AtlasTexture7":
//						xml = XML(new AtlasXml7());
//						break;
//					case "AtlasTexture8":
//						xml = XML(new AtlasXml8());
//						break;
//				}
//				 
//				gameSprites[name] = new TextureAtlas(texture, xml);
//			}
//			
//			return gameSprites[name];
//		}
	}
}