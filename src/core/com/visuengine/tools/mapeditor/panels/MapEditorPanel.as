package com.visuengine.tools.mapeditor.panels{
	
	import com.bit101.components.Panel;
	import com.visuengine.structs.media.vmap.VMap;
	import com.visuengine.tools.mapeditor.components.display.EditorMapView;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
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
		
		public function updateLayer(layerIndex:uint):void{
			_map.updateLayer(layerIndex);
		}
		
		public function applyEventHandlerToAllSprites(eventType:String, handler:Function):void{
			_map.applyEventHandlerToAllSprites(eventType, handler);
		}
		
		public function removeEventHandlerFromAllSprites(eventType:String, handler:Function):void{
			_map.removeEventHandlerFromAllSprites(eventType, handler);
		}
		
		public function applyEventHandlerToSprite(layerIndex:uint, spriteIndex:uint, eventType:String, handler:Function):void{
			_map.applyEventHandlerToSprite(layerIndex, spriteIndex, eventType, handler);
		}
		
		public function getIndexInfoForSprite(targetSprite:Sprite):Vector.<uint>{
			return _map.getIndexInfoForSprite(targetSprite);
		}
		
		public function removeSprite(layerIndex:uint, spriteIndex:uint):void{
			_map.removeSprite(layerIndex, spriteIndex);
		}
		
		public function removeLayer(layerIndex:uint):void{
			_map.removeLayer(layerIndex);
		}
		
		public function destroyMap():void{
			if(_map != null){
				_map.destroy();
			}
		}
		
		public function resize(w:uint, h:uint):void {
			this.width = w;
			this.height = h;
			_viewPortSet = false;
			setViewPort();
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
