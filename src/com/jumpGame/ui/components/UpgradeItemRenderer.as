package com.jumpGame.ui.components
{
	import com.jumpGame.customObjects.Font;
	
	import flash.geom.Point;
	import flash.text.TextFormatAlign;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.controls.text.BitmapFontTextRenderer;
	import feathers.core.FeathersControl;
	import feathers.core.ITextRenderer;
	import feathers.text.BitmapFontTextFormat;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.TextureSmoothing;
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
		private var icon:Image;
		private var btnAction:Button;
		private var priceLabel:TextField;
		private var coinAnimation:MovieClip;
		private var gemAnimation:MovieClip;
		private var eventId:String;
		
		protected var titleLabel:Label;
		protected var captionLabel:Label;
		protected var dataLabel:Label;
		
		protected var _iconField:String;
		
		public function get iconField():String
		{
			return this._iconField;
		}
		
		public function set iconField(value:String):void
		{
			if(this._iconField == value)
			{
				return;
			}
			this._iconField = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
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
		
		protected var _caption2Field:String;
		
		public function get caption2Field():String
		{
			return this._caption2Field;
		}
		
		public function set caption2Field(value:String):void
		{
			if(this._caption2Field == value)
			{
				return;
			}
			this._caption2Field = value;
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
			this.width = 588;
			this.height = 109;
			
			var itemBgButton:Button = new Button();
			itemBgButton.defaultSkin = new Image(Statics.assets.getTexture("UpgradeItemBg0000"));
			this.addChild(itemBgButton);
			
			icon = new Image(Statics.assets.getTexture("UpgradeIconTeleportation0000"));
			icon.x = 21;
			icon.y = 17;
			this.addChild(icon);
			
			// labels
			var labelsX:Number = 120;
			var labelsWidth:Number = 326;
			
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
				titleLabel.width = labelsWidth;
				titleLabel.height = 20;
				titleLabel.x = labelsX;
				titleLabel.y = 23;
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
				captionLabel.width = labelsWidth;
				captionLabel.height = 20;
				captionLabel.x = labelsX;
				captionLabel.y = 48;
				this.addChild(this.captionLabel);
			}
			
			if (!this.dataLabel) {
				this.dataLabel = new Label();
				dataLabel.touchable = false;
				dataLabel.textRendererFactory = function():ITextRenderer
				{
					var textRenderer:BitmapFontTextRenderer = new BitmapFontTextRenderer();
					var textFormat:BitmapFontTextFormat = new BitmapFontTextFormat(Fonts.getBitmapFont("BellGothicBlack13"));
					textFormat.align = TextFormatAlign.LEFT;
					textFormat.color = 0x72370a;
					textRenderer.textFormat = textFormat;
					textRenderer.smoothing = TextureSmoothing.NONE;
					return textRenderer;
				}
				dataLabel.width = labelsWidth;
				dataLabel.height = 20;
				dataLabel.x = labelsX;
				dataLabel.y = 66;
				this.addChild(this.dataLabel);
			}
			
			//			// progress bar
			//			progress = new ProgressBar();
			//			progress.minimum = 0;
			//			progress.maximum = 10;
			//			progress.width = 380;
			//			progress.height = 10;
			//			progress.x = subtitle.x;
			//			progress.y = subtitle.bounds.bottom + 2;
			//			this.addChild(progress);
			
			// price coin graphic
			coinAnimation = new MovieClip(Statics.assets.getTextures("CoinLarge"), 40);
			coinAnimation.scaleX = 0.5;
			coinAnimation.scaleY = 0.5;
			coinAnimation.x = this.width - 125;
			coinAnimation.y = 8;
			Starling.juggler.add(coinAnimation);
			this.addChild(coinAnimation);
			
			// price
			var fontVerdana23:Font = Fonts.getFont("ScoreLabel");
			priceLabel = new TextField(130, 25, "0", fontVerdana23.fontName, fontVerdana23.fontSize, 0xffffff);
			priceLabel.hAlign = HAlign.LEFT;
			priceLabel.vAlign = VAlign.TOP;
//			priceLabel.pivotX = Math.ceil(priceLabel.width);
			priceLabel.x = this.width - 100;
			priceLabel.y = 16;
			addChild(priceLabel);
			
			// action button
			btnAction = new Button();
			btnAction.defaultSkin = new Image(Statics.assets.getTexture("UpgradeItemButton0000"));
			btnAction.hoverSkin = new Image(Statics.assets.getTexture("UpgradeItemButton0000"));
			btnAction.downSkin = new Image(Statics.assets.getTexture("UpgradeItemButton0000"));
			btnAction.hoverSkin.filter = Statics.btnBrightnessFilter;
			btnAction.downSkin.filter = Statics.btnInvertFilter;
			btnAction.useHandCursor = true;
			btnAction.addEventListener(Event.TRIGGERED, upgradeHandler);
			this.addChild(btnAction);
			btnAction.validate();
			btnAction.pivotX = btnAction.width;
			btnAction.x = this.width - 15;
			btnAction.y = 51;
			
			// price gem graphic
			gemAnimation = new MovieClip(Statics.assets.getTextures("Gem"), 20);
			gemAnimation.scaleX = 0.55;
			gemAnimation.scaleY = 0.55;
			gemAnimation.x = this.width - 125;
			gemAnimation.y = 12;
			Starling.juggler.add(gemAnimation);
			this.addChild(gemAnimation);
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
			// upgrade icon
			this.icon.texture = Statics.assets.getTexture("UpgradeIcon" + this.itemToIcon(this._data) + "0000");
			this.icon.readjustSize();
			
			// upgrade title
			this.titleLabel.text = this.itemToTitle(this._data);

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
			
			// upgrade caption
			this.captionLabel.text = this.itemToCaption(this._data);
			
			// caption line 2
			this.dataLabel.text = this.itemToCaption2(this._data);
			
			// update progress bar
//			var progressValue:Number = this.itemToProgress(this._data);
//			this.progress.value = progressValue;
			
			if (this.dataLabel.text == "") { // hide button if fully upgraded
				this.btnAction.visible = false;
				this.priceLabel.text = "";
				this.dataLabel.text = "Max rank reached. Woohoo!";
				this.coinAnimation.visible = false;
				this.gemAnimation.visible = false;
			} else { // show these again for reused item renderers
				this.btnAction.visible = true;
			}
			
			// update upgrade button event id
			this.eventId = this.itemToEventId(this._data);
		}
		
//		protected function layout():void
//		{
//			this.titleLabel.width = this.actualWidth;
//			this.titleLabel.height = 35;
//			
//			this.captionLabel.width = this.actualWidth;
//			this.captionLabel.height = 35;
//			this.captionLabel.y = 35;
//		}
		
		public function itemToIcon(item:Object):String
		{
			if(this._iconField != null && item && item.hasOwnProperty(this._iconField))
			{
				return item[this._iconField].toString();
			}
			return "";
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
		
		public function itemToCaption2(item:Object):String
		{
			if(this._caption2Field != null && item && item.hasOwnProperty(this._caption2Field))
			{
				return item[this._caption2Field].toString();
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
