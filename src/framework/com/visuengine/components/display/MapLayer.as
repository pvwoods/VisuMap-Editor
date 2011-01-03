package com.visuengine.components.display {
	
	import com.visuengine.structs.media.vmap.MapLayerData;
	import com.visuengine.structs.media.vusprite.VUSprite;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	// map layers are treated as sprites instead of bitmaps
	// so that we can support layer sprite effects in the future
	public class MapLayer extends Sprite{
		
		protected var _layerData:MapLayerData;
		protected var _imageData:Vector.<VUSprite>;
		protected var _sprites:Vector.<Bitmap>;
		
		
		public function MapLayer(layerData:MapLayerData, imageData:Vector.<VUSprite>) {
			
			this.cacheAsBitmap = true;
			
			_layerData = layerData;
			
			_imageData = imageData;
			
			_sprites = new Vector.<Bitmap>();
			
			buildLayer();
			
		}
		
		public function buildLayer():void{
			
			for(var i:uint = 0; i < _layerData.sprites.length; i++){
				//var bmp:Bitmap = new 
			}
			
		}
		
		public function destroy():void{
			_layerData = null;
			
			for(var i:uint = 0; i < _sprites.length; i++){
				removeChild(_sprites[i]);
				_sprites[i] = null;
			} 
		}

	}
}