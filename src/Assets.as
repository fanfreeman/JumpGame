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
		[Embed(source="../media/graphics/platform/platforms.png")]
		public static const AtlasTexturePlatforms:Class;
		[Embed(source="../media/graphics/platform/platforms.xml", mimeType="application/octet-stream")]
		public static const AtlasXmlPlatforms:Class;
		
		/**
		 * Background Assets 
		 */
		// layer 1
		[Embed(source="../media/graphics/bgStarrySky.jpg")]
		public static const BgStarrySky:Class;
		
		[Embed(source="../media/graphics/bgWelcome.jpg")]
		public static const BgWelcome:Class;
		
		// layer 2
		[Embed(source="../media/graphics/background/layer2_tree1.png")]
		public static const BgLayer2Tree1L:Class;
		
		[Embed(source="../media/graphics/background/layer2_tree2.png")]
		public static const BgLayer2Tree2R:Class;
		
		[Embed(source="../media/graphics/background/layer2_tree3.png")]
		public static const BgLayer2Tree3L:Class;
		
		// layer 4
		[Embed(source="../media/graphics/background/layer4_tree1.png")]
		public static const BgLayer4Tree1R:Class;
		
		[Embed(source="../media/graphics/background/layer4_tree2.png")]
		public static const BgLayer4Tree2L:Class;
		
		// waves spritesheet
		// scarecrow spritesheet
		[Embed(source="../media/graphics/background/sofwave.png")]
		public static const SpriteTextureWaves:Class;
		[Embed(source="../media/graphics/background/sofwave.xml", mimeType="application/octet-stream")]
		public static const SpriteXmlWaves:Class;
		
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
					case "AtlasTexturePlatforms":
						xml = XML(new AtlasXmlPlatforms());
						break;
					case "SpriteTextureWaves":
						xml = XML(new SpriteXmlWaves());
						break;
				}
				 
				gameSprites[name] = new TextureAtlas(texture, xml);
			}
			
			return gameSprites[name];
		}
	}
}