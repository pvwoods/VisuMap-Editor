package com.visuengine.utils
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	public class ByteUtils{
		
		public static function writeUnsignedShort(ba:ByteArray, value:int):void{
			if(ba.endian == Endian.LITTLE_ENDIAN){
				ba.writeByte(value & 0x00ff);
				ba.writeByte((value & 0xff00) >>> 8);
			}else{
				ba.writeByte((value & 0xff00) >>> 8);
				ba.writeByte(value & 0x00ff);
			}
		}

	}
}