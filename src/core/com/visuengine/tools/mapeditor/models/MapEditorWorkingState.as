package com.visuengine.tools.mapeditor.models
{
	import com.visuengine.structs.media.vmap.VMap;
	
	public class MapEditorWorkingState{
		
		public var vmap:VMap;
		
		public function MapEditorWorkingState(){
			vmap = new VMap();
		}
		
		public function destroy():void{
			vmap = null;
		}

	}
}