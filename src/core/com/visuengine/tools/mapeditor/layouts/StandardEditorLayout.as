package com.visuengine.tools.mapeditor.layouts
{
	import com.visuengine.structs.media.vmap.VMap;
	import com.visuengine.structs.media.vusprite.VUSprite;
	import com.visuengine.tools.layouts.BaseLayout;
	import com.visuengine.tools.mapeditor.panels.MapEditorPanel;
	import com.visuengine.tools.mapeditor.panels.MapToolBar;
	
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	public class StandardEditorLayout extends BaseLayout{
		
		protected var _mapEditor:MapEditorPanel;
		protected var _toolbar:MapToolBar;
		
		public function StandardEditorLayout(container:DisplayObjectContainer) {
			
			super(container);
			
			buildMapEditorPanel();
			buildMapToolBar();
			
		}
		
		public function buildNewMapView(vmap:VMap):void{
			_mapEditor.buildNewMapView(vmap);
			for(var i:uint = 0; i < vmap.totalLayers; i++) _toolbar.addLayerToList();
			for(var q:uint = 0; q < vmap.totalImageData; q++) _toolbar.addImageToList();
		}
		
		public function setToolbarPreviewImage(sprite:VUSprite):void{
			sprite.spriteData.position = 0;
			_toolbar.setPreviewImage(VUSprite.generateBitmapData(sprite));
		}
		
		public function destroyMapView():void{
			_mapEditor.destroyMap();
			_toolbar.resetLists();
		}
		
		public function moveMap(distance:Point):void{
			_mapEditor.map.moveMap(distance);
		}
		
		public function addLayerToMap(layerIndex:uint):void{
			_mapEditor.map.addLayer(layerIndex);
		}
		
		public function resizeForWindow(w:uint, h:uint):void {
			_mapEditor.resize((w - _toolbar.width) - 15, h - 10);
			_toolbar.resize((w - _mapEditor.width) - 10, h - 10);
		}
		
		protected function buildMapEditorPanel():void{
			_mapEditor = new MapEditorPanel(_container);
			
			_mapEditor.width = 800;
			_mapEditor.height =  758;
			_mapEditor.x = 214;
			_mapEditor.y = 5;
			
			_mapEditor.showGrid = true;
			_mapEditor.shadow = true;
			
			_container.addChild(_mapEditor);
		}
		
		protected function buildMapToolBar():void{
			_toolbar = new MapToolBar(_container);
			
			_toolbar.width = 204;
			_toolbar.height = 758;
			_toolbar.x = 5;
			_toolbar.y = 5;
			
			_toolbar.shadow = true;
			
			_container.addChild(_toolbar);
		}
		
		public function get mapEditorPanel():MapEditorPanel{
			return _mapEditor;
		}
		
		public function get mapToolBar():MapToolBar{
			return _toolbar;
		}

	}
}
