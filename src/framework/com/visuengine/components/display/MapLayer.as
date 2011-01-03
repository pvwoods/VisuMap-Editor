package com.visuengine.components.display {
	
	import com.visuengine.structs.media.vmap.MapLayerData;
	import com.visuengine.structs.media.vmap.MapSpriteData;
	import com.visuengine.structs.media.vusprite.VUSprite;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
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
			trace("total sprites on this layer: " + _layerData.sprites.length.toString());
			for(var i:uint = 0; i < _layerData.sprites.length; i++){
				var sprite:VUSprite = _imageData[_layerData.sprites[i].imageDataIndex];
				sprite.spriteData.position = 0;
				var bd:BitmapData = new BitmapData(sprite.width, sprite.width);
				bd.setPixels(bd.rect, sprite.spriteData);
				var bmp:Bitmap = new Bitmap(bd);
				bmp.x = _layerData.sprites[i].x
				bmp.y = _layerData.sprites[i].y
				bmp.rotation = _layerData.sprites[i].rot;
				bmp.scaleX = _layerData.sprites[i].scaleX;
				bmp.scaleY = _layerData.sprites[i].scaleY;
				_sprites.push(bmp);
				addChild(bmp);
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