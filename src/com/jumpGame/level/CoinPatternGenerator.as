package com.jumpGame.level
{
	public class CoinPatternGenerator
	{
		private var builder:LevelParser;
		private var patternNum:int;
		private var rowNum:uint;
		
		
		public function CoinPatternGenerator(builder:LevelParser)
		{
			super();
			this.builder = builder;
		}
		
		public function initailize():void {
			this.patternNum = -1;
			this.rowNum = 0;
		}
		
		public function addRow():void {
			if (this.patternNum == -1) { // generate a new pattern
				this.patternNum = Math.floor(Math.random() * 3); // number of different patterns
				this.rowNum = 0;
			}
			
//			this.patternNum = 2; //testing
			return;
			switch (this.patternNum) {
				case 0:
					this.generateFourPerRow();
					break
				case 1:
					this.generateTwoZigzagColumns();
					break;
				case 2:
					this.generateDiamondShape();
					break;
			}
		}
		
		// add just a simple pattern of coins, for normal gameplay
		public function addSimplePattern():void {
			var randomNum:Number = Math.random();
			if (randomNum < 0.2) { // actually generate coins
//				if (randomNum < 0.1) { // pattern 1: one two one two one two ...
//					var gx:int = -280;
//					var gy:Number = (this.builder.currentY) * Constants.UnitHeight;
//					var count:uint = 0;
//					while (gx <= 280) {
//						if (count % 2 == 0) { // add one coin
//							this.builder.levelElementsArray.push([gy, gx, "CoinSilver"]);
//						} else { // add two coins
//							this.builder.levelElementsArray.push([gy - 20, gx, "CoinBronze"]);
//							this.builder.levelElementsArray.push([gy + 20, gx, "CoinBronze"]);
//						}
//						count++;
//						gx += 40;
//					}
//				}
//				else { // pattern 2: bronze and bubbles
					var gx:int = -320;
					var gy:Number = (this.builder.currentY) * Constants.UnitHeight;
					var count:uint = 0;
					while (gx <= 320) {
						if (count % 2 == 0) { // add bubble coin
							this.builder.levelElementsArray.push([gy, gx, "CoinBubble"]);
						} else { // add two coins
//							this.builder.levelElementsArray.push([gy, gx, "CoinBronze"]);
						}
						count++;
						gx += 40;
					}
//				}
			} // eof actually generate coins
		}
		
		// designed pattern: four coins per row
		private var prevCoinGx:Number;
		private function generateFourPerRow():void {
			var numElementsPerRow:uint = 4;
			var gx:Number;
			if (this.rowNum == 0) {
				gx = Math.random() * 400 - 200;
			} else {
				gx = Math.random() * 100 - 50 + this.prevCoinGx;
			}
			this.prevCoinGx = gx;
			var gy:Number = (this.builder.currentY) * Constants.UnitHeight;
			if (this.rowNum < 8) {
				for (var i:uint = 0;  i < numElementsPerRow; i++) { // loop through elements on the same row
					this.builder.levelElementsArray.push([gy, gx + i * 40, "CoinBronze"]);
				}
			}
			else if (this.rowNum < 14) {
				for (i = 0;  i < numElementsPerRow; i++) { // loop through elements on the same row
					this.builder.levelElementsArray.push([gy, gx + i * 40, "CoinSilver"]);
				}
			}
			else if (this.rowNum < 18) {
				for (i = 0;  i < numElementsPerRow; i++) { // loop through elements on the same row
					this.builder.levelElementsArray.push([gy, gx + i * 40, "Coin"]);
				}
			}
			else {
				for (i = 0;  i < numElementsPerRow; i++) { // loop through elements on the same row
					this.builder.levelElementsArray.push([gy, gx + i * 40, "CoinBubble"]);
				}
			}
			
			// add bubbles on the sides
			if (this.rowNum % 3 == 2) {
				this.builder.levelElementsArray.push([gy, gx - 40, "CoinBubble"]);
				this.builder.levelElementsArray.push([gy, gx + numElementsPerRow * 40, "CoinBubble"]);
			}
			
			this.rowNum++;
			if (this.rowNum == 20) {
				this.patternNum = -1;
			}
		}
		
		private var prevGx1:Number;
		private var prevGx2:Number;
		private var isOpeningUp:Boolean;
		private function generateTwoZigzagColumns():void {
			var gx1:Number;
			var gx2:Number;
			if (this.rowNum == 0) {
				this.isOpeningUp = true;
				prevGx1 = -15;
				gx1 = -15;
				gx2 = 15;
			} else {
				if (isOpeningUp && prevGx1 <= -315) {
					isOpeningUp = false;
				}
				else if (!isOpeningUp && prevGx1 >= -15) {
					isOpeningUp = true;
				}
				if (isOpeningUp) {
					gx1 = prevGx1 - 30;
					gx2 = prevGx2 + 30;
				} else {
					gx1 = prevGx1 + 30;
					gx2 = prevGx2 - 30;
				}
			}
			this.prevGx1 = gx1;
			this.prevGx2 = gx2;
			
			var gy:Number = (this.builder.currentY) * Constants.UnitHeight;
			if (this.rowNum < 24) {
				this.builder.levelElementsArray.push([gy, gx1, "CoinBronze"]);
				this.builder.levelElementsArray.push([gy, gx1 - 30, "CoinBronze"]);
				this.builder.levelElementsArray.push([gy, gx2, "CoinBronze"]);
				this.builder.levelElementsArray.push([gy, gx2 + 30, "CoinBronze"]);
			}
			else if (this.rowNum < 42) {
				this.builder.levelElementsArray.push([gy, gx1, "CoinSilver"]);
				this.builder.levelElementsArray.push([gy, gx1 - 30, "CoinSilver"]);
				this.builder.levelElementsArray.push([gy, gx2, "CoinSilver"]);
				this.builder.levelElementsArray.push([gy, gx2 + 30, "CoinSilver"]);
			}
			else if (this.rowNum < 54) {
				this.builder.levelElementsArray.push([gy, gx1, "Coin"]);
				this.builder.levelElementsArray.push([gy, gx1 - 30, "Coin"]);
				this.builder.levelElementsArray.push([gy, gx2, "Coin"]);
				this.builder.levelElementsArray.push([gy, gx2 + 30, "Coin"]);
			}
			else {
				this.builder.levelElementsArray.push([gy, gx1, "CoinBubble"]);
				this.builder.levelElementsArray.push([gy, gx1 - 30, "CoinBubble"]);
				this.builder.levelElementsArray.push([gy, gx2, "CoinBubble"]);
				this.builder.levelElementsArray.push([gy, gx2 + 30, "CoinBubble"]);
			}
			
			// add bubbles on the sides
			if (this.rowNum % 3 == 2) {
				this.builder.levelElementsArray.push([gy, gx1 - 60, "CoinBubble"]);
				this.builder.levelElementsArray.push([gy, gx1 + 30, "CoinBubble"]);
				this.builder.levelElementsArray.push([gy, gx2 - 30, "CoinBubble"]);
				this.builder.levelElementsArray.push([gy, gx2 + 60, "CoinBubble"]);
			}
			
			this.rowNum++;
			if (this.rowNum == 60) {
				this.patternNum = -1;
			}
		}
		
		// diamond shape coins in the middle
		private var numCoinsPerRow:int;
		private function generateDiamondShape():void {
			if (this.rowNum == 0) {
				this.isOpeningUp = true;
				numCoinsPerRow = 1;
			} else {
				if (this.isOpeningUp && numCoinsPerRow >= 15) {
					this.isOpeningUp = false;
				}
			}
			
			var gy:Number = (this.builder.currentY) * Constants.UnitHeight;
			for (var i:int = -(numCoinsPerRow - 1) / 2; i <= (numCoinsPerRow - 1) / 2; i++) {
				var gx:Number = 40 * i;
				if (this.rowNum < 8) {
					this.builder.levelElementsArray.push([gy, gx, "CoinBronze"]);
				}
				else if (this.rowNum < 12) {
					this.builder.levelElementsArray.push([gy, gx, "CoinSilver"]);
				}
				else if (this.rowNum < 18) {
					this.builder.levelElementsArray.push([gy, gx, "Coin"]);
				}
				else {
					this.builder.levelElementsArray.push([gy, gx, "CoinBubble"]);
				}
			}
			// add bubbles on the sides
			this.builder.levelElementsArray.push([gy, -40 * i, "CoinBubble"]);
			this.builder.levelElementsArray.push([gy, 40 * i, "CoinBubble"]);
			
			if (this.isOpeningUp) {
				numCoinsPerRow += 2;
			} else {
				numCoinsPerRow -= 2;
			}
			this.rowNum++;
			if (numCoinsPerRow < 1) {
				this.patternNum = -1;
			}
		}
	}
}