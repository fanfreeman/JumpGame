package com.jumpGame.ui.popups
{
	import com.jumpGame.level.Statics;
	import com.jumpGame.screens.Menu;
	import com.jumpGame.ui.components.AchievementPlate;
	
	import feathers.controls.Check;
	import feathers.controls.ScrollContainer;
	import feathers.controls.Scroller;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class ScreenAchievements extends Sprite
	{
		private var parent:Menu;
		private var closeButton:Check;
		private var resizableContainer:ScrollContainer;
		
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
			
			// scroll dialog artwork
			var scrollTop:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("ScrollLongTop0000"));
			scrollTop.pivotX = Math.ceil(scrollTop.texture.width / 2);
			scrollTop.x = stage.stageWidth / 2;
			scrollTop.y = 60;
			this.addChild(scrollTop);
			
			var scrollBottom:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("ScrollLongBottom0000"));
			scrollBottom.pivotX = Math.ceil(scrollBottom.texture.width / 2);
			scrollBottom.pivotY = scrollBottom.texture.height;
			scrollBottom.x = stage.stageWidth / 2;
			scrollBottom.y = stage.stageHeight - 70;
			this.addChild(scrollBottom);
			
			var scrollQuad:Quad = new Quad(scrollTop.texture.width - 54, scrollBottom.y - scrollTop.y - scrollTop.texture.height - scrollBottom.texture.height + 2, 0xf1b892);
			scrollQuad.pivotX = Math.ceil(scrollQuad.width / 2);
			scrollQuad.x = stage.stageWidth / 2;
			scrollQuad.y = scrollTop.y + scrollTop.texture.height - 1;
			addChild(scrollQuad);
			// eof scroll dialog artwork
			
			// create scroll container
			resizableContainer = new ScrollContainer();
			resizableContainer.width = scrollQuad.width - 10;
			resizableContainer.x = (stage.stageWidth - resizableContainer.width) / 2;
			resizableContainer.y = scrollQuad.y + 15;
			resizableContainer.height = scrollQuad.height - 30;
			resizableContainer.horizontalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			resizableContainer.verticalScrollPolicy = Scroller.SCROLL_POLICY_ON;
			this.addChild(resizableContainer);
			
			// create achievement plates
			this.achievementPlatesList = new Vector.<AchievementPlate>();
			var prevPlate:AchievementPlate = null;
			var data:Array;
			var achievementPlate:AchievementPlate;
			for (var i:uint = 1; i < Constants.AchievementsData.length; i++) {
				data = Constants.AchievementsData[i];
				achievementPlate = new AchievementPlate();
				achievementPlate.pivotX = Math.ceil(achievementPlate.width / 2);
				achievementPlate.x = resizableContainer.width / 2;
				if (prevPlate != null) {
					achievementPlate.y = prevPlate.bounds.bottom + 10;
				}
				resizableContainer.addChild(achievementPlate);
				achievementPlate.initialize(data[1], data[2], data[3], data[4]);
				this.achievementPlatesList.push(achievementPlate);
				prevPlate = achievementPlate;
			}
			
			// close button
			closeButton = new Check();
			closeButton.isSelected = true;
			closeButton.width = 30;
			closeButton.height = 30;
			closeButton.x = scrollQuad.x + scrollQuad.width / 2 - 40;
			closeButton.y = scrollQuad.y - 25;
			closeButton.addEventListener(Event.TRIGGERED, buttonCloseHandler);
			this.addChild(closeButton);
		}
		
		public function refresh():void {
			closeButton.isSelected = true; // fix close button
		}
		
		private function buttonCloseHandler(event:Event):void {
			this.visible = false;
		}
		
		public function updateAchievementPlates():void {
			for (var i:uint = 1; i < Constants.AchievementsData.length; i++) {
				if (Statics.achievementsList[i]) this.achievementPlatesList[i - 1].check();
			}
		}
	}
}