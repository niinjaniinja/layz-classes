package layz.utils
{
	import flash.external.ExternalInterface;
	
	public class DomainUtils
	{
		public static function getBaseURL():String
		{
			var url:String = "";
			
			if (ExternalInterface.available)
			{
				url = ExternalInterface.call("window.location.href.toString");
				url = url.substring(0, url.lastIndexOf("/") + 1);
				
				if (url.charAt(url.length - 1) != "/")
					url += "/";
			}
			
			return url;
		}
	}
}