package com.jumpGame.level {
	public class LevelGenerator {
		// designed patterns constants
		public static const Dots3PerRow100RowSpace:uint = 10000;
		// other constants
		private static const ScreenBorder = 100; // the sum of the left and right screen borders
		private static const SeparationWidth:uint = 60; // minimum x distance between the centers of rainbows
		private static const SeparationHeight:uint = 30; // minimum y distance between the centers of rainbows
		
		private var level:LevelParser;
		
		public function LevelGenerator(level:LevelParser, type:uint, yMin:int, yMax:int, unitHeight:Number) {
			this.level = level;
			var elementDistribution:Array;
			var elementsPerRowDistribution:Array;
			var sizeDistribution:Array;
			switch(type) {
				// random generation
				case 1: // 1 size 5 normal platform per row
					// 1 per row, 2 per row, 3 per row, 4 per row, 5 per row
					elementsPerRowDistribution = new Array(1.0, 1.0, 1.0, 1.0, 1.0);
					// normal, drop, mobile, trampoline, power trampoline, cannon, power cannon
					elementDistribution = new Array(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
					// size 1, 2, 3, 4, 5
					sizeDistribution = new Array(0.0, 0.0, 0.0, 0.5, 1.0)
					this.generateRandom(yMin, yMax, unitHeight, false, true, elementDistribution, elementsPerRowDistribution, sizeDistribution);
					break;
				case 2: // [1] size [4-5] [normal, drop] platforms per row
					elementsPerRowDistribution = new Array(1.0, 1.0, 1.0, 1.0, 1.0);
					elementDistribution = new Array(0.5, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
					sizeDistribution = new Array(0.0, 0.0, 0.0, 0.5, 1.0)
					this.generateRandom(yMin, yMax, unitHeight, false, true, elementDistribution, elementsPerRowDistribution, sizeDistribution);
					break;
				case 3: // [1] size [3-5] [normal, drop, mobile, trampoline]
					elementsPerRowDistribution = new Array(1.0, 1.0, 1.0, 1.0, 1.0);
					elementDistribution = new Array(0.3, 0.6, 0.9, 1.0, 1.0, 1.0, 1.0);
					sizeDistribution = new Array(0.0, 0.0, 0.3, 1.0, 1.0)
					this.generateRandom(yMin, yMax, unitHeight, false, true, elementDistribution, elementsPerRowDistribution, sizeDistribution);
					break;
				case 4: // [1] size [3-4] [normal, drop, mobile, trampoline, power trampoline, cannon]
					elementsPerRowDistribution = new Array(1.0, 1.0, 1.0, 1.0, 1.0);
					elementDistribution = new Array(0.2, 0.5, 0.8, 0.9, 0.98, 1.0, 1.0);
					sizeDistribution = new Array(0.0, 0.0, 0.5, 1.0, 1.0)
					this.generateRandom(yMin, yMax, unitHeight, false, true, elementDistribution, elementsPerRowDistribution, sizeDistribution);
					break;
				case 5: // [1] size [2-4] [normal, drop, mobile, trampoline, power trampoline, cannon]
					elementsPerRowDistribution = new Array(1.0, 1.0, 1.0, 1.0, 1.0);
					elementDistribution = new Array(0.1, 0.4, 0.8, 0.9, 0.98, 1.0, 1.0);
					sizeDistribution = new Array(0.0, 0.4, 0.8, 1.0, 1.0)
					this.generateRandom(yMin, yMax, unitHeight, false, true, elementDistribution, elementsPerRowDistribution, sizeDistribution);
					break;
				case 6: // [1] size [1-3] [normal, drop, mobile, trampoline, power trampoline, cannon]
					elementsPerRowDistribution = new Array(1.0, 1.0, 1.0, 1.0, 1.0);
					elementDistribution = new Array(0.1, 0.4, 0.85, 0.95, 0.98, 1.0, 1.0);
					sizeDistribution = new Array(0.4, 0.9, 1.0, 1.0, 1.0)
					this.generateRandom(yMin, yMax, unitHeight, false, true, elementDistribution, elementsPerRowDistribution, sizeDistribution);
					break;
				
				// designed patterns
				case Dots3PerRow100RowSpace:
					this.generateDots3PerRow100RowSpace(yMin, yMax, unitHeight);
					break;
				default:
					break;
			}
		}
		
		// generate random segment according to specifications
		private function generateRandom(yMin:Number, yMax:Number, unitHeight:Number, yVariation:Boolean,
										xVariation:Boolean, elementDistribution:Array,
										elementsPerRowDistribution:Array, sizeDistribution:Array) {
			var x:Number = 0;
			var y:Number = 0;
			var rowHeight:Number = unitHeight * 3;
			var currentY:Number = yMin * unitHeight;
			var overlap:Boolean; // whether the current coords overlaps an existing platform
			
			while (currentY <= yMax * unitHeight) {
				var numElementsPerRow:uint = this.getNumElementsPerRowByDistribution(elementsPerRowDistribution);
				for (var i:uint = 0;  i < numElementsPerRow; i++) {
					do {
						overlap = false;
						if (xVariation) {
							x = Math.random() * (Constants.StageWidth - ScreenBorder)
								- (Constants.StageWidth - ScreenBorder) / 2;
						} else {
							x = (Constants.StageWidth / (numElementsPerRow + 1)) * (i + 1) - Constants.StageWidth / 2;
						}
						
						if (yVariation) {
							y = Math.random() * rowHeight - rowHeight + currentY;
						} else {
							y = currentY;
						}
						// prevent creation of rainbow in existing rainbow location
//						for each (var element:GameObject in this.level.rgo.rainbowList) {
//							if (Math.abs(element.mx - x) < SeparationWidth && Math.abs(element.my - y) < SeparationHeight) {
//								overlap = true;
//							}
//						}
					} while (overlap);
					
					var elementClass:String = this.getElementClassByDistribution(elementDistribution);
					var elementSize:String = "";
					if ([Constants.PlatformNormal, Constants.PlatformDrop, Constants.PlatformMobile, Constants.Trampoline].indexOf(elementClass) != -1) {
						elementSize = String(this.getElementSizeByDistribution(sizeDistribution));
					}
					this.level.levelElementsArray.push([y, x, elementClass + elementSize]);
					this.level.levelElementsArray.push([y + unitHeight, x, Constants.Coin]);
					//this.level.addElement(y, x, elementClass + elementSize);
					//this.level.addElement(y + unitHeight, x, Level.Coin);
				}
				currentY += rowHeight;
			}
		}
		
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
				return Constants.Trampoline;
			}
			else if (seed >= elementDistribution[3] && seed < elementDistribution[4]) {
				return Constants.PowerTrampoline;
			}
			else if (seed >= elementDistribution[4] && seed < elementDistribution[5]) {
				//r = new Cloud();
				return Constants.Cannon;
			}
			else if (seed >= elementDistribution[5] && seed < elementDistribution[6]) {
				//r = new CloudMobile();
				return Constants.PowerCannon;
			}
			return Constants.PlatformNormal;
		}
		
		private function getElementSizeByDistribution(sizeDistribution:Array):uint {
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
		
		private function generateDots3PerRow100RowSpace(yMin:Number, yMax:Number, unitHeight:Number) {
			var rowHeight:Number = unitHeight * 3;
			var currentY:Number = yMin * unitHeight;
			while (currentY <= yMax * unitHeight) {
				this.level.levelElementsArray.push([currentY, -100, Constants.AntigravDot]);
				this.level.levelElementsArray.push([currentY, 0, Constants.AntigravDot]);
				this.level.levelElementsArray.push([currentY, 100, Constants.AntigravDot]);
				//this.level.addElement(currentY, -100, Level.AntigravDot);
				//this.level.addElement(currentY, 0, Level.AntigravDot);
				//this.level.addElement(currentY, 100, Level.AntigravDot);
				currentY += unitHeight;
			}
		}
	}
}