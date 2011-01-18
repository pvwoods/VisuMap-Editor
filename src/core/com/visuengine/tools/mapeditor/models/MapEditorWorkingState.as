package com.visuengine.tools.mapeditor.models
{
	import com.visuengine.structs.media.vmap.MapLayerData;
	import com.visuengine.structs.media.vmap.MapSpriteData;
	import com.visuengine.structs.media.vmap.VMap;
	import com.visuengine.structs.media.vusprite.VUSprite;
	import com.visuengine.tools.mapeditor.components.display.EditorMapView;
	
	import flash.display.Sprite;
	
	public class MapEditorWorkingState{
		
		public var vmap:VMap;
		
		public function MapEditorWorkingState(){
			vmap = new VMap();
		}
		
		public function removeSprite(layerIndex:uint, spriteIndex:uint):void{
			vmap.removeSprite(layerIndex, spriteIndex);
		}
		
		public function addLayer():uint{
			var layerIndex:uint = vmap.addLayer() - 1;
			vmap.getLayerByIndex(layerIndex).recievesInput = true;
			return layerIndex;
		}
		
		public function removeLayer(layerIndex:uint):void{
			vmap.removeLayer(layerIndex);
		}
		
		public function replaceImageData(image:VUSprite, index:uint):void {
			vmap.replaceImageData(image, index);
		}
		
		public function updateVMap(map:EditorMapView):void{
			for(var i:uint = 0; i < map.layers.length; i++){
				var mld:MapLayerData = vmap.getLayerByIndex(i);
				for(var q:uint = 0; q < map.layers[i].sprites.length; q++){
					var msd:MapSpriteData = mld.sprites[q];
					var mvs:Sprite = map.layers[i].sprites[q] as Sprite;
					msd.alpha = (mvs.alpha * 100);
					msd.x = mvs.x;
					msd.y = mvs.y;
					var rot:int = int(mvs.rotation % 360);
					if(rot < 0) rot += 360;
					msd.rot = rot;
					msd.scaleX = mvs.scaleX;
					msd.scaleY = mvs.scaleY;
				}
			}
		}
		
		public function destroy():void{
			vmap = null;
		}

	}
}