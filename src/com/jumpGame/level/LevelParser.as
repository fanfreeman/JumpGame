package com.jumpGame.level  {
	
	public class LevelParser {
		
		public var currentY:int = 0;  // the global y in height units the level parser has reached
		public var levelElementsArray:Array;
		
		private var generator:LevelGenerator;
		private var difficulty:int = 1;
		private var nextDifficultyDistance:Number;
		
		// parse level definition file
		public function LevelParser() {
			if (Constants.isDesignerMode) this.difficulty = 999999;
			
			this.levelElementsArray = new Array(); // array used to store generated level elements
			this.generator = new LevelGenerator(this);
			
			// initial contraption settings
			// gy, interval, setting type
			this.levelElementsArray.push([currentY * Constants.UnitHeight, 10, Constants.ContraptionSettingHourglass]);
			this.levelElementsArray.push([currentY * Constants.UnitHeight, 10, Constants.ContraptionSettingTrain]);
			this.levelElementsArray.push([currentY * Constants.UnitHeight, 10, Constants.ContraptionSettingBell]);
			this.levelElementsArray.push([currentY * Constants.UnitHeight, 15, Constants.ContraptionSettingPowerupBoxes]);
			this.levelElementsArray.push([currentY * Constants.UnitHeight, 10, Constants.ContraptionSettingCannon]);
			this.levelElementsArray.push([currentY * Constants.UnitHeight, 10, Constants.ContraptionSettingWitch]);
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
					blockNumber = int(Math.floor(Math.random() * 7) + 2000);
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
				case 8:
					blockNumber = int(Math.floor(Math.random() * 1) + 8000);
					this.generator.generate(blockNumber);
					break;
				case 9:
					blockNumber = int(Math.floor(Math.random() * 1) + 9000);
					this.generator.generate(blockNumber);
					break;
				case 10:
					blockNumber = int(Math.floor(Math.random() * 1) + 10000);
					this.generator.generate(blockNumber);
					break;
					
				case 999999: // level designer
					this.generator.generate(999999);
					break;
			}
		}
		
		public function updateDifficulty():void {
			if (!Constants.isDesignerMode) {
				// increase difficulty based on time elapsed
//				if (Statics.gameTime > 10 * 1000) { // lvl 1
//					this.difficulty = 2;
//				}
//				
//				if (Statics.gameTime > 30 * 1000) { // lvl 2
//					this.difficulty = 3;
//					Statics.speedFactor = 1.2;
//				}
//				
//				if (Statics.gameTime > 50 * 1000) { // lvl 3
//					this.difficulty = 4;
//					Statics.speedFactor = 1.3;
//				}
//				
//				if (Statics.gameTime > 70 * 1000) { // lvl 4
//					this.difficulty = 5;
//					Statics.speedFactor = 1.4;
//				}
//				
//				if (Statics.gameTime > 90 * 1000) { // lvl 5
//					this.difficulty = 6;
//					Statics.speedFactor = 1.5;
//				}
//				
//				if (Statics.gameTime > 110 * 1000) {
//					this.difficulty = 7;
//				}
				
				// increase difficulty based on distance climbed
				if (this.difficulty == 1 && Statics.maxDist > 8000) { // lvl 1 lasts shorter
					this.difficulty = 2;
					this.nextDifficultyDistance = 8000 + 18000;
				}
				
				if (Statics.maxDist > this.nextDifficultyDistance) {
					this.difficulty++;
					if (this.difficulty > 10) {
						this.difficulty = 2;
						Statics.speedFactor *= 1.1;
					}
					this.nextDifficultyDistance += 18000;
				}
			}
		}
	}
}