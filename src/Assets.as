package
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	/**
	 * This class holds all embedded textures, fonts and sounds and other embedded files.  
	 * By using static access methods, only one instance of the asset file is instantiated. This 
	 * means that all Image types that use the same bitmap will use the same Texture on the video card.
	 */
	public class Assets
	{
		// atlas 1: platforms
		[Embed(source="../media/graphics/platforms.png")]
		public static const AtlasTexturePlatforms:Class;
		[Embed(source="../media/graphics/platforms.xml", mimeType="application/octet-stream")]
		public static const AtlasXmlPlatforms:Class;
		
		// atlas 2: gameplay elements
		[Embed(source="../media/graphics/atlas2.png")]
		public static const AtlasTexture2:Class;
		[Embed(source="../media/graphics/atlas2.xml", mimeType="application/octet-stream")]
		public static const AtlasXml2:Class;
		
		// atlas 3: gameplay background elements
		[Embed(source="../media/graphics/atlas3.png")]
		public static const AtlasTexture3:Class;
		[Embed(source="../media/graphics/atlas3.xml", mimeType="application/octet-stream")]
		public static const AtlasXml3:Class;
		
		// atlas 4: UI elements
		[Embed(source="../media/graphics/atlas4.png")]
		public static const AtlasTexture4:Class;
		[Embed(source="../media/graphics/atlas4.xml", mimeType="application/octet-stream")]
		public static const AtlasXml4:Class;
		
		// atlas 5: gameplay foreground elements
		[Embed(source="../media/graphics/atlas5_fg.png")]
		public static const AtlasTexture5:Class;
		[Embed(source="../media/graphics/atlas5_fg.xml", mimeType="application/octet-stream")]
		public static const AtlasXml5:Class;
		
		// atlas 6: background dragon/stingray
		[Embed(source="../media/graphics/atlas6_drgn.png")]
		public static const AtlasTexture6:Class;
		[Embed(source="../media/graphics/atlas6_drgn.xml", mimeType="application/octet-stream")]
		public static const AtlasXml6:Class;
		
		// atlas 7: character idle/hurt animations
		[Embed(source="../media/graphics/atlas7_char.png")]
		public static const AtlasTexture7:Class;
		[Embed(source="../media/graphics/atlas7_char.xml", mimeType="application/octet-stream")]
		public static const AtlasXml7:Class;
		
		/**
		 * Background Assets
		 */
		// layer 0
		[Embed(source="../media/graphics/layer0_ground.png")]
		public static const BgLayer0Ground:Class;
		
		[Embed(source="../media/graphics/layer0_sky.png")]
		public static const BgLayer0Sky:Class;
		
		/**
		 * Texture Cache 
		 */
		private static var gameTextures:Dictionary = new Dictionary();
		private static var gameTextureAtlas:TextureAtlas;
		private static var gameSprites:Dictionary = new Dictionary();
		
		/**
		 * Returns the Texture atlas instance.
		 * @return the TextureAtlas instance (there is only one instance per app)
		 */
//		public static function getAtlas():TextureAtlas
//		{
//			if (gameTextureAtlas == null)
//			{
//				var texture:Texture = getTexture("AtlasTextureGame");
//				var xml:XML = XML(new AtlasXmlGame());
//				gameTextureAtlas=new TextureAtlas(texture, xml);
//			}
//			
//			return gameTextureAtlas;
//		}
		
		/**
		 * Returns a texture from this class based on a string key.
		 * 
		 * @param name A key that matches a static constant of Bitmap type.
		 * @return a starling texture.
		 */
		public static function getTexture(name:String):Texture
		{
			if (gameTextures[name] == undefined)
			{
				var bitmap:Bitmap = new Assets[name]();
				gameTextures[name]=Texture.fromBitmap(bitmap);
			}
			
			return gameTextures[name];
		}
		
		public static function getSprite(name:String):TextureAtlas
		{
			if (gameSprites[name] == undefined)
			{
				var texture:Texture = getTexture(name);
				var xml:XML;
				switch(name)
				{
					case "AtlasTexturePlatforms":
						xml = XML(new AtlasXmlPlatforms());
						break;
					case "AtlasTexture2":
						xml = XML(new AtlasXml2());
						break;
					case "AtlasTexture3":
						xml = XML(new AtlasXml3());
						break;
					case "AtlasTexture4":
						xml = XML(new AtlasXml4());
						break;
					case "AtlasTexture5":
						xml = XML(new AtlasXml5());
						break;
					case "AtlasTexture6":
						xml = XML(new AtlasXml6());
						break;
					case "AtlasTexture7":
						xml = XML(new AtlasXml7());
						break;
				}
				 
				gameSprites[name] = new TextureAtlas(texture, xml);
			}
			
			return gameSprites[name];
		}
	}
}