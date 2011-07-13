package layz.base.ui 
{
	import layz.base.events.UIEvents;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import caurina.transitions.Tweener;
	
	public class BaseUIElement extends MovieClip
	{
		public function BaseUIElement() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		}
		
		protected function onAdded(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		protected function onRemoved(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		public function show(delay:Number = 0):void
		{
			visible = true;
			
			Tweener.removeTweens(this);
			Tweener.addTween(this, {alpha: 1, time: 0.5, transition: "linear", onComplete: function()
			{
				dispatchEvent(new Event(UIEvents.SHOW_COMPLETE));
			}});
		}
		
		public function hide(delay:Number = 0):void
		{
			Tweener.removeTweens(this);
			Tweener.addTween(this, {alpha: 0, time: 0.5, transition: "linear", delay: delay, onComplete: function()
			{
				this.visible = false;
				dispatchEvent(new Event(UIEvents.HIDE_COMPLETE));
			}});
		}
		
		public function resize(swidth:Number, sheight:Number):void
		{
			/* Override in concrete class */
		}
	}
}