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
		[Embed(source="../media/particles/particleLeaf.pex", mimeType="application/octet-stream")]
		public static var ParticleLeafXML:Class;
		
		[Embed(source="../media/particles/leafTexture.png")]
		public static var ParticleLeafTexture:Class;
	}
}