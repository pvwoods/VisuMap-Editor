package com.visuengine.tools.mapeditor.managers
{
	import com.visuengine.structs.media.vmap.MapSpriteData;
	import com.visuengine.structs.media.vmap.VMap;
	import com.visuengine.tools.mapeditor.actions.requests.VMapFileLoadRequest;
	import com.visuengine.tools.mapeditor.actions.requests.VMapFileSaveRequest;
	import com.visuengine.tools.mapeditor.layouts.StandardEditorLayout;
	import com.visuengine.tools.mapeditor.models.MapEditorWorkingState;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.ui.Keyboard;
	import flash.utils.ByteArray;
	
	public class MapEditorFlowManager{
		
		protected const TOOL_BAR_ACTIONS:Array = [["Load a new Map", onLoadMapClicked], ["Save Current Map", onSaveMapClicked], ["Generate Ugly Map", onGenerateUglyMap]]
		
		protected var _stage:Stage;
		
		protected var _editorLayout:StandardEditorLayout;
		protected var _workingState:MapEditorWorkingState;
		
		protected var _targetSprite:Sprite;
		
		public function MapEditorFlowManager(){
			
			
		}
		
		public function init(containerClip:DisplayObjectContainer, stage:Stage):void{
			
			_stage = stage;
			
			_workingState = new MapEditorWorkingState();
			
			_editorLayout = new StandardEditorLayout(containerClip);
			
			_editorLayout.mapToolBar.build(TOOL_BAR_ACTIONS);
			
		}
		
		protected function onLoadMapClicked(event:MouseEvent):void{
			VMapFileLoadRequest.dispatchRequestToLoadFileData(onMapLoaded);
		}
		
		
		protected function onMapLoaded(map:VMap):void{
			destroyMap();
			_workingState.vmap = map;
			_editorLayout.buildNewMapView(_workingState.vmap);
			_editorLayout.mapEditorPanel.applyEventHandlerToAllSprites(MouseEvent.MOUSE_DOWN, onClickSprite);
			_stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		protected function onSaveMapClicked(event:MouseEvent):void{
			VMapFileSaveRequest.dispatchRequestToSaveFileData(_workingState.vmap.generateByteArray(), onMapSaved);
		}
		
		protected function onMapSaved():void{
			//
		}
		
		protected function onClickSprite(event:MouseEvent):void{
			var sp:Sprite = (event.currentTarget as Sprite);
			if(_targetSprite != null) _targetSprite.filters = [];
			_targetSprite = sp;
			var selectedFilter:GlowFilter = new GlowFilter(0xFFFF0000, 1, 5, 5, 10, 1, true);
			_targetSprite.filters = [selectedFilter];
			_targetSprite.startDrag();
		}
		
		protected function onMouseUp(event:MouseEvent):void{
			if(_targetSprite != null){
				_targetSprite.stopDrag();	
			}
		}
		
		protected function onKeyDown(event:KeyboardEvent):void{
			if(_targetSprite != null){
				switch(event.keyCode){
					
					case Keyboard.LEFT:
						_targetSprite.rotation -= 2;
						break;
						
					case Keyboard.RIGHT:
						_targetSprite.rotation += 2;
						break;
						
					case Keyboard.UP:
						_targetSprite.alpha = (_targetSprite.alpha + .05);
						if(_targetSprite.alpha > 1) _targetSprite.alpha = 1;
						break;
						
					case Keyboard.DOWN:
						_targetSprite.alpha = (_targetSprite.alpha - .05);
						if(_targetSprite.alpha < .1) _targetSprite.alpha = .1;
						break;
					// scale should eventually be percentage increments
					// w
					case 87:
						_targetSprite.scaleY += .1;
						break;
						
					// s
					case 83:
						_targetSprite.scaleY -= .1;
						if(_targetSprite.scaleY < .1) _targetSprite.scaleY = .1;
						break;
					
					// a
					case 65:
						_targetSprite.scaleX -= .1;
						if(_targetSprite.scaleX < .1) _targetSprite.scaleX = .1;
						break;
						
					// w
					case 68:
						_targetSprite.scaleX += .1;
						break;
						
					// q
					case 81:
						_targetSprite.scaleY -= .1;
						_targetSprite.scaleX -= .1;
						if(_targetSprite.scaleX < .1) _targetSprite.scaleX = .1;
						if(_targetSprite.scaleY < .1) _targetSprite.scaleY = .1;
						break;
						
					// e
					case 69:
						_targetSprite.scaleX += .1;
						_targetSprite.scaleY += .1;
						break;
					
				}
			}
		}
		
		protected function destroyMap():void{
			if(_editorLayout.mapEditorPanel.map != null){
				_editorLayout.mapEditorPanel.removeEventHandlerFromAllSprites(MouseEvent.MOUSE_DOWN, onClickSprite);
				_editorLayout.destroyMapView();
				_workingState.destroy();
				_workingState = new MapEditorWorkingState();
				_stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
				_stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			}
		}
		
		protected function onGenerateUglyMap(event:MouseEvent):void{
			
			destroyMap();
			
			for(var i:uint = 0; i < 20; i++){
				
				var layer:uint = Math.floor(i / 10);
				
				if(i % 10 == 0) _workingState.vmap.addLayer();
				
				if(i % 2 == 0){
					var image:ByteArray = new ByteArray();
					var imageWidth:uint = 10 + uint(Math.random()*90);
					var imageHeight:uint = imageWidth;
					for(var q:uint = 0; q < imageWidth*imageHeight; q++) image.writeUnsignedInt(0xFF << 24 | uint(Math.random()*0xFF) << 16 | uint(Math.random()*0xFF) << 8 | uint(Math.random()*0xFF));
					image.position = 0;
					_workingState.vmap.addImageData(image, imageWidth);
				}
				
				var sprite:MapSpriteData = new MapSpriteData();
				
				sprite.x = uint(10 + (Math.random()*500));
				sprite.y = uint(10 + (Math.random()*500));
				sprite.alpha = uint(Math.random()*100);
				sprite.rot = int(Math.random() * 360);
				sprite.scaleX = .75 + Math.random()*.5;
				sprite.scaleY = .75 + Math.random()*.5;
				sprite.tintR = uint(Math.random()*255);
				sprite.tintG = uint(Math.random()*255);
				sprite.tintB = uint(Math.random()*255);
				sprite.imageDataIndex = uint(i / 2);
				
				_workingState.vmap.addSprite(sprite, layer);
				
				
			}
			
			onMapLoaded(_workingState.vmap);
			
		}
		

	}
}