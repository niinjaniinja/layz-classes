package layz.utils
{
	import flash.events.ContextMenuEvent;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	public class CustomContextMenu
	{
		private var _contextMenu				:ContextMenu;
		
		public function CustomContextMenu(hideBuiltInItems:Boolean = true)
		{
			_contextMenu = new ContextMenu;
			
			if (hideBuiltInItems)
				_contextMenu.hideBuiltInItems();
		}
		
		public function hideBuiltInItems():void
		{
			_contextMenu.hideBuiltInItems();
		}
		
		public function addItem(label:String, func:Function):void
		{
			var item:ContextMenuItem = new ContextMenuItem(label);
			item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, func);
			
			_contextMenu.customItems.push(item);
		}
		
		public function get contextMenu():ContextMenu { return _contextMenu; }
		
		public function set contextMenu(value:ContextMenu):void 
		{
			_contextMenu = value;
		}
	}
}