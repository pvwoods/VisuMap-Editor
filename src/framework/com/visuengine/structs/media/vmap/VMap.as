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
		
		public function addLayer(layer:MapLayerData=null):uint{
				return _layers.push(layer == null ? new MapLayerData():layer);
		}
		
		public function addSprite(sprite:MapSpriteData, layerIndex:uint):uint{
			
			if(layerIndex >= _layers.length || layerIndex < 0) throw new Error("Layer Index out of Bounds");
			
			return _layers[layerIndex].sprites.push(sprite);
		}
		
		public function addImageData(image:ByteArray):uint{
			return _spriteImageData.push(image);
		}
		
		public function getImageData(index:uint):ByteArray{
			return _spriteImageData[index];
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
		
		public static function generateMapfromFile(data:ByteArray):VMap{
			var result:VMap = new VMap();
			
			data.endian = STRUCT_ENDIAN;
			
			data.uncompress();
			
			var sig:uint = data.readUnsignedInt();
			
			if(sig != STRUCT_SIGNATURE) throw new Error("this file does not contain the appropriate \"VUMP\" signature!");
			
			result.overrideStructVersion(data.readByte());
			result.imageDataEncodingType = data.readByte();
			
			var totalImages:uint = data.readUnsignedShort();
			var totalLayers:uint = data.readUnsignedShort();
			
			data.position += 2;
			
			for(var i:uint = 0; i < totalImages; i++){
				var ba:ByteArray = new ByteArray();
				var baLength:uint = data.readUnsignedInt();
				data.readBytes(ba, 0, baLength);
				data.position += 2;
				result.addImageData(ba);
			}
			
			for(var q:uint = 0; q < totalLayers; q++){
				var mld:MapLayerData = MapLayerData.fromByteArray(data);
				data.position += 2;
				result.addLayer(mld);
			}
			
			
			
			return result;
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
		
		public function set imageDataEncodingType(value:uint):void{
			_imageDataEncodingType = value;
		}
		
		public function get imageDataEncodingType():uint{
			return _imageDataEncodingType;
		}
		
		public function overrideStructVersion(version:uint):void{
			_structVersion = version;
		}

	}
}