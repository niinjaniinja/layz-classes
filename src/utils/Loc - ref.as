package layz.pixie.utils
{
	import flash.text.AntiAliasType;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import pixie.core.Etc;
	import pixie.core.Styles;
	
	public class Loc
	{
		
		// Text align consts
		public static const LEFT		: String = "left";
		public static const TOP_LEFT	: String = "top_left";
		public static const RIGHT		: String = "right";
		public static const CENTER		: String = "center";
		
		private static var xml : XML;
		
		public static function setXML( xml : XML ) : void
		{
			Loc.xml = xml;
		}
		
		public static function exists( id : String ) : Boolean
		{
			var list : XMLList = Loc.xml.children();
			return ( list.( attribute( "id" ) == id ) != undefined );
		}
		
		public static function getText( id : String ) : String
		{
			if ( !Loc.xml )
				Loc.xml = new XML;
				
			var list : XMLList = Loc.xml.children();
			var len : int = list.( attribute( "id" ) == id ).length();
			
			while ( len == 0 )
			{
				list = list.children();
				len = list.( attribute( "id" ) == id ).length();
				
				if ( list.length() == 0 )
					break;
			}
			
			var value : String = list.( attribute( "id" ) == id ).text().toString();
			
			while ( value.charAt( 0 ) == " " )
				value = value.substr( 1 );
			
			return value;
		}
		
		public static function getHTMLText( id : String ) : String
		{
			var text : String = Loc.getText( id );
			
			if ( text != "" )
				text = "<body>" + format( text ) + "</body>";
			
			return text;
		}
		
		
		// Configure TextFields
		public static function setResizableTf(t:TextField, alignStyle:String):void
		{
			switch(alignStyle)
			{
				case LEFT:
					t.autoSize = TextFieldAutoSize.LEFT;
					t.wordWrap = false;
				break;
				case TOP_LEFT:
					t.autoSize = TextFieldAutoSize.LEFT;
					t.wordWrap = true;
				break;
				case RIGHT:
					t.autoSize = TextFieldAutoSize.RIGHT;
					t.wordWrap = false;
				break;
				case CENTER:
					t.autoSize = TextFieldAutoSize.CENTER;
					t.wordWrap = false;
				break;
				default :
					trace("Loc >> : "+alignStyle+" align style is not register");
				break;
			}
		}
		
		/**
		 * Set font style and localised text
		 * @param	id					single ID or an array of IDs for multiple texts in the same TextField (will be separated by a line break)
		 * @param	tf					TextField to be filled
		 * @param	fontStyle			Name of the font style, defined in FontManager.as
		 * @param	textFormatParams	Extra TextFormat parametres
		 * @param	alignStyle			Text align (LEFT by default)
		 * @param 	upperCase			Text in upper case (false by default)
		 */
		public static function setText( id : *, tf : TextField, fontStyle : String, textFormatParams : Object = null, alignStyle : String = "left", upperCase : Boolean = false) : void
		{
			setResizableTf( tf, alignStyle );
			
			tf.embedFonts = true;
			tf.antiAliasType = AntiAliasType.NORMAL;
			tf.defaultTextFormat = FontManager.getTextFormat( fontStyle, textFormatParams );
			
			var txt : String = "";
			
			if ( id is String )
			{
				txt = getText( id );
			}
			else
			{
				var len : int = id.length;
				for ( var i : int = 0; i < len; i++ )
					txt += getText( id[ i ] ) + "\n";
			}
			
			if(upperCase)
				txt = txt.toUpperCase();
			tf.text = txt;
			
			FontManager.updateLineAscent( tf );
		}
		
		/**
		 * Set font style and localised text with HTML tags
		 * @param	id					single ID or an array of IDs for multiple texts in the same TextField (will be separated by a line break)
		 * @param	tf					TextField to be filled
		 * @param	fontStyle			Name of the font style, defined in FontManager.as
		 * @param	textFormatParams	Extra TextFormat parametres
		 * @param	alignStyle			Text align (LEFT by default)
		 * @param 	upperCase			Text in upper case (false by default)
		 */
		public static function setHTMLText( id : *, tf : TextField, fontName : String, boldColor : uint = 0, alignStyle : String = "left" , upperCase : Boolean = false) : void
		{
			setResizableTf( tf, alignStyle );
			
			if ( tf.styleSheet )
				tf.styleSheet.clear();
			
			tf.embedFonts = true;
			tf.antiAliasType = AntiAliasType.NORMAL;			
			tf.styleSheet = FontManager.getStylesheet( fontName, boldColor );
			
			var txt : String = "";
			
			if ( id is String )
			{
				txt = getHTMLText( id );
			}
			else
			{
				var len : int = id.length;
				for ( var i : int = 0; i < len; i++ )
					txt += getHTMLText( id[ i ] ) + "\n";
			}
			
			if( upperCase )
				txt = txt.toUpperCase();
				
			tf.htmlText = txt;
			
			FontManager.updateLineAscent( tf );
		}
		
		public static function format( text : String ) : String
		{
			var s : String = text.replace( /pixie/gi, "PIXIE" );					// Convert all Pixie to uppercase
			s = s.replace( /(?!nespresso.com)nespresso/gi, "<i>Nespresso</i>" );	// Convert all Nespresso to italic
			s = s.replace( /aeroccino/gi, "Aeroccino3" );							// Change Aeroccino to Aeroccino3
			s = s.replace( /3( )*3/gi, "3" );										// Change Aeroccino to Aeroccino3
			
			s = s.replace( /( )+/, " " );											// Fix double or more spaces
			s = s.replace( /<i><i>/gi, "<i>" );										// Fix double italic tags
			s = s.replace( /<i> <i>/gi, " <i>" );									// Fix double italic tags
			s = s.replace( /<\/i><\/i>/gi, "</i>" );								// Fix double italic tags
			s = s.replace( /<\/i> <\/i>/gi, "</i> " );								// Fix double italic tags
			
			s = s.replace( /(<b><i>|<i><b>)/gi, "<boldItalic>" );
			s = s.replace( /(<b> <i>|<i> <b>)/gi, " <boldItalic>" );
			s = s.replace( /(<\/b><\/i>|<\/i><\/b>)/gi, "</boldItalic>" );
			s = s.replace( /(<\/b> <\/i>|<\/i> <\/b>)/gi, "</boldItalic> " );
			s = s.replace( /i>/gi, "italic>" );
			s = s.replace( /b>/gi, "bold>" );
			
			return s;
		}
	}
}