package com.visuengine.structs.media.vmap
{
	import com.visuengine.utils.ByteUtils;
	
	import flash.utils.ByteArray;
	
	public class MapSpriteData
	{
		public var imageDataIndex:uint;
		public var x:int;
		public var y:int;
		public var z:int;
		public var alpha:uint; // 0-100
		public var tintR:uint;
		public var tintG:uint;
		public var tintB:uint;
		public var rot:Number;
		public var scaleX:Number;
		public var scaleY:Number;
		
		
		public function clone():MapSpriteData{
			var s:MapSpriteData = new MapSpriteData();
			s.imageDataIndex = this.imageDataIndex;
			s.x = this.x;
			s.y = this.y;
			s.z = this.z;
			s.alpha = this.alpha;
			s.tintR = this.tintR;
			s.tintG = this.tintG;
			s.tintB = this.tintB;
			s.rot = this.rot;
			s.scaleX = this.scaleX;
			s.scaleY = this.scaleY;
			
			return s;
		}
		
		public function toByteArray():ByteArray{
			
			var result:ByteArray = new ByteArray();
			ByteUtils.writeUnsignedShort(result, imageDataIndex);
			result.writeInt(x);
			result.writeInt(y);
			result.writeInt(z);
			result.writeByte(alpha);
			result.writeByte(tintR);
			result.writeByte(tintG);
			result.writeByte(tintB);
			result.writeShort(isNaN(rot) ? 0:(rot * 1000));
			result.writeShort(isNaN(scaleX) ? 0:(scaleX * 10));
			result.writeShort(isNaN(scaleY) ? 0:(scaleY * 10));
			
			return result;
			
		}
		
		public static function fromByteArray(data:ByteArray):MapSpriteData{
			var result:MapSpriteData = new MapSpriteData();
			
			result.x = data.readInt();
			result.y = data.readInt();
			result.z = data.readInt();
			result.alpha = data.readByte();
			result.tintR = data.readByte();
			result.tintG = data.readByte();
			result.tintB = data.readByte();
			result.rot = data.readShort() / 1000;
			result.scaleX = data.readShort() / 10;
			result.scaleY = data.readShort() / 10;
			
			return result;
		}
		
	}
}