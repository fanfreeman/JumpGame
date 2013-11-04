package com.jumpGame.ui.components
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.system.Security;
	
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.core.FeathersControl;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;

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
		
		protected var _pictureField:String;
		
		public function get pictureField():String
		{
			return this._pictureField;
		}
		
		public function set pictureField(value:String):void
		{
			if(this._pictureField == value)
			{
				return;
			}
			this._pictureField = value;
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
			this.width = 600;
			this.height = 55;
			
			if (!this.titleLabel) {
				this.titleLabel = new Label();
				this.addChild(this.titleLabel);
			}
			
			if (!this.captionLabel) {
				this.captionLabel = new Label();
				this.addChild(this.captionLabel);
			}
			
			if (!this.profilePicture) {
				this.profilePicture = new Image(Assets.getSprite("AtlasTexturePlatforms").getTexture("Cannonball0000"));
				this.addChild(this.profilePicture);
			}
			
			loader = new Loader();
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
			
			if(dataInvalid || sizeInvalid)
			{
				this.layout();
			}
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
				this.captionLabel.text = this.itemToCaption(this._data);
				
				// load profile picture
				var profilePicUrl:String = this.itemToPictureUrl(this._data);
				if (profilePicUrl == "none") {
					this.profilePicture.texture = Assets.getSprite("AtlasTexturePlatforms").getTexture("Cannonball0000");
					this.profilePicture.readjustSize();
				} else {
					Security.loadPolicyFile("https://fbcdn-profile-a.akamaihd.net/crossdomain.xml");
					loader.load(new URLRequest(profilePicUrl));
					loader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, onPictureLoadComplete);
				}
			}
			else
			{
				this.titleLabel.text = "";
				this.captionLabel.text = "";
			}
		}
		
		protected function onPictureLoadComplete(event:flash.events.Event):void
		{
			var loadedBitmap:Bitmap = event.currentTarget.loader.content as Bitmap;
			this.profilePicture.texture = Texture.fromBitmap(loadedBitmap);
			this.profilePicture.readjustSize();
		}
		
		protected function layout():void
		{
			this.titleLabel.width = 250;
			this.titleLabel.height = 50;
			this.titleLabel.x = 60;
			
			this.captionLabel.width = 250;
			this.captionLabel.height = 50;
			this.captionLabel.x = 330;
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
		
		public function itemToPictureUrl(item:Object):String
		{
			if(this._pictureField != null && item && item.hasOwnProperty(this._pictureField))
			{
				return item[this._pictureField].toString();
			}
			return "";
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