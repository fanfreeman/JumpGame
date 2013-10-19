package com.oaxoa.fx
{
	import starling.textures.Texture;

	public class TextureWrapper
	{
		public var texture:Texture;
		//volatile textures are replaced every time textureFromSprite is called. They are also dealocated whenever a game ends
		public var volatile:Boolean;
		public var name:String
		
		public function TextureWrapper(name:String, texture:Texture, volatile:Boolean = false):void 
		{
			this.name = name;
			this.texture = texture;
			this.volatile = volatile;
		}
	}
}