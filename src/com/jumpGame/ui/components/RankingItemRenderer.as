package com.jumpGame.ui.components
{
	import com.jumpGame.level.Statics;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.text.TextFormatAlign;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.controls.text.BitmapFontTextRenderer;
	import feathers.core.FeathersControl;
	import feathers.core.ITextRenderer;
	import feathers.text.BitmapFontTextFormat;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;

	public class RankingItemRenderer extends FeathersControl implements IListItemRenderer
	{
		public function RankingItemRenderer()
		{
			this.addEventListener(TouchEvent.TOUCH, touchHandler);
			this.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}
		
		protected var _titleField:String;
		
		public function get titleField():String
		{
			return this._titleField;
		}
		
		public function set titleField(value:String):void
		{
			if(this._titleField == value)
			{
				return;
			}
			this._titleField = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}
		
		protected var _captionField:String;
		
		public function get captionField():String
		{
			return this._captionField;
		}
		
		public function set captionField(value:String):void
		{
			if(this._captionField == value)
			{
				return;
			}
			this._captionField = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}
		
		protected var _facebookIdField:String;
		
		public function get facebookIdField():String
		{
			return this._facebookIdField;
		}
		
		public function set facebookIdField(value:String):void
		{
			if(this._facebookIdField == value)
			{
				return;
			}
			this._facebookIdField = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}
		
		protected var _pictureUrlField:String;
		
		public function get pictureUrlField():String
		{
			return this._pictureUrlField;
		}
		
		public function set pictureUrlField(value:String):void
		{
			if(this._pictureUrlField == value)
			{
				return;
			}
			this._pictureUrlField = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}
		
		protected var _pictureWidthField:uint = 0;
		
		public function get pictureWidthField():uint
		{
			return this._pictureWidthField;
		}
		
		public function set pictureWidthField(value:uint):void
		{
			if(this._pictureWidthField == value)
			{
				return;
			}
			this._pictureWidthField = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}
		
		protected var titleLabel:Label;
		protected var captionLabel:Label;
		protected var profilePicture:Image;
		protected var loader:Loader;
		
		protected var _index:int = -1;
		
		public function get index():int
		{
			return this._index;
		}
		
		public function set index(value:int):void
		{
			if(this._index == value)
			{
				return;
			}
			this._index = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}
		
		protected var _owner:List;
		
		public function get owner():List
		{
			return List(this._owner);
		}
		
		public function set owner(value:List):void
		{
			if(this._owner == value)
			{
				return;
			}
			this._owner = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}
		
		protected var _data:Object;
		
		public function get data():Object
		{
			return this._data;
		}
		
		public function set data(value:Object):void
		{
			if(this._data == value)
			{
				return;
			}
			this._data = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}
		
		protected var _isSelected:Boolean;
		
		public function get isSelected():Boolean
		{
			return this._isSelected;
		}
		
		public function set isSelected(value:Boolean):void
		{
			if(this._isSelected == value)
			{
				return;
			}
			this._isSelected = value;
			this.invalidate(INVALIDATION_FLAG_SELECTED);
			this.dispatchEventWith(starling.events.Event.CHANGE);
		}
		
		override protected function initialize():void
		{
			this.width = 437;
			this.height = 90;
			this.useHandCursor = true;
			
			var itemBgButton:Button = new Button();
			itemBgButton.defaultSkin = new Image(Assets.getSprite("AtlasTexture8").getTexture("RankingsItemBg0000"));
			itemBgButton.hoverSkin = new Image(Assets.getSprite("AtlasTexture8").getTexture("RankingsItemBg0000"));
			itemBgButton.downSkin = new Image(Assets.getSprite("AtlasTexture8").getTexture("RankingsItemBg0000"));
			itemBgButton.hoverSkin.filter = Statics.btnBrightnessFilter;
			itemBgButton.downSkin.filter = Statics.btnInvertFilter;
			this.addChild(itemBgButton);
			
			if (!this.titleLabel) {
				this.titleLabel = new Label();
				titleLabel.touchable = false;
				titleLabel.textRendererFactory = function():ITextRenderer
				{
					var textRenderer:BitmapFontTextRenderer = new BitmapFontTextRenderer();
					var textFormat:BitmapFontTextFormat = new BitmapFontTextFormat(Fonts.getBitmapFont("Materhorn24"));
					textFormat.align = TextFormatAlign.LEFT;
					textRenderer.textFormat = textFormat;
					textRenderer.smoothing = TextureSmoothing.NONE;
					return textRenderer;
				}
				titleLabel.width = this.width;
				titleLabel.height = 35;
				titleLabel.x = 110;
				titleLabel.y = 30;
				this.addChild(this.titleLabel);
			}
			
			if (!this.captionLabel) {
				this.captionLabel = new Label();
				captionLabel.touchable = false;
				captionLabel.textRendererFactory = function():ITextRenderer
				{
					var textRenderer:BitmapFontTextRenderer = new BitmapFontTextRenderer();
					var textFormat:BitmapFontTextFormat = new BitmapFontTextFormat(Fonts.getBitmapFont("BellGothicBlack13"));
					textFormat.align = TextFormatAlign.LEFT;
					textFormat.color = 0x72370a;
					textRenderer.textFormat = textFormat;
					textRenderer.smoothing = TextureSmoothing.NONE;
					return textRenderer;
				}
				captionLabel.width = this.width;
				captionLabel.height = 35;
				captionLabel.x = 111;
				captionLabel.y = 55;
				this.addChild(this.captionLabel);
			}
			
			if (!this.profilePicture) {
				this.profilePicture = new Image(Assets.getSprite("AtlasTexturePlatforms").getTexture("Cannonball0000"));
				profilePicture.touchable = false;
				profilePicture.x = 15;
				profilePicture.y = 15;
				this.addChild(this.profilePicture);
			}
			
			ExternalInterface.addCallback("returnProfilePictureUrlToAs", Statics.pictureUrlReturnedFromJs);
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, onPictureLoadComplete);
		}
		
		private function pictureUrlReturnedFromJs(facebookId:String, pictureUrlData:Object):void {
			if (pictureUrlData.url != null && pictureUrlData.width != null) {
				if (facebookId == Statics.facebookId) {
//					this. = uint(pictureUrlData.width);
					loader.load(new URLRequest(pictureUrlData.url));
				}
			}
		}
		
		override protected function draw():void
		{
			const dataInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_DATA);
			const selectionInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_SELECTED);
			var sizeInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_SIZE);
			
			if(dataInvalid)
			{
				this.commitData();
			}
			
			//			sizeInvalid = this.autoSizeIfNeeded() || sizeInvalid;
			
