package com.visuengine.components.display {
	
	import com.visuengine.structs.media.vmap.VMap;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class MapView{
		
		protected var _vmap:VMap;
		protected var _layers:Vector.<MapLayer>;
		protected var _container:Sprite;
		
		public function MapView(vmap:VMap){
			
			_vmap = vmap;
			_layers = new Vector.<MapLayer>();
			_container = new Sprite();
			
			draw();
			
		}
		
		public function draw():void{
			for(var i:uint = 0; i < _vmap.totalLayers; i++) addLayer(i);
		}
		
		public function addLayer(layerIndex:uint):void{
			_layers.push(new MapLayer(_vmap.getLayerByIndex(layerIndex), _vmap.imageData));
			_container.addChild(_layers[layerIndex]);
		}
		
		public function clearMap():void{
			for(var i:uint = 0; i < _layers.length; i++){
				_container.removeChild(_layers[i]);
				_layers[i].destroy();
			}
			_layers = new Vector.<MapLayer>();
		}
		
		//place holder function
		public function moveMap(distance:Point):void{
			for(var i:uint = 0; i < _layers.length; i++){
				_layers[i].x += distance.x * (i + 1);
				_layers[i].y += distance.y * (i + 1);
			}
		}
		
		public function zoomMap(amount:Number):void{
			
		}
		
		public function get mapContainer():Sprite{
			return _container;
		}
		
		public function destroy():void{
			_vmap = null;
			clearMap();
		}

	}
}