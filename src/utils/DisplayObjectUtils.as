package layz.utils
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	
	public class DisplayObjectUtils
	{
		public static function stopAll(target:DisplayObjectContainer):void
		{
			var numChildren:int = target.numChildren;
			for (var i:int = 0; i < numChildren; i++)
			{
				var child:DisplayObject = target.getChildAt(i);
				if (child is DisplayObjectContainer)
				{
					if (child is MovieClip)
						MovieClip(child).stop();
					
					stopAll(DisplayObjectContainer(child));
				}
			}
		}
		
		public static function removeChildren(target:DisplayObjectContainer):void
		{
			while(target.numChildren > 0)
			{
				var child:DisplayObject = target.getChildAt(0);
				
				if (child is DisplayObjectContainer)
				{
					if (child is MovieClip)
						stopAll(DisplayObjectContainer(child));
					
					if ((child as DisplayObjectContainer).numChildren > 0)
						removeChildren(DisplayObjectContainer(child));
				}
				else
				{
					if (child is Bitmap)
						(child as Bitmap).bitmapData.dispose();
				}
				
				target.removeChild(child);
			}
		}
	}
}