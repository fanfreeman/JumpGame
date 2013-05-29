package
{
	/**
	 * This class holds all the constant values used during game play.
	 * Modifying certain properties of this class could result in
	 * slightly varied behavior in the game, e.g., hero's lives or speed.
	 */
	public class Constants
	{
		// Hero's graphic states - what is the position/animation of hero?
		public static const HERO_STATE_IDLE:int = 0;
		public static const HERO_STATE_WALK:int = 1;
		public static const HERO_STATE_JUMP:int = 2;
		public static const HERO_STATE_DIE:int = 3;
		
		// hero initial position
		public static const HERO_INITIAL_X:int = 0;
		public static const HERO_INITIAL_Y:int = 0;
		
		// Particle types ------------------------------------------\
		/** Particle - Sparkle. */		
		public static const PARTICLE_TYPE_1:int = 1;
		
		/** Particle - Wind Force. */		
		public static const PARTICLE_TYPE_2:int = 2;
		
		// Box2d object types
		public static const SHAPE_CIRCLE:uint = 0;
		public static const SHAPE_BOX:uint = 1;
		
		// Box2d unit conversion
		public static const M_TO_PX:Number = 150;
		public static const PX_TO_M:Number = 1 / M_TO_PX;
	}
}