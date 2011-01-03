package com.visuengine.structs.media.vusprite
{
	import flash.utils.ByteArray;
	
	public class VUSprite{
		
		public var width:uint;
		public var spriteData:ByteArray;
		
		public function VUSprite(im:ByteArray, wi:uint){
			width = wi;
			spriteData = im;
		}

	}
}