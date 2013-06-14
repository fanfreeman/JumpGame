package
{
	import com.jumpGame.customObjects.Font;
	
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	/**
	 * This class embeds the bitmap fonts used in the game.
	 */
	public class Fonts
	{
		/**
		 *  Regular font used for UI.
		 */		
		[Embed(source="../media/fonts/bitmap/fontRegular.png")]
		public static const Font_Regular:Class;
		
		[Embed(source="../media/fonts/bitmap/fontRegular.fnt", mimeType="application/octet-stream")]
		public static const XML_Regular:Class;
		
		/**
		 * Font for score label. 
		 */		
		[Embed(source="../media/fonts/bitmap/fontScoreLabel.png")]
		public static const Font_ScoreLabel:Class;
		
		[Embed(source="../media/fonts/bitmap/fontScoreLabel.fnt", mimeType="application/octet-stream")]
		public static const XML_ScoreLabel:Class;
		
		/**
		 * Font for score value. 
		 */		
		[Embed(source="../media/fonts/bitmap/fontScoreValue.png")]
		public static const Font_ScoreValue:Class;
		
		[Embed(source="../media/fonts/bitmap/fontScoreValue.fnt", mimeType="application/octet-stream")]
		public static const XML_ScoreValue:Class;
		
		// test font
		[Embed(source="../media/fonts/bitmap/fontBadabb.png")]
		public static const Font_Badabb:Class;
		
		[Embed(source="../media/fonts/bitmap/fontBadabb.fnt", mimeType="application/octet-stream")]
		public static const XML_Badabb:Class;
		
		/**
		 * Font objects.
		 */
		private static var Regular:BitmapFont;
		private static var ScoreLabel:BitmapFont;
		private static var ScoreValue:BitmapFont;
		private static var Badabb:BitmapFont;
		
		/**
		 * Returns the BitmapFont (texture + xml) instance's fontName property (there is only one instance per app)
		 * @return String 
		 */
		public static function getFont(_fontStyle:String):Font
		{
			if (Fonts[_fontStyle] == undefined)
			{
				var texture:Texture = Texture.fromBitmap(new Fonts["Font_" + _fontStyle]());
				var xml:XML = XML(new Fonts["XML_" + _fontStyle]());
				Fonts[_fontStyle] = new BitmapFont(texture, xml);
				TextField.registerBitmapFont(Fonts[_fontStyle]);
			}
			
			return new Font(Fonts[_fontStyle].name, Fonts[_fontStyle].size);
		}
		
		/**
		 * Returns a BitmapFont
		 * @return BitmapFont 
		 */
		public static function getBitmapFont(_fontStyle:String):BitmapFont
		{
			if (Fonts[_fontStyle] == undefined)
			{
				var texture:Texture = Texture.fromBitmap(new Fonts["Font_" + _fontStyle]());
				var xml:XML = XML(new Fonts["XML_" + _fontStyle]());
				Fonts[_fontStyle] = new BitmapFont(texture, xml);
				TextField.registerBitmapFont(Fonts[_fontStyle]);
			}
			
			return Fonts[_fontStyle];
		}
	}
}