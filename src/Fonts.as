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
		
		// Materhorn 24 regular font (matches list)
		[Embed(source="../media/fonts/bitmap/materhorn24.png")]
		public static const Font_Materhorn24:Class;
		[Embed(source="../media/fonts/bitmap/materhorn24.fnt", mimeType="application/octet-stream")]
		public static const XML_Materhorn24:Class;
		
		// Bell Gothic Std Black 13 font (matches list)
		[Embed(source="../media/fonts/bitmap/bellgothicblack13.png")]
		public static const Font_BellGothicBlack13:Class;
		[Embed(source="../media/fonts/bitmap/bellgothicblack13.fnt", mimeType="application/octet-stream")]
		public static const XML_BellGothicBlack13:Class;
		
		// Badaboom 25 font (matches list)
		[Embed(source="../media/fonts/bitmap/badaboom25.png")]
		public static const Font_Badaboom25:Class;
		[Embed(source="../media/fonts/bitmap/badaboom25.fnt", mimeType="application/octet-stream")]
		public static const XML_Badaboom25:Class;
		
		// Materhorn 25 dark font (matches details popup, town square)
		[Embed(source="../media/fonts/bitmap/materhorn25.png")]
		public static const Font_Materhorn25:Class;
		[Embed(source="../media/fonts/bitmap/materhorn25.fnt", mimeType="application/octet-stream")]
		public static const XML_Materhorn25:Class;
		
		// Badaboom 50 font (in game messages)
		[Embed(source="../media/fonts/bitmap/badaboom50.png")]
		public static const Font_Badaboom50:Class;
		[Embed(source="../media/fonts/bitmap/badaboom50.fnt", mimeType="application/octet-stream")]
		public static const XML_Badaboom50:Class;
		
		// Badaboom 72 font (pulsing distance text)
		[Embed(source="../media/fonts/bitmap/pulsing72fire.png")]
		public static const Font_Pulsing72:Class;
		[Embed(source="../media/fonts/bitmap/pulsing72fire.fnt", mimeType="application/octet-stream")]
		public static const XML_Pulsing72:Class;
		
		// Badaboom 72 font (pulsing distance text)
		[Embed(source="../media/fonts/bitmap/pulsing72.png")]
		public static const Font_Pulsing72Fire:Class;
		[Embed(source="../media/fonts/bitmap/pulsing72.fnt", mimeType="application/octet-stream")]
		public static const XML_Pulsing72Fire:Class;
		
		// Bell Gothic Black 25 font (dialog box)
		[Embed(source="../media/fonts/bitmap/bellgothicblack25.png")]
		public static const Font_BellGothicBlack25:Class;
		[Embed(source="../media/fonts/bitmap/bellgothicblack25.fnt", mimeType="application/octet-stream")]
		public static const XML_BellGothicBlack25:Class;
		
		// Materhorn 24 White font (get gems / get coins)
		[Embed(source="../media/fonts/bitmap/materhorn24white.png")]
		public static const Font_Materhorn24White:Class;
		[Embed(source="../media/fonts/bitmap/materhorn24white.fnt", mimeType="application/octet-stream")]
		public static const XML_Materhorn24White:Class;
		
		// Materhorn 15 White font (get gems / get coins)
		[Embed(source="../media/fonts/bitmap/materhorn15white.png")]
		public static const Font_Materhorn15White:Class;
		[Embed(source="../media/fonts/bitmap/materhorn15white.fnt", mimeType="application/octet-stream")]
		public static const XML_Materhorn15White:Class;
		
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
		private static var Materhorn24:BitmapFont;
		private static var BellGothicBlack13:BitmapFont;
		private static var Badaboom25:BitmapFont;
		private static var Materhorn25:BitmapFont;
		private static var Badaboom50:BitmapFont;
		private static var Pulsing72:BitmapFont;
		private static var Pulsing72Fire:BitmapFont;
		private static var BellGothicBlack25:BitmapFont;
		private static var Materhorn24White:BitmapFont;
		private static var Materhorn15White:BitmapFont;
		
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