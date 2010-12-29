package com.visuengine.tools.layouts
{
	import flash.display.DisplayObjectContainer;
	
	public class BaseLayout {
		
		protected var _container:DisplayObjectContainer;
		
		public function BaseLayout(container:DisplayObjectContainer){
			
			_container = container;
			
		}
		
		public function get layoutContainer():DisplayObjectContainer{
			return _container;
		}

	}
}