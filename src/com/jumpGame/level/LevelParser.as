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
			this.levelElementsArray.push([currentY * Constants.UnitHeight, Constants.ContraptionSettingHourglass, 0]);
			this.levelElementsArray.push([currentY * Constants.UnitHeight, Constants.ContraptionSettingTrainRight, 0]);
			this.levelElementsArray.push([currentY * Constants.UnitHeight, Constants.ContraptionSettingTrainLeft, 0]);
			this.levelElementsArray.push([currentY * Constants.UnitHeight, Constants.ContraptionSettingBell, 0]);
			this.levelElementsArray.push([currentY * Constants.UnitHeight, Constants.ContraptionSettingPowerupBoxes, 0]);
			this.levelElementsArray.push([currentY * Constants.UnitHeight, Constants.ContraptionSettingCannon, 0]);
			this.levelElementsArray.push([currentY * Constants.UnitHeight, Constants.ContraptionSettingWitch, 0]);
		}
		
		/**
		 * Given difficulty, return a block number
		 * @return block number
		 */
		public function requestBlock():void {
			trace("requesting difficulty " + this.difficulty);
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
					this.levelElementsArray.push([currentY * Constants.UnitHeight, Constants.ContraptionSettingTrainRight, 15]);
					blockNumber = int(Math.floor(Math.random() * 2) + 1000);
					this.generator.generate(blockNumber);
					break;
				case 11:
					this.levelElementsArray.push([currentY * Constants.UnitHeight, Constants.ContraptionSettingTrainLeft, 15]);
					blockNumber = int(Math.floor(Math.random() * 7) + 2000);
					this.generator.generate(blockNumber);
					break;
				case 12:
					this.levelElementsArray.push([currentY * Constants.UnitHeight, Constants.ContraptionSettingPowerupBoxes, 30]);
					blockNumber = int(Math.floor(Math.random() * 2) + 3000);
					this.generator.generate(blockNumber);
					break;
				case 13:
					blockNumber = int(Math.floor(Math.random() * 2) + 4000);
					this.generator.generate(blockNumber);
					break;
				case 14:
					this.levelElementsArray.push([currentY * Constants.UnitHeight, Constants.ContraptionSettingBell, 30]);
					this.levelElementsArray.push([currentY * Constants.UnitHeight, Constants.ContraptionSettingWitch, 15]);
					blockNumber = int(Math.floor(Math.random() * 1) + 5000);
					this.generator.generate(blockNumber);
					break;
				case 15:
					blockNumber = int(Math.floor(Math.random() * 2) + 6000);
					this.generator.generate(blockNumber);
					break;
				case 16:
					this.levelElementsArray.push([currentY * Constants.UnitHeight, Constants.ContraptionSettingTrainRight, 10]);
					this.levelElementsArray.push([currentY * Constants.UnitHeight, Constants.ContraptionSettingTrainLeft, 10]);
					blockNumber = int(Math.floor(Math.random() * 1) + 7000);
					this.generator.generate(blockNumber);
					break;
				case 17:
					this.levelElementsArray.push([currentY * Constants.UnitHeight, Constants.ContraptionSettingPowerupBoxes, 20]);
					blockNumber = int(Math.floor(Math.random() * 1) + 8000);
					this.generator.generate(blockNumber);
					break;
				case 18:
					this.levelElementsArray.push([currentY * Constants.UnitHeight, Constants.ContraptionSettingWitch, 10]);
					blockNumber = int(Math.floor(Math.random() * 1) + 9000);
					this.generator.generate(blockNumber);
					break;
				case 19:
					blockNumber = int(Math.floor(Math.random() * 1) + 10000);
					this.generator.generate(blockNumber);
					break;
				case 20:
					blockNumber = int(Math.floor(Math.random() * 1) + 11000);
					this.generator.generate(blockNumber);
					break;
				case 21:
					blockNumber = int(Math.floor(Math.random() * 1) + 12000);
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
					if (this.difficulty == 7) {
						this.difficulty++;
						this.nextDifficultyDistance += 5000;
					}
					else if (this.difficulty == 9) {
						this.difficulty++;
						this.nextDifficultyDistance += 5000;
					}
					else {
						this.difficulty++;
						if (this.difficulty > 21) {
							this.difficulty = 12;
							Statics.speedFactor *= 1.1;
							this.levelElementsArray.push([currentY * Constants.UnitHeight, Constants.ContraptionSettingPowerupBoxes, 15]);
							this.levelElementsArray.push([currentY * Constants.UnitHeight, Constants.ContraptionSettingCannon, 20]);
						}
						this.nextDifficultyDistance += 18000;
					}
					
					// add a row of red stars
					this.generator.addRowRedStars();
				}
			}
		}
	}
}