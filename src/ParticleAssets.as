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
		[Embed(source="../media/particles/charge/particleCharge.pex", mimeType="application/octet-stream")]
		public static var ParticleChargeXML:Class;
		
		[Embed(source="../media/particles/charge/texture.png")]
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
		
		// jet
		[Embed(source="../media/particles/jet/particle.pex", mimeType="application/octet-stream")]
		public static var ParticleJetXML:Class;
		
		[Embed(source="../media/particles/jet/texture.png")]
		public static var ParticleJetTexture:Class;
		
		// comet tail
		[Embed(source="../media/particles/comet/particle.pex", mimeType="application/octet-stream")]
		public static var ParticleCometXML:Class;
		
		[Embed(source="../media/particles/comet/texture.png")]
		public static var ParticleCometTexture:Class;
		
		// sea of fire
//		[Embed(source="../media/particles/fire/particle.pex", mimeType="application/octet-stream")]
//		public static var ParticleFireXML:Class;
//		
//		[Embed(source="../media/particles/fire/texture.png")]
//		public static var ParticleFireTexture:Class;
	}
}