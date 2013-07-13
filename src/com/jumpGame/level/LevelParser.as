package com.jumpGame.level  {
	
	public class LevelParser {
		
		public var currentY:int = 0;  // the global y in height units the level parser has reached
		public var levelElementsArray:Array;
		
		private var generator:LevelGenerator;
		private var difficulty:int = 1;
		
		// parse level definition file
		public function LevelParser() {
			if (Constants.isDesignerMode) this.difficulty = 9999;
			
			this.levelElementsArray = new Array(); // array used to store generated level elements
			this.generator = new LevelGenerator(this);
			
			// initial contraption settings
			// gy, interval, setting type
			this.levelElementsArray.push([currentY * Constants.UnitHeight, 10, Constants.ContraptionSettingHourglass]);
			this.levelElementsArray.push([currentY * Constants.UnitHeight, 10, Constants.ContraptionSettingTrain]);
			this.levelElementsArray.push([currentY * Constants.UnitHeight, 10, Constants.ContraptionSettingTrainFromLeft]);
			this.levelElementsArray.push([currentY * Constants.UnitHeight, 20, Constants.ContraptionSettingBell]);
			this.levelElementsArray.push([currentY * Constants.UnitHeight, 10, Constants.ContraptionSettingPowerupBoxes]);
		}
		
		/**
		 * Given difficulty, return a block number
		 * @return block number
		 */
		public function requestBlock():void {
			var blockNumber:int;
			switch (this.difficulty) {
				case 1:
					blockNumber = int(Math.floor(Math.random() * 2) + 1000);
					this.generator.generate(blockNumber);
					break;
				case 2:
					blockNumber = int(Math.floor(Math.random() * 6) + 2000);
					this.generator.generate(blockNumber);
					break;
				case 3:
					blockNumber = int(Math.floor(Math.random() * 2) + 3000);
					this.generator.generate(blockNumber);
					break;
				case 4:
					blockNumber = int(Math.floor(Math.random() * 1) + 4000);
					this.generator.generate(blockNumber);
					break;
				case 5:
					blockNumber = int(Math.floor(Math.random() * 1) + 5000);
					this.generator.generate(blockNumber);
					break;
				case 6:
					blockNumber = int(Math.floor(Math.random() * 1) + 6000);
					this.generator.generate(blockNumber);
					break;
				case 7:
					blockNumber = int(Math.floor(Math.random() * 1) + 7000);
					this.generator.generate(blockNumber);
					break;
					
				case 9999: // level designer
					this.generator.generate(2003);
					break;
			}
		}
		
		public function updateDifficulty():void {
			if (!Constants.isDesignerMode) {
				if (Statics.gameTime > 10 * 1000) { // lvl 1
					this.difficulty = 2;
				}
				
				if (Statics.gameTime > 30 * 1000) { // lvl 2
					this.difficulty = 3;
				}
				
				if (Statics.gameTime > 50 * 1000) { // lvl 3
					this.difficulty = 4;
				}
				
				if (Statics.gameTime > 70 * 1000) { // lvl 4
					this.difficulty = 5;
				}
				
				if (Statics.gameTime > 90 * 1000) { // lvl 5
					this.difficulty = 6;
				}
				
				if (Statics.gameTime > 110 * 1000) {
					this.difficulty = 7;
				}
			}
		}
	}
}