package layz.utils
{
	public class Loc
	{
		public static var xml:XML;
		
		public static function exists(id:String):Boolean
		{
			if (!Loc.xml)
				throw new Error("# Loc # the base XML has not been defined");
				
			var list:XMLList = Loc.xml.children();
			return (list.(attribute("id") == id) != undefined);
		}
		
		public static function getText(id:String):String
		{
			if (!Loc.xml)
				throw new Error("# Loc # the base XML has not been defined");
				
			var list:XMLList = Loc.xml.children();
			var len:int = list.(attribute("id") == id).length();
			
			while (len == 0)
			{
				list = list.children();
				len = list.(attribute("id") == id).length();
				
				if (list.length() == 0)
					break;
			}
			
			var value:String = list.(attribute("id") == id).text().toString();
			
			while (value.charAt(0) == " ")
				value = value.substr(1);
			
			return value;
		}
	}
}