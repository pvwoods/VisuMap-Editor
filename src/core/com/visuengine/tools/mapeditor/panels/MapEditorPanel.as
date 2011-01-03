package com.visuengine.tools.mapeditor.panels{
	
	import com.bit101.components.Panel;
	import com.visuengine.components.display.MapView;
	import com.visuengine.structs.media.vmap.VMap;
	
	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;
	
	public class MapEditorPanel extends Panel{
		
		protected var _map:MapView;
		protected var _viewPortSet:Boolean;
		
		public function MapEditorPanel(parent:DisplayObjectContainer){
			
			super(parent);
			
		}
		
		public function buildNewMapView(map:VMap):void{
			_map = new MapView(map);
			setViewPort();
			addChild(_map.mapContainer);
		}
		
		public function destroyMap():void{
			_map.destroy();
			removeChild(_map.mapContainer);
		}
		
		public function setViewPort():void{
			if(!_viewPortSet){
				this.scrollRect = new Rectangle(0, 0, this.width, this.height);
				this.cacheAsBitmap = true;
				_viewPortSet = true;
			}
		}
		
		public function get map():MapView{
			return _map;
		}

	}
}