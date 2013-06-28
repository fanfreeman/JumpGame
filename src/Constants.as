package
{
	/**
	 * This class holds all the constant values used during game play.
	 * Modifying certain properties of this class could result in
	 * slightly varied behavior in the game, e.g., hero's lives or speed.
	 */
	public class Constants
	{
		// stage size
		public static const StageWidth:uint = 756;
		public static const StageHeight:uint = 650;
		
		// element preload window
		public static const ElementPreloadWindow:Number = 650;
		
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
		public static const HeroInitialVelocityY:Number = 2.072;
		
		// Particle types ------------------------------------------\
		/** Particle - Sparkle. */		
		public static const PARTICLE_TYPE_1:int = 1;
		
		/** Particle - Wind Force. */		
		public static const PARTICLE_TYPE_2:int = 2;
		
		// physics
		public static const Gravity:Number = 0.00158;
		public static const MaxHeroFallVelocity:Number = -2.0;
		
		public static const HeroMaxSpeedX:Number = 0.5;
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
		public static const ContraptionBell:uint = 2;
		
		// level generator definition
		public static const Generator:String = "Generator"; // randomly generate elements according to specification
		
		// contraption setting definitions
		public static const ContraptionSettingTrain:String = "ContraptionSettingTrain";
		public static const ContraptionSettingHourglass:String = "ContraptionSettingHourglass";
		public static const ContraptionSettingBell:String = "ContraptionSettingBell";
		
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
		public static const SofWidth:uint = 760;
		
		// sea of fire scaling factors
		public static const SofLayer1ScaleFactor:Number = 1.0;
		public static const SofLayer2ScaleFactor:Number = 1.5;
		public static const SofLayer3ScaleFactor:Number = 1.75;
		public static const SofLayer4ScaleFactor:Number = 2.0;
		public static const SofLayer5ScaleFactor:Number = 2.5;
		
		// sea of fire wave heights
		public static const SofLayer1HeightOffset:Number = 30;
		public static const SofLayer2HeightOffset:Number = 20;
		public static const SofLayer3HeightOffset:Number = 0;
		public static const SofLayer4HeightOffset:Number = -30;
		public static const SofLayer5HeightOffset:Number = -70;
		
		/** Misc ********************************************************/
		
		// animations
		public static const HeroAnimWalk:uint = 0;
		public static const HeroAnimJump:uint = 1;
		public static const HeroAnimFail:uint = 2;
		
		// background or foreground
		public static const Background:uint = 0;
		public static const Foreground:uint = 1;
		
		// server URIs
		public static const UriGetUserInfo:String = "/app_dev.php/user/info";
		public static const UriPostUserInfo:String = "/app_dev.php/user/post";
		
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
	}
}