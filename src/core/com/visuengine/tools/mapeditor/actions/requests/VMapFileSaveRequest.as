package com.visuengine.tools.mapeditor.actions.requests {
	
	import com.visuengine.structs.media.vmap.VMap;
	
	import flash.events.Event;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	public class VMapFileSaveRequest {
		
		protected static const VMAP_FILE_LOADED:String = "VMapFileSaveRequest_VMAPSaved";
		
		protected static var _loadRequestsToCallbacks:Dictionary = new Dictionary();
		
		protected var fr:FileReference;
		protected var _data:ByteArray;
		
		public function VMapFileSaveRequest(data:ByteArray){
			fr = new FileReference();
			_data = data;
		}
		
		public static function dispatchRequestToSaveFileData(data:ByteArray, callback:Function):void{
			var request:VMapFileSaveRequest = new VMapFileSaveRequest(data);
			_loadRequestsToCallbacks[request] = callback;
			request.requestSaveVMapFile();
		}
		
		protected static function VMAPSaveRequestCompleted(request:VMapFileSaveRequest):void{
			(_loadRequestsToCallbacks[request] as Function).apply(null);
			delete _loadRequestsToCallbacks[request];
		}
		
		public function requestSaveVMapFile():void{
			fr.addEventListener(Event.COMPLETE, onFileSaved);
			fr.save(_data);
		}
		
		private function onFileSaved(e:Event):void {
			fr.removeEventListener(Event.COMPLETE, onFileSaved);
			VMAPSaveRequestCompleted(this);
		}

	}
}