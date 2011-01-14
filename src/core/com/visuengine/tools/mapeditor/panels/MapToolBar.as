package com.visuengine.tools.mapeditor.panels {
	
	import com.bit101.components.List;
	import com.bit101.components.Panel;
	import com.bit101.components.PushButton;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;

	public class MapToolBar extends Panel{
		
		protected static const ITEM_SPACER:uint = 5;
		protected static const BUTTON_HEIGHT:uint = 20;
		
		protected var _toolBarButtons:Vector.<PushButton>;
		protected var _layerList:List;
		protected var _imageList:List;
		protected var _previewImageContainer:Sprite;
		protected var _previewImage:Bitmap;
		
		public function MapToolBar(parent:DisplayObjectContainer){
			
			super(parent);
			
			_toolBarButtons = new Vector.<PushButton>();
			
		}
		
		public function build(args:Array):void{
			
			for(var i:int = 0; i < args.length; i++){
				var idx:uint = _toolBarButtons.push(new PushButton(this, ITEM_SPACER, (BUTTON_HEIGHT + ITEM_SPACER) * i + ITEM_SPACER, args[i][0] as String, args[i][1] as Function)) - 1;
				_toolBarButtons[idx].width = this.width - (ITEM_SPACER * 2);
			}
			
			_layerList = new List(this, ITEM_SPACER, (BUTTON_HEIGHT + ITEM_SPACER) * _toolBarButtons.length + ITEM_SPACER);
			_layerList.width = this.width - (ITEM_SPACER * 2);
			
			_imageList = new List(this, ITEM_SPACER, _layerList.y + _layerList.height + ITEM_SPACER);
			_imageList.width = this.width - (ITEM_SPACER * 2);
			
			_previewImageContainer = new Sprite();
			_previewImageContainer.x = ITEM_SPACER;
			_previewImageContainer.y = _imageList.y + _imageList.height + ITEM_SPACER;
			addChild(_previewImageContainer);
			
			
		}
		
		public function resetLists():void{
			_layerList.removeAll();
			_imageList.removeAll();
		}
		
		public function addLayerToList():void{
			_layerList.addItem("Layer " + _layerList.items.length);
		}
		
		public function removeLayerFromList(index:uint):void{
			_layerList.removeItem("Layer " + index.toString());
		}
		
		public function get selectedLayer():uint{
			return _layerList.selectedIndex;
		}
		
		public function addImageToList():void{
			_imageList.addItem("Image " + _imageList.items.length);
		}
		
		public function get selectedImage():uint{
			return _imageList.selectedIndex;
		}
		
		public function addImageSelectedHandler(handler:Function):void{
			_imageList.addEventListener(Event.SELECT, handler);
		}
		
		public function removeImageSelectedHandler(handler:Function):void{
			_imageList.removeEventListener(Event.SELECT, handler);
		}
		
		public function resize(w:uint, h:uint):void {
			// we will ignore the height for now
			this.height = h;
		}
		
		public function setPreviewImage(image:BitmapData):void{
			if(_previewImage != null) _previewImageContainer.removeChild(_previewImage);
			_previewImage = new Bitmap(image);
			var targetWidth:uint = this.width - (ITEM_SPACER * 2);
			var tscale:Number;
			if(_previewImage.width > targetWidth || _previewImage.height > targetWidth){
				tscale = (targetWidth/((_previewImage.width > _previewImage.height) ? _previewImage.width:_previewImage.height));
				_previewImage.scaleX = _previewImage.scaleY = tscale;
			}
			_previewImage.smoothing = true;
			_previewImageContainer.addChild(_previewImage);
		}
	}
}