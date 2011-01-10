package com.visuengine.tools.mapeditor.panels{
	
	import com.bit101.components.Panel;
	import com.visuengine.structs.media.vmap.VMap;
	import com.visuengine.tools.mapeditor.components.display.EditorMapView;
	
	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;
	
	public class MapEditorPanel extends Panel{
		
		protected var _map:EditorMapView;
		protected var _viewPortSet:Boolean;
		
		public function MapEditorPanel(parent:DisplayObjectContainer){
			
			super(parent);
			
		}
		
		public function buildNewMapView(map:VMap):void{
			_map = new EditorMapView(map);
			setViewPort();
			addChild(_map.mapContainer);
		}
		
		public function applyEventHandlerToAllSprites(eventType:String, handler:Function):void{
			_map.applyEventHandlerToAllSprites(eventType, handler);
		}
		
		public function removeEventHandlerFromAllSprites(eventType:String, handler:Function):void{
			_map.removeEventHandlerFromAllSprites(eventType, handler);
		}
		
		public function destroyMap():void{
			if(_map != null){
				_map.destroy();
			}
		}
		
		public function setViewPort():void{
			if(!_viewPortSet){
				this.scrollRect = new Rectangle(0, 0, this.width, this.height);
				this.cacheAsBitmap = true;
				_viewPortSet = true;
			}
		}
		
		public function get map():EditorMapView{
			return _map;
		}

	}
}