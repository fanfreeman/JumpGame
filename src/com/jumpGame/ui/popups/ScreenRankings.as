package com.jumpGame.ui.popups
{
	import com.jumpGame.level.Statics;
	import com.jumpGame.screens.Menu;
	import com.jumpGame.ui.components.RankingItemRenderer;
	
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.controls.Scroller;
	
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class ScreenRankings extends Sprite
	{
		public var listRankings:List;
//		public var rankingsArray:Array;
		
		private var parent:Menu;
		private var popupContainer:Sprite;
		
		private var btnGlobal:Button;
		private var btnFriends:Button;
		private var imgGlobalOn:Image;
		private var imgFriendsOn:Image;
		
		public function ScreenRankings(parent:Menu)
		{
			super();
			this.parent = parent;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			// bg quad
			var bg:Quad = new Quad(stage.stageWidth, stage.stageHeight, 0x000000);
			bg.alpha = 0.5;
			this.addChild(bg);
			
			popupContainer = new Sprite();
			
			// popup artwork
			var popup:Image = new Image(Assets.getSprite("AtlasTexture8").getTexture("RankingsBg0000"));
			popupContainer.addChild(popup);
			popupContainer.pivotX = Math.ceil(popupContainer.width / 2);
			popupContainer.pivotY = Math.ceil(popupContainer.height / 2);
			popupContainer.x = Statics.stageWidth / 2;
			popupContainer.y = Statics.stageHeight / 2;
			this.addChild(popupContainer);
			
			// popup close button
			var buttonClose:Button = new Button();
			buttonClose.defaultSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ButtonPopupClose0000"));
			buttonClose.hoverSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ButtonPopupClose0000"));
			buttonClose.downSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ButtonPopupClose0000"));
			buttonClose.hoverSkin.filter = Statics.btnBrightnessFilter;
			buttonClose.downSkin.filter = Statics.btnInvertFilter;
			buttonClose.useHandCursor = true;
			buttonClose.addEventListener(Event.TRIGGERED, buttonCloseHandler);
			popupContainer.addChild(buttonClose);
			buttonClose.validate();
			buttonClose.pivotX = buttonClose.width;
			buttonClose.x = popup.bounds.right - 24;
			buttonClose.y = popup.bounds.top + 22;
			
			// global button on
			imgGlobalOn = new Image(Assets.getSprite("AtlasTexture8").getTexture("RankingsBtnGlobalOn0000"));
			imgGlobalOn.x = 155;
			imgGlobalOn.y = -6;
			popupContainer.addChild(imgGlobalOn);
			
			// global button off
			btnGlobal = new Button();
			btnGlobal.defaultSkin = new Image(Assets.getSprite("AtlasTexture8").getTexture("RankingsBtnGlobalOff0000"));
			btnGlobal.hoverSkin = new Image(Assets.getSprite("AtlasTexture8").getTexture("RankingsBtnGlobalOff0000"));
			btnGlobal.downSkin = new Image(Assets.getSprite("AtlasTexture8").getTexture("RankingsBtnGlobalOff0000"));
			btnGlobal.hoverSkin.filter = Statics.btnBrightnessFilter;
			btnGlobal.downSkin.filter = Statics.btnInvertFilter;
			btnGlobal.useHandCursor = true;
			btnGlobal.x = imgGlobalOn.x;
			btnGlobal.y = imgGlobalOn.y + 8;
			btnGlobal.visible = false;
			popupContainer.addChild(btnGlobal);
			btnGlobal.addEventListener(Event.TRIGGERED, buttonGlobalHandler);
			
			// friends button on
			imgFriendsOn = new Image(Assets.getSprite("AtlasTexture8").getTexture("RankingsBtnFriendsOn0000"));
			imgFriendsOn.x = imgGlobalOn.bounds.right - 23;
			imgFriendsOn.y = imgGlobalOn.y;
			imgFriendsOn.visible = false;
			popupContainer.addChild(imgFriendsOn);
			
			// friends button off
			btnFriends = new Button();
			btnFriends.defaultSkin = new Image(Assets.getSprite("AtlasTexture8").getTexture("RankingsBtnFriendsOff0000"));
			btnFriends.hoverSkin = new Image(Assets.getSprite("AtlasTexture8").getTexture("RankingsBtnFriendsOff0000"));
			btnFriends.downSkin = new Image(Assets.getSprite("AtlasTexture8").getTexture("RankingsBtnFriendsOff0000"));
			btnFriends.hoverSkin.filter = Statics.btnBrightnessFilter;
			btnFriends.downSkin.filter = Statics.btnInvertFilter;
			btnFriends.useHandCursor = true;
			btnFriends.x = imgFriendsOn.x + 22;
			btnFriends.y = btnGlobal.y;
			popupContainer.addChild(btnFriends);
			btnFriends.addEventListener(Event.TRIGGERED, buttonFriendsHandler);
			
			// decorative brackets
			var imageBracketLeft:Image = new Image(Assets.getSprite("AtlasTexture8").getTexture("RankingsBracketLeft0000"));
			imageBracketLeft.x = imgGlobalOn.x - 15;
			imageBracketLeft.y = imgGlobalOn.y + 30;
			popupContainer.addChild(imageBracketLeft);
			
			var imageBracketRight:Image = new Image(Assets.getSprite("AtlasTexture8").getTexture("RankingsBracketLeft0000"));
			imageBracketRight.scaleX = -1;
			imageBracketRight.x = imgFriendsOn.bounds.right + 15;
			imageBracketRight.y = imgGlobalOn.y + 30;
			popupContainer.addChild(imageBracketRight);
			
			// rankings list
			listRankings = new List();
			listRankings.width = 437;
			listRankings.height = 350;
			listRankings.pivotX = Math.ceil(listRankings.width / 2);
			listRankings.pivotY = Math.ceil(listRankings.height / 2);
			listRankings.x = Math.ceil(popup.width / 2);
			listRankings.y = Math.ceil(popup.height / 2);
			listRankings.horizontalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			popupContainer.addChild(listRankings);
			listRankings.itemRendererType = RankingItemRenderer;
			listRankings.itemRendererProperties.titleField = "title";
			listRankings.itemRendererProperties.captionField = "caption";
			listRankings.itemRendererProperties.facebookIdField = "facebook_id";
			listRankings.itemRendererProperties.pictureUrlField = "picture_url";
			listRankings.itemRendererProperties.pictureWidthField = "picture_width";
			listRankings.addEventListener(Event.CHANGE, listRankingsChangeHandler);
			
//			rankingsArray = new Array();
		}
		
		private function listRankingsChangeHandler(event:Event):void {
			if (listRankings.selectedIndex == -1) return;
			parent.showProfileScreenGivenData(listRankings.selectedIndex);
			//parent.rankingsArray[listRankings.selectedIndex]
			listRankings.selectedIndex = -1;
		}
		
		public function initialize():void {
			this.visible = true;
			
			// popup pop out effect
			popupContainer.scaleX = 0.5;
			popupContainer.scaleY = 0.5;
			Starling.juggler.tween(popupContainer, 0.5, {
				transition: Transitions.EASE_OUT_ELASTIC,
				scaleX: 1,
				scaleY: 1
			});
		}
		
		private function buttonCloseHandler(event:Event):void {
			if (!Sounds.sfxMuted) Sounds.sndClick.play();
			
			this.visible = false;
		}
		
		private function buttonGlobalHandler(event:Event):void {
			if (!Sounds.sfxMuted) Sounds.sndClick.play();
			
			this.btnGlobal.visible = false;
			this.imgFriendsOn.visible = false;
			this.imgGlobalOn.visible = true;
			this.btnFriends.visible = true;
			Menu(this.parent).refreshRankingsGlobal();
		}
		
		private function buttonFriendsHandler(event:Event):void {
			if (!Sounds.sfxMuted) Sounds.sndClick.play();
			
			this.imgGlobalOn.visible = false;
			this.btnFriends.visible = false;
			this.btnGlobal.visible = true;
			this.imgFriendsOn.visible = true;
			Menu(this.parent).refreshRankingsFriends();
		}
	}
}