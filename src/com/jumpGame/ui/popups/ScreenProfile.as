package com.jumpGame.ui.popups
{
	import com.jumpGame.customObjects.Font;
	import com.jumpGame.screens.Menu;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import feathers.controls.Button;
	
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class ScreenProfile extends Sprite
	{
		private var parent:Menu;
		private var popupContainer:Sprite;
		
		private var nameField:TextField;
		private var highScoreField:TextField;
		
		private var playerPicture:Image;
		private var playerPictureLoader:Loader;
		private var playerPictureWidth:uint;
		
		public function ScreenProfile(parent:Menu)
		{
			super();
			this.parent = parent;
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:starling.events.Event):void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			
			// bg quad
			var bg:Quad = new Quad(stage.stageWidth, stage.stageHeight, 0x000000);
			bg.alpha = 0.5;
			this.addChild(bg);
			
			popupContainer = new Sprite();
			
			// popup artwork
			var popup:Image = new Image(Statics.assets.getTexture("PopupLarge0000"));
			popupContainer.addChild(popup);
			popupContainer.pivotX = Math.ceil(popupContainer.width / 2);
			popupContainer.pivotY = Math.ceil(popupContainer.height / 2);
			popupContainer.x = Statics.stageWidth / 2;
			popupContainer.y = Statics.stageHeight / 2;
			this.addChild(popupContainer);
			
			// popup header
			var popupHeader:Image = new Image(Statics.assets.getTexture("PopupHeaderProfile0000"));
			popupHeader.pivotX = Math.ceil(popupHeader.width / 2);
			popupHeader.x = popupContainer.width / 2;
			popupHeader.y = popup.bounds.top + 27;
			popupContainer.addChild(popupHeader);
			
			// popup close button
			var buttonClose:Button = new Button();
			buttonClose.defaultSkin = new Image(Statics.assets.getTexture("ButtonPopupClose0000"));
			buttonClose.hoverSkin = new Image(Statics.assets.getTexture("ButtonPopupClose0000"));
			buttonClose.downSkin = new Image(Statics.assets.getTexture("ButtonPopupClose0000"));
			buttonClose.hoverSkin.filter = Statics.btnBrightnessFilter;
			buttonClose.downSkin.filter = Statics.btnInvertFilter;
			buttonClose.useHandCursor = true;
			buttonClose.addEventListener(starling.events.Event.TRIGGERED, buttonCloseHandler);
			popupContainer.addChild(buttonClose);
			buttonClose.validate();
			buttonClose.pivotX = buttonClose.width;
			buttonClose.x = popup.bounds.right - 25;
			buttonClose.y = popup.bounds.top + 28;
			
			// player profile picture
			playerPicture = new Image(Statics.assets.getTexture("PictureSilhouette0000"));
			playerPicture.x = 107;
			playerPicture.y = 111;
			popupContainer.addChild(playerPicture);
			var pictureScaleFactor:Number = 59 / playerPicture.texture.width;
			playerPicture.scaleX = pictureScaleFactor;
			playerPicture.scaleY = pictureScaleFactor;
			// player profile picture frame
			var pictureFrame:Image = new Image(Statics.assets.getTexture("RankingsPictureFrame0000"));
			pictureFrame.x = 100;
			pictureFrame.y = 100;
			popupContainer.addChild(pictureFrame);
			// picture loader
			playerPictureLoader = new Loader();
			playerPictureLoader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, onPlayerPictureLoadComplete);
			
			var fontHeader:Font = Fonts.getFont("Materhorn24");
			var fontData:Font = Fonts.getFont("BellGothicBlack13");
			
			// player name field
			nameField = new TextField(300, 25, "", fontHeader.fontName, fontHeader.fontSize, 0xffdd1e);
			nameField.vAlign = VAlign.TOP;
			nameField.hAlign = HAlign.LEFT;
			nameField.x = playerPicture.bounds.right + 40;
			nameField.y = 110;
			popupContainer.addChild(nameField);
			
			// high score field
			highScoreField = new TextField(400, 40, "", fontData.fontName, fontData.fontSize, 0x000000);
			highScoreField.vAlign = VAlign.TOP;
			highScoreField.hAlign = HAlign.LEFT;
			highScoreField.x = nameField.bounds.left;
			highScoreField.y = nameField.bounds.bottom;
			popupContainer.addChild(highScoreField);
			
			var comingSoonText:TextField = new TextField(popup.width, 100, "More data will be added!", fontHeader.fontName, fontHeader.fontSize, 0xffa352);
			comingSoonText.y = highScoreField.bounds.bottom + 10;
			comingSoonText.hAlign = HAlign.CENTER;
			comingSoonText.vAlign = VAlign.TOP;
			popupContainer.addChild(comingSoonText);
		}
		
		public function initialize(playerData:Object):void {
			this.visible = true;
			nameField.text = playerData.title;
			highScoreField.text = "High Score: " + playerData.caption;
			
			// load player picture
			if (playerData.picture_url == null || playerData.picture_url == "none") { // tried getting picture data but unsuccessful
				// do nothing
			}
			else { // picture data available, load picture
				playerPictureWidth = playerData.picture_width;
				playerPictureLoader.load(new URLRequest(playerData.picture_url));
			}
			
			// popup pop out effect
			popupContainer.scaleX = 0.5;
			popupContainer.scaleY = 0.5;
			Starling.juggler.tween(popupContainer, 0.5, {
				transition: Transitions.EASE_OUT_ELASTIC,
				scaleX: 1,
				scaleY: 1
			});
		}
		
		private function onPlayerPictureLoadComplete(event:flash.events.Event):void {
			this.playerPicture.texture = Texture.fromBitmap(event.currentTarget.loader.content as Bitmap);
			this.playerPicture.readjustSize();
			var pictureScaleFactor:Number = 59 / playerPictureWidth;
			this.playerPicture.scaleX = pictureScaleFactor;
			this.playerPicture.scaleY = pictureScaleFactor;
		}
		
		private function buttonCloseHandler(event:starling.events.Event):void {
			if (!Sounds.sfxMuted) Statics.assets.playSound("SND_CLICK");
			
			this.visible = false;
		}
	}
}