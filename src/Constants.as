package
{
	/**
	 * This class holds all the constant values used during game play.
	 * Modifying certain properties of this class could result in
	 * slightly varied behavior in the game, e.g., hero's lives or speed.
	 */
	public class Constants
	{
		// level designer mode switch
		public static const isDesignerMode:Boolean = false;
		public static const powerupsEnabled:Boolean = true;
		public static const contraptionsEnabled:Boolean = true;
		
		// stage size
		public static const StageWidth:uint = 756;
		public static const StageHeight:uint = 650;
		
		// element preload window
		public static const ElementPreloadWindow:Number = 650 / 2;
		
		// screen border on left and right side
		public static const ScreenBorder:Number = 100;
		
		// Hero's graphic states - what is the position/animation of hero?
		public static const HERO_STATE_IDLE:int = 0;
		public static const HERO_STATE_WALK:int = 1;
		public static const HERO_STATE_JUMP:int = 2;
		public static const HERO_STATE_DIE:int = 3;
		
		// hero initial specs
		public static const HERO_INITIAL_X:Number = 0;
		public static const HERO_INITIAL_Y:Number = 0;
		public static const HeroInitialVelocityY:Number = 3.072;
		
		// Particle types ------------------------------------------\
		/** Particle - Sparkle. */		
		public static const PARTICLE_TYPE_1:int = 1;
		
		/** Particle - Wind Force. */		
		public static const PARTICLE_TYPE_2:int = 2;
		
		// physics
		public static const Gravity:Number = 0.00158;
		public static const MaxHeroFallVelocity:Number = -2.0;
		public static const MaxHeroBouncePower:Number = 3.0;
		
		public static const HeroMaxSpeedX:Number = 0.5;
		public static const HeroExpansionMaxSpeedX:Number = 0.5;
		public static const HeroSpeedX:Number = 0.002;
		
		/** Level Elements ********************************************************/
		// level element name definitions
		public static const PlatformNormal:String = "PlatformNormal";
		public static const PlatformDrop:String = "PlatformDrop";
		public static const PlatformMobile:String = "PlatformMobile";
		public static const PlatformNormalBoost:String = "PlatformNormalBoost";
		public static const PlatformDropBoost:String = "PlatformDropBoost";
		public static const PlatformMobileBoost:String = "PlatformMobileBoost";
		public static const PlatformPower:String = "PlatformPower";
		public static const PlatformSuper:String = "PlatformSuper";
		public static const Coin:String = "Coin";
		public static const AntigravDot:String = "AntigravDot";
		public static const Goal:String = "Goal";
		
		// contraption name definitions
		public static const Hourglass:String = "Hourglass";
		public static const Train:String = "Train";
		public static const Bell:String = "Bell";
		
		// contraption index definitions
		public static const ContraptionHourglass:uint = 0;
		public static const ContraptionTrain:uint = 1;
		public static const ContraptionTrainFromLeft:uint = 2;
		public static const ContraptionBell:uint = 3;
		public static const ContraptionPowerupBoxes:uint = 4;
		public static const ContraptionCannon:uint = 5;
		public static const ContraptionCannonFromLeft:uint = 6;
		public static const ContraptionWitch:uint = 7;
		
		// powerup index definitions
		public static const PowerupBlink:uint = 0;
		public static const PowerupAttractor:uint = 1;
		public static const PowerupLevitation:uint = 2;
		public static const PowerupExtender:uint = 3;
		public static const PowerupExpansion:uint = 4;
		public static const PowerupPyromancy:uint = 5;
		public static const PowerupCometRun:uint = 6;
		
		// level generator definition
		public static const Generator:String = "Generator"; // randomly generate elements according to specification
		
		// contraption setting definitions
		public static const ContraptionSettingTrain:String = "ContraptionSettingTrain";
		public static const ContraptionSettingHourglass:String = "ContraptionSettingHourglass";
		public static const ContraptionSettingBell:String = "ContraptionSettingBell";
		public static const ContraptionSettingPowerupBoxes:String = "ContraptionSettingPowerupBoxes";
		public static const ContraptionSettingCannon:String = "ContraptionSettingCannon";
		public static const ContraptionSettingWitch:String = "ContraptionSettingWitch";
		
		// bounce power definitions
//		public static const NormalBouncePower:Number = 0.85;
//		public static const BoostBouncePower:Number = 1.1;
//		public static const PowerBouncePower:Number = 1.3;
//		public static const SuperBouncePower:Number = 2.4;
		public static const NormalBouncePower:Number = 1.05;
		public static const BoostBouncePower:Number = 1.35;
		public static const PowerBouncePower:Number = 1.6;
		public static const SuperBouncePower:Number = 2.4;
		
		// platform attributes
		public static const PlatformMaxSize:int = 5; // platform max size
		public static const PlatformDropFallVelocity:Number = 0.06; // platform drop
		public static const PlatformMobileMaxVelocityX:Number = 0.15;
		
		// height per unit y distance, usually 1/3rd the height of a row
		public static const UnitHeight:Number = 75;
		
		// train attributes
		public static const TrainVelocity:Number = -1.0;
		public static const DirectionUp:uint = 0;
		public static const DirectionDown:uint = 1;
		
		/** Sea of Fire ********************************************************/
		// enable sea of fire or not
		public static const SofEnabled:Boolean = true;
		
		// sea of fire dimensions
		public static const SofWidth:uint = 750;
		
		// sea of fire scaling factors
		public static const SofLayer1ScaleFactor:Number = 1.0;
		public static const SofLayer2ScaleFactor:Number = 1.5;
		public static const SofLayer3ScaleFactor:Number = 1.75;
		public static const SofLayer4ScaleFactor:Number = 2.0;
		public static const SofLayer5ScaleFactor:Number = 2.5;
		
		// sea of fire wave heights
		public static const SofLayer1HeightOffset:Number = 45;
		public static const SofLayer2HeightOffset:Number = 20;
		public static const SofLayer3HeightOffset:Number = 0;
		public static const SofLayer4HeightOffset:Number = -45;
		public static const SofLayer5HeightOffset:Number = -95;
		public static const SofQuadHeightOffset:Number = 50;
		
		/** Misc ********************************************************/
		
		// animations
//		public static const HeroAnimWalk:uint = 0;
//		public static const HeroAnimJump:uint = 1;
//		public static const HeroAnimFail:uint = 2;
		
		// background or foreground
		public static const Background:uint = 0;
		public static const Foreground:uint = 1;
		
		// background and foreground parallax depths
		public static const BgLayer0ParallaxDepth:Number = 0.02;
		public static const BgLayer1ParallaxDepth:Number = 0.05;
		public static const BgLayer2ParallaxDepth:Number = 0.5;
		// note: player layer has depth 1.0
		public static const BgLayer4ParallaxDepth:Number = 1.5;
		
		// server URIs
		public static const UriGetUserInfo:String = "user/info";
		public static const UriPostUserInfo:String = "user/post";
		public static const UriPurchaseUpgrade:String = "user/purchase/upgrade";
		public static const UriPurchaseCoins:String = "user/purchase/coins";
		public static const UriVerifyPurchase:String = "user/verify/purchase";
		public static const UriFindMatch:String = "user/findmatch";
		public static const UriCreateMatchFacebook:String = "user/creatematchfb";
		public static const UriResignMatch:String = "user/resignmatch";
		
		// camera
		public static const CameraEasingTimeY:Number = 10.0;
		public static const CameraEasingTimeX:Number = 10.0;
		public static const CameraBoundTop:Number = 0.0;
		public static const CameraBoundBottom:Number = 200.0;
		public static const CameraBoundLeft:Number = 10;
		public static const CameraBoundRight:Number = 10;
		public static const CameraMoveX:Boolean = false;
		
		// debug switches
		public static const DebugObjectPools:Boolean = false;
		
		// game mode
		public static const PrepareStep0:uint = 0;
		public static const PrepareStep1:uint = 1;
		public static const PrepareStep2:uint = 2;
		public static const PrepareStep3:uint = 3;
		public static const PrepareStep4:uint = 4;
		public static const PrepareStepDone:uint = 5;
		public static const ModeNormal:uint = 5;
		public static const ModeBonus:uint = 6;
		
		// music mode specific
		public static const MusicModeColumnSpacing:Number = 200;
		public static const MoveNone:uint = 0;
		public static const MoveLeft:uint = 1;
		public static const MoveRight:uint = 2;
		
		// designed patterns
		public static const ElementSpacing:Number = 60;
		
		// power up icons
		public static const PowerupIconHeight:Number = 61;
		public static const PowerupIconSpacing:Number = 20;
		
		// power up completion warning, flash reel for this duration
		public static const PowerupWarningDuration:int = 3000; // 3 seconds
		
		// charm: attractor
		public static const CharmDurationAttractor:int = 10000; // 10 seconds
		
		// acquired coin flight target; y-value is top screen border
		public static const CoinTargetX:Number = 200;
		
		// special indicators total width
		public static const SpecialsTotalWidth:Number = 400;
		
		// platform reaction bounce distance
		public static const PlatformReactionBounce:Number = 15;
		
		// main menu tabs
		public static const ScreenMatches:String = "ScreenMatches";
		public static const ScreenUpgrades:String = "ScreenUpgrades";
		public static const ScreenAchievements:String = "ScreenAchievements";
	}
}