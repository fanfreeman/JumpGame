package com.jumpGame.level  {
	
	public dynamic class LevelDefinition {
		public static function getBonusContents():Array {
			var stageContents:Array = new Array();
			
			// music mode
			stageContents.push(new Array(3, 			0, 			Constants.PlatformNormal, 5));
			stageContents.push(new Array(3, 			0, 			Constants.PlatformNormal, 5));
			stageContents.push(new Array(3, 			0, 			Constants.PlatformNormal, 5));
			stageContents.push(new Array(3, 			0, 			Constants.PlatformNormal, 5));
			stageContents.push(new Array(3, 			0, 			Constants.PlatformNormal, 5));
			stageContents.push(new Array(3, 			0, 			Constants.PlatformNormal, 5));
			stageContents.push(new Array(3, 			0, 			Constants.PlatformNormal, 5));
			stageContents.push(new Array(3, 			0, 			Constants.PlatformNormal, 5));
			stageContents.push(new Array(3, 			0, 			Constants.PlatformNormal, 5));
			stageContents.push(new Array(3, 			0, 			Constants.PlatformNormal, 5));
			stageContents.push(new Array(Constants.Generator, 999, 3, 3543));
			
			// goal
			//stageContents.push(new Array(3, 			0, 				Constants.Goal));
			
			return stageContents;
		}
		
		public static function getNormalContents():Array {
			var stageContents:Array = new Array();
			
			// change hourglass settings
			stageContents.push(new Array(Constants.ContraptionSettingHourglass, 10));
			
			// change train settings
			stageContents.push(new Array(Constants.ContraptionSettingTrain, 10));
			
			// change bell settings
			stageContents.push(new Array(Constants.ContraptionSettingBell, 20));
			
			// change powerup boxes settings
			stageContents.push(new Array(Constants.ContraptionSettingPowerupBoxes, 10));
			
			//
			
			// generate random type 1
			stageContents.push(new Array(Constants.Generator, 1, 1, 61));
			
			// generate random type 2
			// [1] size [4-5] [normal, drop] platforms per row
			stageContents.push(new Array(Constants.Generator, 2, 3, 63));
			
			// generate random type 3
			// [1] size [3-4] [normal, drop, mobile, normalboost]
			stageContents.push(new Array(Constants.Generator, 3, 3, 123));
			
			// generate random type 4
			// [1] size [3-4] [normal, drop, mobile, normalboost, power, super]
			stageContents.push(new Array(Constants.Generator, 4, 3, 123));
			
			// [1] size [2-4] [normal, drop, mobile, normalboost, power, super]
			stageContents.push(new Array(Constants.Generator, 5, 3, 243));
			
			// centered dots
			//stageContents.push(new Array(Constants.Generator, LevelGenerator.Dots3PerRow100RowSpace, 3, 33));
			
			// [1] size [1-3] [normal, drop, mobile, normalboost, power, super]
			stageContents.push(new Array(Constants.Generator, 6, 3, 243));
			
			// centered dots
			//stageContents.push(new Array(Constants.Generator, LevelGenerator.Dots3PerRow100RowSpace, 3, 33));
			
			// goal
			//stageContents.push(new Array(3, 			0, 				Constants.Goal));
			
			return stageContents;
		}
		
		public static function getContents2():Array {
			var stageContents:Array = new Array();
			
			//							 +y				x				element class
			stageContents.push(new Array(3, 			-250, 			Constants.PlatformNormal, 5));
			stageContents.push(new Array(3, 			-250, 			Constants.PlatformNormal, 5));
			stageContents.push(new Array(3, 			-250, 			Constants.PlatformNormal, 5));
			stageContents.push(new Array(3, 			-250, 			Constants.PlatformNormal, 5));
			stageContents.push(new Array(3, 			-250, 			Constants.PlatformNormal, 5));
			stageContents.push(new Array(3, 			-250, 			Constants.PlatformNormal, 5));
			
			stageContents.push(new Array(3, 			-100, 			Constants.PlatformNormal, 5));
			stageContents.push(new Array(3, 			100, 			Constants.PlatformNormal, 5));
			stageContents.push(new Array(3, 			-100, 			Constants.PlatformNormal, 5));
			stageContents.push(new Array(3, 			100, 			Constants.PlatformNormal, 5));
			stageContents.push(new Array(3, 			-200, 			Constants.PlatformNormal, 5));
			stageContents.push(new Array(3, 			0, 				Constants.PlatformNormal, 5));
			stageContents.push(new Array(3, 			-200, 			Constants.PlatformNormal, 5));
			stageContents.push(new Array(3, 			0, 				Constants.PlatformNormal, 5));
			stageContents.push(new Array(3, 			-100, 			Constants.PlatformNormal, 5));
			stageContents.push(new Array(3, 			200, 			Constants.PlatformNormal, 5));
			stageContents.push(new Array(3, 			-100, 			Constants.PlatformNormal, 5));
			stageContents.push(new Array(3, 			200, 			Constants.PlatformNormal, 5));
			stageContents.push(new Array(3, 			-200, 			Constants.PlatformNormal, 5));
			stageContents.push(new Array(3, 			200, 			Constants.PlatformNormal, 5));
			stageContents.push(new Array(3, 			-200, 			Constants.PlatformNormal, 5));
			stageContents.push(new Array(3, 			200, 			Constants.PlatformNormal, 5));
			stageContents.push(new Array(3, 			-200, 			Constants.PlatformNormal, 5));
			stageContents.push(new Array(3, 			200, 			Constants.PlatformNormal, 5));
			stageContents.push(new Array(3, 			-200, 			Constants.PlatformNormal, 5));
			stageContents.push(new Array(3, 			200, 			Constants.PlatformNormal, 5));
			
			stageContents.push(new Array(3, 			270, 			Constants.PlatformNormal, 5));
			stageContents.push(new Array(1, 			270, 			Constants.Coin));
			stageContents.push(new Array(1, 			270, 			Constants.Coin));
			stageContents.push(new Array(1, 			90, 			Constants.PlatformNormal, 5));
			stageContents.push(new Array(1, 			90, 			Constants.Coin));
			stageContents.push(new Array(1, 			90, 			Constants.Coin));
			stageContents.push(new Array(1, 			-90, 			Constants.PlatformNormal, 5));
			stageContents.push(new Array(1, 			-90, 			Constants.Coin));
			stageContents.push(new Array(1, 			-90, 			Constants.Coin));
			stageContents.push(new Array(1, 			-270, 			Constants.PlatformNormal, 5));
			stageContents.push(new Array(1, 			-270, 			Constants.Coin));
			stageContents.push(new Array(1, 			-270, 			Constants.Coin));
			stageContents.push(new Array(1, 			-90, 			Constants.PlatformNormal, 5));
			stageContents.push(new Array(1, 			-90, 			Constants.Coin));
			stageContents.push(new Array(1, 			-90, 			Constants.Coin));
			stageContents.push(new Array(1, 			90, 			Constants.PlatformNormal, 5));
			stageContents.push(new Array(1, 			90, 			Constants.Coin));
			stageContents.push(new Array(1, 			90, 			Constants.Coin));
			stageContents.push(new Array(1, 			270, 			Constants.PlatformNormal, 5));
			stageContents.push(new Array(1, 			270, 			Constants.Coin));
			stageContents.push(new Array(1, 			270, 			Constants.Coin));
			
			// generate random type 1, starting from y+1, ending at y+4
			stageContents.push(new Array(Constants.Generator, 1, 1, 61));
			
			// generate random type 2
			// [1] size [4-5] [normal, drop] platforms per row
			stageContents.push(new Array(Constants.Generator, 2, 3, 63));
			
			// generate random type 3
			// [1] size [3-4] [normal, drop, mobile, trampoline]
			stageContents.push(new Array(Constants.Generator, 3, 3, 123));
			
			// centered dots
			stageContents.push(new Array(Constants.Generator, LevelGenerator.Dots3PerRow100RowSpace, 3, 33));
			
			// generate random type 4
			// [1] size [3-4] [normal, drop, mobile, trampoline, power trampoline, cannon]
			stageContents.push(new Array(Constants.Generator, 4, 3, 123));
			
			// centered dots
			stageContents.push(new Array(Constants.Generator, LevelGenerator.Dots3PerRow100RowSpace, 3, 33));
			
			// [1] size [2-4] [normal, drop, mobile, trampoline, power trampoline, cannon]
			stageContents.push(new Array(Constants.Generator, 5, 3, 243));
			
			// centered dots
			stageContents.push(new Array(Constants.Generator, LevelGenerator.Dots3PerRow100RowSpace, 3, 33));
			
			// [1] size [1-3] [normal, drop, mobile, trampoline, power trampoline, cannon]
			stageContents.push(new Array(Constants.Generator, 6, 3, 243));
			
			// centered dots
			stageContents.push(new Array(Constants.Generator, LevelGenerator.Dots3PerRow100RowSpace, 3, 33));
			
			// goal
			stageContents.push(new Array(3, 			0, 				Constants.Goal));
			
			return stageContents;
		} // eof getContents()
	}
}
