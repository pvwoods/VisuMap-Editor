package com.visuengine.tools.mapeditor.components.display
{
	import com.visuengine.components.display.MapLayer;
	import com.visuengine.components.display.MapView;
	import com.visuengine.structs.media.vmap.VMap;
	
	import flash.display.Sprite;

	public class EditorMapView extends MapView {
		
		protected var _showSpriteGrids:Boolean;
		
		public function EditorMapView(vmap:VMap){
			_showSpriteGrids = true;
			for(var i:uint = 0; i < vmap.totalLayers; i++) vmap.getLayerByIndex(i).recievesInput = true;
			super(vmap);
			_container.mouseChildren = true;
		}
		
		override public function draw():void{
			super.draw();
		}
		
		public function applyEventHandlerToAllSprites(eventType:String, handler:Function):void{
			for(var i:uint = 0; i < _layers.length; i++){
				for(var q:uint = 0; q < _layers[i].sprites.length; q++) applyEventHandlerToSprite(i, q, eventType, handler);
			}
		}
		
		public function removeEventHandlerFromAllSprites(eventType:String, handler:Function):void{
			for(var i:uint = 0; i < _layers.length; i++){
				for(var q:uint = 0; q < _layers[i].sprites.length; q++) removeEventHandlerFromSprite(i, q, eventType, handler);
			}
		}
		
		public function applyEventHandlerToSprite(layerIndex:uint, spriteIndex:uint, eventType:String, handler:Function):void{
			var sprite:Sprite = _layers[layerIndex].sprites[spriteIndex] as Sprite;
			sprite.addEventListener(eventType, handler);
		}
		
		public function removeEventHandlerFromSprite(layerIndex:uint, spriteIndex:uint, eventType:String, handler:Function):void{
			var sprite:Sprite = _layers[layerIndex].sprites[spriteIndex] as Sprite;
			sprite.removeEventListener(eventType, handler);
		}
		
		public function getIndexInfoForSprite(targetSprite:Sprite):Vector.<uint>{
			var result:Vector.<uint> = new Vector.<uint>();
			result.push(_layers.indexOf(targetSprite.parent as Sprite))
			result.push((_layers[result[0]] as MapLayer).sprites.indexOf(targetSprite));
			return result;
		}
		
		public function removeSprite(layerIndex:uint, spriteIndex:uint):void{
			_layers[layerIndex].removeChild(_layers[layerIndex].sprites[spriteIndex]);
			_layers[layerIndex].sprites.splice(spriteIndex, 1);
		}
		
		public function removeLayer(layerIndex:uint):void{
			_container.removeChild(_layers[layerIndex]);
			_layers.splice(layerIndex, 1);
		}
		
		public function updateLayer(layerIndex:uint):void{
			_layers[layerIndex].buildLayer(true);
		}
		
		public function get showSpriteGrids():Boolean{
			return _showSpriteGrids;
		}
		
		public function set showSpriteGrids(value:Boolean):void{
			if(_showSpriteGrids != value){
				_showSpriteGrids = value;
				clearMap();
				draw();
			}
		}
		
		public function get layers():Vector.<MapLayer>{
			return _layers;
		}
		
	}
}