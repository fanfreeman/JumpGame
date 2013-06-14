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
		
		// Hero's graphic states - what is the position/animation of hero?
		public static const HERO_STATE_IDLE:int = 0;
		public static const HERO_STATE_WALK:int = 1;
		public static const HERO_STATE_JUMP:int = 2;
		public static const HERO_STATE_DIE:int = 3;
		
		// hero initial specs
		public static const HERO_INITIAL_X:int = 0;
		public static const HERO_INITIAL_Y:int = 0;
		public static const HeroInitialVelocityY:Number = 2.0;
		
		// Particle types ------------------------------------------\
		/** Particle - Sparkle. */		
		public static const PARTICLE_TYPE_1:int = 1;
		
		/** Particle - Wind Force. */		
		public static const PARTICLE_TYPE_2:int = 2;
		
		// physics
		public static const Gravity:Number = 0.00158;
		public static const MaxHeroFallVelocity:Number = -2.0;
		
		public static const HeroMaxSpeedX:Number = 0.5;
		public static const HeroSpeedX:Number = 0.003;
		
		// level element definitions
		public static const PlatformNormal:String = "PlatformNormal";
		public static const PlatformDrop:String = "PlatformDrop";
		public static const PlatformMobile:String = "PlatformMobile";
		public static const Trampoline:String = "Trampoline";
		public static const PowerTrampoline:String = "PowerTrampoline";
		public static const Cannon:String = "Cannon";
		public static const PowerCannon:String = "PowerCannon";
		public static const Coin:String = "Coin";
		public static const AntigravDot:String = "AntigravDot";
		public static const Goal:String = "Goal";
		// leve generator definition
		public static const Generator:String = "Generator"; // randomly generate elements according to specification
		
		// height per unit y distance, usually 1/3rd the height of a row
		public static const UnitHeight:Number = 50;
		
		// scroll everything up when hero falls down this distance from y=0
		public static const ScrollDownThreshold:Number = 150;
		
		// Sea of Fire ////////////////////////////////////////////
		// sea of fire dimensions
		public static const SofWidth:uint = 760;
		
		// sea of fire scaling factors
		public static const SofLayer1ScaleFactor:Number = 1.0;
		public static const SofLayer2ScaleFactor:Number = 1.25;
		public static const SofLayer3ScaleFactor:Number = 1.5;
		public static const SofLayer4ScaleFactor:Number = 1.75;
		public static const SofLayer5ScaleFactor:Number = 2.0;
		///////////////////////////////////////////////////////////
		
		// animations
		public static const HeroAnimWalk:uint = 0;
		public static const HeroAnimJump:uint = 1;
		
		// background or foreground
		public static const Background:uint = 0;
		public static const Foreground:uint = 1;
		
		// server URIs
		public static const UriUserInfo:String = "/app_dev.php/user/info"
	}
}