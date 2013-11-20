package com.jumpGame.customObjects
{
	import flash.external.ExternalInterface;
	import flash.utils.Dictionary;
	
	import starling.events.EventDispatcher;
	
	public class PictureLoader extends EventDispatcher
	{
		private var profilePicturesData:Dictionary;
		
		public function PictureLoader()
		{
			super();
			// profile pictures loader
			profilePicturesData = new Dictionary();
			
			// for retrieving profile pictures
			ExternalInterface.addCallback("returnProfilePictureUrlToAs", pictureUrlReturnedFromJs);
		}
		
		public function pictureUrlReturnedFromJs(facebookId:String, pictureUrlData:Object):void {
			if (pictureUrlData.url != null && pictureUrlData.width != null) { // data valid
				if (profilePicturesData[facebookId] == null) { // object not yet added to dictionary
					var pictureObject:Object = new Object();
					pictureObject.url = String(pictureUrlData.url);
					pictureObject.width = uint(pictureUrlData.width);
					profilePicturesData[facebookId] = pictureObject;
					this.dispatchEventWith("pictureDataLoaded", false, facebookId);
				}
			}
		}
		
		public function getProfilePictureUrl(facebookId:String):String {
			var pictureObject:Object = profilePicturesData[facebookId];
			if (pictureObject != null) {
				return pictureObject.url;
			}
			return null;
		}
		
		public function getProfilePictureWidth(facebookId:String):uint {
			var pictureObject:Object = profilePicturesData[facebookId];
			if (pictureObject != null) {
				return uint(pictureObject.width);
			}
			return 0;
		}
	}
}