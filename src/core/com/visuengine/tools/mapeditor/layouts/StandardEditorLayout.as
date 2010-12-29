package com.visuengine.tools.mapeditor.layouts
{
	import com.visuengine.tools.layouts.BaseLayout;
	import com.visuengine.tools.mapeditor.panels.MapEditorPanel;
	import com.visuengine.tools.mapeditor.panels.MapToolBar;
	
	import flash.display.DisplayObjectContainer;
	
	public class StandardEditorLayout extends BaseLayout{
		
		protected var _mapEditor:MapEditorPanel;
		protected var _toolbar:MapToolBar;
		
		public function StandardEditorLayout(container:DisplayObjectContainer) {
			
			super(container);
			
			buildMapEditorPanel();
			buildMapToolBar();
			
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