//			if(dataInvalid || sizeInvalid)
//			{
//				this.layout();
//			}
		}
		
		//		protected function autoSizeIfNeeded():Boolean
		//		{
		//			const needsWidth:Boolean = isNaN(this.explicitWidth);
		//			const needsHeight:Boolean = isNaN(this.explicitHeight);
		//			if(!needsWidth && !needsHeight)
		//			{
		//				return false;
		//			}
		//			this.itemLabel.width = NaN;
		//			this.itemLabel.height = NaN;
		//			this.itemLabel.validate();
		//			var newWidth:Number = this.explicitWidth;
		//			if(needsWidth)
		//			{
		//				newWidth = this.itemLabel.width;
		//			}
		//			var newHeight:Number = this.explicitHeight;
		//			if(needsHeight)
		//			{
		//				newHeight = this.itemLabel.height;
		//			}
		//			return this.setSizeInternal(newWidth, newHeight, false);
		//		}
		
		protected function commitData():void
		{
			if(this._data && this._owner)
			{
				this.titleLabel.text = this.itemToTitle(this._data);
				this.captionLabel.text = "High Score: " + this.itemToCaption(this._data);
				
				// load profile picture
				var profilePicUrl:String = this.itemToPictureUrl(this._data);
				if (profilePicUrl == "none") {
//					this.profilePicture.texture = Assets.getSprite("AtlasTexturePlatforms").getTexture("Cannonball0000");
//					this.profilePicture.readjustSize();
					if(ExternalInterface.available){
						ExternalInterface.call("getProfilePictureUrl", this.itemToFacebookId(this._data));
						trace("facebook id: " + this.itemToFacebookId(this._data));
					}
				} else {
//					Security.loadPolicyFile("https://fbcdn-profile-a.akamaihd.net/crossdomain.xml"); // already loaded in Game.as
					loader.load(new URLRequest(profilePicUrl));
				}
			}
			else
			{
				this.titleLabel.text = "";
				this.captionLabel.text = "";
			}
		}
		
		private function getProfilePictureUrlFromJs(facebookId:String):void {
			if(ExternalInterface.available){
				ExternalInterface.call("getProfilePictureUrl", facebookId);
			} else {
				trace("External interface unavailabe");
			}
		}
		
		protected function onPictureLoadComplete(event:flash.events.Event):void
		{
			var loadedBitmap:Bitmap = event.currentTarget.loader.content as Bitmap;
			this.profilePicture.texture = Texture.fromBitmap(loadedBitmap);
			this.profilePicture.readjustSize();
			// scale profile picture to fit box
			var profilePicWidth:uint = this.itemToPictureWidth(this._data);
			if (profilePicWidth != 0) {
				var pictureScaleFactor:Number = 70 / profilePicWidth;
				this.profilePicture.scaleX = pictureScaleFactor;
				this.profilePicture.scaleY = pictureScaleFactor;
			}
		}
		
		protected function layout():void
		{
//			this.titleLabel.width = 250;
//			this.titleLabel.height = 50;
//			this.titleLabel.x = 60;
//			
//			this.captionLabel.width = 250;
//			this.captionLabel.height = 50;
//			this.captionLabel.x = 330;
		}
		
		public function itemToTitle(item:Object):String
		{
			if(this._titleField != null && item && item.hasOwnProperty(this._titleField))
			{
				return item[this._titleField].toString();
			}
			return "";
		}
		
		public function itemToCaption(item:Object):String
		{
			if(this._captionField != null && item && item.hasOwnProperty(this._captionField))
			{
				return item[this._captionField].toString();
			}
			return "";
		}
		
		public function itemToFacebookId(item:Object):String
		{
			if(this._facebookIdField != null && item && item.hasOwnProperty(this._facebookIdField))
			{
				return item[this._facebookIdField].toString();
			}
			return "";
		}
		
		public function itemToPictureUrl(item:Object):String
		{
			if(this._pictureUrlField != null && item && item.hasOwnProperty(this._pictureUrlField))
			{
				return item[this._pictureUrlField].toString();
			}
			return "";
		}
		
		public function itemToPictureWidth(item:Object):uint
		{
			if(this._pictureWidthField != 0 && item && item.hasOwnProperty(this._pictureWidthField))
			{
				return item[this._pictureWidthField];
			}
			return 0;
		}
		
		protected var touchPointID:int = -1;
		private static const HELPER_POINT:Point = new Point();
		
		protected function touchHandler(event:TouchEvent):void
		{
			const touches:Vector.<Touch> = event.getTouches(this);
			if(touches.length == 0)
			{
				//hover has ended
				return;
			}
			if(this.touchPointID >= 0)
			{
				var touch:Touch;
				for each(var currentTouch:Touch in touches)
				{
					if(currentTouch.id == this.touchPointID)
					{
						touch = currentTouch;
						break;
					}
				}
				if(!touch)
				{
					return;
				}
				if(touch.phase == TouchPhase.ENDED)
				{
					this.touchPointID = -1;
					
					touch.getLocation(this.stage, HELPER_POINT);
					//check if the touch is still over the target
					const isInBounds:Boolean = this.contains(this.stage.hitTest(HELPER_POINT, true));
					if(isInBounds)
					{
						this.isSelected = true;
					}
					return;
				}
			}
			else
			{
				for each(touch in touches)
				{
					if(touch.phase == TouchPhase.BEGAN)
					{
						this.touchPointID = touch.id;
						return;
					}
				}
			}
		}
		
		protected function removedFromStageHandler(event:starling.events.Event):void
		{
			this.touchPointID = -1;
		}
	}
}