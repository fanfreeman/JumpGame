package com.jumpGame.ui.components
{
	
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
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.TextureSmoothing;
	import starling.display.MovieClip;
	
	public class CharacterItemRenderer extends FeathersControl implements IListItemRenderer
	{
		public function CharacterItemRenderer()
		{
			this.addEventListener(TouchEvent.TOUCH, touchHandler);
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}
		
		protected var _nicknameField:String;
		
		public function get nicknameField():String
		{
			return this._nicknameField;
		}
		
		public function set nicknameField(value:String):void
		{
			if(this._nicknameField == value)
			{
				return;
			}
			this._nicknameField = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}
		
		protected var _levelField:String;
		
		public function get levelField():String
		{
			return this._levelField;
		}
		
		public function set levelField(value:String):void
		{
			if(this._levelField == value)
			{
				return;
			}
			this._levelField = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}
		
		protected var _isnewField:String;
		
		public function get isnewField():String
		{
			return this._isnewField;
		}
		
		public function set isnewField(value:String):void
		{
			if(this._isnewField == value)
			{
				return;
			}
			this._isnewField = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}
		
		protected var charNameBanner:Image;
		protected var charName:Label;
		protected var charAnimation:MovieClip;
		protected var newFlag:Image;
		
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
			this.width = 219;
			this.height = 200;
			this.useHandCursor = true;
			
//			if (!this.itemBgButton) {
//				itemBgButton = new Button();
//				itemBgButton.defaultSkin = new Image(Statics.assets.getTexture("MatchesItemBg0000"));
//				itemBgButton.hoverSkin = new Image(Statics.assets.getTexture("MatchesItemBg0000"));
//				itemBgButton.downSkin = new Image(Statics.assets.getTexture("MatchesItemBg0000"));
//				itemBgButton.hoverSkin.filter = Statics.btnBrightnessFilter;
//				itemBgButton.downSkin.filter = Statics.btnInvertFilter;
//				itemBgButton.x = 20;
//				this.addChild(itemBgButton);
//			}
			
			// character name banner
			if (!this.charNameBanner) {
				this.charNameBanner = new Image(Statics.assets.getTexture("CharName0000"));
				this.addChild(charNameBanner);
			}
			
			// character name text
			if (!this.charName) {
				this.charName = new Label();
				charName.touchable = false;
				charName.textRendererFactory = function():ITextRenderer
				{
					var textRenderer:BitmapFontTextRenderer = new BitmapFontTextRenderer();
					var textFormat:BitmapFontTextFormat = new BitmapFontTextFormat(Fonts.getBitmapFont("Materhorn15White"));
					textFormat.align = TextFormatAlign.CENTER;
					textRenderer.textFormat = textFormat;
					textRenderer.smoothing = TextureSmoothing.NONE;
					return textRenderer;
				}
				charName.width = this.width;
				charName.height = 35;
				charName.y = 11;
				this.addChild(this.charName);
			}
			
			if (!this.charAnimation) {
				charAnimation = new MovieClip(Statics.assets.getTextures("CharPrinceIdle"), 40);
				charAnimation.y = 30;
				this.addChild(charAnimation);
			}
			
			if (!this.newFlag) {
				newFlag = new Image(Statics.assets.getTexture("MatchesItemNew0000"));
				newFlag.y = 12;
				this.addChild(newFlag);
			}
			
//			if (!this.captionLabel) {
//				this.captionLabel = new Label();
//				captionLabel.touchable = false;
//				captionLabel.textRendererFactory = function():ITextRenderer
//				{
//					var textRenderer:BitmapFontTextRenderer = new BitmapFontTextRenderer();
//					var textFormat:BitmapFontTextFormat = new BitmapFontTextFormat(Fonts.getBitmapFont("BellGothicBlack13"));
//					textFormat.align = TextFormatAlign.CENTER;
//					textFormat.color = 0x72370a;
//					textRenderer.textFormat = textFormat;
//					textRenderer.smoothing = TextureSmoothing.NONE;
//					return textRenderer;
//				}
//				captionLabel.width = this.width;
//				captionLabel.height = 35;
//				captionLabel.y = 35;
//				this.addChild(this.captionLabel);
//			}
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
				var nickname:String = this.itemToNickname(this._data);
				switch (nickname) {
					case "random":
						this.charName.text = "Scroll of Summoning";
						break;
					case "prince":
						this.charName.text = "Prince Valorpants";
						break;
					case "princess":
						this.charName.text = "Princess Cherry";
						break;
					case "boy":
						this.charName.text = "Iago the Brave";
						break;
					case "girl":
						this.charName.text = "Little Alice";
						break;
				}
				if (this.itemToIsnew(this._data)) this.newFlag.visible = true;
				else this.newFlag.visible = false;
			}
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
		
		public function itemToNickname(item:Object):String
		{
			if(this._nicknameField != null && item && item.hasOwnProperty(this._nicknameField))
			{
				return item[this._nicknameField].toString();
			}
			return "";
		}
		
		public function itemToLevel(item:Object):String
		{
			if(this._levelField != null && item && item.hasOwnProperty(this._levelField))
			{
				return item[this._levelField].toString();
			}
			return "";
		}
		
		public function itemToIsnew(item:Object):Boolean
		{
			if(this._isnewField != null && item && item.hasOwnProperty(this._isnewField))
			{
				return true;
			}
			return false;
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