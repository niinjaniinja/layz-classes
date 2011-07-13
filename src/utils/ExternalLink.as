package layz.utils
{
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.utils.setTimeout;
	
	public class ExternalLink
	{
		public static var onExternalLink:Function;
		
		public static function open(link:String, window:String = "_blank", callCallback:Boolean = true):void
		{
			if (onExternalLink != null && callCallback)
				onExternalLink.call();
			
			navigateToURL(new URLRequest(link), window);
		}
	}
}