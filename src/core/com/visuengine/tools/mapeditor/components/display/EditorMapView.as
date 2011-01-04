package com.visuengine.tools.mapeditor.components.display
{
	import com.visuengine.components.display.MapLayer;
	import com.visuengine.components.display.MapView;
	import com.visuengine.structs.media.vmap.VMap;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;

	public class EditorMapView extends MapView {
		
		protected var _showSpriteGrids:Boolean;
		
		public function EditorMapView(vmap:VMap){
			_showSpriteGrids = true;
			super(vmap);
		}
		
		override public function draw():void{
			super.draw();
			
			var border:Sprite = new Sprite();
			if(_showSpriteGrids){
				for(var i:uint = 0; i < _layers.length; i++){
					for(var q:uint = 0; q < _layers[i].sprites.length; q++){
						var sprite:Bitmap = _layers[i].sprites[q];
						border.graphics.clear();
						border.graphics.lineStyle(1, 0xFFFF0000);
						border.graphics.drawRect(0,0,sprite.bitmapData.width-1,sprite.bitmapData.height-1);
						border.graphics.moveTo(0,0);
						border.graphics.lineTo(sprite.bitmapData.width,sprite.bitmapData.height);
						border.graphics.lineTo(0,sprite.bitmapData.height);
						border.graphics.lineTo(sprite.bitmapData.width,0);
						sprite.bitmapData.draw(border);
					}
				}
			}
		}
		
		public function applyEventHandlerToSprites(eventType:String, handler:Function):void{
			for(var i:uint = 0; i < _layers.length; i++){
				for(var q:uint = 0; q < _layers[i].sprites.length; q++){
					var sprite:Bitmap = _layers[i].sprites[q];
					sprite.addEventListener(eventType, handler);
				}
			}
		}
		
		public function removeEventHandlerFromSprites(eventType:String, handler:Function):void{
			for(var i:uint = 0; i < _layers.length; i++){
				for(var q:uint = 0; q < _layers[i].sprites.length; q++){
					var sprite:Bitmap = _layers[i].sprites[q];
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