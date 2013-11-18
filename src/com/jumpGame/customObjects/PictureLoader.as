package com.jumpGame.customObjects
{
	import flash.external.ExternalInterface;
	import flash.utils.Dictionary;
	
	import starling.events.EventDispatcher;
	import starling.utils.AssetManager;
	
	public class PictureLoader extends EventDispatcher
	{
//		public var assets:AssetManager;
		public var profilePicturesLoading:Dictionary;
		private var profilePicturesLoaded:Dictionary;
		
		public function PictureLoader()
		{
			super();
			// profile pictures loader
			profilePicturesLoading = new Dictionary();
			profilePicturesLoaded = new Dictionary();
//			assets = new AssetManager();
//			assets.verbose = true;
			
			// for retrieving profile pictures
			ExternalInterface.addCallback("returnProfilePictureUrlToAs", pictureUrlReturnedFromJs);
		}
		
		// bof profile pictures
		public function pictureUrlReturnedFromJs(facebookId:String, pictureUrlData:Object):void {
			if (pictureUrlData.url != null && pictureUrlData.width != null) {
				var pictureObject:Object = new Object();
				pictureObject.url = String(pictureUrlData.url);
				pictureObject.width = uint(pictureUrlData.width);
				profilePicturesLoading[facebookId] = pictureObject;
//				if (pictureObject.url != "none") {
					// store file name and facebook id in dictionary
					//					var pathArray:Array = pictureObject.url.split('/');
					//					var filenameFull:String = pathArray.pop();
					//					var partsArray:Array = filenameFull.split('.');
					//					var filename:String = partsArray[0];
					//					profilePicturesLoading[facebookId].filename = filename;
					//					assets.enqueue(pictureObject.url);
//					assets.enqueueWithName(pictureObject.url, facebookId);
//					assets.loadQueue(function(ratio:Number):void
//					{
////						trace("Loading assets, progress:", ratio);
//						if (ratio == 1.0) {
////							var newPictureLoaded:Boolean = false;
//							var loadedTextures:Vector.<String> = assets.getTextureNames();
//							for (var key:String in profilePicturesLoading) { // key is facebook id
//								//								var value:Object = profilePicturesLoading[k];
//								if (findIndexOfValue(loadedTextures, key) != -1) { // filename is loaded
//									profilePicturesLoading[key].texture = assets.getTexture(key);
//									profilePicturesLoaded[key] = profilePicturesLoading[key];
//									delete profilePicturesLoading[key];
//									dispatchEventWith("newPictureLoaded", true, key);
////									newPictureLoaded = true;
//								}
//							}
//						}
//					});
//				}
			}
		}
		
		// search a vector for a given string
		private function findIndexOfValue(vector:Vector.<String>, value:String):int {
			var length:uint = vector.length;
			for (var i:uint = 0; i < length; i++) {
				if (vector[i] == value) {
					return i;
				}
			}
			return -1;
		}
		
		private function traceDictionary(dict:Dictionary):void {
			for (var key:String in dict) {
				trace('dict[' + key + '] = ' + dict[key]);
			}
		}
		//		public static function getProfilePictureUrl(facebookId:String):String {
		//			var pictureObject:Object = profilePictures[facebookId];
		//			if (pictureObject != null && pictureObject.url != null) {
		//				return pictureObject.url;
		//			}
		//			return "none";
		//		}
		//		
		//		public static function getProfilePictureWidth(facebookId:String):uint {
		//			var pictureObject:Object = profilePictures[facebookId];
		//			if (pictureObject != null && pictureObject.width != null) {
		//				return uint(pictureObject.width);
		//			}
		//			return 0;
		//		}
		
		//		private static function onPictureLoadComplete(event:flash.events.Event):void
		//		{
		//			var loadedBitmap:Bitmap = event.currentTarget.loader.content as Bitmap;
		//		}
		// eof profile pictures
	}
}