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
	}
}