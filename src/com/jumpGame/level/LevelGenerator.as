package com.jumpGame.level {
	
	public class LevelGenerator {
		
		private var prevElementX:Number = 0;
		private var builder:LevelParser;
		
		public function LevelGenerator(builder:LevelParser) {
			this.builder = builder;
		}
		
		public function generate(type:uint):void {
			// distribution arrays
			var elementDistribution:Array;
			var elementsPerRowDistribution:Array;
			var sizeDistribution:Array;
			
			var height:int = 40; // height of block to generate
			
			switch(type) {
				// random generation
				case 700:
					this.generateDesigned2001();
					break;
				case 701:
					this.generateBeginnerRadiator();
					break;
				case 702:
					this.generateBeginnerHearts();
					break;
				
				case 800:
					// 1 per row, 2 per row, 3 per row, 4 per row, 5 per row
//					elementsPerRowDistribution = new Array(0.0, 1.0, 1.0, 1.0, 1.0);
					// normal, drop, mobile, normalboost, etc.
					elementDistribution = new Array(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
					// size 1, 2, 3, 4, 5
					sizeDistribution = new Array(0.0, 0.0, 0.0, 0.6, 1.0)
					this.generateRandom(height, false, elementDistribution, sizeDistribution, true);
					break;
				
				case 900: // beginner stars
					this.generateSineWave();
					break;
				case 901: // beginner stars
					this.generateDesigned2003();
					break;
				case 902: // designed pattern
					this.generateBeginnerSpinningCircles();
					break;
				case 903:
					this.generateStraightLine();
					break;
				
				case 1000: // 1 size 5 normal platform per row
					// normal, drop, mobile, normalboost, etc.
					elementDistribution = new Array(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
					// size 1, 2, 3, 4, 5
					sizeDistribution = new Array(0.0, 0.0, 0.2, 0.6, 1.0)
					this.generateRandom(height, false, elementDistribution, sizeDistribution, false);
					break;
				case 1001: // [1] size [4-5] [normal, drop] platforms per row
					elementDistribution = new Array(0.5, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
					sizeDistribution = new Array(0.0, 0.0, 0.0, 0.5, 1.0)
					this.generateRandom(height, false, elementDistribution, sizeDistribution, false);
					break;
				
				case 2000: // designed pattern
					this.generateDesigned2000();
					break;
				case 2001: // designed pattern
					this.generateDesigned2001();
					break;
				case 2002: // designed pattern
					this.generateSineWave();
					break;
				case 2003: // designed pattern
					this.generateDesigned2003();
					break;
				case 2004: // designed pattern
					this.generateBeginnerRadiator();
					break;
				case 2005: // designed pattern
					this.generateBeginnerHearts();
					break;
				case 2006: // designed pattern
					this.generateBeginnerSpinningCircles();
					break;
				
				case 3000: // [1] size [3-5] [normal, drop, mobile, normalboost, mobileboost]
					elementDistribution = new Array(0.3, 0.6, 0.9, 0.97, 0.97, 1.0, 1.0, 1.0);
					sizeDistribution = new Array(0.0, 0.0, 0.3, 1.0, 1.0)
					this.generateRandom(height, false, elementDistribution, sizeDistribution, false);
					break;
				case 3001: // [1] size [3-4] [normal, drop, mobile, normalboost, dropboost, mobileboost]
					elementDistribution = new Array(0.2, 0.5, 0.8, 0.9, 0.98, 1.0, 1.0, 1.0);
					sizeDistribution = new Array(0.0, 0.0, 0.5, 1.0, 1.0)
					this.generateRandom(height, false, elementDistribution, sizeDistribution, false);
					break;
				
				case 4000: // designed pattern
					this.generateDesigned4000();
					break;
				case 4001: // designed pattern
					this.generateEasySpinners();
					break;
				case 4002:
					this.generateAttractorsTwoColumns();
					break;
				case 4003:
					this.generateMovingStarsHorizontal();
					break;
				case 4004:
					this.generateStarsCircularMotion();
					break;
				
				case 5000: // [2] size [2-4] [normal, drop, mobile, normalboost, dropboost, mobileboost, power, super]
					elementDistribution = new Array(0.1, 0.4, 0.8, 0.85, 0.9, 0.95, 1.0, 1.0);
					sizeDistribution = new Array(0.0, 0.4, 0.8, 1.0, 1.0)
					this.generateRandom(height, false, elementDistribution, sizeDistribution, true);
					break;
				
				case 6000: // designed pattern
					this.generateDesigned2000(2);
					break;
				case 6001: // designed pattern
					this.generateEasySpinningCircles();
					break;
				case 6002:
					this.generateSinusoidal();
					break;
				case 6003:
					this.generateDesigned2000(8);
					break;
				
				case 7000:
					this.generateDesignedMobileReuplsor();
					break;
				case 7001:
					this.generateDesigned2000(3);
					break;
				
				case 8000:
					this.generateSineWave(2);
					break;
				case 8001:
					this.generateDesigned2000(4);
					break;
				case 8002:
					this.generateBouncerTwoColumns();
					break;
				case 8003:
					this.generateStarCrossLarge();
					break;
				case 8004:
					this.generateMickeyMouseLarge();
					break;
				
				case 9000: // [2] size [1-3] [normal, drop, mobile, normalboost, dropboost, mobileboost, power, super]
					elementDistribution = new Array(0.03, 0.35, 0.8, 0.83, 0.86, 0.9, 0.95, 1.0);
					sizeDistribution = new Array(0, 0.6, 1.0, 1.0, 1.0)
					this.generateRandom(height, false, elementDistribution, sizeDistribution, true);
					break;
				
				case 10000:
					this.generateDesigned2001(2);
					break;
				case 10001:
					this.generateDesigned2000(5);
					break;
				case 10002:
					this.generateStraightLine(2);
					break;
				case 10003:
					this.generateStarCrossLarge();
					break;
				case 10004:
					this.generateBeginnerSpinningCircles(2);
					break;
				
				case 11000: // [1] size [2-3] [normal, drop, mobile, normalboost, dropboost, mobileboost, power, super]
					elementDistribution = new Array(0.1, 0.4, 0.8, 0.85, 0.9, 0.95, 1.0, 1.0);
					sizeDistribution = new Array(0.0, 0.6, 1.0, 1.0, 1.0)
					this.generateRandom(height, false, elementDistribution, sizeDistribution, false);
					break;
				
				case 12000:
					this.generateDesigned2001(3);
					break;
				case 12001:
					this.generateStraightLine(3);
					break;
				case 12002:
					this.generateDesigned2000(6);
					break;
				case 12003:
					this.generateSineWave(3);
					break;
				
				case 13000:
					elementDistribution = new Array(0.1, 0.4, 0.8, 0.85, 0.9, 0.95, 1.0, 1.0);
					sizeDistribution = new Array(0.0, 0.6, 1.0, 1.0, 1.0)
					this.generateRandom(height, false, elementDistribution, sizeDistribution, false, 0.33, 0);
					break;
				
				case 14000:
					this.generateDesigned2000(7);
					break;
				case 14001:
					this.generateStarCrossLarge();
					break;
				case 14002:
					this.generateMickeyMouseSmall();
					break;
				
				case 15000:
					elementDistribution = new Array(0.1, 0.4, 0.8, 0.85, 0.9, 0.95, 1.0, 1.0);
					sizeDistribution = new Array(0.0, 0.6, 1.0, 1.0, 1.0)
					this.generateRandom(height, false, elementDistribution, sizeDistribution, false, 0, 0.5);
					break;
				
				case 16000:
					this.generateDesigned2000(9);
					break;
				case 16001:
					this.generateStarCrossLarge(2);
					break;
				case 16002:
					this.generateBarrels();
					break;
				case 16003:
					this.generateBouncers();
					break;
				
				case 17000:
					this.generateSingleRisingMobile();
					break;
				case 17001:
					this.generateSingleRisingMobile(3);
					break;
//				case 17002:
//					this.generateSingleRisingMobile(2);
//					break;
//				case 17003:
//					this.generateSingleRisingMobile(4);
//					break;
				
				case 18000:
					this.generateDesigned2000(10);
					break;
				case 18001:
					this.generateMovingStarsHorizontal(2);
					break;
				case 18002:
					this.generateStarCrossLarge(4);
					break;
				
				case 20000:
					this.generateDesigned2000(11);
					break;
				case 20001:
					this.generateStarCrossLarge(3);
					break;
				
				case 22000:
					this.generateStarCrossLarge(5);
					break;
				
//				case 13000: // [1] size [1-3] [normal, drop, mobile, normalboost, dropboost, mobileboost, power, super]
//					elementDistribution = new Array(0.03, 0.35, 0.5, 0.7, 0.86, 0.9, 0.95, 1.0);
//					sizeDistribution = new Array(0.3, 0.9, 1.0, 1.0, 1.0)
//					this.generateRandom(height, false, elementDistribution, sizeDistribution, false);
//					break;
					
				
				case 999999: // designed pattern
//					elementDistribution = new Array(0.1, 0.4, 0.7, 0.77, 0.84, 0.91, 0.98, 1.0);
//					this.generateBouncers();
//					elementDistribution = new Array(0.1, 0.4, 0.8, 0.85, 0.9, 0.95, 1.0, 1.0);
//					sizeDistribution = new Array(0.0, 0.6, 1.0, 1.0, 1.0)
//					this.generateRandom(height, false, elementDistribution, sizeDistribution, false, 0, 0.5);
					this.generateDesigned999999();
//					this.generateStarCrossLarge(4);
					break;
//					// 1 per row, 2 per row, 3 per row, 4 per row, 5 per row
//					elementsPerRowDistribution = new Array(1.0, 1.0, 1.0, 1.0, 1.0);
//					// normal, drop, mobile, normalboost, etc.
//					elementDistribution = new Array(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
//					// size 1, 2, 3, 4, 5
//					sizeDistribution = new Array(0.0, 0.0, 0.2, 0.6, 1.0)
//					this.generateRandom(height, false, elementDistribution, elementsPerRowDistribution, sizeDistribution);
//					break;
				
				case 999: // music mode
					elementDistribution = new Array(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0); // all normal platforms
					sizeDistribution = new Array(0.0, 0.0, 0.0, 1.0, 1.0) // all size 4
					this.generateRandom(height, true, elementDistribution, sizeDistribution, false);
					break;
			}
		}
		
		/**
		 * generate random segment according to specifications
		 * @param height the height of a block to generate
		 */
		private function generateRandom(height:int, isBonusMode:Boolean, elementDistribution:Array, 
										sizeDistribution:Array, twoPerRow:Boolean, chanceRepulsor:Number = 0, chanceStarDark:Number = 0):void {
			var gx:Number = 0;
			var gy:Number = 0;
			var roof:Number = this.builder.currentY + height;
			
			var elementsPerRow:uint = 1;
			if (twoPerRow) elementsPerRow = 2;
			
			while (this.builder.currentY < roof) { // one row of platforms
				for (var i:uint = 0; i < elementsPerRow; i++) { // loop through elements on the same row
					var border:Number = Constants.StageWidth / 15;
					if (elementsPerRow == 2 && i == 0) { // left element
						gx = Math.random() * (Constants.StageWidth / 2 - border * 2) - (Constants.StageWidth / 2 - border);
					}
					else if (elementsPerRow == 2 && i == 1) { // right element
						gx = Math.random() * (Constants.StageWidth / 2 - border * 2) + (border);
					}
					else gx = Math.random() * 400 - 200 + this.prevElementX; // do not place consecutive platforms too far apart
					// do not go off sides of screen
					if (gx < -Constants.StageWidth / 2 + 300) {
						this.prevElementX = -Constants.StageWidth / 2 + 300;
					}
					else if (gx > Constants.StageWidth / 2 - 300) {
						this.prevElementX = Constants.StageWidth / 2 - 300;
					}
					gy = this.builder.currentY * Constants.UnitHeight;
					
					var elementClass:String = this.getElementClassByDistribution(elementDistribution);
					var elementSize:int = 0;
					if ([Constants.PlatformNormal, Constants.PlatformDrop, Constants.PlatformMobile,
						Constants.PlatformNormalBoost, Constants.PlatformDropBoost, Constants.PlatformMobileBoost].indexOf(elementClass) != -1) {
						elementSize = this.getElementSizeByDistribution(sizeDistribution);
					}
					this.builder.levelElementsArray.push([gy, gx, elementClass, elementSize]);
				} // eof loop through elements on the same row
				
				// add coins
//				this.builder.levelElementsArray.push([this.builder.currentY * Constants.UnitHeight, Math.random() * 400 - 200, Constants.Coin]);
//				this.builder.currentY++;
//				this.builder.levelElementsArray.push([this.builder.currentY * Constants.UnitHeight, Math.random() * 400 - 200, Constants.Coin]);
//				this.builder.currentY++;
//				this.builder.levelElementsArray.push([this.builder.currentY * Constants.UnitHeight, Math.random() * 400 - 200, Constants.Coin]);
//				this.builder.currentY++;
				if (Math.random() < 0.33) { // add coins
					this.addCoins();
				}
				
				// repulsor/dark stars
				var prevElemGx:Number = gx;
				if (chanceRepulsor > 0 && Math.random() < chanceRepulsor) {
					gx = Math.random() * 600 - 300;
					while (Math.abs(gx - prevElemGx) < 100) gx = Math.random() * 600 - 300;
					if (chanceStarDark > 0) this.builder.levelElementsArray.push([(this.builder.currentY + 1) * Constants.UnitHeight, gx, "Repulsor"]);
					else this.builder.levelElementsArray.push([(this.builder.currentY + 2) * Constants.UnitHeight, gx, "Repulsor"]);
				}
				if (chanceStarDark > 0 && Math.random() < chanceStarDark) {
					gx = Math.random() * 600 - 300;
					while (Math.abs(gx - prevElemGx) < 100) gx = Math.random() * 600 - 300;
					this.builder.levelElementsArray.push([(this.builder.currentY + 2) * Constants.UnitHeight, gx, "StarDark"]);
				}
				
				this.builder.currentY += 3;
			} // eof one row
		} // eof generateRandom()
		
		// obtain a number of elements per row for random generation according to distribution
//		private function getNumElementsPerRowByDistribution(elementsPerRowDistribution:Array):uint {
//			var seed:Number = Math.random();
//			if (seed >= elementsPerRowDistribution[0] && seed < elementsPerRowDistribution[1]) {
//				return 2;
//			} 
//			else if (seed >= elementsPerRowDistribution[1] && seed < elementsPerRowDistribution[2]) {
//				return 3;
//			}
//			else if (seed >= elementsPerRowDistribution[2] && seed < elementsPerRowDistribution[3]) {
//				return 4;
//			}
//			else if (seed >= elementsPerRowDistribution[3] && seed < elementsPerRowDistribution[4]) {
//				return 5;
//			}
//			return 1;
//		}
		
		// obtain an element class for random generation according to distribution
		private function getElementClassByDistribution(elementDistribution:Array):String {
			var seed:Number = Math.random();
			if (seed >= elementDistribution[0] && seed < elementDistribution[1]) {
				return Constants.PlatformDrop;
			} 
			else if (seed >= elementDistribution[1] && seed < elementDistribution[2]) {
				return Constants.PlatformMobile;
			}
			else if (seed >= elementDistribution[2] && seed < elementDistribution[3]) {
				return Constants.PlatformNormalBoost;
			}
			else if (seed >= elementDistribution[3] && seed < elementDistribution[4]) {
				return Constants.PlatformDropBoost;
			}
			else if (seed >= elementDistribution[4] && seed < elementDistribution[5]) {
				return Constants.PlatformMobileBoost;
			}
			else if (seed >= elementDistribution[5] && seed < elementDistribution[6]) {
				return Constants.Bouncer;
			}
			else if (seed >= elementDistribution[6] && seed < elementDistribution[7]) {
				return Constants.PlatformSuper;
			}
			return Constants.PlatformNormal;
		}
		
		// obtain an element size for random generation according to distribution
		private function getElementSizeByDistribution(sizeDistribution:Array):int {
			var seed:Number = Math.random();
			if (seed >= sizeDistribution[0] && seed < sizeDistribution[1]) {
				return 2;
			} 
			else if (seed >= sizeDistribution[1] && seed < sizeDistribution[2]) {
				return 3;
			}
			else if (seed >= sizeDistribution[2] && seed < sizeDistribution[3]) {
				return 4;
			}
			else if (seed >= sizeDistribution[3] && seed < sizeDistribution[4]) {
				return 5;
			}
			return 1;
		}
		
		/********** Designed Patterns **********/
		
		// just one rising mobile platform
		private function generateSingleRisingMobile(difficulty:uint = 1):void {
			var gx:Number = 0;
			var gy:Number;
			for (var i:uint = 0; i < 20; i++) {
				gy = this.builder.currentY * Constants.UnitHeight;
				this.builder.levelElementsArray.push([gy, gx, "StarBlue"]);
				this.builder.currentY += 2;
			}
			if (difficulty < 3) {
				this.builder.levelElementsArray.push([gy, gx, "PlatformMobileBoost", 4, 0, 0.5]);
			}
			else {
				var separationX:Number = (Statics.stageWidth) / 12;
				for (i = 0; i < 12; i++) {
					gx = 35 + i * separationX - (Statics.stageWidth) / 2;
					this.builder.levelElementsArray.push([gy, gx, "PlatformDropBoost", 2, 0, 0.5]);
				}
				
			}
			this.builder.currentY += 8;
			var targetY:int = this.builder.currentY + 80;
			while(this.builder.currentY < targetY) {
				if (difficulty == 1 || difficulty == 4) {
					gx = Math.random() * 600 - 300;
					gy = this.builder.currentY * Constants.UnitHeight;
					this.builder.levelElementsArray.push([gy, gx, "StarDark"]);
					this.builder.currentY += 4;
				}
				else if (difficulty == 2 || difficulty == 3) {
					gx = Math.random() * 600 - 300;
					gy = (this.builder.currentY + 2) * Constants.UnitHeight;
					this.builder.levelElementsArray.push([gy, gx, "Repulsor"]);
					this.builder.currentY += 8;
				}
			}
		}
		
		// easy random stars
		private function generateDesigned2000(difficulty:uint = 1):void {
			var gx:Number;
			var gy:Number;
			var i:uint;
			if (difficulty == 9) { // add a row of red stars to make things easier
				var numElementsPerRow:uint = 6;
				for (i = 0;  i < numElementsPerRow; i++) { // loop through elements on the same row
					// get new gx and gy values for new element
					gx = (Constants.StageWidth / (numElementsPerRow + 1)) * (i + 1) - Constants.StageWidth / 2;
					gy = this.builder.currentY * Constants.UnitHeight;
					this.builder.levelElementsArray.push([gy, gx, "StarRed"]);
				} // eof loop through elements on the same row
			}
			
			var targetY:int = this.builder.currentY + 80;
			if (difficulty == 9 || difficulty == 11) targetY = this.builder.currentY + 120;
			while(this.builder.currentY < targetY) {
				gx = Math.random() * 600 - 300;
				gy = this.builder.currentY * Constants.UnitHeight;
				if (difficulty == 1) {
					this.builder.levelElementsArray.push([gy, gx, "Star"]);
					this.builder.currentY += 2;
				}
				else if (difficulty == 2) {
					this.builder.levelElementsArray.push([gy, gx, "StarBlue"]);
					gx = Math.random() * 600 - 300;
					for (i = 0; i < 3; i++) {
						gy = (this.builder.currentY + i) * Constants.UnitHeight;
						this.builder.levelElementsArray.push([gy, gx, "Coin"]);
					}
					if (Math.random() > 0.5) {
						gx = Math.random() * 600 - 300;
						gy = (this.builder.currentY + 1) * Constants.UnitHeight;
						this.builder.levelElementsArray.push([gy, gx, "Star", 0, 0, 0, 50]);
					}
					this.builder.currentY += 3;
				}
				else if (difficulty == 3) {
					gx = Math.random() * 600 - 300;
					this.builder.levelElementsArray.push([gy, gx, "Repulsor"]);
					gx = Math.random() * 600 - 300;
					this.builder.levelElementsArray.push([(this.builder.currentY + 1) * Constants.UnitHeight, gx, "Star"]);
					gx = Math.random() * 600 - 300;
					this.builder.levelElementsArray.push([(this.builder.currentY + 2) * Constants.UnitHeight, gx, "Star"]);
					gx = Math.random() * 600 - 300;
					this.builder.levelElementsArray.push([(this.builder.currentY + 3) * Constants.UnitHeight, gx, "Star"]);
					this.builder.currentY += 4;
				}
				else if (difficulty == 4) {
					if (this.builder.currentY % 16 == 0) {
						gx = Math.random() * 400 - 200;
						this.builder.levelElementsArray.push([gy, gx, "Attractor"]);
					} else {
						gx = Math.random() * 600 - 300;
						this.builder.levelElementsArray.push([this.builder.currentY * Constants.UnitHeight, gx, "Star"]);
					}
					this.builder.currentY++;
				}
				else if (difficulty == 5) {
					var randNum:Number = Math.random();
					if (this.builder.currentY % 8 == 0) {
						gx = Math.random() * 600 - 300;
						if (randNum < 0.33) this.builder.levelElementsArray.push([gy, gx, "Attractor"]);
						else if (randNum < 0.66) this.builder.levelElementsArray.push([gy, gx, "Repulsor"]);
						else this.builder.levelElementsArray.push([gy, gx, "StarDark"]);
					} else {
						gx = Math.random() * 600 - 300;
						if (randNum < 0.5) this.builder.levelElementsArray.push([this.builder.currentY * Constants.UnitHeight, gx, "Star"]);
						else this.builder.levelElementsArray.push([this.builder.currentY * Constants.UnitHeight, gx, "StarBlue"]);
					}
					this.builder.currentY++;
				}
				else if (difficulty == 6) {
					gx = Math.random() * 600 - 300;
					this.builder.levelElementsArray.push([gy, gx, "Repulsor"]);
					gx = Math.random() * 600 - 300;
					this.builder.levelElementsArray.push([gy, gx, "StarDark"]);
					gx = Math.random() * 600 - 300;
					this.builder.levelElementsArray.push([(this.builder.currentY + 1) * Constants.UnitHeight, gx, "Star"]);
					gx = Math.random() * 600 - 300;
					this.builder.levelElementsArray.push([(this.builder.currentY + 2) * Constants.UnitHeight, gx, "StarBlue"]);
					gx = Math.random() * 600 - 300;
					this.builder.levelElementsArray.push([(this.builder.currentY + 3) * Constants.UnitHeight, gx, "StarRed"]);
					this.builder.currentY += 4;
				}
				else if (difficulty == 7) {
					gx = Math.random() * 600 - 300;
					this.builder.levelElementsArray.push([gy, gx, "Repulsor"]);
					gx = Math.random() * 600 - 300;
					this.builder.levelElementsArray.push([gy, gx, "StarDark"]);
					gx = Math.random() * 600 - 300;
					this.builder.levelElementsArray.push([(this.builder.currentY + 1) * Constants.UnitHeight, gx, "StarBlue"]);
					gx = Math.random() * 600 - 300;
					gy = (this.builder.currentY + 2) * Constants.UnitHeight;
					this.builder.levelElementsArray.push([gy, gx, "Repulsor"]);
					
//					gx = Math.random() * 400 - 200;
					this.builder.levelElementsArray.push([gy, gx, "Star"]);
					this.builder.levelElementsArray.push([gy, gx, "Star", 0, 0, 0, 100, null, true]);
					this.builder.levelElementsArray.push([gy, gx, "Star", 0, 0, 0, 100, null, true, Math.PI]);
					
					gx = Math.random() * 600 - 300;
					this.builder.levelElementsArray.push([(this.builder.currentY + 3) * Constants.UnitHeight, gx, "StarRed"]);
					
					
					
					this.builder.currentY += 4;
				}
				else if (difficulty == 8) { // move up slow
					this.builder.levelElementsArray.push([gy, gx, "Star", 0, 0, 0.5]);
					gx = Math.random() * 600 - 300;
					gy = (this.builder.currentY + 1) * Constants.UnitHeight;
					this.builder.levelElementsArray.push([gy, gx, "Star"]);
					gx = Math.random() * 600 - 300;
					gy = (this.builder.currentY + 2) * Constants.UnitHeight;
					this.builder.levelElementsArray.push([gy, gx, "Coin", 0, 0, 0.7]);
					this.builder.currentY += 3;
				}
				else if (difficulty == 9) { // move up fast
					if (Math.random() > 0.5) {
						this.builder.levelElementsArray.push([gy, gx, "StarRed", 0, 0, 0.8]);
					}
					gx = Math.random() * 600 - 300;
					gy = (this.builder.currentY + 1) * Constants.UnitHeight;
					this.builder.levelElementsArray.push([gy, gx, "StarBlue", 0, 0, 0.5]);
					gx = Math.random() * 600 - 300;
					gy = (this.builder.currentY + 1) * Constants.UnitHeight;
					this.builder.levelElementsArray.push([gy, gx, "Coin", 0, 0, 1.0]);
					gx = Math.random() * 600 - 300;
					gy = (this.builder.currentY + 2) * Constants.UnitHeight;
					this.builder.levelElementsArray.push([gy, gx, "Coin", 0, 0, 1.0]);
					this.builder.currentY += 3;
				}
				else if (difficulty == 10) { // move down medium
					this.builder.levelElementsArray.push([gy, gx, "StarBlue"]);
					gx = Math.random() * 600 - 300;
					gy = (this.builder.currentY) * Constants.UnitHeight;
					this.builder.levelElementsArray.push([gy, gx, "Star", 0, 0, -1]);
					gx = Math.random() * 600 - 300;
					gy = (this.builder.currentY + 1) * Constants.UnitHeight;
					this.builder.levelElementsArray.push([gy, gx, "Star", 0, 0, -1]);
					if (Math.random() > 0.7) {
						gx = Math.random() * 600 - 300;
						gy = (this.builder.currentY + 1) * Constants.UnitHeight;
						this.builder.levelElementsArray.push([gy, gx, "StarDark", 0, 0, -1]);
					}
					if (Math.random() > 0.8) {
						gx = Math.random() * 600 - 300;
						gy = (this.builder.currentY + 2) * Constants.UnitHeight;
						this.builder.levelElementsArray.push([gy, gx, "Repulsor"]);
					}
					gx = Math.random() * 600 - 300;
					gy = (this.builder.currentY + 1) * Constants.UnitHeight;
					this.builder.levelElementsArray.push([gy, gx, "Coin", 0, 0, -0.5]);
					gx = Math.random() * 600 - 300;
					gy = (this.builder.currentY + 2) * Constants.UnitHeight;
					this.builder.levelElementsArray.push([gy, gx, "Coin", 0, 0, -0.5]);
					this.builder.currentY += 2;
				}
				else if (difficulty == 11) { // move down hard
					this.builder.levelElementsArray.push([gy, gx, "StarBlue"]);
					gx = Math.random() * 600 - 300;
					gy = (this.builder.currentY) * Constants.UnitHeight;
					this.builder.levelElementsArray.push([gy, gx, "StarRed", 0, 0, -1]);
					if (Math.random() > 0.7) {
						gx = Math.random() * 600 - 300;
						gy = (this.builder.currentY + 2) * Constants.UnitHeight;
						this.builder.levelElementsArray.push([gy, gx, "Repulsor"]);
					}
					if (this.builder.currentY % 12 == 0) {
						gx = Math.random() * 600 - 300;
						gy = (this.builder.currentY + 2) * Constants.UnitHeight;
						this.builder.levelElementsArray.push([gy, gx, "Attractor"]);
					}
					gx = Math.random() * 600 - 300;
					gy = (this.builder.currentY + 1) * Constants.UnitHeight;
					this.builder.levelElementsArray.push([gy, gx, "Coin", 0, 0, -0.5]);
					gx = Math.random() * 600 - 300;
					gy = (this.builder.currentY + 2) * Constants.UnitHeight;
					this.builder.levelElementsArray.push([gy, gx, "Coin", 0, 0, -0.5]);
					this.builder.currentY += 2;
				}
			}
		}
		
		private function generateMickeyMouseSmall():void {
			var gx:Number;
			var gy:Number;
			var targetY:int = this.builder.currentY + 40;
			while(this.builder.currentY < targetY) {
				gx = Math.random() * 600 - 300;
				gy = this.builder.currentY * Constants.UnitHeight;
				this.builder.levelElementsArray.push([gy, gx, "Repulsor"]);
				gx -= 75;
				gy = (this.builder.currentY + 1) * Constants.UnitHeight;
				this.builder.levelElementsArray.push([gy, gx, "StarBlue"]);
				gx += 150;
				this.builder.levelElementsArray.push([gy, gx, "StarBlue"]);
				this.builder.currentY += 4;
				
				gx = Math.random() * 600 - 300;
				gy = this.builder.currentY * Constants.UnitHeight;
				this.builder.levelElementsArray.push([gy, gx, "Bouncer"]);
				this.builder.levelElementsArray.push([gy, gx, "Star", 0, 0, 0, 75, null, true, 0]);
				this.builder.levelElementsArray.push([gy, gx, "Star", 0, 0, 0, 75, null, true, Math.PI / 2]);
				this.builder.currentY += 4;
			}
		}
		
		// easy stars in rectangular shape
		private function generateDesigned2001(difficulty:uint = 1):void {
			var gx:Number;
			var gy:Number;
			var prevType:uint = 0;
			for (var ri:uint = 0; ri < 8; ri++) {
				var numElementsPerRow:int = 6;
				gy = this.builder.currentY * Constants.UnitHeight;
				for (var i:uint = 0;  i < numElementsPerRow; i++) { // loop through elements on the same row
					// get new gx and gy values for new element
					if (prevType == 0)
						gx = (Constants.StageWidth / (numElementsPerRow + 1)) * (i + 1) - Constants.StageWidth / 2;
					else {
						if (i == numElementsPerRow - 1) break;
						gx = (Constants.StageWidth / (numElementsPerRow + 1)) * (i + 1.5) - Constants.StageWidth / 2;
					}
					
					if (difficulty == 1) {
						this.builder.levelElementsArray.push([gy, gx, "Star"]);
					}
					else if (difficulty == 2) {
						if (Math.random() > 0.8) this.builder.levelElementsArray.push([gy, gx, "Repulsor"]);
						else this.builder.levelElementsArray.push([gy, gx, "Star", 0]);
					}
					else if (difficulty == 3) {
						if (Math.random() > 0.8) this.builder.levelElementsArray.push([gy, gx, "StarDark"]);
						else this.builder.levelElementsArray.push([gy, gx, "Star", 0]);
					}
				} // eof loop through elements on the same row
				
				// add repulsor
//				if (difficulty > 1) {
//					gx = Math.random() * 600 - 300;
//					this.builder.levelElementsArray.push([gy, gx, "Repulsor", 0]);
//				}
				
				this.builder.currentY += 2;
				prevType = 1 - prevType;
			}
			this.builder.currentY += 4;
		}
		
		private function generateAttractorsTwoColumns():void {
			var targetY:int = this.builder.currentY + 60;
			while(this.builder.currentY < targetY) {
				if (this.builder.currentY % 16 == 0) {
					// left column
					this.builder.levelElementsArray.push([this.builder.currentY * Constants.UnitHeight, -250, "Attractor"]);
				}
				else if (this.builder.currentY % 16 == 8) {
					// right column
					this.builder.levelElementsArray.push([this.builder.currentY * Constants.UnitHeight, 250, "Attractor"]);
				}
				// middle column of stars
				this.builder.levelElementsArray.push([this.builder.currentY * Constants.UnitHeight, 0, "StarBlue"]);
				this.builder.currentY++;
			}
		}
		
		private function generateBouncerTwoColumns():void {
			var targetY:int = this.builder.currentY + 60;
			while(this.builder.currentY < targetY) {
				if (this.builder.currentY % 8 == 0) {
					// left column
					this.builder.levelElementsArray.push([this.builder.currentY * Constants.UnitHeight, -150, "Bouncer"]);
				}
				else if (this.builder.currentY % 8 == 4) {
					// right column
					this.builder.levelElementsArray.push([this.builder.currentY * Constants.UnitHeight, 150, "Bouncer"]);
				}
				// middle column of stars
				this.builder.levelElementsArray.push([this.builder.currentY * Constants.UnitHeight, 0, "Coin"]);
				this.builder.currentY++;
			}
		}
		
		// easy stars following a sine wave
		// difficulty 2 has a column of repulsors in the center
		private function generateSineWave(difficulty:uint = 1):void {
			var gx:Number = 0;
			var gy:Number = 0;
			for (var ri:uint = 0; ri < 80; ri++) { // loop through rows
				var numElementsPerRow:int = 2;
				gy = this.builder.currentY * Constants.UnitHeight;
				for (var i:uint = 0;  i < numElementsPerRow; i++) { // loop through elements on the same row
					// get new gx and gy values for new element
					gx = ((Constants.StageWidth - 100) / 2) * Math.sin(this.builder.currentY / 8) + (i - 0.5) * 100;
					
					if (difficulty == 1) {
						this.builder.levelElementsArray.push([gy, gx, "Star", 0]);
					} else {
						this.builder.levelElementsArray.push([gy, gx, "StarBlue", 0]);
					}
				} // eof loop through elements on the same row
				
				// add repulsor
				if (difficulty == 2 && ri % 3 == 0) this.builder.levelElementsArray.push([gy, 0, "Repulsor", 0]);
				else if (difficulty == 3) {
					if (ri % 8 == 4) this.builder.levelElementsArray.push([gy, 0, "Repulsor", 0]);
					if (ri % 8 == 0) this.builder.levelElementsArray.push([gy, 0, "Attractor", 0]);
				}
				
				// add coin
				this.builder.currentY ++;
				this.builder.levelElementsArray.push([this.builder.currentY * Constants.UnitHeight, ((Constants.StageWidth - 100) / 2) * Math.sin(this.builder.currentY / 8), Constants.Coin]); // coin
				this.builder.currentY ++;
			}
			// two blue stars at the end
			gy = this.builder.currentY * Constants.UnitHeight;
			gx = ((Constants.StageWidth - 100) / 2) * Math.sin(this.builder.currentY / 8) + (-0.5) * 100;
			this.builder.levelElementsArray.push([gy, gx, "StarBlue", 0]);
			gx = ((Constants.StageWidth - 100) / 2) * Math.sin(this.builder.currentY / 8) + (0.5) * 100;
			this.builder.levelElementsArray.push([gy, gx, "StarBlue", 0]);
			
			this.builder.currentY += 4;
		}
		
		// easy two random curved lines of stars
		private function generateDesigned2003(difficulty:uint = 1):void {
			var gx:Number = 0;
			var gy:Number = 0;
			var prevGx1:Number = 0;
			var prevGx2:Number = 0;
			for (var ri:uint = 0; ri < 80; ri++) {
				var numElementsPerRow:int = 2;
				// line 1
				gx = Math.random() * 100 - 50 + prevGx1;
				if (gx > Constants.StageWidth / 2 - 50) gx = Constants.StageWidth / 2 - 50;
				else if (gx < -Constants.StageWidth / 2 + 50) gx = -Constants.StageWidth / 2 + 50;
				prevGx1 = gx;
				gy = this.builder.currentY * Constants.UnitHeight;
				this.builder.levelElementsArray.push([gy, gx, "Star"]);
				// line 2
				gx = Math.random() * 100 - 50 + prevGx2;
				if (gx > Constants.StageWidth / 2 - 50) gx = Constants.StageWidth / 2 - 50;
				else if (gx < -Constants.StageWidth / 2 + 50) gx = -Constants.StageWidth / 2 + 50;
				prevGx2 = gx;
				gy = this.builder.currentY * Constants.UnitHeight;
				this.builder.levelElementsArray.push([gy, gx, "Star"]);
				this.builder.currentY += 2;
			}
			this.builder.currentY += 4;
		}
		
		// easy big radiating star with four layers
		// NOTE: (TODO) this can be optimized by replacing location calculations with precalculated literal values
		private function generateBeginnerRadiator():void {
			var r:Number;; // radius
			var angle:Number = Math.PI / 4;
			var i:uint;
			var gx:Number;
			var gy:Number;
			
			for (var ii:uint = 0; ii < 10; ii++) { // number of patterns to create
				
				// pattern center
				gx = Math.random() * 400 - 200;
				gy = this.builder.currentY * Constants.UnitHeight;
				r = Constants.ElementSpacing;
				
				var patternArray:Array = new Array();
				
				// inner circle
				for (i = 0; i < 4; i++) {
					patternArray.push([gy + r * Math.sin(angle), gx + r * Math.cos(angle), "Star"]);
					angle += Math.PI / 2;
				}
				
				// middle circle
				r = Constants.ElementSpacing * 2;
				angle = 0;
				for (i = 0; i < 8; i++) {
					patternArray.push([gy + r * Math.sin(angle), gx + r * Math.cos(angle), "Star"]);
					angle += Math.PI / 4;
				}
				
				// outer circle
				r = Constants.ElementSpacing * 3;
				angle = 0;
				for (i = 0; i < 8; i++) {
					patternArray.push([gy + r * Math.sin(angle), gx + r * Math.cos(angle), "StarMini"]);
					angle += Math.PI / 4;
				}
				
				// outermost circle of coins
				r = Constants.ElementSpacing * 4;
				angle = 0;
				for (i = 0; i < 8; i++) {
					patternArray.push([gy + r * Math.sin(angle), gx + r * Math.cos(angle), "Coin"]);
					angle += Math.PI / 4;
				}
				
				patternArray.sort(sortOnElementGy);
				this.builder.levelElementsArray = this.builder.levelElementsArray.concat(patternArray);
				this.builder.currentY += 8;
			} // eof loop through patterns
		}
		
		public function addRowRedStars():void {
			var numElementsPerRow:uint = 6;
			var gx:Number;
			var gy:Number = this.builder.currentY * Constants.UnitHeight;
			for (var i:uint = 0;  i < numElementsPerRow; i++) { // loop through elements on the same row
				// get new gx and gy values for new element
				gx = (Constants.StageWidth / (numElementsPerRow + 1)) * (i + 1) - Constants.StageWidth / 2;
				this.builder.levelElementsArray.push([gy, gx, "StarRed"]);
			} // eof loop through elements on the same row
			
			this.builder.currentY += 8;
		}
		
		public function addRowBlueStars():void {
			var numElementsPerRow:uint = 6;
			var gx:Number;
			var gy:Number = this.builder.currentY * Constants.UnitHeight;
			for (var i:uint = 0;  i < numElementsPerRow; i++) { // loop through elements on the same row
				// get new gx and gy values for new element
				gx = (Constants.StageWidth / (numElementsPerRow + 1)) * (i + 1) - Constants.StageWidth / 2;
				this.builder.levelElementsArray.push([gy, gx, "StarBlue"]);
			} // eof loop through elements on the same row
			
			this.builder.currentY += 6;
		}
		
		private function addCoins():void {
			if (Math.random() > 0) { // add two rows of coins
				for (var ri:uint = 0; ri < 2; ri++) {
					var numElementsPerRow:uint = 8;
					for (var i:uint = 0;  i < numElementsPerRow; i++) { // loop through elements on the same row
						// get new gx and gy values for new element
						var gx:Number = (Constants.StageWidth / (numElementsPerRow + 1)) * (i + 1) - Constants.StageWidth / 2;
						var gy:Number = (this.builder.currentY + 1 + ri) * Constants.UnitHeight;
						this.builder.levelElementsArray.push([gy, gx, "Coin"]);
					} // eof loop through elements on the same row
				}
			}
		}
		
		// this function accompanies patterns that are based on a math function and require sorting
		private function sortOnElementGy(a:Array, b:Array):Number {
			var aGy:Number = a[0];
			var bGy:Number = b[0];
			
			if(aGy > bGy) {
				return 1;
			} else if(aGy < bGy) {
				return -1;
			} else  {
				return 0;
			}
		}
		
		// easy fixed heart shaped stars
		private function generateBeginnerHearts():void {
			var gx:Number;
			var gy:Number; 
			var t:Number; // time factor, used in calculating heart shapes
			
			var fx:Number;
			var fy:Number;
			
			for (var i:uint = 0; i < 8; i++) { // number of hearts to create
				gx = Math.random() * 400 - 200;
				gy = this.builder.currentY * Constants.UnitHeight;
				t = 0;
				
				var patternArray:Array = new Array();
				for (var ri:uint = 0; ri < 15; ri++) {
					t += Math.PI / 8;
					// get new gx and gy values for new element
					fx = (16 * Math.sin(t) * Math.sin(t) * Math.sin(t)) * 10;
					fy = (13 * Math.cos(t) - 5 * Math.cos(2 * t) - 2 * Math.cos(3 * t) - Math.cos(4 * t)) * 10;
					patternArray.push([gy + fy, gx + fx, "Star", 0]);
				}
				// coins
//				patternArray.push([(this.builder.currentY - 2) * Constants.UnitHeight, gx - 250, Constants.Coin]); // coin
//				patternArray.push([(this.builder.currentY - 2) * Constants.UnitHeight, gx + 250, Constants.Coin]); // coin
//				patternArray.push([this.builder.currentY * Constants.UnitHeight, gx - 250, Constants.Coin]); // coin
//				patternArray.push([this.builder.currentY * Constants.UnitHeight, gx + 250, Constants.Coin]); // coin
//				patternArray.push([(this.builder.currentY + 2) * Constants.UnitHeight, gx - 250, Constants.Coin]); // coin
//				patternArray.push([(this.builder.currentY + 2) * Constants.UnitHeight, gx + 250, Constants.Coin]); // coin
				
				patternArray.sort(sortOnElementGy);
				this.builder.levelElementsArray = this.builder.levelElementsArray.concat(patternArray);
				this.builder.currentY += 8;
			}
		}
		
		// two sinusoidal lines of stars
		private function generateDesigned2006():void {
			var gx:Number = 0;
			var gy:Number = 0;
			for (var ri:uint = 0; ri < 80; ri++) {
				var numElementsPerRow:int = 2;
				
				// left line
				// get new gx and gy values for new element
				var sinVal:Number = Math.sin(this.builder.currentY / 8);
				gx = ((Constants.StageWidth) / 4) * sinVal;
				gy = this.builder.currentY * Constants.UnitHeight;
				this.builder.levelElementsArray.push([gy, gx, "StarBlue", 0]);
				
				// right line
				// get new gx and gy values for new element
				gx *= -1;
				gy = this.builder.currentY * Constants.UnitHeight;
				this.builder.levelElementsArray.push([gy, gx, "Star", 0]);
				
				
				this.builder.currentY ++;
				this.builder.levelElementsArray.push([this.builder.currentY * Constants.UnitHeight, ((Constants.StageWidth - 100) / 2) * Math.sin(this.builder.currentY / 8), Constants.Coin]); // coin
				this.builder.currentY ++;
			}
			this.builder.currentY += 4;
		}
		
		// medium difficulty single short lines
		private function generateDesigned4000():void {
			for (var i:uint = 0; i < 10; i++) {
				var gx:Number = Math.random() * 600 - 300;
				var gy:Number = this.builder.currentY * Constants.UnitHeight;
				
				for (var ri:uint = 0; ri < 8; ri++) {
					this.builder.levelElementsArray.push([gy, gx, "Star", 0]);
					gy += 60;
				}
				
				this.builder.currentY += 8;
			}
			
			
			this.builder.currentY += 4;
		}
		
		// five tiny moving platforms per row
//		private function generateDesigned6000():void {
//			var gx:Number = 0;
//			var gy:Number = 0;
//			
//			var numElementsPerRow:int = 5;
//			for (var i:uint = 0;  i < numElementsPerRow; i++) { // loop through elements on the same row
//				// get new gx and gy values for new element
//				gx = (Constants.StageWidth / (numElementsPerRow + 1)) * (i + 1) - Constants.StageWidth / 2
//				gy = this.builder.currentY * Constants.UnitHeight;
//				this.builder.levelElementsArray.push([gy, gx, "PlatformMobile", 1]);
//			} // eof loop through elements on the same row
//			
//			this.builder.currentY += 2;
//		}
		
		// hard: two mobiles and one repulsor per row; 8 rows
		private function generateDesignedMobileReuplsor():void {
			var gx:Number = 0;
			var gy:Number = 0;
			for (var ri:uint = 0; ri < 8; ri++) { // loop through rows
				
				gx = -250;
				gy = this.builder.currentY * Constants.UnitHeight;
				this.builder.levelElementsArray.push([gy, gx, "PlatformMobileBoost", 4]);
				
				gx = 250;
				gy = this.builder.currentY * Constants.UnitHeight;
				this.builder.levelElementsArray.push([gy, gx, "PlatformMobileBoost", 4]);
				
				gx = Math.random() * 400 - 200
				gy = this.builder.currentY * Constants.UnitHeight;
				this.builder.levelElementsArray.push([gy, gx, "Repulsor", 0]);
				
				// coins
				this.builder.levelElementsArray.push([this.builder.currentY * Constants.UnitHeight, Math.random() * 400 - 200, Constants.Coin]);
				this.builder.currentY++;
				this.builder.levelElementsArray.push([this.builder.currentY * Constants.UnitHeight, Math.random() * 400 - 200, Constants.Coin]);
				this.builder.currentY++;
				this.builder.levelElementsArray.push([this.builder.currentY * Constants.UnitHeight, Math.random() * 400 - 200, Constants.Coin]);
				this.builder.currentY++;
			}
			
			// a row of blue stars
			var numElementsPerRow:uint = 6;
			for (var i:uint = 0;  i < numElementsPerRow; i++) { // loop through elements on the same row
				// get new gx and gy values for new element
				gx = (Constants.StageWidth / (numElementsPerRow + 1)) * (i + 1) - Constants.StageWidth / 2;
				gy = this.builder.currentY * Constants.UnitHeight;
				this.builder.levelElementsArray.push([gy, gx, "StarBlue", 0]);
			} // eof loop through elements on the same row
			
			this.builder.currentY += 4;
		}
		
		// medium size circles
		private function generateBeginnerSpinningCircles(difficulty:uint = 1):void { //
			var gx:Number = 0;
			var gy:Number;
			var j:uint;
			for (var i:uint = 0; i < 10; i++) { // loop through rows of spinners
				gx = Math.random() * 400 - 200;
				gy = this.builder.currentY * Constants.UnitHeight;
				
				if (difficulty == 1) {
					for (j = 0; j < 8; j++) {
						this.builder.levelElementsArray.push([gy, gx, "Star", 0, 0, 0, 200, 2 * Math.PI / 180, true, Math.PI * j / 4]);
					}
					this.builder.currentY += 8;
				}
				else if (difficulty == 2) {
					for (j = 0; j < 8; j++) {
						this.builder.levelElementsArray.push([gy, gx, "Star", 0, 0, 0, 200, 2 * Math.PI / 180, true, Math.PI * j / 4]);
					}
					for (j = 0; j < 6; j++) {
						this.builder.levelElementsArray.push([gy, gx, "StarBlue", 0, 0, 0, 120, 2 * Math.PI / 180, false, Math.PI * j / 3]);
					}
					this.builder.levelElementsArray.push([gy, gx, "Attractor"]);
					
					this.builder.currentY += 5;
					gx = Math.random() * 400 - 200;
					gy = this.builder.currentY * Constants.UnitHeight;
					for (j = 0; j < 6; j++) {
						this.builder.levelElementsArray.push([gy, gx, "StarBlue", 0, 0, 0, 120, 2 * Math.PI / 180, false, Math.PI * j / 3]);
					}
					this.builder.levelElementsArray.push([gy, gx, "Repulsor"]);
					
					this.builder.currentY += 5;
				}
			}
		}
		
		private function generateMickeyMouseLarge():void {
			var gx:Number = 0;
			var gy:Number;
			
			for (var i:uint = 0; i < 10; i++) { // loop through rows
				gx = Math.random() * 400 - 200;
				gy = this.builder.currentY * Constants.UnitHeight;
				
				// face
				this.builder.levelElementsArray.push([gy, gx, "Star", 0, 0, 0, 150, 2 * Math.PI / 180, true]);
				this.builder.levelElementsArray.push([gy, gx, "Star", 0, 0, 0, 150, 2 * Math.PI / 180, true, Math.PI / 3]);
				this.builder.levelElementsArray.push([gy, gx, "Star", 0, 0, 0, 150, 2 * Math.PI / 180, true, Math.PI * 2 / 3]);
				this.builder.levelElementsArray.push([gy, gx, "Star", 0, 0, 0, 150, 2 * Math.PI / 180, true, Math.PI]);
				this.builder.levelElementsArray.push([gy, gx, "Star", 0, 0, 0, 150, 2 * Math.PI / 180, true, Math.PI * 4 / 3]);
				this.builder.levelElementsArray.push([gy, gx, "Star", 0, 0, 0, 150, 2 * Math.PI / 180, true, Math.PI * 5 / 3]);

				// eyes
				gy = (this.builder.currentY + 0.5) * Constants.UnitHeight;
				gx -= 50;
				this.builder.levelElementsArray.push([gy, gx, "StarBlue"]);
				gx += 100;
				this.builder.levelElementsArray.push([gy, gx, "StarBlue"]);
				gx -= 50;
				
				gy = (this.builder.currentY - 0.5) * Constants.UnitHeight;
				this.builder.levelElementsArray.push([gy, gx, "PlatformDropBoost", 3]);
				
				// ears
				gy = (this.builder.currentY + 2.5) * Constants.UnitHeight;
				gx -= 170;
				this.builder.levelElementsArray.push([gy, gx, "Repulsor"]);
				gx += 340;
				this.builder.levelElementsArray.push([gy, gx, "Repulsor"]);

				this.builder.currentY += 8;
			}
		}
			
		// tiny circles
		private function generateEasySpinningCircles():void { //
			var gx:Number = 0;
			var gy:Number;
			
			for (var i:uint = 0; i < 10; i++) { // loop through rows of spinners
				gx = Math.random() * 400 - 200;
				gy = this.builder.currentY * Constants.UnitHeight;
				
				if (gx < 0) {
					this.builder.levelElementsArray.push([gy, gx, "Star", 0, 0, 0, 100, null, true]);
					this.builder.levelElementsArray.push([gy, gx, "Star", 0, 0, 0, 100, null, true, Math.PI / 2]);
					this.builder.levelElementsArray.push([gy, gx, "Star", 0, 0, 0, 100, null, true, Math.PI]);
					this.builder.levelElementsArray.push([gy, gx, "Star", 0, 0, 0, 100, null, true, Math.PI * 3 / 2]);
				} else {
					this.builder.levelElementsArray.push([gy, gx, "Star", 0, 0, 0, 100, null, false]);
					this.builder.levelElementsArray.push([gy, gx, "Star", 0, 0, 0, 100, null, false, Math.PI / 2]);
					this.builder.levelElementsArray.push([gy, gx, "Star", 0, 0, 0, 100, null, false, Math.PI]);
					this.builder.levelElementsArray.push([gy, gx, "Star", 0, 0, 0, 100, null, false, Math.PI * 3 / 2]);
				}
				
				if (Math.random() < 0.33) { // coins
					gx = Math.random() * 400 - 200;
					gy = (this.builder.currentY + 3) * Constants.UnitHeight;
					this.builder.levelElementsArray.push([gy, gx, "Coin", 0, 0, 0, 100, null, false]);
					this.builder.levelElementsArray.push([gy, gx, "Coin", 0, 0, 0, 100, null, false, Math.PI / 2]);
					this.builder.levelElementsArray.push([gy, gx, "Coin", 0, 0, 0, 100, null, false, Math.PI]);
					this.builder.levelElementsArray.push([gy, gx, "Coin", 0, 0, 0, 100, null, false, Math.PI * 3 / 2]);
				}
				this.builder.currentY += 6;
			}
		}
		
		private function generateStarsCircularMotion():void {
			var gx:Number = 0;
			var gy:Number;
			
			for (var i:uint = 0; i < 10; i++) { // loop through rows of spinners
				gx = Math.random() * 400 - 200;
				gy = this.builder.currentY * Constants.UnitHeight;

				this.builder.levelElementsArray.push([gy, gx, "Star", 0, 0, 0, 120, (Math.random() * 2 + 1) * Math.PI / 180, true]);
				this.builder.levelElementsArray.push([gy, gx, "Star", 0, 0, 0, 240, (Math.random() * 2 + 1) * Math.PI / 180, true]);
				this.builder.levelElementsArray.push([gy, gx, "Star", 0, 0, 0, 360, (Math.random() * 2 + 1) * Math.PI / 180, true]);
				this.builder.levelElementsArray.push([gy, gx, "Star", 0, 0, 0, 480, (Math.random() * 2 + 1) * Math.PI / 180, true]);

				this.builder.levelElementsArray.push([gy, gx, "Star", 0, 0, 0, 120, (Math.random() * 2 + 1) * Math.PI / 180, false, Math.PI]);
				this.builder.levelElementsArray.push([gy, gx, "Star", 0, 0, 0, 240, (Math.random() * 2 + 1) * Math.PI / 180, false, Math.PI]);
				this.builder.levelElementsArray.push([gy, gx, "Star", 0, 0, 0, 360, (Math.random() * 2 + 1) * Math.PI / 180, false, Math.PI]);
				this.builder.levelElementsArray.push([gy, gx, "Star", 0, 0, 0, 480, (Math.random() * 2 + 1) * Math.PI / 180, false, Math.PI]);

//				if (Math.random() < 0.33) { // coins
//					gx = Math.random() * 400 - 200;
//					gy = (this.builder.currentY + 3) * Constants.UnitHeight;
//					this.builder.levelElementsArray.push([gy, gx, "Coin", 0, 0, 0, 100, null, false]);
//					this.builder.levelElementsArray.push([gy, gx, "Coin", 0, 0, 0, 100, null, false, Math.PI / 2]);
//					this.builder.levelElementsArray.push([gy, gx, "Coin", 0, 0, 0, 100, null, false, Math.PI]);
//					this.builder.levelElementsArray.push([gy, gx, "Coin", 0, 0, 0, 100, null, false, Math.PI * 3 / 2]);
//				}
				this.builder.currentY += 5;
			}
		}
		
		private function generateEasySpinners():void { // 5 stars in a line spinner
			var gx:Number = 0;
			var gy:Number;
			
			for (var i:uint = 0; i < 10; i++) { // loop through rows of spinners
				gx = Math.random() * 400 - 200;
				gy = this.builder.currentY * Constants.UnitHeight;
				
				if (gx < 0) {
					this.builder.levelElementsArray.push([gy, gx, "Star"]);
					this.builder.levelElementsArray.push([gy, gx, "Star", 0, 0, 0, 100, null, true]);
					this.builder.levelElementsArray.push([gy, gx, "Star", 0, 0, 0, 200, null, true]);
					this.builder.levelElementsArray.push([gy, gx, "Star", 0, 0, 0, 100, null, true, Math.PI]);
					this.builder.levelElementsArray.push([gy, gx, "Star", 0, 0, 0, 200, null, true, Math.PI]);
				} else {
					this.builder.levelElementsArray.push([gy, gx, "Star"]);
					this.builder.levelElementsArray.push([gy, gx, "Star", 0, 0, 0, 100, null, false]);
					this.builder.levelElementsArray.push([gy, gx, "Star", 0, 0, 0, 200, null, false]);
					this.builder.levelElementsArray.push([gy, gx, "Star", 0, 0, 0, 100, null, false, Math.PI]);
					this.builder.levelElementsArray.push([gy, gx, "Star", 0, 0, 0, 200, null, false, Math.PI]);
				}
				this.builder.currentY += 6;
			}
		}
		
		private function generateStraightLine(difficulty:uint = 1):void { // straight line upward
			var gx:Number = Math.random() * 600 - 300;
			var gy:Number;
			var targetY:int = this.builder.currentY + 60;
			while(this.builder.currentY < targetY) {
				gy = this.builder.currentY * Constants.UnitHeight;
				if (difficulty == 1) { // two straight lines at the left and right edges
					this.builder.levelElementsArray.push([gy, -300, "Star"]);
					this.builder.levelElementsArray.push([gy, 300, "Star"]);
					this.builder.levelElementsArray.push([gy, 0, "Coin"]);
				}
				else if (difficulty == 2) {
					// left column
					if (Math.random() < 0.1) this.builder.levelElementsArray.push([gy, gx - 50, "Repulsor"]);
					else if (Math.random() > 0.9) this.builder.levelElementsArray.push([gy, gx - 50, "StarDark"]);
					else this.builder.levelElementsArray.push([gy, gx - 50, "Star"]);
					// right column
					if (Math.random() < 0.1) this.builder.levelElementsArray.push([gy, gx + 50, "Repulsor"]);
					else if (Math.random() > 0.9) this.builder.levelElementsArray.push([gy, gx + 50, "StarDark"]);
					else this.builder.levelElementsArray.push([gy, gx + 50, "Star"]);
				}
				else if (difficulty == 3) {
					// left column
					if (Math.random() < 0.2) this.builder.levelElementsArray.push([gy, gx - 50, "Repulsor"]);
					else if (Math.random() > 0.85) this.builder.levelElementsArray.push([gy, gx - 50, "StarDark"]);
					else this.builder.levelElementsArray.push([gy, gx - 50, "Star"]);
					// right column
					if (Math.random() < 0.2) this.builder.levelElementsArray.push([gy, gx + 50, "Repulsor"]);
					else if (Math.random() > 0.85) this.builder.levelElementsArray.push([gy, gx + 50, "StarDark"]);
					else this.builder.levelElementsArray.push([gy, gx + 50, "Star"]);
					// attractor
					if (this.builder.currentY % 15 == 0) {
						var attractorX:Number = Math.random() * 400 - 200;
						this.builder.levelElementsArray.push([(this.builder.currentY + 1) * Constants.UnitHeight, attractorX, "Attractor"]);
					}
				}
				this.builder.currentY += 2;
			}
			gy = this.builder.currentY * Constants.UnitHeight;
			if (difficulty == 1) {
				this.builder.levelElementsArray.push([gy, -300, "StarBlue"]);
				this.builder.levelElementsArray.push([gy, 300, "StarBlue"]);
			}
			else if (difficulty == 2 || difficulty == 3) {
				this.builder.levelElementsArray.push([gy, gx - 50, "StarBlue"]);
				this.builder.levelElementsArray.push([gy, gx + 50, "StarBlue"]);
			}
			this.builder.currentY += 2;
		}
		
		// very large spinning cross
		private function generateStarCrossLarge(difficulty:uint = 1):void {
			var gx:Number = Math.random() * 600 - 300;
			var gy:Number = this.builder.currentY * Constants.UnitHeight;
			var j:uint;
			var k:uint;
			
			this.builder.levelElementsArray.push([gy, gx, "Repulsor"]); // repulsor
			if (difficulty == 1) {
				for (j = 0; j < 4; j++) {
					for (k = 1; k < 5; k++) {
						this.builder.levelElementsArray.push([gy, gx, "Star", 0, 0, 0, k * 100, null, true, Math.PI * j / 2]);
					}
				}
			}
			else if (difficulty == 2) {
				for (j = 0; j < 4; j++) {
					for (k = 1; k < 7; k++) {
						if (j % 2 == 0) this.builder.levelElementsArray.push([gy, gx, "StarBlue", 0, 0, 0, k * 100, null, true, Math.PI * j / 2]);
						else this.builder.levelElementsArray.push([gy, gx, "StarDark", 0, 0, 0, k * 100, null, true, Math.PI * j / 2]);
					}
				}
			}
			else if (difficulty == 3) {
				for (j = 0; j < 4; j++) {
					for (k = 1; k < 7; k++) {
						if (k < 2) {
							if (j % 2 == 0) this.builder.levelElementsArray.push([gy, gx, "StarRed", 0, 0, 0, k * 100, null, true, Math.PI * j / 2]);
						} else {
							if (j % 2 == 0) this.builder.levelElementsArray.push([gy, gx, "StarBlue", 0, 0, 0, k * 100, null, true, Math.PI * j / 2]);
							else this.builder.levelElementsArray.push([gy, gx, "StarDark", 0, 0, 0, k * 100, null, false, Math.PI * j / 2]);
						}
					}
				}
			}
			else if (difficulty == 4) {
				for (j = 0; j < 4; j++) {
					for (k = 1; k < 7; k++) {
						if (k % 2 == 1) this.builder.levelElementsArray.push([gy, gx, "StarBlue", 0, 0, 0, k * 100, (7 - k) * Math.PI / 180, false, Math.PI * j / 2]);
						else this.builder.levelElementsArray.push([gy, gx, "Star", 0, 0, 0, k * 100, (7 - k) * Math.PI / 180, false, Math.PI * j / 2]);
					}
				}
			}
			else if (difficulty == 5) {
				for (j = 0; j < 2; j++) {
					for (k = 1; k < 6; k++) {
						if (k % 2 == 1) this.builder.levelElementsArray.push([gy, gx, "StarRed", 0, 0, 0, k * 100, (7 - k) * Math.PI / 180, false, Math.PI * j]);
						else this.builder.levelElementsArray.push([gy, gx, "StarBlue", 0, 0, 0, k * 100, (7 - k) * Math.PI / 180, false, Math.PI * j]);
					}
				}
			}
			
			for (var i:uint = 0; i < 4; i++) { // obstacles
				gx = Math.random() * 600 - 300;
				gy = (this.builder.currentY + i + 1) * Constants.UnitHeight;
				this.builder.levelElementsArray.push([gy, gx, "StarDark"]);
			}
			
			if (difficulty == 2 || difficulty == 4) {
				// add attractor
				gx = Math.random() * 600 - 300;
				gy = (this.builder.currentY + 6) * Constants.UnitHeight;
				this.builder.levelElementsArray.push([gy, gx, "Attractor"]);
			}
			else if (difficulty == 3 || difficulty == 5) {
				// add repulsors
				gx = Math.random() * 600 - 300;
				gy = (this.builder.currentY + 3) * Constants.UnitHeight;
				this.builder.levelElementsArray.push([gy, gx, "Repulsor"]);
				gx = Math.random() * 600 - 300;
				gy = (this.builder.currentY + 6) * Constants.UnitHeight;
				this.builder.levelElementsArray.push([gy, gx, "Repulsor"]);
			}
			this.builder.currentY += 8;
		}
		
		// two sinusoidal lines of rotating stars
		private function generateSinusoidal():void { // test revolving stars
			var gx:Number = 0;
			var gy:Number = 0;
			
			for (var ri:uint = 0; ri < 80; ri++) {
				
				// left line
				// get new gx and gy values for new element
				var sinVal:Number = Math.sin(this.builder.currentY / 8);
				gx = ((Constants.StageWidth) / 4) * sinVal;
				gy = this.builder.currentY * Constants.UnitHeight;
				this.builder.levelElementsArray.push([gy, gx, "Star", 0, 0, 0, 100]);
				
				// right line
				// get new gx and gy values for new element
				gx *= -1;
				gy = this.builder.currentY * Constants.UnitHeight;
				this.builder.levelElementsArray.push([gy, gx, "Star", 0, 0, 0, 100, null, false, 0]);
				
				this.builder.currentY ++;
				this.builder.levelElementsArray.push([this.builder.currentY * Constants.UnitHeight, ((Constants.StageWidth - 100) / 2) * Math.sin(this.builder.currentY / 8), Constants.Coin]); // coin
				this.builder.currentY ++;
			}
			this.builder.currentY += 4;
		}
		
		private function generateMovingStarsHorizontal(difficulty:uint = 1):void {
			var gx:Number;
			var gy:Number;
			var targetY:int;
			if (difficulty == 1) targetY = this.builder.currentY + 80;
			else targetY = this.builder.currentY + 160;
			var iterations:uint = 0;
			while(this.builder.currentY < targetY) {
				if (difficulty == 1) {
					gx = -700;
					gy = this.builder.currentY * Constants.UnitHeight;
					this.builder.levelElementsArray.push([gy, gx, "Star", 0, 1]);
					gx = -500;
					this.builder.levelElementsArray.push([gy, gx, "StarBlue", 0, 1]);
					gx = -300;
					this.builder.levelElementsArray.push([gy, gx, "Star", 0, 1]);
					gx = -100;
					this.builder.levelElementsArray.push([gy, gx, "StarBlue", 0, 1]);
					gx = 700;
					gy = (this.builder.currentY + 2) * Constants.UnitHeight;
					this.builder.levelElementsArray.push([gy, gx, "Star", 0, -1]);
					gx = 500;
					this.builder.levelElementsArray.push([gy, gx, "StarBlue", 0, -1]);
					gx = 300;
					this.builder.levelElementsArray.push([gy, gx, "Star", 0, -1]);
					gx = 100;
					this.builder.levelElementsArray.push([gy, gx, "StarBlue", 0, -1]);
					this.builder.currentY += 4;
				}
				else if (difficulty == 2) {
					gx = -700;
					gy = this.builder.currentY * Constants.UnitHeight;
					this.addStarBlueDark(gy, gx, 1);
					gx = -500;
					this.addStarBlueDark(gy, gx, 1);
					gx = -300;
					this.addStarBlueDark(gy, gx, 1);
					gx = -100;
					this.addStarBlueDark(gy, gx, 1);
					gx = 700;
					gy = (this.builder.currentY + 2) * Constants.UnitHeight;
					this.addStarBlueDark(gy, gx, -1);
					gx = 500;
					this.addStarBlueDark(gy, gx, -1);
					gx = 300;
					this.addStarBlueDark(gy, gx, -1);
					gx = 100;
					this.addStarBlueDark(gy, gx, -1);
					// repulsors
					gx = Math.random() * 600 - 300;
					this.builder.levelElementsArray.push([gy, gx, "Repulsor"]);
					if (iterations % 5 == 0) { // row of rising stars
						var numElementsPerRow:uint = 6;
						for (var i:uint = 0;  i < numElementsPerRow; i++) { // loop through elements on the same row
							// get new gx and gy values for new element
							gx = (Constants.StageWidth / (numElementsPerRow + 1)) * (i + 1) - Constants.StageWidth / 2;
							this.builder.levelElementsArray.push([gy, gx, "StarRed", 0, 0, 1]);
						} // eof loop through elements on the same row
					}
					this.builder.currentY += 4;
				}
				iterations++;
			}
		}
		
		private function addStarBlueDark(gy, gx, velocityX:Number):void {
			if (Math.random() > 0.7) this.builder.levelElementsArray.push([gy, gx, "StarDark", 0, velocityX]);
			else this.builder.levelElementsArray.push([gy, gx, "StarBlue", 0, velocityX]);
		}
		
		/** all barrels and attractors */
		private function generateBarrels():void {
			var gx:Number;
			var gy:Number;
			var targetY:int = this.builder.currentY + 60;
			while(this.builder.currentY < targetY) {
				gx = Math.random() * 600 - 300
				gy = this.builder.currentY * Constants.UnitHeight;
				this.builder.levelElementsArray.push([gy, gx, "PlatformSuper"]);
				
				if (Math.random() < 0.33) {
					gx = Math.random() * 600 - 300
					gy = (this.builder.currentY + 2) * Constants.UnitHeight;
					this.builder.levelElementsArray.push([gy, gx, "Attractor"]);
				}
				
				this.builder.currentY += 4;
			}
		}
		
		/** all bouncers */
		private function generateBouncers():void {
			var gx:Number;
			var gy:Number;
			var targetY:int = this.builder.currentY + 60;
			while(this.builder.currentY < targetY) {
				gx = Math.random() * 600 - 300
				gy = this.builder.currentY * Constants.UnitHeight;
				this.builder.levelElementsArray.push([gy, gx, "Bouncer"]);
				
				if (Math.random() < 0.33) {
					gx = Math.random() * 600 - 300
					gy = (this.builder.currentY + 2) * Constants.UnitHeight;
					this.builder.levelElementsArray.push([gy, gx, "Star", 0, 0, 0.5]);
				}
				
				this.builder.currentY += 4;
			}
		}
		
		// DESIGNER TOOL
		private function generateDesigned999998():void { // test comets
			var gx:Number = 0;
			var gy:Number = 0;
			
			for (var ri:uint = 0; ri < 80; ri++) {
				
				// left line
				// get new gx and gy values for new element
				var sinVal:Number = Math.sin(this.builder.currentY / 8);
				gx = ((Constants.StageWidth) / 4) * sinVal;
				gy = this.builder.currentY * Constants.UnitHeight;
				this.builder.levelElementsArray.push([gy, gx, "Star", 0]);
				
				// right line
				// get new gx and gy values for new element
				gx *= -1;
				gy = this.builder.currentY * Constants.UnitHeight;
				this.builder.levelElementsArray.push([gy, gx, "Star", 0]);
				
				gx = 300;
				gy = this.builder.currentY * Constants.UnitHeight;
				this.builder.levelElementsArray.push([gy, gx, "Comet", 0]);
					
					
				this.builder.currentY ++;
				this.builder.levelElementsArray.push([this.builder.currentY * Constants.UnitHeight, ((Constants.StageWidth - 100) / 2) * Math.sin(this.builder.currentY / 8), Constants.Coin]); // coin
				this.builder.currentY ++;
			}
			this.builder.currentY += 4;
		}
		
		// DESIGNER TOOL
		private function generateDesigned999999():void { // test attractors
			var gx:Number = 0;
			var gy:Number = 0;
			
			for (var ri:uint = 0; ri < 80; ri++) {
				gx = 200;
				gy = this.builder.currentY * Constants.UnitHeight;
				this.builder.levelElementsArray.push([gy, gx, "PlatformNormal", 4]);
				
				if (Math.random() < 0) {
					gx = Math.random() * 600 - 300;
					gy = this.builder.currentY * Constants.UnitHeight;
					this.builder.levelElementsArray.push([gy, gx, "Attractor", 4]);
				}
				
				this.builder.currentY += 3;
			}
			this.builder.currentY += 4;
		}
	}
}