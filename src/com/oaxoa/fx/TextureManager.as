package com.oaxoa.fx
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import starling.display.Image;
	import starling.textures.SubTexture;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Colin Northway
	 */
	public class TextureManager
	{
		protected static var _instance:TextureManager;
		protected static var _instanciate:Boolean = false;
		
		protected var _textures:Dictionary;
		
		public function TextureManager() 
		{
			if ( !_instanciate ) {
				throw new Error("Can not be instanciated. Use TextureManager.i");
			}
			
			_textures = new Dictionary();
		}
		public static function get i():TextureManager
		{
			if ( _instance != null ) {
				return _instance;
			}else {
				_instanciate = true;
				_instance = new TextureManager();
				_instanciate = false;
				return _instance;
			}
		}
		
		public function imageFromSprite(textureName:String, sprite:DisplayObject, replaceTexture:Boolean = false):Image
		{
			var rect:Rectangle = sprite.getBounds(sprite);
			
			var image:Image = new Image(textureFromSprite(textureName, sprite, replaceTexture));
			image.x = rect.x;
			image.y = rect.y;
			
			return image;
		}
		
		public function getTexture(name:String):Texture 
		{
			if ( _textures[name] == null ) {
				throw new Error("Texture not loaded: " + name);
			}
			
			return _textures[name].texture as Texture;
		}
		
		public function loadTexture(name:String, bitmapData:BitmapData, volatile:Boolean = false):Texture 
		{
			if ( _textures[name] != null ) {
				if ( !volatile ) {
					return _textures[name].texture as Texture;
				}else{
					freeTexture(name);
				}
			}
			
			var texture:Texture = Texture.fromBitmapData(bitmapData);
			_textures[name] = new TextureWrapper(name, texture, volatile);
			
			return texture;
		}
		
		public function textureFromSprite(name:String, sprite:DisplayObject, volatile:Boolean = false, recentre:Boolean = true, bounds:Rectangle = null):Texture
		{
			var rect:Rectangle = sprite.getBounds(sprite);
			if ( bounds != null ) {
				rect.height = bounds.height;
				rect.width = bounds.width;
			}
			
			if ( rect.width > 2048 ) {
				rect.width = 2048;
				trace("Bitmap too big, shrinking");
			}
			if ( rect.height > 2048 ) {
				rect.height = 2048;
				trace("Bitmap too big, shrinking");
			}
			
			//red box means invalid texture
			if ( rect.width <= 2 || rect.height <= 2 ) {
				var tempSprite:flash.display.Sprite = new flash.display.Sprite();
				tempSprite.graphics.beginFill(0xFF0000);
				tempSprite.graphics.drawRect(0, 0, 50, 50);
				sprite = tempSprite;
				rect = sprite.getBounds(sprite);
			}
			
			var bmd:BitmapData = new BitmapData(rect.width, rect.height, true, 0x0000000000);
			var matrix:Matrix = new Matrix();
			if( recentre ){
				matrix.translate( -rect.x, -rect.y);
			}
			// draw the shape on the bitmap
			bmd.draw(sprite, matrix);
			
			return loadTexture(name, bmd, volatile);
		}
		
		public function freeTexture(name:String):void 
		{
			if ( _textures[name] == null ) {
				return;
			}
			
			var texture:Texture = _textures[name].texture as Texture;
			texture.dispose();
			if ( texture is SubTexture ) {
				(texture as SubTexture).parent.dispose();
			}
			delete _textures[name];
		}
		
		public function freePrefix(prefix:String):void 
		{
			for (var textureName:String in _textures) {
				if( textureName.indexOf(prefix) != -1 ){
					freeTexture(textureName);
				}
			}
		}
		
		public function freeVolatileTextures():void 
		{
			for each (var textureWrapper:TextureWrapper in _textures) {
				if ( textureWrapper.volatile ) {
					freeTexture(textureWrapper.name);
				}
			}
		}
		
		public function traceAllocatedTextures():void 
		{
			var textureNames:Array = new Array();
			
			for (var textureName:String in _textures) {
				if( textureName.indexOf("convertedMovieClip") == -1 || textureName.indexOf("(0)") != -1 ){
					textureNames.push(textureName);
				}
			}
			
			textureNames.sort(Array.CASEINSENSITIVE);
			for each (textureName in textureNames) {
				trace(textureName);
			}
		}
	}
}