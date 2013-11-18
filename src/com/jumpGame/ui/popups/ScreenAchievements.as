package com.jumpGame.ui.popups
{
	import com.jumpGame.customObjects.Font;
	import com.jumpGame.level.Statics;
	import com.jumpGame.screens.Menu;
	import com.jumpGame.ui.components.AchievementPlate;
	
	import feathers.controls.Button;
	import feathers.controls.Check;
	import feathers.controls.ScrollBar;
	import feathers.controls.ScrollContainer;
	import feathers.controls.Scroller;
	
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class ScreenAchievements extends Sprite
	{
		private var parent:Menu;
		private var popupContainer:Sprite;
		private var closeButton:Check;
		private var resizableContainer:ScrollContainer;
		private var earnedMessage:TextField;
		private var achievementPlatesList:Vector.<AchievementPlate>;
		
		public function ScreenAchievements(parent:Menu)
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
			var popup:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("PopupLarge0000"));
			popupContainer.addChild(popup);
			popupContainer.pivotX = Math.ceil(popupContainer.width / 2);
			popupContainer.pivotY = Math.ceil(popupContainer.height / 2);
			popupContainer.x = Statics.stageWidth / 2;
			popupContainer.y = Statics.stageHeight / 2;
			this.addChild(popupContainer);
			
			// popup header
			var popupHeader:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("PopupHeaderAchievements0000"));
			popupHeader.pivotX = Math.ceil(popupHeader.width / 2);
			popupHeader.x = popupContainer.width / 2;
			popupHeader.y = popup.bounds.top + 26;
			popupContainer.addChild(popupHeader);
			
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
			buttonClose.x = popup.bounds.right - 25;
			buttonClose.y = popup.bounds.top + 28;
			
			// create scroll container
			resizableContainer = new ScrollContainer();
			resizableContainer.width = popupContainer.width - 160;
			resizableContainer.x = (stage.stageWidth - resizableContainer.width) / 2 - 30;
			resizableContainer.y = 95;
			resizableContainer.height = popupContainer.height - 160;
			resizableContainer.horizontalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			resizableContainer.verticalScrollPolicy = Scroller.SCROLL_POLICY_ON;
			resizableContainer.verticalScrollBarFactory = function():ScrollBar
			{
				var scrollBar:ScrollBar = new ScrollBar();
				scrollBar.useHandCursor = true;
				scrollBar.direction = ScrollBar.DIRECTION_VERTICAL;
				scrollBar.trackLayoutMode = ScrollBar.TRACK_LAYOUT_MODE_SINGLE;
				scrollBar.thumbFactory = function():Button
				{
					var button:Button = new Button();
					button.defaultSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ScrollbarThumb0000"));
					button.hoverSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ScrollbarThumb0000"));
					button.downSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ScrollbarThumb0000"));
					button.hoverSkin.filter = Statics.btnBrightnessFilter;
					button.downSkin.filter = Statics.btnInvertFilter;
					button.scaleY = 0.6;
					return button;
				}
				scrollBar.minimumTrackFactory = function():Button
				{
					var button:Button = new Button();
					button.defaultSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ScrollbarTrack0000"));
					button.hoverSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ScrollbarTrack0000"));
					button.downSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ScrollbarTrack0000"));
					button.hoverSkin.filter = Statics.btnBrightnessFilter;
					button.downSkin.filter = Statics.btnInvertFilter;
					button.pivotX = 1;
					button.pivotY = -10;
					button.scaleY = 0.9;
					return button;
				}
				scrollBar.decrementButtonFactory = function():Button
				{
					var button:Button = new Button();
					button.defaultSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ScrollbarArrowUp0000"));
					button.hoverSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ScrollbarArrowUp0000"));
					button.downSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ScrollbarArrowUp0000"));
					button.hoverSkin.filter = Statics.btnBrightnessFilter;
					button.downSkin.filter = Statics.btnInvertFilter;
					return button;
				}
				scrollBar.incrementButtonFactory = function():Button
				{
					var button:Button = new Button();
					button.defaultSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ScrollbarArrowDown0000"));
					button.hoverSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ScrollbarArrowDown0000"));
					button.downSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ScrollbarArrowDown0000"));
					button.hoverSkin.filter = Statics.btnBrightnessFilter;
					button.downSkin.filter = Statics.btnInvertFilter;
					return button;
				}
				return scrollBar;
			}
			resizableContainer.interactionMode = Scroller.INTERACTION_MODE_TOUCH_AND_SCROLL_BARS;
			resizableContainer.scrollBarDisplayMode = Scroller.SCROLL_BAR_DISPLAY_MODE_FIXED;
			popupContainer.addChild(resizableContainer);
			resizableContainer.validate();
			
			// number of achievements earned message
			var fontMaterhorn:Font = Fonts.getFont("Materhorn25");
			earnedMessage = new TextField(400, 35, "", fontMaterhorn.fontName, fontMaterhorn.fontSize, 0xffffff);
			earnedMessage.hAlign = HAlign.CENTER;
			earnedMessage.vAlign = VAlign.TOP;
			earnedMessage.pivotX = Math.ceil(earnedMessage.width / 2);
			earnedMessage.x = Math.ceil(resizableContainer.width / 2);
			earnedMessage.y = 10;
			resizableContainer.addChild(earnedMessage);
			
			// create achievement plates
			this.achievementPlatesList = new Vector.<AchievementPlate>();
			var prevPlate:AchievementPlate = null;
			var data:Array;
			var achievementPlate:AchievementPlate;
			var numAchievements:uint = Constants.AchievementsData.length;
			for (var i:uint = 1; i < numAchievements; i++) {
				data = Constants.AchievementsData[i];
				achievementPlate = new AchievementPlate();
				achievementPlate.pivotX = Math.ceil(achievementPlate.width / 2);
				achievementPlate.x = resizableContainer.width / 2;
				if (prevPlate != null) {
					achievementPlate.y = prevPlate.bounds.bottom + 10;
				} else {
					achievementPlate.y = earnedMessage.bounds.bottom + 10;
				}
				resizableContainer.addChild(achievementPlate);
				achievementPlate.initialize(data[1], data[2], data[3], data[4]);
				this.achievementPlatesList.push(achievementPlate);
				prevPlate = achievementPlate;
			}
		}
		
		private function buttonCloseHandler(event:Event):void {
			this.visible = false;
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
			
//			resizableContainer.alpha = 0;
//			Starling.juggler.tween(resizableContainer, 0.3, {
//				transition: Transitions.LINEAR,
//				alpha: 1
//			});
			
			var numAchievements:uint = Constants.AchievementsData.length;
			var numAchievementsEarned:uint = 0;
			for (var i:uint = 1; i < numAchievements; i++) {
				if (Statics.achievementsList[i]) {
					this.achievementPlatesList[i - 1].check();
					numAchievementsEarned++;
				}
			}
			
			earnedMessage.text = numAchievementsEarned.toString() + " of " + (numAchievements - 1).toString() + " Achievements Earned";
		}
	}
}