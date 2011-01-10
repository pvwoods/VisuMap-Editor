package com.visuengine.tools.mapeditor.components.display
{
	import com.visuengine.components.display.MapLayer;
	import com.visuengine.components.display.MapView;
	import com.visuengine.structs.media.vmap.VMap;
	
	import flash.display.DisplayObject;
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
			/*
			for(var i:uint = 0; i < _layers.length; i++){
				(_layers[i] as Sprite).mouseChildren = true;
				for(var q:uint = 0; q < _layers[i].sprites.length; q++){
					var border:Sprite = _layers[i].sprites[q] as Sprite;
					border.graphics.clear();
					if(_showSpriteGrids){
						border.graphics.lineStyle(1, 0xFFFF0000);
						border.graphics.drawRect(0,0,border.width,border.height);
						border.graphics.moveTo(0,0);
						border.graphics.lineTo(border.width,border.height);
						border.graphics.lineTo(0,border.height);
						border.graphics.lineTo(border.width,0);
						border.cacheAsBitmap = true;
					}
				}
			}
			*/
		}
		
		public function applyEventHandlerToAllSprites(eventType:String, handler:Function):void{
			for(var i:uint = 0; i < _layers.length; i++){
				for(var q:uint = 0; q < _layers[i].sprites.length; q++){
					var sprite:Sprite = _layers[i].sprites[q] as Sprite;
					sprite.addEventListener(eventType, handler);
				}
			}
		}
		
		public function removeEventHandlerFromAllSprites(eventType:String, handler:Function):void{
			for(var i:uint = 0; i < _layers.length; i++){
				for(var q:uint = 0; q < _layers[i].sprites.length; q++){
					var sprite:Sprite = _layers[i].sprites[q] as Sprite;
					sprite.removeEventListener(eventType, handler);
				}
			}
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