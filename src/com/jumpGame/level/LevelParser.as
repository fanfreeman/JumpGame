package com.jumpGame.level  {
	
	public class LevelParser {
		
		public var currentY:int = 0;  // the global y in height units the level parser has reached
		public var levelElementsArray:Array;
		
		private var generator:LevelGenerator;
		private var difficulty:int = 7;
		private var nextDifficultyDistance:Number = 18000;
		
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
				case 7:
					blockNumber = int(Math.floor(Math.random() * 3) + 700);
					this.generator.generate(blockNumber);
					break;
				case 8:
					blockNumber = int(Math.floor(Math.random() * 1) + 800);
					this.generator.generate(blockNumber);
					break;
				case 9:
					blockNumber = int(Math.floor(Math.random() * 3) + 900);
					this.generator.generate(blockNumber);
					break;
				case 10:
					blockNumber = int(Math.floor(Math.random() * 2) + 1000);
					this.generator.generate(blockNumber);
					break;
				case 11:
					blockNumber = int(Math.floor(Math.random() * 7) + 2000);
					this.generator.generate(blockNumber);
					break;
				case 12:
					blockNumber = int(Math.floor(Math.random() * 2) + 3000);
					this.generator.generate(blockNumber);
					break;
				case 13:
					blockNumber = int(Math.floor(Math.random() * 2) + 4000);
					this.generator.generate(blockNumber);
					break;
				case 14:
					blockNumber = int(Math.floor(Math.random() * 1) + 5000);
					this.generator.generate(blockNumber);
					break;
				case 15:
					blockNumber = int(Math.floor(Math.random() * 2) + 6000);
					this.generator.generate(blockNumber);
					break;
				case 16:
					blockNumber = int(Math.floor(Math.random() * 1) + 7000);
					this.generator.generate(blockNumber);
					break;
				case 17:
					blockNumber = int(Math.floor(Math.random() * 1) + 8000);
					this.generator.generate(blockNumber);
					break;
				case 18:
					blockNumber = int(Math.floor(Math.random() * 1) + 9000);
					this.generator.generate(blockNumber);
					break;
				case 19:
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
				// increase difficulty based on distance climbed
				if (Statics.maxDist > this.nextDifficultyDistance) {
					this.difficulty++;
					if (this.difficulty > 19) {
						this.difficulty = 12;
						Statics.speedFactor *= 1.1;
					}
					this.nextDifficultyDistance += 18000;
				}
			}
		}
	}
}