package com.jumpGame.level  {
	
	public class LevelParser {
		
		public var currentY:int;  // the global y in height units the level parser has reached
		public var levelElementsArray:Array;
		
		private var generator:LevelGenerator;
		private var difficulty:int;
		private var nextDifficultyDistance:Number;
		
		private var repetitions:uint; // number of times the entire difficulty sequence has repeated
		
		// parse level definition file
		public function LevelParser() { // create new objects here
			this.levelElementsArray = new Array(); // array used to store generated level elements
			this.generator = new LevelGenerator(this);
		}
		
		public function initialize():void { // reset properties here
			currentY = 30;
			nextDifficultyDistance = 18000; // distance of the very first difficulty level
			difficulty = 7;
			repetitions = 0;
			
			if (Constants.isDesignerMode) this.difficulty = 999999;
			this.levelElementsArray.length = 0; // clear this array
			
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
					this.levelElementsArray.push([currentY * Constants.UnitHeight, Constants.ContraptionSettingBell, 10]);
					blockNumber = int(Math.floor(Math.random() * 3) + 700);
					this.generator.generate(blockNumber);
					break;
				case 8:
					blockNumber = int(Math.floor(Math.random() * 1) + 800);
					this.generator.generate(blockNumber);
					break;
				case 9:
					this.levelElementsArray.push([currentY * Constants.UnitHeight, Constants.ContraptionSettingPowerupBoxes, 30]);
					blockNumber = int(Math.floor(Math.random() * 4) + 900);
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
					blockNumber = int(Math.floor(Math.random() * 2) + 3000);
					this.generator.generate(blockNumber);
					break;
				case 13:
					blockNumber = int(Math.floor(Math.random() * 5) + 4000);
					this.generator.generate(blockNumber);
					break;
				case 14:
					this.levelElementsArray.push([currentY * Constants.UnitHeight, Constants.ContraptionSettingWitch, 15]);
					blockNumber = int(Math.floor(Math.random() * 1) + 5000);
					this.generator.generate(blockNumber);
					break;
				case 15:
					blockNumber = int(Math.floor(Math.random() * 4) + 6000);
					this.generator.generate(blockNumber);
					break;
				case 16:
					this.levelElementsArray.push([currentY * Constants.UnitHeight, Constants.ContraptionSettingTrainRight, 10]);
					this.levelElementsArray.push([currentY * Constants.UnitHeight, Constants.ContraptionSettingTrainLeft, 10]);
					blockNumber = int(Math.floor(Math.random() * 2) + 7000);
					this.generator.generate(blockNumber);
					break;
				case 17:
					this.levelElementsArray.push([currentY * Constants.UnitHeight, Constants.ContraptionSettingPowerupBoxes, 20]);
					blockNumber = int(Math.floor(Math.random() * 5) + 8000);
					this.generator.generate(blockNumber);
					break;
				case 18:
					this.levelElementsArray.push([currentY * Constants.UnitHeight, Constants.ContraptionSettingWitch, 10]);
					blockNumber = int(Math.floor(Math.random() * 1) + 9000);
					this.generator.generate(blockNumber);
					break;
				case 19:
					blockNumber = int(Math.floor(Math.random() * 5) + 10000);
					this.generator.generate(blockNumber);
					break;
				case 20:
					blockNumber = int(Math.floor(Math.random() * 1) + 11000);
					this.generator.generate(blockNumber);
					break;
				case 21:
					blockNumber = int(Math.floor(Math.random() * 4) + 12000);
					this.generator.generate(blockNumber);
					break;
				case 22:
					blockNumber = int(Math.floor(Math.random() * 1) + 13000);
					this.generator.generate(blockNumber);
					break;
				case 23:
					blockNumber = int(Math.floor(Math.random() * 3) + 14000);
					this.generator.generate(blockNumber);
					break;
				case 24:
					blockNumber = int(Math.floor(Math.random() * 1) + 15000);
					this.generator.generate(blockNumber);
					break;
				case 25:
//					this.disableContraptions();
					Statics.contraptionsEnabled = false;
					blockNumber = int(Math.floor(Math.random() * 4) + 16000);
					this.generator.generate(blockNumber);
					break;
				case 26:
					blockNumber = int(Math.floor(Math.random() * 2) + 17000);
					this.generator.generate(blockNumber);
					break;
				case 27:
					blockNumber = int(Math.floor(Math.random() * 3) + 18000);
					this.generator.generate(blockNumber);
					break;
				case 28:
					blockNumber = int(Math.floor(Math.random() * 2) + 19000);
					this.generator.generate(blockNumber);
					break;
				case 29:
//					this.reenableContraptions();
					blockNumber = int(Math.floor(Math.random() * 2) + 20000);
					this.generator.generate(blockNumber);
					break;
					
				case 999999: // level designer
					this.generator.generate(999999);
					break;
			}
			
			this.generator.addRowBlueStars();
			this.updateDifficulty();
		}
		
//		private function disableContraptions():void {
//			this.levelElementsArray.push([currentY * Constants.UnitHeight, Constants.ContraptionSettingWitch, 0]);
//			this.levelElementsArray.push([currentY * Constants.UnitHeight, Constants.ContraptionSettingBell, 0]);
//			this.levelElementsArray.push([currentY * Constants.UnitHeight, Constants.ContraptionSettingPowerupBoxes, 0]);
//		}
//		
//		private function reenableContraptions():void {
//			this.levelElementsArray.push([currentY * Constants.UnitHeight, Constants.ContraptionSettingWitch, 10]);
//			this.levelElementsArray.push([currentY * Constants.UnitHeight, Constants.ContraptionSettingBell, 10]);
//			this.levelElementsArray.push([currentY * Constants.UnitHeight, Constants.ContraptionSettingPowerupBoxes, 20]);
//		}
		
		public function updateDifficulty():void {
			if (!Constants.isDesignerMode) {
				// increase difficulty based on distance climbed
				if (Statics.maxDist > this.nextDifficultyDistance) {
					if (this.difficulty == 7) {
						this.raiseDifficulty();
						this.nextDifficultyDistance = Statics.maxDist + 5000;
					}
					else if (this.difficulty == 9) {
						this.raiseDifficulty();
						this.nextDifficultyDistance = Statics.maxDist + 5000;
					}
					else {
						this.raiseDifficulty();
						if (this.difficulty > 27) {
							Statics.contraptionsEnabled = true; // reenable contraptions
							this.difficulty = 12;
							if (this.repetitions == 0) { // second go through, schedule cannons
								this.levelElementsArray.push([currentY * Constants.UnitHeight, Constants.ContraptionSettingPowerupBoxes, 15]);
								this.levelElementsArray.push([currentY * Constants.UnitHeight, Constants.ContraptionSettingCannon, 20]);
							}
							else { // third go through and beyond
								this.levelElementsArray.push([currentY * Constants.UnitHeight, Constants.ContraptionSettingPowerupBoxes, 10]);
								this.levelElementsArray.push([currentY * Constants.UnitHeight, Constants.ContraptionSettingCannon, 15]);
							}
							this.repetitions++;
						}
						if (this.difficulty % 2 == 0) this.nextDifficultyDistance = Statics.maxDist + 8000;
						else this.nextDifficultyDistance = Statics.maxDist + 16000; // star levels are longer
					}
					
					// add a row of red stars
					this.generator.addRowRedStars();
				}
			}
		}
		
		private function raiseDifficulty():void {
			this.difficulty++;
			if (Statics.speedFactor < 1.2) Statics.speedFactor += 0.005;
		}
	}
}