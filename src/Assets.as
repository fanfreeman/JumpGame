package
{
	/**
	 * This class holds all embedded textures, fonts and sounds and other embedded files.  
	 * By using static access methods, only one instance of the asset file is instantiated. This 
	 * means that all Image types that use the same bitmap will use the same Texture on the video card.
	 */
	public class Assets
	{
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
		 * Background Assets
		 */
		// layer 0
		[Embed(source="../media/graphics/layer0_ground.png")]
		public static const layer0_ground:Class;
		
		[Embed(source="../media/graphics/layer0_sky.png")]
		public static const layer0_sky:Class;
		
		
		
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