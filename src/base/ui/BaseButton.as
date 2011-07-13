package layz.base.ui
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class BaseButton extends BaseUIElement
	{
		private var _id			:* = "";
		private var _label		:String = "";
		
		private var _hit		:Sprite;
		
		public function BaseButton()
		{
			super();
			
			_hit = this;
			_hit.buttonMode = true;
			_hit.mouseChildren = false;
			
			toggleEnabled(true);
		}
		
		override protected function onAdded(e:Event):void
		{
			super.onAdded(e);
			
			stop();
		}
		
		override protected function onRemoved(e:Event):void
		{
			super.onRemoved(e);
			
			_hit.removeEventListener(MouseEvent.ROLL_OVER, rollOver);
			_hit.removeEventListener(MouseEvent.ROLL_OUT, rollOut);
			_hit.removeEventListener(MouseEvent.CLICK, click);
		}
		
		protected function setNewHitArea(target:Sprite):void
		{
			_hit.buttonMode = false;
			_hit.mouseChildren = true;
			
			// Clear previous hit's listeners
			toggleEnabled(false);
			
			// Set new hit
			_hit = target;
			_hit.alpha = 0;
			
			_hit.buttonMode = true;
			_hit.mouseChildren = false;
			
			// Add listeners to new hit
			toggleEnabled(true);
		}
		
		public function toggleEnabled(value:Boolean):void
		{
			_hit.mouseEnabled = value;
			
			_hit.removeEventListener(MouseEvent.ROLL_OVER, rollOver);
			_hit.removeEventListener(MouseEvent.ROLL_OUT, rollOut);
			_hit.removeEventListener(MouseEvent.CLICK, click);
			
			if (value)
			{
				_hit.addEventListener(MouseEvent.ROLL_OVER, rollOver);
				_hit.addEventListener(MouseEvent.ROLL_OUT, rollOut);
				_hit.addEventListener(MouseEvent.CLICK, click);
			}
		}
		
		public function rollOver(event:MouseEvent = null):void
		{
			gotoAndPlay("over");
		}
		
		public function rollOut(event:MouseEvent = null):void
		{
			gotoAndPlay("out");
		}
		
		public function click(event:MouseEvent = null):void
		{
			/* Override in concrete class */
		}
		
		public function get id():* { return _id; }
		
		public function set id(value:*):void 
		{
			_id = value;
		}
		
		public function get label():String { return _label; }
		
		public function set label(value:String):void 
		{
			_label = value;
		}
	}
}