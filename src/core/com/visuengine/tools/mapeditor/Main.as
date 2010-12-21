package com.visuengine.tools.mapeditor{
	
	import com.visuengine.structs.media.vmap.MapSpriteData;
	import com.visuengine.structs.media.vmap.VMap;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.net.FileReference;
	
	public class Main extends Sprite{
		
		
		public function Main():void{
			var map:VMap = new VMap();
			
			map.addLayer();
			var s:MapSpriteData = new MapSpriteData();
			s.x = 10;
			s.y = 10;
			s.z = 1;
			s.rot = 25.6;
			s.tintR = 120;
			s.tintG = 120;
			s.tintB = 120;
			s.alpha = 200;
			s.scaleX = 1.1;
			s.scaleY = 2.4;
			map.addSprite(s, 0);
			s = s.clone();
			s.x += 120;
			s.tintG += 120;
			s.rot += 120;
			map.addSprite(s, 0);
			
			var bd:BitmapData = new BitmapData(20, 20);
			
			var i:int = 3998;
			
			while(i-=2) bd.setPixel(i%20, Math.floor(i/20), Math.random()*0xFFFFFF);
			
			addChild(new Bitmap(bd));
			
			map.addImageData(bd.getPixels(bd.rect));
			
			var fr:FileReference = new FileReference();
			fr.save(map.generateByteArray(), "test.vump");
		}
		
		
	}
}