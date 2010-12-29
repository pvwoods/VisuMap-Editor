package com.visuengine.tools.mapeditor.managers
{
	import com.visuengine.structs.media.vmap.VMap;
	import com.visuengine.tools.mapeditor.actions.requests.VMapFileLoadRequest;
	import com.visuengine.tools.mapeditor.layouts.StandardEditorLayout;
	import com.visuengine.tools.mapeditor.models.MapEditorWorkingState;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	public class MapEditorFlowManager{
		
		protected const TOOL_BAR_ACTIONS:Array = [["Load a new Map", onLoadMapClicked], ["Save Current Map", onSaveMapClicked]]
		
		protected var _editorLayout:StandardEditorLayout;
		protected var _workingState:MapEditorWorkingState;
		
		public function MapEditorFlowManager(){
			
			
		}
		
		public function init(containerClip:DisplayObjectContainer):void{
			
			_workingState = new MapEditorWorkingState();
			
			_editorLayout = new StandardEditorLayout(containerClip);
			
			_editorLayout.mapToolBar.build(TOOL_BAR_ACTIONS);
			
		}
		
		protected function onLoadMapClicked(event:MouseEvent):void{
			VMapFileLoadRequest.dispatchRequestToLoadFileData(onMapLoaded);
		}
		
		
		protected function onMapLoaded(map:VMap):void{
			_workingState.vmap = map;
		}
		
		protected function onSaveMapClicked(event:MouseEvent):void{
			// stub for now
			
		}

	}
}