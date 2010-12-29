package com.visuengine.tools.mapeditor.panels {
	
	import com.bit101.components.Panel;
	import com.bit101.components.PushButton;
	
	import flash.display.DisplayObjectContainer;

	public class MapToolBar extends Panel{
		
		protected var _toolBarButtons:Vector.<PushButton>;
		
		public function MapToolBar(parent:DisplayObjectContainer){
			
			super(parent);
			
			_toolBarButtons = new Vector.<PushButton>();
			
		}
		
		public function build(args:Array):void{
			
			for(var i:int = 0; i < args.length; i++){
				var idx:uint = _toolBarButtons.push(new PushButton(this, 5, 25 * i + 5, args[i][0] as String, args[i][1] as Function)) - 1;
				_toolBarButtons[idx].width = this.width - 10;
			}
		}
	}
}