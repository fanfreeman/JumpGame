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
		/**
		 * Texture Atlas 
		 */
		[Embed(source="../media/graphics/mySpritesheet.png")]
		public static const AtlasTextureGame:Class;
		
		[Embed(source="../media/graphics/mySpritesheet.xml", mimeType="application/octet-stream")]
		public static const AtlasXmlGame:Class;
		
		// scarecrow spritesheet
		[Embed(source="../media/graphics/Scarecrow.png")]
		public static const SpriteTextureScarecrow:Class;
		[Embed(source="../media/graphics/Scarecrow.xml", mimeType="application/octet-stream")]
		public static const SpriteXmlScarecrow:Class;
		
		// platform spritesheet
		[Embed(source="../media/graphics/platform/platform.png")]
		public static const SpriteTexturePlatform:Class;
		[Embed(source="../media/graphics/platform/platform.xml", mimeType="application/octet-stream")]
		public static const SpriteXmlPlatform:Class;
		
		/**
		 * Background Assets 
		 */
		[Embed(source="../media/graphics/bgLayer1.jpg")]
		public static const BgLayer1:Class;
		
		[Embed(source="../media/graphics/bgWelcome.jpg")]
		public static const BgWelcome:Class;
		
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
		public static function getAtlas():TextureAtlas
		{
			if (gameTextureAtlas == null)
			{
				var texture:Texture = getTexture("AtlasTextureGame");
				var xml:XML = XML(new AtlasXmlGame());
				gameTextureAtlas=new TextureAtlas(texture, xml);
			}
			
			return gameTextureAtlas;
		}
		
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
					case "SpriteTextureScarecrow":
						xml = XML(new SpriteXmlScarecrow());
						break;
					case "SpriteTexturePlatform":
						xml = XML(new SpriteXmlPlatform());
						break;
				}
				 
				gameSprites[name] = new TextureAtlas(texture, xml);
			}
			
			return gameSprites[name];
		}
	}
}