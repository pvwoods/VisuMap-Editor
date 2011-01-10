package com.visuengine.tools.mapeditor.actions.requests
{
	import com.visuengine.structs.media.vusprite.VUSprite;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.utils.Dictionary;
	
	public class ImageFileLoadRequest{
		
		protected static const VMAP_FILE_LOADED:String = "VMapFileLoadRequest_VMAPLoaded";
		
		protected static var _loadRequestsToCallbacks:Dictionary = new Dictionary();
		
		protected var fr:FileReference;
		protected var _loader:Loader;
		public var image:VUSprite;
		
		public function ImageFileLoadRequest(){
			fr = new FileReference();
		}
		
		public static function dispatchRequestToLoadFileData(callback:Function):void{
			var request:ImageFileLoadRequest = new ImageFileLoadRequest();
			_loadRequestsToCallbacks[request] = callback;
			request.requestLoadImageFile();
		}
		
		protected static function ImageRequestCompleted(request:ImageFileLoadRequest):void{
			(_loadRequestsToCallbacks[request] as Function).apply(null, [request.image]);
			delete _loadRequestsToCallbacks[request];
		}
		
		public function requestLoadImageFile():void{
			fr.browse([new FileFilter("Image Files", "*.png")]);
			fr.addEventListener(Event.SELECT, onFileSelected);
		}
		
		private function onFileSelected(e:Event):void {
			fr.removeEventListener(Event.SELECT, onFileSelected);
			fr.addEventListener(Event.COMPLETE, onFileLoaded);
			fr.load();
		}
		
		private function onFileLoaded(e:Event):void {
			fr.removeEventListener(Event.COMPLETE, onFileLoaded);
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onDataLoaded);
			_loader.loadBytes(e.target.data);
		}
		
		private function onDataLoaded(event:Event):void{
			var bmp:BitmapData = Bitmap(_loader.content).bitmapData;
			image = new VUSprite(bmp.getPixels(bmp.rect),bmp.width);
			ImageRequestCompleted(this);
		}

	}
}