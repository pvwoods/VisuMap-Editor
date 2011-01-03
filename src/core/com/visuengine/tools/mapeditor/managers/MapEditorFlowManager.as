package com.visuengine.tools.mapeditor.managers
{
	import com.visuengine.structs.media.vmap.MapSpriteData;
	import com.visuengine.structs.media.vmap.VMap;
	import com.visuengine.tools.mapeditor.actions.requests.VMapFileLoadRequest;
	import com.visuengine.tools.mapeditor.actions.requests.VMapFileSaveRequest;
	import com.visuengine.tools.mapeditor.layouts.StandardEditorLayout;
	import com.visuengine.tools.mapeditor.models.MapEditorWorkingState;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	public class MapEditorFlowManager{
		
		protected const TOOL_BAR_ACTIONS:Array = [["Load a new Map", onLoadMapClicked], ["Save Current Map", onSaveMapClicked], ["Generate Ugly Map", onGenerateUglyMap]]
		
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
			_editorLayout.buildNewMapView(_workingState.vmap);
		}
		
		protected function onSaveMapClicked(event:MouseEvent):void{
			VMapFileSaveRequest.dispatchRequestToSaveFileData(_workingState.vmap.generateByteArray(), onMapSaved);
		}
		
		protected function onMapSaved():void{
			//
		}
		
		protected function onGenerateUglyMap(event:MouseEvent):void{
			
			_workingState.destroy();
			
			_workingState = new MapEditorWorkingState();
			
			for(var i:uint = 0; i < 20; i++){
				
				var layer:uint = Math.floor(i / 10);
				
				if(i % 10 == 0) _workingState.vmap.addLayer();
				
				if(i % 2 == 0){
					var image:ByteArray = new ByteArray();
					var imageWidth:uint = 10 + uint(Math.random()*90);
					var imageHeight:uint = 10 + uint(Math.random()*90);
					for(var q:uint = 0; q < imageWidth*imageHeight; q++) image.writeUnsignedInt(0xFF << 24 | uint(Math.random() * 0xffffff) << 16);
					image.position = 0;
					_workingState.vmap.addImageData(image, imageWidth);
				}
				
				var sprite:MapSpriteData = new MapSpriteData();
				
				sprite.x = uint(10 + (Math.random()*300));
				sprite.y = uint(10 + (Math.random()*300));
				sprite.alpha = uint(Math.random()*100);
				sprite.rot = Math.random();
				sprite.scaleX = .75 + Math.random()*.5;
				sprite.scaleY = .75 + Math.random()*.5;
				sprite.tintR = uint(Math.random()*255);
				sprite.tintG = uint(Math.random()*255);
				sprite.tintB = uint(Math.random()*255);
				sprite.imageDataIndex = uint(i / 2);
				
				
			}
			
		}
		

	}
}