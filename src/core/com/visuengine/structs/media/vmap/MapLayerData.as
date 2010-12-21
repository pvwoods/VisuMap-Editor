package com.visuengine.structs.media.vmap
{
	import com.visuengine.utils.ByteUtils;
	
	import flash.utils.ByteArray;
	
	public class MapLayerData {
		
		public var sprites:Vector.<MapSpriteData>;
	
		public function MapLayerData():void{
			sprites = new Vector.<MapSpriteData>();
		}
		
		public function toByteArray():ByteArray{
			var result:ByteArray = new ByteArray();
			
			ByteUtils.writeUnsignedShort(result, sprites.length);
			
			for(var i:uint = 0; i < sprites.length; i++){
				var ba:ByteArray = sprites[i].toByteArray();
				result.writeBytes(ba, 0, ba.bytesAvailable);
			}
			
			return result;
			
		}
		
		public static function fromByteArray(data:ByteArray):MapLayerData{
			var result:MapLayerData = new MapLayerData();
			var totalSprites:uint = data.readUnsignedShort();
			for(var i:uint = 0; i < totalSprites; i++){
				var msd:MapSpriteData = MapSpriteData.fromByteArray(data);
				result.sprites.push(msd);
			}
			return result;
		}

	}
}