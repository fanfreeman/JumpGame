package com.jumpGame.ui.components
{
	import com.jumpGame.customObjects.Font;
	
	import flash.geom.Point;
	
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.core.FeathersControl;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class UpgradeItemRenderer extends FeathersControl implements IListItemRenderer
	{
		public function UpgradeItemRenderer()
		{
			this.addEventListener(TouchEvent.TOUCH, touchHandler);
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}
		
//		private var progress:ProgressBar;
		private var btnAction:Button;
		private var priceLabel:TextField;
		private var title:TextField;
		private var subtitle:TextField;
		private var coinAnimation:MovieClip;
		private var gemAnimation:MovieClip;
		private var eventId:String;
		
		private function createElements():void {
			// bg quad
			var scrollQuad:Quad = new Quad(640, 80, 0xffffff);
//			scrollQuad.pivotX = Math.ceil(scrollQuad.width / 2);
			addChild(scrollQuad);
			
			// icon
			var iconQuad:Quad = new Quad(80, 80, 0xff0000);
			addChild(iconQuad);
			
			// label line 1
			var fontVerdana23:Font = Fonts.getFont("Verdana23");
			title = new TextField(370, 25, "", fontVerdana23.fontName, fontVerdana23.fontSize, 0x873623);
			title.hAlign = HAlign.LEFT;
			title.vAlign = VAlign.TOP;
			title.x = iconQuad.bounds.right + 10;
			title.y = 10;
			addChild(title);
			
			// label line 2
			var fontVerdana14:Font = Fonts.getFont("Verdana14");
			subtitle = new TextField(370, 20, "", fontVerdana14.fontName, fontVerdana14.fontSize, 0x873623);
			subtitle.hAlign = HAlign.LEFT;
			subtitle.vAlign = VAlign.TOP;
			subtitle.x = iconQuad.bounds.right + 10;
			subtitle.y = title.bounds.bottom + 2;
			addChild(subtitle);
			
//			// progress bar
//			progress = new ProgressBar();
//			progress.minimum = 0;
//			progress.maximum = 10;
//			progress.width = 380;
//			progress.height = 10;
//			progress.x = subtitle.x;
//			progress.y = subtitle.bounds.bottom + 2;
//			this.addChild(progress);
			
			// price
			priceLabel = new TextField(130, 25, "0", fontVerdana23.fontName, fontVerdana23.fontSize, 0x873623);
			priceLabel.hAlign = HAlign.RIGHT;
			priceLabel.vAlign = VAlign.TOP;
			priceLabel.pivotX = Math.ceil(priceLabel.width);
			priceLabel.x = scrollQuad.width - 10;
			priceLabel.y = 10;
			addChild(priceLabel);
			
			// action button
			btnAction = new Button();
			btnAction.width = 130;
			btnAction.height = 34;
			btnAction.pivotX = Math.ceil(btnAction.width);
			btnAction.x = scrollQuad.width - 10;
			btnAction.y = priceLabel.bounds.bottom;
			btnAction.label = "Upgrade";
			this.btnAction.addEventListener(Event.TRIGGERED, upgradeHandler);
			addChild(btnAction);
			
			// price coin graphic
			coinAnimation = new MovieClip(Assets.getSprite("AtlasTexturePlatforms").getTextures("Coin"), 40);
			coinAnimation.scaleX = 0.5;
			coinAnimation.scaleY = 0.5;
			coinAnimation.x = btnAction.bounds.left;
			coinAnimation.y = priceLabel.bounds.top - 5;
			Starling.juggler.add(coinAnimation);
			this.addChild(coinAnimation);
			
			// price gem graphic
			gemAnimation = new MovieClip(Assets.getSprite("AtlasTexture4").getTextures("ArrowBounce"), 20);
			gemAnimation.scaleX = 0.5;
			gemAnimation.scaleY = 0.5;
			gemAnimation.x = btnAction.bounds.left;
			gemAnimation.y = priceLabel.bounds.top - 5;
			Starling.juggler.add(gemAnimation);
			this.addChild(gemAnimation);
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
		
		protected var _priceField:String;
		
		public function get priceField():String
		{
			return this._priceField;
		}
		
		public function set priceField(value:String):void
		{
			if(this._priceField == value)
			{
				return;
			}
			this._priceField = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}
		
		protected var _priceTypeField:String;
		
		public function get priceTypeField():String
		{
			return this._priceTypeField;
		}
		
		public function set priceTypeField(value:String):void
		{
			if(this._priceTypeField == value)
			{
				return;
			}
			this._priceTypeField = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}
		
//		protected var _progressField:String;
//		
//		public function get progressField():String
//		{
//			return this._progressField;
//		}
//		
//		public function set progressField(value:String):void
//		{
//			if(this._progressField == value)
//			{
//				return;
//			}
//			this._progressField = value;
//			this.invalidate(INVALIDATION_FLAG_DATA);
//		}
		
		protected var _eventidField:String;
		
		public function get eventidField():String
		{
			return this._eventidField;
		}
		
		public function set eventidField(value:String):void
		{
			if(this._eventidField == value)
			{
				return;
			}
			this._eventidField = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}
		
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
			this.width = 300;
			this.height = 80;
			this.createElements();
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
			// upgrade title
			this.title.text = this.itemToTitle(this._data);

			// upgrade price
			this.priceLabel.text = this.itemToPrice(this._data);
			
			// upgrade price type
			var priceType:String = this.itemToPriceType(this._data);
			if (priceType == "coins") {
				this.coinAnimation.visible = true;
				this.gemAnimation.visible = false;
			}
			else if (priceType == "gems") {
				this.coinAnimation.visible = false;
				this.gemAnimation.visible = true;
			}
			
			// upgrade subtitle
			this.subtitle.text = this.itemToCaption(this._data);
			
			// update progress bar
//			var progressValue:Number = this.itemToProgress(this._data);
//			this.progress.value = progressValue;
			
			if (this.subtitle.text == "") { // hide button if fully upgraded
				this.btnAction.visible = false;
				this.priceLabel.text = "";
				this.subtitle.text = "Max rank reached. Woohoo!";
				this.coinAnimation.visible = false;
				this.gemAnimation.visible = false;
			} else { // show these again for reused item renderers
				this.btnAction.visible = true;
			}
			
			// update upgrade button event id
			this.eventId = this.itemToEventId(this._data);
		}
		
		protected function layout():void
		{
//			this.titleLabel.width = this.actualWidth;
//			this.titleLabel.height = 35;
//			
//			this.captionLabel.width = this.actualWidth;
//			this.captionLabel.height = 35;
//			this.captionLabel.y = 35;
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
		
		public function itemToPrice(item:Object):String
		{
			if(this._priceField != null && item && item.hasOwnProperty(this._priceField))
			{
				return item[this._priceField].toString();
			}
			return "";
		}
		
		public function itemToPriceType(item:Object):String
		{
			if(this._priceTypeField != null && item && item.hasOwnProperty(this._priceTypeField))
			{
				return item[this._priceTypeField].toString();
			}
			return "";
		}
		
//		public function itemToProgress(item:Object):Number
//		{
//			if(this._progressField != null && item && item.hasOwnProperty(this._progressField))
//			{
//				return item[this._progressField];
//			}
//			return 0;
//		}
		
		public function itemToEventId(item:Object):String
		{
			if(this._eventidField != null && item && item.hasOwnProperty(this._eventidField))
			{
				return item[this._eventidField];
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
		
		protected function removedFromStageHandler(event:Event):void
		{
			this.touchPointID = -1;
		}
		
		protected function upgradeHandler(event:Event):void {
			dispatchEvent(new Event(this.eventId, true));
		}
	}
}
