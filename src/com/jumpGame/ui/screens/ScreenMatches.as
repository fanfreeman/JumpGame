package com.jumpGame.ui.screens
{
	import com.jumpGame.events.NavigationEvent;
	import com.jumpGame.level.Statics;
	import com.jumpGame.ui.popups.MatchDataContainer;
	import com.jumpGame.screens.Menu;
	import com.jumpGame.ui.components.MatchItemRenderer;
	
	import flash.external.ExternalInterface;
	
	import feathers.controls.List;
	import feathers.controls.PickerList;
	import feathers.controls.Screen;
	import feathers.controls.ScrollContainer;
	import feathers.controls.Scroller;
	import feathers.controls.popups.CalloutPopUpContentManager;
	import feathers.data.ListCollection;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	
	public class ScreenMatches extends Screen
	{
		private var matchesContainer:ScrollContainer;
		public var startGamePicker:PickerList // the start a game button
		public var listYourTurn:List;
		private var headerTheirTurn:Image;
		public var listTheirTurn:List;
		private var headerFinished:Image;
		public var listFinished:List;
		public var gamesMyTurn:Array; // stores match data
		public var gamesTheirTurn:Array;
		public var gamesFinished:Array;
		public var matchDataPopup:MatchDataContainer;
		
		public function ScreenMatches()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function addedToStageHandler(event:Event):void
		{
			drawMatchDataPopup(); // match data popup
		}
		
		private function drawMatchDataPopup():void
		{
			matchDataPopup = new MatchDataContainer(this);
			matchDataPopup.visible = false;
			this.addChild(matchDataPopup);
		}
		
		override protected function draw():void
		{
			//			this._header.width = this.actualWidth;
			//			this._header.validate();
		}
		
		override protected function initialize():void
		{
			// scroll dialog artwork
			var scrollTop:Image = new Image(Assets.getSprite("AtlasTexture2").getTexture("ScrollLongTop0000"));
			scrollTop.pivotX = Math.ceil(scrollTop.texture.width / 2);
			scrollTop.x = stage.stageWidth / 2;
			scrollTop.y = 60;
			this.addChild(scrollTop);
			
			var scrollBottom:Image = new Image(Assets.getSprite("AtlasTexture2").getTexture("ScrollLongBottom0000"));
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
			
			// create matches scroll container
			matchesContainer = new ScrollContainer();
			matchesContainer.width = scrollQuad.width - 10;
			matchesContainer.x = (stage.stageWidth - matchesContainer.width) / 2;
			matchesContainer.y = scrollQuad.y + 10;
			matchesContainer.height = scrollQuad.height - 20;
			matchesContainer.horizontalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			matchesContainer.verticalScrollPolicy = Scroller.SCROLL_POLICY_ON;
			//			var layout:VerticalLayout = new VerticalLayout();
			//			layout.gap = 10;
			//			matchesContainer.layout = layout;
			this.addChild(matchesContainer);
			
			startGamePicker = new PickerList();
			startGamePicker.width = matchesContainer.width - 40;
			startGamePicker.height = 48;
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
			startGamePicker.listProperties.@itemRendererProperties.labelField = "text";
			startGamePicker.labelField = "text";
			startGamePicker.prompt = "Start a Game";
			startGamePicker.selectedIndex = -1;
			startGamePicker.popUpContentManager = new CalloutPopUpContentManager();
			startGamePicker.addEventListener(Event.CHANGE, buttonGameStartHandler);
			
			// your turn header
			var headerYourTurn:Image = new Image(Assets.getSprite("AtlasTexture2").getTexture("HeaderYourTurn0000"));
			headerYourTurn.pivotX = Math.ceil(headerYourTurn.texture.width / 2);
			headerYourTurn.x = matchesContainer.width / 2;
			headerYourTurn.y = startGamePicker.height + 20;
			matchesContainer.addChild(headerYourTurn);
			
			// your turn match list
			listYourTurn = new List();
			listYourTurn.width = matchesContainer.width - 40;
			listYourTurn.pivotX = Math.ceil(listYourTurn.width / 2);
			listYourTurn.x = matchesContainer.width / 2;
			listYourTurn.y = headerYourTurn.y + headerYourTurn.height + 10;
			listYourTurn.verticalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			matchesContainer.addChild(listYourTurn);
			listYourTurn.itemRendererType = MatchItemRenderer;
//			listYourTurn.itemRendererName = "MatchItemRenderer";
			listYourTurn.itemRendererProperties.labelField = "text";
			listYourTurn.addEventListener(Event.CHANGE, listYourTurnChangeHandler);
			
			// their turn header
			headerTheirTurn = new Image(Assets.getSprite("AtlasTexture2").getTexture("HeaderTheirTurn0000"));
			headerTheirTurn.pivotX = Math.ceil(headerTheirTurn.texture.width / 2);
			headerTheirTurn.x = matchesContainer.width / 2;
			headerTheirTurn.y = listYourTurn.height + 20;
			matchesContainer.addChild(headerTheirTurn);
			
			// your turn match list
			listTheirTurn = new List();
			listTheirTurn.width = matchesContainer.width - 40;
			listTheirTurn.pivotX = Math.ceil(listTheirTurn.width / 2);
			listTheirTurn.x = matchesContainer.width / 2;
			listTheirTurn.y = headerTheirTurn.y + headerTheirTurn.height + 10;
			listTheirTurn.verticalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			matchesContainer.addChild(listTheirTurn);
			listTheirTurn.itemRendererProperties.labelField = "text";
			listTheirTurn.addEventListener(Event.CHANGE, listTheirTurnChangeHandler);
			// eof create scroll container
			
			// finished matches header
			headerFinished = new Image(Assets.getSprite("AtlasTexture2").getTexture("HeaderTheirTurn0000"));
			headerFinished.pivotX = Math.ceil(headerFinished.texture.width / 2);
			headerFinished.x = matchesContainer.width / 2;
			headerFinished.y = listTheirTurn.height + 20;
			matchesContainer.addChild(headerFinished);
			
			// finished matches list
			listFinished = new List();
			listFinished.width = matchesContainer.width - 40;
			listFinished.pivotX = Math.ceil(listFinished.width / 2);
			listFinished.x = matchesContainer.width / 2;
			listFinished.y = headerFinished.bounds.bottom + 10;
			listFinished.verticalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			matchesContainer.addChild(listFinished);
			listFinished.itemRendererProperties.labelField = "text";
			listFinished.addEventListener(Event.CHANGE, listFinishedChangeHandler);
			// eof create scroll container
			
			listYourTurn.selectedIndex = -1;
			listTheirTurn.selectedIndex = -1;
		}
		
		private function buttonGameStartHandler(event:Event):void {
			if (startGamePicker.selectedIndex == -1) {
				return;
			}
			else if (startGamePicker.selectedIndex == 0) { // select from Facebook friends
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
				Menu(this.owner).displayLoadingNotice("Finding an opponent...");
				Menu(this.owner).communicator.addEventListener(NavigationEvent.RESPONSE_RECEIVED, Menu(this.owner).dataReceived);
				Menu(this.owner).communicator.findSmartMatch();
			}
			startGamePicker.selectedIndex = -1;
		}
		
		private function opponentReturnedFromJs(opponentId:String):void {
			Menu(this.owner).displayLoadingNotice("Creating a new match...");
			Menu(this.owner).communicator.addEventListener(NavigationEvent.RESPONSE_RECEIVED, Menu(this.owner).dataReceived);
			Menu(this.owner).communicator.createMatch(opponentId);
		}
		
		private function listYourTurnChangeHandler(event:Event):void {
			if (listYourTurn.selectedIndex == -1) return;
			Statics.opponentName = gamesMyTurn[listYourTurn.selectedIndex].opponent_first_name + " " + gamesMyTurn[listYourTurn.selectedIndex].opponent_last_name.toString().substr(0, 1) + ".";
			Statics.roundScores = gamesMyTurn[listYourTurn.selectedIndex].roundScores;
			Statics.isPlayer2 = Boolean(int(gamesMyTurn[listYourTurn.selectedIndex].is_player_2));
			Statics.opponentFbid = gamesMyTurn[listYourTurn.selectedIndex].opponent_fbid;
			Statics.gameId = int(gamesMyTurn[listYourTurn.selectedIndex].game_id);
			Statics.resignedBy = '0';
			matchDataPopup.initialize(false);
			matchDataPopup.visible = true;
			listYourTurn.selectedIndex = -1;
		}
		
		private function listTheirTurnChangeHandler(event:Event):void {
			if (listTheirTurn.selectedIndex == -1) return;
			Statics.opponentName = gamesTheirTurn[listTheirTurn.selectedIndex].opponent_first_name + " " + gamesTheirTurn[listTheirTurn.selectedIndex].opponent_last_name.toString().substr(0, 1) + ".";
			Statics.roundScores = gamesTheirTurn[listTheirTurn.selectedIndex].roundScores;
			Statics.isPlayer2 = Boolean(int(gamesTheirTurn[listTheirTurn.selectedIndex].is_player_2));
			Statics.gameId = int(gamesTheirTurn[listTheirTurn.selectedIndex].game_id);
			Statics.resignedBy = '0';
			matchDataPopup.initialize(false);
			matchDataPopup.visible = true;
			listTheirTurn.selectedIndex = -1;
		}
		
		private function listFinishedChangeHandler(event:Event):void {
			if (listFinished.selectedIndex == -1) return;
			Statics.opponentName = gamesFinished[listFinished.selectedIndex].opponent_first_name + " " + gamesFinished[listFinished.selectedIndex].opponent_last_name.toString().substr(0, 1) + ".";
			Statics.roundScores = gamesFinished[listFinished.selectedIndex].roundScores;
			Statics.isPlayer2 = Boolean(int(gamesFinished[listFinished.selectedIndex].is_player_2));
			Statics.gameId = int(gamesFinished[listFinished.selectedIndex].game_id);
			Statics.resignedBy = String(gamesFinished[listFinished.selectedIndex].resigned_by);
			matchDataPopup.initialize(false);
			matchDataPopup.visible = true;
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
		}
		
		public function resignMatch():void {
			Menu(this.owner).displayLoadingNotice("Updating matches...");
			Menu(this.owner).communicator.addEventListener(NavigationEvent.RESPONSE_RECEIVED, Menu(this.owner).dataReceived);
			Menu(this.owner).communicator.resignMatch(Statics.gameId);
		}
	}
}