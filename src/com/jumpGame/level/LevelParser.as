package com.jumpGame.level  {
	public class LevelParser {
		// instance vars
		public var levelElementsArray:Array;
		
		// parse level definition file
		public function LevelParser() {
			// get level definition according to game mode 
			var stageContents:Array;
			if (Statics.gameMode == Constants.ModeNormal) {
				stageContents = LevelDefinition.getNormalContents();
			}
			else if (Statics.gameMode == Constants.ModeBonus) {
				stageContents = LevelDefinition.getBonusContents();
			}
			
			var currentY:int = 0;
			this.levelElementsArray = new Array(); // array used to store generated level elements
			var generator:LevelGenerator = new LevelGenerator(this);
			
			// expand level definition file into level elements array
			for each (var element:Array in stageContents) {
				// random generateion
				if (element[0] == Constants.Generator) {
					generator.generate(element[1], currentY + element[2], currentY + element[3], Constants.UnitHeight);
					currentY += element[3];
				}
				
				// hourglass settings
				else if (element[0] == Constants.ContraptionSettingHourglass) { // currentY + 650 (so it triggers at currentY), interval, type
					this.levelElementsArray.push([currentY * Constants.UnitHeight + Constants.ElementPreloadWindow, element[1], element[0]]);
				}
				
				// train settings
				else if (element[0] == Constants.ContraptionSettingTrain) {
					this.levelElementsArray.push([currentY * Constants.UnitHeight + Constants.ElementPreloadWindow, element[1], element[0]]);
				}
				
				// bell settings
				else if (element[0] == Constants.ContraptionSettingBell) {
					this.levelElementsArray.push([currentY * Constants.UnitHeight + Constants.ElementPreloadWindow, element[1], element[0]]);
				}
				
				// static definition
				else {
					currentY += element[0];
					this.levelElementsArray.push([currentY * Constants.UnitHeight, element[1], element[2], element[3]]);
				}
			}
		}
	}
}