package
{
	/**
	 * This class holds all particle files
	 */
	public class ParticleAssets
	{
		/**
		 * Particle 
		 */
		
		// leaf
		[Embed(source="../media/particles/particleLeaf.pex", mimeType="application/octet-stream")]
		public static var ParticleLeafXML:Class;
		
		[Embed(source="../media/particles/leafTexture.png")]
		public static var ParticleLeafTexture:Class;
		
		// charge
		[Embed(source="../media/particles/particleMushroom.pex", mimeType="application/octet-stream")]
		public static var ParticleChargeXML:Class;
		
		[Embed(source="../media/particles/texture.png")]
		public static var ParticleChargeTexture:Class;
		
		// wind
		[Embed(source="../media/particles/wind/particle.pex", mimeType="application/octet-stream")]
		public static var ParticleWindXML:Class;
		
		[Embed(source="../media/particles/wind/texture.png")]
		public static var ParticleWindTexture:Class;
		
		// rain
		[Embed(source="../media/particles/rain/particle.pex", mimeType="application/octet-stream")]
		public static var ParticleRainXML:Class;
		
		[Embed(source="../media/particles/rain/texture.png")]
		public static var ParticleRainTexture:Class;
		
		// sea of fire
		[Embed(source="../media/particles/fire/particle.pex", mimeType="application/octet-stream")]
		public static var ParticleFireXML:Class;
		
		[Embed(source="../media/particles/fire/texture.png")]
		public static var ParticleFireTexture:Class;
	}
}