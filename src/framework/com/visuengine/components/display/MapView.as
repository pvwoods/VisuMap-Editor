package com.visuengine.components.display {
	
	import com.visuengine.structs.media.vmap.VMap;
	
	import flash.display.Sprite;
	
	public class MapView{
		
		protected var _vmap:VMap;
		protected var _layers:Vector.<MapLayer>;
		protected var _container:Sprite;
		
		public function MapView(vmap:VMap){
			
			_vmap = vmap;
			_layers = new Vector.<MapLayer>();
			
			draw();
			
		}
		
		public function draw():void{
			
			for(var i:uint = 0; i < _vmap.totalLayers; i++){
				
				
				
			}
			
		}
		
		public function get mapContainer():Sprite{
			return _container;
		}
		
		public function destroy():void{
			_vmap = null;
			for(var i:uint = 0; i < _layers.length; i++){
				_container.removeChild(_layers[i]);
				_layers[i].destroy();
			}
		}

	}
}