package com.jumpGame.ui.screens
{
	import com.jumpGame.events.NavigationEvent;
	import com.jumpGame.level.Statics;
	import com.jumpGame.screens.Menu;
	import com.jumpGame.ui.components.MatchItemRenderer;
	import com.jumpGame.ui.components.StartGameItemRenderer;
	
	import flash.external.ExternalInterface;
	
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.controls.PickerList;
	import feathers.controls.Screen;
	import feathers.controls.ScrollContainer;
	import feathers.controls.Scroller;
	import feathers.controls.popups.CalloutPopUpContentManager;
	import feathers.data.ListCollection;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.events.Event;
	
	public class ScreenMatches extends Screen
	{
		private var matchesContainer:ScrollContainer;
		public var startGamePicker:PickerList // the start a game button
		private var headerYourTurn:Image;
		public var listYourTurn:List;
		private var headerTheirTurn:Image;
		public var listTheirTurn:List;
		private var headerFinished:Image;
		public var listFinished:List;
		public var gamesMyTurn:Array; // stores match data
		public var gamesTheirTurn:Array;
		public var gamesFinished:Array;
		
		public function ScreenMatches()
		{
//			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
//		private function addedToStageHandler(event:Event):void
//		{
//			drawMatchDataPopup(); // match data popup
//		}
		
		override protected function draw():void
		{
		}
		
		override protected function initialize():void
		{
			// popup artwork
			var popup:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("PopupLarge0000"));
			popup.pivotX = Math.ceil(popup.width / 2);
			popup.pivotY = Math.ceil(popup.height / 2);
			popup.x = Statics.stageWidth / 2;
			popup.y = Statics.stageHeight / 2;
			this.addChild(popup);
			
			// popup header
			var popupHeader:Image = new Image(Assets.getSprite("AtlasTexture4").getTexture("PopupHeaderMatches0000"));
			popupHeader.pivotX = Math.ceil(popupHeader.width / 2);
			popupHeader.x = Statics.stageWidth / 2;
			popupHeader.y = popup.bounds.top + 24;
			this.addChild(popupHeader);
			
			// popup close button
			var buttonClose:Button = new Button();
			buttonClose.defaultSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ButtonPopupClose0000"));
			buttonClose.hoverSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ButtonPopupClose0000"));
			buttonClose.downSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ButtonPopupClose0000"));
			buttonClose.hoverSkin.filter = Statics.btnBrightnessFilter;
			buttonClose.downSkin.filter = Statics.btnInvertFilter;
			buttonClose.useHandCursor = true;
			buttonClose.addEventListener(Event.TRIGGERED, Menu(this.owner).buttonClosePopupHandler);
			this.addChild(buttonClose);
			buttonClose.validate();
			buttonClose.pivotX = buttonClose.width;
			buttonClose.x = popup.bounds.right - 25;
			buttonClose.y = popup.bounds.top + 28;
			
			// create matches scroll container
			matchesContainer = new ScrollContainer();
			matchesContainer.width = 570;
			matchesContainer.x = (stage.stageWidth - matchesContainer.width) / 2;
			matchesContainer.y = popup.bounds.top + 95;
			matchesContainer.height = 400;
			matchesContainer.horizontalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			matchesContainer.verticalScrollPolicy = Scroller.SCROLL_POLICY_ON;
			//			var layout:VerticalLayout = new VerticalLayout();
			//			layout.gap = 10;
			//			matchesContainer.layout = layout;
			this.addChild(matchesContainer);
			
			startGamePicker = new PickerList();
			startGamePicker.useHandCursor = true;
			startGamePicker.buttonFactory = function():Button
			{
				var button:Button = new Button();
				button.defaultSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ButtonStartGame0000"));
				button.downSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ButtonStartGame0000"));
				button.hoverSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("ButtonStartGame0000"));
				button.hoverSkin.filter = Statics.btnBrightnessFilter;
				button.downSkin.filter = Statics.btnInvertFilter;
				return button;
			};
			startGamePicker.listFactory = function():List
			{
				var list:List = new List();
				list.backgroundSkin = new Image(Assets.getSprite("AtlasTexture4").getTexture("StartGameCalloutBg0000"));
				list.pivotY = 15;
				list.width = 277;
				list.height = 177;
				list.paddingTop = 41;
				list.paddingLeft = 32;
				list.itemRendererType = StartGameItemRenderer;
				list.verticalScrollPolicy = List.SCROLL_POLICY_OFF;
				list.horizontalScrollPolicy = List.SCROLL_POLICY_OFF;
				return list;
			};
			startGamePicker.width = matchesContainer.width;
			startGamePicker.height = 69;
			startGamePicker.pivotX = Math.ceil(startGamePicker.width / 2);
			startGamePicker.x = matchesContainer.width / 2;
			startGamePicker.visible = false;
			matchesContainer.addChild(startGamePicker);
			var startGameOptions:ListCollection = new ListCollection(
				[
					{ text: "Facebook Friends" },
					{ text: "Smart Match" },
				]);
			startGamePicker.dataProvider = startGameOptions;
			startGamePicker.selectedIndex = -1;
			startGamePicker.popUpContentManager = new CalloutPopUpContentManager();
			startGamePicker.addEventListener(Event.CHANGE, buttonGameStartHandler);
			
			// your turn header
			headerYourTurn = new Image(Assets.getSprite("AtlasTexture4").getTexture("HeaderYourTurn0000"));
			headerYourTurn.pivotX = Math.ceil(headerYourTurn.texture.width / 2);
			headerYourTurn.x = matchesContainer.width / 2;
			headerYourTurn.y = startGamePicker.height + 20;
			headerYourTurn.visible = false;
			matchesContainer.addChild(headerYourTurn);
			
			// your turn match list
			listYourTurn = new List();
			listYourTurn.width = matchesContainer.width;
			listYourTurn.pivotX = Math.ceil(listYourTurn.width / 2);
			listYourTurn.x = matchesContainer.width / 2;
			listYourTurn.y = headerYourTurn.y + headerYourTurn.height + 10;
			listYourTurn.verticalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			matchesContainer.addChild(listYourTurn);
			listYourTurn.itemRendererType = MatchItemRenderer;
			listYourTurn.itemRendererProperties.titleField = "title";
			listYourTurn.itemRendererProperties.captionField = "caption";
			listYourTurn.addEventListener(Event.CHANGE, listYourTurnChangeHandler);
			
			// their turn header
			headerTheirTurn = new Image(Assets.getSprite("AtlasTexture4").getTexture("HeaderTheirTurn0000"));
			headerTheirTurn.pivotX = Math.ceil(headerTheirTurn.texture.width / 2);
			headerTheirTurn.x = matchesContainer.width / 2;
			headerTheirTurn.y = listYourTurn.height + 20;
			headerTheirTurn.visible = false;
			matchesContainer.addChild(headerTheirTurn);
			
			// your turn match list
			listTheirTurn = new List();
			listTheirTurn.width = matchesContainer.width;
			listTheirTurn.pivotX = Math.ceil(listTheirTurn.width / 2);
			listTheirTurn.x = matchesContainer.width / 2;
			listTheirTurn.y = headerTheirTurn.y + headerTheirTurn.height + 10;
			listTheirTurn.verticalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			matchesContainer.addChild(listTheirTurn);
			listTheirTurn.itemRendererType = MatchItemRenderer;
			listTheirTurn.itemRendererProperties.titleField = "title";
			listTheirTurn.itemRendererProperties.captionField = "caption";
			listTheirTurn.addEventListener(Event.CHANGE, listTheirTurnChangeHandler);
			
			// finished matches header
			headerFinished = new Image(Assets.getSprite("AtlasTexture4").getTexture("HeaderFinished0000"));
			headerFinished.pivotX = Math.ceil(headerFinished.texture.width / 2);
			headerFinished.x = matchesContainer.width / 2;
			headerFinished.y = listTheirTurn.height + 20;
			headerFinished.visible = false;
			matchesContainer.addChild(headerFinished);
			
			// finished matches list
			listFinished = new List();
			listFinished.width = matchesContainer.width;
			listFinished.pivotX = Math.ceil(listFinished.width / 2);
			listFinished.x = matchesContainer.width / 2;
			listFinished.y = headerFinished.bounds.bottom + 10;
			listFinished.verticalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			matchesContainer.addChild(listFinished);
			listFinished.itemRendererType = MatchItemRenderer;
			listFinished.itemRendererProperties.titleField = "title";
			listFinished.itemRendererProperties.captionField = "caption";
			listFinished.addEventListener(Event.CHANGE, listFinishedChangeHandler);
			// eof create scroll container
			
			listYourTurn.selectedIndex = -1;
			listTheirTurn.selectedIndex = -1;
			listFinished.selectedIndex = -1;
		}
		
		private function buttonGameStartHandler(event:Event):void {
			if (startGamePicker.selectedIndex == -1) {
				return;
			}
			else if (startGamePicker.selectedIndex == 0) { // select from Facebook friends
				if (!Sounds.sfxMuted) Sounds.sndClick.play();
				
				// call JS
				if(ExternalInterface.available){
					trace("Calling JS...");
					ExternalInterface.call("selectOpponent");
					ExternalInterface.addCallback("returnOpponentToAs", opponentReturnedFromJs);
				} else {
					trace("External interface unavailabe");
				}
			}
			else if (startGamePicker.selectedIndex == 1) { // smart match
				if (!Sounds.sfxMuted) Sounds.sndClick.play();
				
				Menu(this.owner).displayLoadingNotice("Finding an opponent...");
				Menu(this.owner).communicator.addEventListener(NavigationEvent.RESPONSE_RECEIVED, Menu(this.owner).dataReceived);
				Menu(this.owner).communicator.findSmartMatch();
			}
			startGamePicker.selectedIndex = -1;
			startGamePicker.popUpContentManager.close();
		}
		
		private function opponentReturnedFromJs(opponentId:String):void {
			Menu(this.owner).displayLoadingNotice("Creating a new match...");
			Menu(this.owner).communicator.addEventListener(NavigationEvent.RESPONSE_RECEIVED, Menu(this.owner).dataReceived);
			Menu(this.owner).communicator.createMatch(opponentId);
		}
		
		private function listYourTurnChangeHandler(event:Event):void {
			if (listYourTurn.selectedIndex == -1) return;
//			Statics.opponentName = gamesMyTurn[listYourTurn.selectedIndex].opponent_first_name + " " + gamesMyTurn[listYourTurn.selectedIndex].opponent_last_name.toString().substr(0, 1) + ".";
			Statics.opponentName = gamesMyTurn[listYourTurn.selectedIndex].opponent_first_name + "\n" + gamesMyTurn[listYourTurn.selectedIndex].opponent_last_name;
			Statics.roundScores = gamesMyTurn[listYourTurn.selectedIndex].roundScores;
			Statics.isPlayer2 = Boolean(int(gamesMyTurn[listYourTurn.selectedIndex].is_player_2));
			Statics.opponentFbid = gamesMyTurn[listYourTurn.selectedIndex].opponent_fbid;
			Statics.gameId = int(gamesMyTurn[listYourTurn.selectedIndex].game_id);
			Statics.resignedBy = '0';
			Menu(this.owner).showMatchDetailsPopup(false);
			listYourTurn.selectedIndex = -1;
		}
		
		private function listTheirTurnChangeHandler(event:Event):void {
			if (listTheirTurn.selectedIndex == -1) return;
//			Statics.opponentName = gamesTheirTurn[listTheirTurn.selectedIndex].opponent_first_name + " " + gamesTheirTurn[listTheirTurn.selectedIndex].opponent_last_name.toString().substr(0, 1) + ".";
			Statics.opponentName = gamesTheirTurn[listTheirTurn.selectedIndex].opponent_first_name + "\n" + gamesTheirTurn[listTheirTurn.selectedIndex].opponent_last_name;
			Statics.roundScores = gamesTheirTurn[listTheirTurn.selectedIndex].roundScores;
			Statics.isPlayer2 = Boolean(int(gamesTheirTurn[listTheirTurn.selectedIndex].is_player_2));
			Statics.opponentFbid = gamesTheirTurn[listTheirTurn.selectedIndex].opponent_fbid;
			Statics.gameId = int(gamesTheirTurn[listTheirTurn.selectedIndex].game_id);
			Statics.resignedBy = '0';
			Menu(this.owner).showMatchDetailsPopup(false);
			listTheirTurn.selectedIndex = -1;
		}
		
		private function listFinishedChangeHandler(event:Event):void {
			if (listFinished.selectedIndex == -1) return;
//			Statics.opponentName = gamesFinished[listFinished.selectedIndex].opponent_first_name + " " + gamesFinished[listFinished.selectedIndex].opponent_last_name.toString().substr(0, 1) + ".";
			Statics.opponentName = gamesFinished[listFinished.selectedIndex].opponent_first_name + "\n" + gamesFinished[listFinished.selectedIndex].opponent_last_name;
			Statics.roundScores = gamesFinished[listFinished.selectedIndex].roundScores;
			Statics.isPlayer2 = Boolean(int(gamesFinished[listFinished.selectedIndex].is_player_2));
			Statics.opponentFbid = gamesFinished[listFinished.selectedIndex].opponent_fbid;
			Statics.gameId = int(gamesFinished[listFinished.selectedIndex].game_id);
			Statics.resignedBy = String(gamesFinished[listFinished.selectedIndex].resigned_by);
			Menu(this.owner).showMatchDetailsPopup(false);
			listFinished.selectedIndex = -1;
		}
		
		/**
		 * Update list height after assigning data provider.
		 * This is for positioning the Their Turn list correctly.
		 */
		public function updateLists():void {
			// call self if either list is not yet valid
			if (listYourTurn.isInvalid() || listTheirTurn.isInvalid()) {
				Starling.juggler.delayCall(updateLists, 0.01);
				return;
			}
			
			// move their turn header and list
			headerTheirTurn.y = listYourTurn.bounds.bottom + 20;
			listTheirTurn.y = headerTheirTurn.bounds.bottom + 10;
			
			// move finished matches header and list
			headerFinished.y = listTheirTurn.bounds.bottom + 20;
			listFinished.y = headerFinished.bounds.bottom + 10;
			
			// display headers if needed
			if (this.gamesMyTurn.length > 0 || this.gamesTheirTurn.length > 0) {
				headerYourTurn.visible = true;
				headerTheirTurn.visible = true;
			}
			
			if (this.gamesFinished.length > 0) {
				headerFinished.visible = true;
			}
		}
	}
}