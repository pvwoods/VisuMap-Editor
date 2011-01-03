package com.visuengine.tools.mapeditor.actions.requests
{
	import com.visuengine.structs.media.vmap.VMap;
	
	import flash.events.Event;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.utils.Dictionary;
	
	public class VMapFileLoadRequest{
		
		protected static const VMAP_FILE_LOADED:String = "VMapFileLoadRequest_VMAPLoaded";
		
		protected static var _loadRequestsToCallbacks:Dictionary = new Dictionary();
		
		protected var fr:FileReference;
		public var vmap:VMap;
		
		public function VMapFileLoadRequest(){
			fr = new FileReference();
		}
		
		public static function dispatchRequestToLoadFileData(callback:Function):void{
			var request:VMapFileLoadRequest = new VMapFileLoadRequest();
			_loadRequestsToCallbacks[request] = callback;
			request.requestLoadVMapFile();
		}
		
		protected static function VMAPRequestCompleted(request:VMapFileLoadRequest):void{
			(_loadRequestsToCallbacks[request] as Function).apply(null, [request.vmap]);
			delete _loadRequestsToCallbacks[request];
		}
		
		public function requestLoadVMapFile():void{
			fr.browse([new FileFilter("VisuMaps", "*.vump")]);
			fr.addEventListener(Event.SELECT, onFileSelected);
		}
		
		private function onFileSelected(e:Event):void {
			fr.removeEventListener(Event.SELECT, onFileSelected);
			fr.addEventListener(Event.COMPLETE, onFileLoaded);
			fr.load();
		}
		
		private function onFileLoaded(e:Event):void {
			fr.removeEventListener(Event.COMPLETE, onFileLoaded);
			vmap = VMap.generateMapfromFile(e.target.data);
			VMAPRequestCompleted(this);
		}

	}
}