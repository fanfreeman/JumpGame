package com.jumpGame.ui.components
{
	
	import com.jumpGame.customObjects.Font;
	
	import flash.geom.Point;
	
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.core.FeathersControl;
	import feathers.text.BitmapFontTextFormat;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
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
		protected var charName:TextField;
		protected var levelCaption:TextField;
		protected var charAnimation:MovieClip;
		protected var charDescription:TextField;
		protected var btnAction:Button;
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
			var itemWidth:int = 219 + 11;
			this.width = itemWidth;
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
				charNameBanner.x = 5;
				charNameBanner.y = 20;
				this.addChild(charNameBanner);
			}
			
			// character name text
			if (!this.charName) {
//				this.charName = new Label();
//				charName.touchable = false;
//				charName.textRendererFactory = function():ITextRenderer
//				{
//					var textRenderer:BitmapFontTextRenderer = new BitmapFontTextRenderer();
//					var textFormat:BitmapFontTextFormat = new BitmapFontTextFormat(Fonts.getBitmapFont("Materhorn15White"));
//					textFormat.align = TextFormatAlign.CENTER;
//					textRenderer.textFormat = textFormat;
//					textRenderer.smoothing = TextureSmoothing.NONE;
//					return textRenderer;
//				}
//				charName.width = this.width;
//				charName.height = 35;
//				charName.y = 15;
//				this.addChild(this.charName);
				var font15:Font = Fonts.getFont("Materhorn15White");
				this.charName = new TextField(200, 20, "Name", font15.fontName, font15.fontSize, 0xffffff);
				charName.hAlign = HAlign.CENTER;
				charName.vAlign = VAlign.TOP;
				charName.pivotX = charName.width / 2;
				charName.x = itemWidth / 2;
				charName.y = charNameBanner.y + 15;
				this.addChild(charName);
			}
			
			// level caption
			if (!this.levelCaption) {
				this.levelCaption = new TextField(200, 20, "Max Level: 60", font15.fontName, font15.fontSize, 0x72370a);
				levelCaption.hAlign = HAlign.CENTER;
				levelCaption.vAlign = VAlign.TOP;
				levelCaption.pivotX = levelCaption.width / 2;
				levelCaption.x = itemWidth / 2;
				levelCaption.y = charNameBanner.y + charNameBanner.height;
				this.addChild(levelCaption);
			}
			
			// character animation
			if (!this.charAnimation) {
				charAnimation = new MovieClip(Statics.assets.getTextures("CharPrinceIdle"), 40);
				charAnimation.pivotX = Math.ceil(charAnimation.texture.width / 2);
				charAnimation.x = itemWidth / 2;
				charAnimation.y = levelCaption.y + levelCaption.height;
				this.addChild(charAnimation);
				Starling.juggler.add(charAnimation);
			}
			
			// character description
			if (!this.charDescription) {
				this.charDescription = new TextField(200, 50, "Default Description Text", font15.fontName, font15.fontSize, 0x72370a);
				charDescription.hAlign = HAlign.CENTER;
				charDescription.vAlign = VAlign.TOP;
				charDescription.pivotX = charDescription.width / 2;
				charDescription.x = itemWidth / 2;
				charDescription.y = charAnimation.y + charAnimation.height;
				this.addChild(charDescription);
			}
			
			// action button
			if (!this.btnAction) {
				btnAction = new Button();
				btnAction.defaultSkin = new Image(Statics.assets.getTexture("ButtonMatchDetailsCta0000"));
				btnAction.hoverSkin = new Image(Statics.assets.getTexture("ButtonMatchDetailsCta0000"));
				btnAction.downSkin = new Image(Statics.assets.getTexture("ButtonMatchDetailsCta0000"));
				btnAction.hoverSkin.filter = Statics.btnBrightnessFilter;
				btnAction.downSkin.filter = Statics.btnInvertFilter;
				btnAction.useHandCursor = true;
				btnAction.addEventListener(Event.TRIGGERED, btnActionHandler);
				this.addChild(btnAction);
				btnAction.validate();
				btnAction.pivotX = Math.ceil(btnAction.width / 2);
				btnAction.x = itemWidth / 2;
				btnAction.y = charDescription.y + charDescription.height;
				var ctaTextFormat:BitmapFontTextFormat = new BitmapFontTextFormat(Fonts.getBitmapFont("Materhorn25"));
				btnAction.defaultLabelProperties.textFormat = ctaTextFormat;
			}
			
			// new badge
			if (!this.newFlag) {
				newFlag = new Image(Statics.assets.getTexture("MatchesItemNew0000"));
				newFlag.pivotX = newFlag.texture.width;
				newFlag.x = itemWidth;
//				newFlag.y = 10;
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
					case "cat":
						this.charName.text = "Captain Fluffpaws";
						this.charDescription.text = "The infamous pirate captain can autotrigger Fly, and turns stone into gold";
						this.swapFrames(charAnimation, Statics.assets.getTextures("CharCatIdle"));
						break;
					case "prince":
						this.charName.text = "Prince Valorawesome";
						this.charDescription.text = "This future heir can FLY, and wields the arcane power of PROTECTION";
						this.swapFrames(charAnimation, Statics.assets.getTextures("CharPrinceIdle"));
						break;
					case "princess":
						this.charName.text = "Princess Powerberries";
						this.charDescription.text = "A beautiful princess with the amazing ability to FLY short distances.";
						this.swapFrames(charAnimation, Statics.assets.getTextures("CharPrincessIdle"));
						break;
					case "girl":
						this.charName.text = "Cinderella";
						this.charDescription.text = "A pretty little girl who has the rare gift of SLOW FALL.";
						this.swapFrames(charAnimation, Statics.assets.getTextures("CharGirlIdle"));
						break;
					case "boy":
						this.charName.text = "Iago Don Juan";
						this.charDescription.text = "A courageous young lad with big dreams.";
						this.swapFrames(charAnimation, Statics.assets.getTextures("CharBoyIdle"));
						this.btnAction.label = "Upgrade";
						break;
				}
				if (this.itemToIsnew(this._data)) this.newFlag.visible = true;
				else this.newFlag.visible = false;
			}
		}
		
		private function swapFrames(clip:MovieClip, textures:Vector.<Texture>):void {
			// remove all frame but one, since a MovieClip is not allowed to have 0 frames
			while(clip.numFrames > 1){
				clip.removeFrameAt(0);
			}
			
			// add new frames
			for each (var texture:Texture in textures){
				clip.addFrame(texture);
			}
			
			// remove that last previous frame
			clip.removeFrameAt(0);
			
			// set to frame 1
			clip.currentFrame = 1;
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
		
		protected function btnActionHandler(event:Event):void {
			
		}
	}
}