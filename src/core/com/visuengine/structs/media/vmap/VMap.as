package com.visuengine.structs.media.vmap {
	
	import com.visuengine.utils.ByteUtils;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	public class VMap{
		// "VUMP" file
		public static const STRUCT_SIGNATURE:uint = 1448430928;
		public static const STRUCT_ENDIAN:String = Endian.BIG_ENDIAN;
		public static const STRUCT_VERSION:uint = 1;
		
		public static const IMAGE_ENCODING_TYPE__RESERVED__:uint = 0;
		public static const IMAGE_ENCODING_TYPE_PNG:uint = 1;
		public static const IMAGE_ENCODING_TYPE_BITMAP_DATA:uint = 2;
		
		protected var _layers:Vector.<MapLayerData>;
		protected var _spriteImageData:Vector.<ByteArray>;
		protected var _structVersion:uint;
		protected var _imageDataEncodingType:uint;
		
		public function VMap(){
			
			_layers = new Vector.<MapLayerData>();
			_spriteImageData = new Vector.<ByteArray>();
			_structVersion = STRUCT_VERSION;
			_imageDataEncodingType = IMAGE_ENCODING_TYPE_BITMAP_DATA;
			
		}
		
		public function addLayer():uint{
			return _layers.push(new MapLayerData());
		}
		
		public function addSprite(sprite:MapSpriteData, layerIndex:uint):uint{
			
			if(layerIndex >= _layers.length || layerIndex < 0) throw new Error("Layer Index out of Bounds");
			
			return _layers[layerIndex].sprites.push(sprite);
		}
		
		public function addImageData(image:ByteArray):uint{
			return _spriteImageData.push(image);
		}
		
		// once this gets solidified a bit more, it could use a refactor
		public function generateByteArray():ByteArray{
			
			var result:ByteArray = new ByteArray();
			result.endian = STRUCT_ENDIAN;
			// "VUMP" sig and version #
			result.writeUnsignedInt(STRUCT_SIGNATURE);
			result.writeByte(_structVersion);
			result.writeByte(_imageDataEncodingType);
			// total image data 
			ByteUtils.writeUnsignedShort(result, _spriteImageData.length);
			// total layers
			ByteUtils.writeUnsignedShort(result, _layers.length);
			//end header
			result.writeShort(0);
			// write image data
			for(var i:uint = 0; i < _spriteImageData.length; i++){
				_spriteImageData[i].position = 0;
				result.writeUnsignedInt(_spriteImageData[i].bytesAvailable);
				result.writeBytes(_spriteImageData[i], 0, _spriteImageData[i].bytesAvailable);
				result.writeShort(0);
			}
			// write layers
			for(var q:uint = 0; q < _layers.length; q++){
				var ba:ByteArray = _layers[q].toByteArray();
				result.writeBytes(ba, 0, ba.bytesAvailable);
				result.writeShort(0);
			}
			
			result.compress();
			
			return result;
		}
		
		public static function generateMapfromFile():VMap{
			return new VMap();
		}
		
		public function get totalLayers():uint{
			return _layers.length;
		}
		
		public function get totalImageData():uint{
			return _spriteImageData.length;
		}
		
		public function get version():uint{
			return _structVersion;
		}
		
		public function overrideStructVersion(version:uint):void{
			_structVersion = version;
		}

	}
}