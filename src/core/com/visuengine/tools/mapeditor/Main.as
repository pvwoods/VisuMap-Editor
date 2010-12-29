package com.visuengine.tools.mapeditor{
	
	import com.visuengine.tools.mapeditor.managers.MapEditorFlowManager;
	
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	
	public class Main extends Sprite{
		
		public function Main():void{
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			var m:MapEditorFlowManager = new MapEditorFlowManager();
			m.init(this);
			
		}
		
	}
}