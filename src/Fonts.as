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
		
		// Badabb font
		[Embed(source="../media/fonts/bitmap/fontBadabb.png")]
		public static const Font_Badabb:Class;
		[Embed(source="../media/fonts/bitmap/fontBadabb.fnt", mimeType="application/octet-stream")]
		public static const XML_Badabb:Class;
		
		// Verdana 14 font
		[Embed(source="../media/fonts/bitmap/verdana14.png")]
		public static const Font_Verdana14:Class;
		[Embed(source="../media/fonts/bitmap/verdana14.fnt", mimeType="application/octet-stream")]
		public static const XML_Verdana14:Class;
		
		// Lithos 30 font
		[Embed(source="../media/fonts/bitmap/fontLithos30.png")]
		public static const Font_Lithos24:Class;
		[Embed(source="../media/fonts/bitmap/fontLithos30.fnt", mimeType="application/octet-stream")]
		public static const XML_Lithos24:Class;
		
		// Lithos 42 font
		[Embed(source="../media/fonts/bitmap/fontLithos42.png")]
		public static const Font_Lithos42:Class;
		[Embed(source="../media/fonts/bitmap/fontLithos42.fnt", mimeType="application/octet-stream")]
		public static const XML_Lithos42:Class;
		
		// Verdana 23 font
		[Embed(source="../media/fonts/bitmap/fontVerdana23.png")]
		public static const Font_Verdana23:Class;
		[Embed(source="../media/fonts/bitmap/fontVerdana23.fnt", mimeType="application/octet-stream")]
		public static const XML_Verdana23:Class;
		
		// Lithos 44 bold font
		[Embed(source="../media/fonts/bitmap/fontLithosBold44.png")]
		public static const Font_LithosBold44:Class;
		[Embed(source="../media/fonts/bitmap/fontLithosBold44.fnt", mimeType="application/octet-stream")]
		public static const XML_LithosBold44:Class;
		
		/**
		 * Font objects.
		 */
		private static var Regular:BitmapFont;
		private static var ScoreLabel:BitmapFont;
		private static var ScoreValue:BitmapFont;
		private static var Badabb:BitmapFont;
		private static var Verdana14:BitmapFont;
		private static var Lithos24:BitmapFont;
		private static var Lithos42:BitmapFont;
		private static var Verdana23:BitmapFont;
		private static var LithosBold44:BitmapFont;
		
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