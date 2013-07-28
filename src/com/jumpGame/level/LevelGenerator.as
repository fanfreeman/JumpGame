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
			
			var height:int = 60; // height of block to generate
			
			switch(type) {
				// random generation
				case 1000: // 1 size 5 normal platform per row
					// 1 per row, 2 per row, 3 per row, 4 per row, 5 per row
					elementsPerRowDistribution = new Array(1.0, 1.0, 1.0, 1.0, 1.0);
					// normal, drop, mobile, normalboost, etc.
					elementDistribution = new Array(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
					// size 1, 2, 3, 4, 5
					sizeDistribution = new Array(0.0, 0.0, 0.2, 0.6, 1.0)
					this.generateRandom(height, false, elementDistribution, elementsPerRowDistribution, sizeDistribution);
					break;
				case 1001: // [1] size [4-5] [normal, drop] platforms per row
					elementsPerRowDistribution = new Array(1.0, 1.0, 1.0, 1.0, 1.0);
					elementDistribution = new Array(0.5, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
					sizeDistribution = new Array(0.0, 0.0, 0.0, 0.5, 1.0)
					this.generateRandom(height, false, elementDistribution, elementsPerRowDistribution, sizeDistribution);
					break;
				
				case 2000: // designed pattern
					this.generateDesigned2000();
					break;
				case 2001: // designed pattern
					this.generateDesigned2001();
					break;
				case 2002: // designed pattern
					this.generateDesigned2002();
					break;
				case 2003: // designed pattern
					this.generateDesigned2003();
					break;
				case 2004: // designed pattern
					this.generateDesigned2004();
					break;
				case 2005: // designed pattern
					this.generateDesigned2005();
					break;
				
				case 3000: // [1] size [3-5] [normal, drop, mobile, normalboost, mobileboost]
					elementsPerRowDistribution = new Array(1.0, 1.0, 1.0, 1.0, 1.0);
					elementDistribution = new Array(0.3, 0.6, 0.9, 0.97, 0.97, 1.0, 1.0, 1.0);
					sizeDistribution = new Array(0.0, 0.0, 0.3, 1.0, 1.0)
					this.generateRandom(height, false, elementDistribution, elementsPerRowDistribution, sizeDistribution);
					break;
				case 3001: // [1] size [3-4] [normal, drop, mobile, normalboost, dropboost, mobileboost]
					elementsPerRowDistribution = new Array(1.0, 1.0, 1.0, 1.0, 1.0);
					elementDistribution = new Array(0.2, 0.5, 0.8, 0.9, 0.98, 1.0, 1.0, 1.0);
					sizeDistribution = new Array(0.0, 0.0, 0.5, 1.0, 1.0)
					this.generateRandom(height, false, elementDistribution, elementsPerRowDistribution, sizeDistribution);
					break;
				
				case 4000: // designed pattern
					this.generateDesigned4000();
					break;
				
				
				case 5000: // [1] size [2-4] [normal, drop, mobile, normalboost, dropboost, mobileboost, power, super]
					elementsPerRowDistribution = new Array(1.0, 1.0, 1.0, 1.0, 1.0);
					elementDistribution = new Array(0.1, 0.4, 0.8, 0.85, 0.9, 0.95, 1.0, 1.0);
					sizeDistribution = new Array(0.0, 0.4, 0.8, 1.0, 1.0)
					this.generateRandom(height, false, elementDistribution, elementsPerRowDistribution, sizeDistribution);
					break;
				
				case 6000: // designed pattern
					this.generateDesigned6000();
					break;
				
				case 7000: // [1] size [1-3] [normal, drop, mobile, normalboost, dropboost, mobileboost, power, super]
					elementsPerRowDistribution = new Array(1.0, 1.0, 1.0, 1.0, 1.0);
					elementDistribution = new Array(0.03, 0.35, 0.8, 0.83, 0.86, 0.9, 0.95, 1.0);
					sizeDistribution = new Array(0.4, 0.9, 1.0, 1.0, 1.0)
					this.generateRandom(height, false, elementDistribution, elementsPerRowDistribution, sizeDistribution);
					break;
				
				case 999999: // designed pattern
//					this.generateDesigned9000();
//					break;
					// 1 per row, 2 per row, 3 per row, 4 per row, 5 per row
					elementsPerRowDistribution = new Array(1.0, 1.0, 1.0, 1.0, 1.0);
					// normal, drop, mobile, normalboost, etc.
					elementDistribution = new Array(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
					// size 1, 2, 3, 4, 5
					sizeDistribution = new Array(0.0, 0.0, 0.2, 0.6, 1.0)
					this.generateRandom(height, false, elementDistribution, elementsPerRowDistribution, sizeDistribution);
					break;
				
				case 999: // music mode
					elementsPerRowDistribution = new Array(1.0, 1.0, 1.0, 1.0, 1.0); // 1 per row
					elementDistribution = new Array(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0); // all normal platforms
					sizeDistribution = new Array(0.0, 0.0, 0.0, 1.0, 1.0) // all size 4
					this.generateRandom(height, true, elementDistribution, elementsPerRowDistribution, sizeDistribution);
					break;
			}
		}
		
		/**
		 * generate random segment according to specifications
		 * @param height the height of a block to generate
		 */
		private function generateRandom(height:int, isBonusMode:Boolean, elementDistribution:Array,
										elementsPerRowDistribution:Array, sizeDistribution:Array):void {
			var gx:Number = 0;
			var gy:Number = 0;
			var roof:Number = this.builder.currentY + height;
			
			while (this.builder.currentY < roof) { // one row
				var numElementsPerRow:uint = this.getNumElementsPerRowByDistribution(elementsPerRowDistribution);
				for (var i:uint = 0;  i < numElementsPerRow; i++) { // loop through elements on the same row
					// get new gx and gy values for new element
					if (isBonusMode) {
						if (Math.random() < 0.5) { // place next platform toward left
							gx = this.prevElementX - Constants.MusicModeColumnSpacing;
						} else { // place next platfrom toward right
							gx = this.prevElementX + Constants.MusicModeColumnSpacing;
						}
						this.prevElementX = gx;
					} else {
						gx = Math.random() * 400 - 200 + this.prevElementX; // do not place consecutive platforms too far apart
						// do not go off sides of screen
						if (gx < -Constants.StageWidth / 2 + 300) {
							this.prevElementX = -Constants.StageWidth / 2 + 300;
						}
						else if (gx > Constants.StageWidth / 2 - 300) {
							this.prevElementX = Constants.StageWidth / 2 - 300;
						}
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
				this.builder.levelElementsArray.push([this.builder.currentY * Constants.UnitHeight, Math.random() * 400 - 200, Constants.Coin]);
				this.builder.currentY++;
				
				this.builder.levelElementsArray.push([this.builder.currentY * Constants.UnitHeight, Math.random() * 400 - 200, Constants.Coin]);
				this.builder.currentY++;
				
				this.builder.levelElementsArray.push([this.builder.currentY * Constants.UnitHeight, Math.random() * 400 - 200, Constants.Coin]);
				this.builder.currentY++;
			} // eof one row
		} // eof generateRandom()
		
		// obtain a number of elements per row for random generation according to distribution
		private function getNumElementsPerRowByDistribution(elementsPerRowDistribution:Array):uint {
			var seed:Number = Math.random();
			if (seed >= elementsPerRowDistribution[0] && seed < elementsPerRowDistribution[1]) {
				return 2;
			} 
			else if (seed >= elementsPerRowDistribution[1] && seed < elementsPerRowDistribution[2]) {
				return 3;
			}
			else if (seed >= elementsPerRowDistribution[2] && seed < elementsPerRowDistribution[3]) {
				return 4;
			}
			else if (seed >= elementsPerRowDistribution[3] && seed < elementsPerRowDistribution[4]) {
				return 5;
			}
			return 1;
		}
		
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
				return Constants.PlatformPower;
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
		
		// easy random stars
		private function generateDesigned2000():void {
			for (var ri:uint = 0; ri < 80; ri++) {
				var gx:Number = Math.random() * 600 - 300;
				var gy:Number = this.builder.currentY * Constants.UnitHeight;
				this.builder.levelElementsArray.push([gy, gx, "Star", 0]);
				this.builder.currentY+=2;
			}
			
			this.builder.currentY += 4;
		}
		
		// easy stars in rectangular shape
		private function generateDesigned2001():void {
			var gx:Number = 0;
			var gy:Number = 0;
			var prevType:uint = 0;
			for (var ri:uint = 0; ri < 8; ri++) {
				var numElementsPerRow:int = 6;
				for (var i:uint = 0;  i < numElementsPerRow; i++) { // loop through elements on the same row
					// get new gx and gy values for new element
					if (prevType == 0)
						gx = (Constants.StageWidth / (numElementsPerRow + 1)) * (i + 1) - Constants.StageWidth / 2;
					else {
						if (i == numElementsPerRow - 1) break;
						gx = (Constants.StageWidth / (numElementsPerRow + 1)) * (i + 1.5) - Constants.StageWidth / 2;
					}
					
					gy = this.builder.currentY * Constants.UnitHeight;
					this.builder.levelElementsArray.push([gy, gx, "Star", 0]);
				} // eof loop through elements on the same row
				
				this.builder.currentY += 2;
				prevType = 1 - prevType;
			}
			this.builder.currentY += 4;
		}
		
		// easy stars following a sine wave
		private function generateDesigned2002():void {
			var gx:Number = 0;
			var gy:Number = 0;
			for (var ri:uint = 0; ri < 80; ri++) {
				var numElementsPerRow:int = 2;
				for (var i:uint = 0;  i < numElementsPerRow; i++) { // loop through elements on the same row
					// get new gx and gy values for new element
					gx = ((Constants.StageWidth - 100) / 2) * Math.sin(this.builder.currentY / 8) + (i - 0.5) * 100;
					gy = this.builder.currentY * Constants.UnitHeight;
					this.builder.levelElementsArray.push([gy, gx, "Star", 0]);
				} // eof loop through elements on the same row
				this.builder.currentY ++;
				this.builder.levelElementsArray.push([this.builder.currentY * Constants.UnitHeight, ((Constants.StageWidth - 100) / 2) * Math.sin(this.builder.currentY / 8), Constants.Coin]); // coin
				this.builder.currentY ++;
			}
			this.builder.currentY += 4;
		}
		
		// easy two random lines of stars
		private function generateDesigned2003():void {
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
				this.builder.levelElementsArray.push([gy, gx, "Star", 0]);
				// line 2
				gx = Math.random() * 100 - 50 + prevGx2;
				if (gx > Constants.StageWidth / 2 - 50) gx = Constants.StageWidth / 2 - 50;
				else if (gx < -Constants.StageWidth / 2 + 50) gx = -Constants.StageWidth / 2 + 50;
				prevGx2 = gx;
				gy = this.builder.currentY * Constants.UnitHeight;
				this.builder.levelElementsArray.push([gy, gx, "Star", 0]);
				this.builder.currentY ++;
				//this.builder.levelElementsArray.push([this.builder.currentY * Constants.UnitHeight, ((Constants.StageWidth - 100) / 2) * Math.sin(this.builder.currentY / 8), Constants.Coin]); // coin
				this.builder.currentY ++;
			}
			this.builder.currentY += 4;
		}
		
		// easy big radiating star with four layers
		// NOTE: (TODO) this can be optimized by replacing location calculations with precalculated literal values
		private function generateDesigned2004():void {
			// pattern center
			var gx:Number = Math.random() * 400 - 200;
			var gy:Number = this.builder.currentY * Constants.UnitHeight;
			
			var r:Number = Constants.ElementSpacing; // radius
			var angle:Number = Math.PI / 4;
			var i:uint;
			
			var patternArray:Array = new Array();
			
			// inner circle
			for (i = 0; i < 4; i++) {
				patternArray.push([gy + r * Math.sin(angle), gx + r * Math.cos(angle), "Star", 0]);
				angle += Math.PI / 2;
			}
			
			// middle circle
			r = Constants.ElementSpacing * 2;
			angle = 0;
			for (i = 0; i < 8; i++) {
				patternArray.push([gy + r * Math.sin(angle), gx + r * Math.cos(angle), "Star", 0]);
				angle += Math.PI / 4;
			}
			
			// outer circle
			r = Constants.ElementSpacing * 3;
			angle = 0;
			for (i = 0; i < 8; i++) {
				patternArray.push([gy + r * Math.sin(angle), gx + r * Math.cos(angle), "StarMini", 0]);
				angle += Math.PI / 4;
			}
			
			// outermost circle of coins
			r = Constants.ElementSpacing * 4;
			angle = 0;
			for (i = 0; i < 8; i++) {
				patternArray.push([gy + r * Math.sin(angle), gx + r * Math.cos(angle), "Coin", 0]);
				angle += Math.PI / 4;
			}
			
			patternArray.sort(sortOnElementGy);
			this.builder.levelElementsArray = this.builder.levelElementsArray.concat(patternArray);
			this.builder.currentY += 4;
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
		private function generateDesigned2005():void {
			var gx:Number;
			var gy:Number; 
			var t:Number; // time factor, used in calculating heart shapes
			
			var fx:Number;
			var fy:Number;
			
			for (var i:uint = 0; i < 10; i++) { // number of hearts to create
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
				patternArray.push([(this.builder.currentY - 2) * Constants.UnitHeight, gx - 250, Constants.Coin]); // coin
				patternArray.push([(this.builder.currentY - 2) * Constants.UnitHeight, gx + 250, Constants.Coin]); // coin
				patternArray.push([this.builder.currentY * Constants.UnitHeight, gx - 250, Constants.Coin]); // coin
				patternArray.push([this.builder.currentY * Constants.UnitHeight, gx + 250, Constants.Coin]); // coin
				patternArray.push([(this.builder.currentY + 2) * Constants.UnitHeight, gx - 250, Constants.Coin]); // coin
				patternArray.push([(this.builder.currentY + 2) * Constants.UnitHeight, gx + 250, Constants.Coin]); // coin
				
				
				patternArray.sort(sortOnElementGy);
				this.builder.levelElementsArray = this.builder.levelElementsArray.concat(patternArray);
				this.builder.currentY += 8;
			}
			
			// a row of blue stars
			var numElementsPerRow:int = 6;
			for (i = 0;  i < numElementsPerRow; i++) { // loop through elements on the same row
				// get new gx and gy values for new element
				gx = (Constants.StageWidth / (numElementsPerRow + 1)) * (i + 1) - Constants.StageWidth / 2;
				gy = this.builder.currentY * Constants.UnitHeight;
				this.builder.levelElementsArray.push([gy, gx, "StarBlue", 0]);
			} // eof loop through elements on the same row
			
			this.builder.currentY += 8;
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
		private function generateDesigned6000():void {
			var gx:Number = 0;
			var gy:Number = 0;
			
			var numElementsPerRow:int = 5;
			for (var i:uint = 0;  i < numElementsPerRow; i++) { // loop through elements on the same row
				// get new gx and gy values for new element
				gx = (Constants.StageWidth / (numElementsPerRow + 1)) * (i + 1) - Constants.StageWidth / 2
				gy = this.builder.currentY * Constants.UnitHeight;
				this.builder.levelElementsArray.push([gy, gx, "PlatformMobile", 1]);
			} // eof loop through elements on the same row
			
			this.builder.currentY += 2;
		}
		
		// hard: two mobiles and one repulsor per row; 8 rows
		private function generateDesigned9000():void { // test repulsor fields
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
		private function generateDesigned999999():void { // test repulsors
			var gx:Number = 0;
			var gy:Number = 0;
			
			for (var ri:uint = 0; ri < 80; ri++) {
				gx = 200;
				gy = this.builder.currentY * Constants.UnitHeight;
				this.builder.levelElementsArray.push([gy, gx, "PlatformNormal", 4]);
				
				gx = -200;
				gy = this.builder.currentY * Constants.UnitHeight;
				this.builder.levelElementsArray.push([gy, gx, "Repulsor", 0]);
				
				this.builder.currentY += 3;
			}
			this.builder.currentY += 4;
		}
	}
}