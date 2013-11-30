package com.jumpGame.level
{
	import com.mixpanel.Mixpanel;
	
	import flash.display.Bitmap;
	
	import starling.core.Starling;
	import starling.extensions.PDParticleSystem;
	import starling.filters.ColorMatrixFilter;

	public class Statics
	{
		// stage sizes
		public static var stageWidth:int;
		public static var stageHeight:int;
		
		// whether game is paused
		public static var gamePaused:Boolean;
		
		// whether the player has lost
		public static var checkWinLose:Boolean;
		
		// contraption control
		public static var contraptionsEnabled:Boolean;
		
		// particle emitters
		public static var particleLeaf:PDParticleSystem;
		public static var particleCharge:PDParticleSystem;
		public static var particleWind:PDParticleSystem;
		public static var particleJet:PDParticleSystem;
		public static var particleComet:PDParticleSystem;
		public static var particleBounce:PDParticleSystem;
		public static var particleExplode:PDParticleSystem;
		public static var particleConfetti:PDParticleSystem;
		
		// normal/bonus/preparation mode
		public static var gameMode:uint;
		
		// preparation step
		public static var preparationStep:uint;
		
		// game speed multiplicatin factor
		public static var speedFactor:Number;
		
		// game time since start in milliseconds
		public static var gameTime:int;
		
		// max climb distance in pixels (each unit height is 75 pixels)
		public static var maxDist:Number;
		
		// number of seconds of bonus mode time available
//		public static var bonusTime:int;
		
		// number of milliseconds of bonus mode time left
		public static var bonusTimeLeft:int;
		
		// next musical note to play when a star is touched
		public static var nextStarNote:int;
		
		// whether game is rendering through hardware
		public static var isHardwareRendering:Boolean;
		
		// camera shake duration and intensity
		public static var cameraShake:Number;
		
		// position of next platform
		public static var nextPlatformX:Number;
		public static var nextPlatformY:Number;
		
		// allows disabling of powerups when one is in progress
		public static var powerupsEnabled:Boolean
		
		// number of speical abilities left
		public static var numSpecials:uint;
		public static var specialUseTime:int;
		public static var specialReadyTime:int;
		public static var specialReady:Boolean;
		
		// contraption activation status
		public static var isBellActive:Boolean;
		public static var isRightCannonActive:Boolean;
		public static var isLeftCannonActive:Boolean;
		
		// achievements
//		public static var displayingBadge:Boolean;
		public static var achievementsList:Vector.<Boolean>;
		
		// communication
		public static var playerName:String;
		public static var firstName:String;
		public static var lastName:String;
		public static var playerHighScore:int;
		public static var opponentName:String;
		public static var currentRound:uint;
		public static var roundScores:Array;
		public static var isPlayer2:Boolean;
		public static var gameId:uint;
		public static var opponentFbid:String;
		public static var userId:String;
		public static var facebookId:String;
		public static var resignedBy:String;
		
		// player picture
		public static var playerPictureBitmap:Bitmap = null;
		
		// upgrade ranks
		public static var rankTeleportation:uint;
		public static var rankAttraction:uint;
		public static var rankDuplication:uint;
		public static var rankSafety:uint;
		public static var rankBarrels:uint;
		public static var rankCannonballs:uint;
		public static var rankComet:uint;
		public static var rankAbilityCooldown:uint;
		public static var rankAbilityPower:uint;
		public static var rankExtraAbility:uint;
		public static var rankCoinDoubler:uint;
		
		// player wealth
		public static var playerCoins:int;
		public static var playerGems:int;
		
		// upgrade prices
		public static var upgradePrices:Object;
		
		// calculate hero velocity ema
		public static var calculateEmaVelocity:Boolean;
		
		// temporary invincibility when losing transfiguration
		public static var invincibilityExpirationTime:int;
		
		// camera target modifier
		public static var cameraTargetModifierY:Number;
		
		public static var powerupAttractionEnabled:Boolean;
		
		// button states filters
		public static var btnBrightnessFilter:ColorMatrixFilter;
		public static var btnInvertFilter:ColorMatrixFilter;
		public static var btnContrastFilter:ColorMatrixFilter;
		
		// mixpanel
		public static var mixpanel:Mixpanel;
		public static var isAnalyticsEnabled:Boolean;
		
		/**
		 * Find the distance between two points
		 */
		public static function distance(x1:Number, y1:Number, x2:Number, y2:Number):Number {
			var dx:Number = Math.abs(x1 - x2);
			var dy:Number = Math.abs(y1 - y2);
			return Math.sqrt(dx * dx + dy * dy);
		}
		
		/**
		 * Find the angle of the vector formed from point 1 to point 2
		 */
		public static function vectorAngle(x1:Number, y1:Number, x2:Number, y2:Number):Number {
			var dx:Number = x2 - x1;
			var dy:Number = y2 - y1;
			return Math.atan2(dy,dx);
		}
		
//		// bof picture url loader
//		public static var profilePicturesData:Dictionary;
//		
//		public static function pictureUrlReturnedFromJs(facebookId:String, pictureUrlData:Object):void {
//			if (pictureUrlData.url != null && pictureUrlData.width != null) {
//				var pictureObject:Object = new Object();
//				pictureObject.url = String(pictureUrlData.url);
//				pictureObject.width = uint(pictureUrlData.width);
//				profilePicturesData[facebookId] = pictureObject;
//			}
//		}
//		
//		public static function getProfilePictureUrl(facebookId:String):String {
//			var pictureObject:Object = profilePicturesData[facebookId];
//			if (pictureObject != null && pictureObject.url != null) {
//				return pictureObject.url;
//			}
//			return "none";
//		}
//		
//		public static function getProfilePictureWidth(facebookId:String):uint {
//			var pictureObject:Object = profilePicturesData[facebookId];
//			if (pictureObject != null && pictureObject.width != null) {
//				return uint(pictureObject.width);
//			}
//			return 0;
//		}
//		// eof picture url loader
		
		public static function initialize():void { // initialized in Game.as
			// create button state filters
			btnBrightnessFilter = new ColorMatrixFilter();
			btnBrightnessFilter.adjustBrightness(0.25);
			btnInvertFilter = new ColorMatrixFilter();
			btnInvertFilter.invert();
			btnContrastFilter = new ColorMatrixFilter();
			btnContrastFilter.adjustContrast(0.75);
			
			isHardwareRendering = Starling.context.driverInfo.toLowerCase().indexOf("software") == -1;
//			trace("Hardware rendering: " + Statics.isHardwareRendering);
			
			// create mixpanel object
			isAnalyticsEnabled = false;
			mixpanel = new Mixpanel("f6cea95ffc1fa6a0db7c5db16597f5a4");
		}
	}
}