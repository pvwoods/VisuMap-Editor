package com.visuengine.components.display {
	
	import com.visuengine.structs.media.vmap.MapLayerData;
	import com.visuengine.structs.media.vusprite.VUSprite;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	
	// map layers are treated as sprites instead of bitmaps
	// so that we can support layer sprite effects in the future
	public class MapLayer extends Sprite{
		
		protected var _layerData:MapLayerData;
		protected var _imageData:Vector.<VUSprite>;
		protected var _sprites:Vector.<DisplayObject>;
		
		
		public function MapLayer(layerData:MapLayerData, imageData:Vector.<VUSprite>) {
			
			this.cacheAsBitmap = true;
			
			_layerData = layerData;
			
			_imageData = imageData;
			
			_sprites = new Vector.<DisplayObject>();
			
			buildLayer();
			
		}
		
		public function buildLayer():void{
			
			for(var i:uint = 0; i < _layerData.sprites.length; i++){
				var sprite:VUSprite = _imageData[_layerData.sprites[i].imageDataIndex];
				sprite.spriteData.position = 0;
				var bd:BitmapData = new BitmapData(sprite.width, sprite.spriteData.bytesAvailable / (sprite.width * 4));
				bd.setPixels(bd.rect, sprite.spriteData);
				bd.colorTransform(bd.rect, new ColorTransform(_layerData.sprites[i].tintR/255, _layerData.sprites[i].tintG/255,
															  _layerData.sprites[i].tintB/255,1, _layerData.sprites[i].tintR,
															  _layerData.sprites[i].tintG, _layerData.sprites[i].tintB, 1));
				var bmp:Bitmap = new Bitmap(bd);
				bmp.smoothing = true;
				
				if(_layerData.recievesInput){
					var iCon:Sprite = new Sprite();
					iCon.addChild(bmp);
					iCon.x = _layerData.sprites[i].x
					iCon.y = _layerData.sprites[i].y
					iCon.rotation = _layerData.sprites[i].rot;
					iCon.scaleX = _layerData.sprites[i].scaleX;
					iCon.scaleY = _layerData.sprites[i].scaleY;
					iCon.alpha = _layerData.sprites[i].alpha / 100;
					_sprites.push(iCon);
					addChild(iCon);
				}else{
					bmp.x = _layerData.sprites[i].x
					bmp.y = _layerData.sprites[i].y
					bmp.rotation = _layerData.sprites[i].rot;
					bmp.scaleX = _layerData.sprites[i].scaleX;
					bmp.scaleY = _layerData.sprites[i].scaleY;
					bmp.alpha = _layerData.sprites[i].alpha / 100;
					_sprites.push(bmp);
					addChild(bmp);
				}
			}
			
		}
		
		public function get sprites():Vector.<DisplayObject>{
			return _sprites;
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