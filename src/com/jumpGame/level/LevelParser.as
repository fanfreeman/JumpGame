package com.jumpGame.level  {
	public class LevelParser {
		// instance vars
		public var levelElementsArray:Array;
		
		// parse level definition file
		public function LevelParser() {
			var stageContents:Array = LevelDefinition.getContents();
			var currentY:int = 0;
			this.levelElementsArray = new Array();
			// expand level definition file into level elements array
			for each (var element:Array in stageContents) {
				if (element[0] == Constants.Generator) {
					var generator:LevelGenerator = new LevelGenerator(this, element[1], currentY + element[2], currentY + element[3], Constants.UnitHeight);
					currentY += element[3];
				} else {
					currentY += element[0];
					this.levelElementsArray.push([currentY * Constants.UnitHeight, element[1], element[2], element[3]]);
				}
			}
		}
	}
}