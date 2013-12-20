package com.jumpGame.ui.components
{
	
	import flash.geom.Point;
	
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.core.FeathersControl;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class StartGameItemRenderer extends FeathersControl implements IListItemRenderer
	{
		public function StartGameItemRenderer()
		{
			this.addEventListener(TouchEvent.TOUCH, touchHandler);
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}
		
		private var itemBgButton:Button;
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
			this.dispatchEventWith(Event.CHANGE);
		}
		
		override protected function initialize():void
		{
			this.width = 209;
			this.height = 55;
			this.useHandCursor = true;
			
			itemBgButton = new Button();
			this.addChild(itemBgButton);
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
		}
		
		protected function commitData():void
		{
			if(this._data && this._owner)
			{
				if (this._index == 0) {
					itemBgButton.defaultSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("StartGameBtnFacebook0000"));
					itemBgButton.hoverSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("StartGameBtnFacebook0000"));
					itemBgButton.downSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("StartGameBtnFacebook0000"));
				}
				else if (this._index == 1) {
					itemBgButton.defaultSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("StartGameBtnMatch0000"));
					itemBgButton.hoverSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("StartGameBtnMatch0000"));
					itemBgButton.downSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("StartGameBtnMatch0000"));
				}
				itemBgButton.hoverSkin.filter = Statics.btnBrightnessFilter;
				itemBgButton.downSkin.filter = Statics.btnInvertFilter;
			}
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
		
		protected function removedFromStageHandler(event:Event):void
		{
			this.touchPointID = -1;
		}
	}
}