package com.visuengine.structs.media.vusprite
{
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	
	public class VUSprite{
		
		public var width:uint;
		public var spriteData:ByteArray;
		
		public function VUSprite(im:ByteArray, wi:uint){
			width = wi;
			spriteData = im;
		}
		
		public static function generateBitmapData(vus:VUSprite):BitmapData{
			var bmd:BitmapData = new BitmapData(vus.width, vus.spriteData.bytesAvailable / (vus.width * 4))
			bmd.setPixels(bmd.rect, vus.spriteData);
			return bmd;
		}

	}
}