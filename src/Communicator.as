package
{
	import com.adobe.crypto.MD5;
	import com.jumpGame.events.NavigationEvent;
	
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import starling.events.EventDispatcher;
		
	public class Communicator extends EventDispatcher
	{
		private var _loader:URLLoader;
		private var _request:URLRequest;
		
		public function Communicator()
		{
		}
		
		/**
		 * retrieve user data from the backend
		 */
		public function retrieveUserData():void {
			this.sendGetRequest(Constants.UriGetUserInfo);
		}
		
		/**
		 * post a piece of user data to the backend
		 * 
		 * @param data a json string to send
		 */
		public function postUserData(data:String):void {
			this.sendPostRequest(data, Constants.UriPostUserInfo);
		}
		
		public function postPurchaseUpgrade(data:String):void {
			this.sendPostRequest(data, Constants.UriPurchase);
		}
		
		/**
		 * Send a post request
		 */
		public function sendPostRequest(data:String, url:String):void {
			var preSalt:String = "oMgTHIS__$iS?Saltted!@#39-";
			var afterSalt:String = "-=^pErrf_-_+=f3$ct:)#";
			var hash:String = MD5.hash(preSalt + data + afterSalt + afterSalt);
			
			var loader:URLLoader = new URLLoader();
			configureListeners(loader);
			
			var request:URLRequest = new URLRequest(url);
			request.method = URLRequestMethod.POST;
			
			var variables : URLVariables = new URLVariables();
			variables.data = data;
			variables.hash = hash;
			request.data = variables;
			
			try {
				loader.load(request);
			} catch (error:Error) {
				trace("Unable to send post request");
			}
		}
		
		/**
		 * Find a smart match opponent for the current user
		 */
		public function findSmartMatch():void {
			this.sendGetRequest(Constants.UriFindMatch);
		}
		
		/**
		 * Find a smart match opponent for the current user
		 */
		public function createMatch(opponentId:String):void {
			this.sendGetRequest(Constants.UriCreateMatchFacebook + "?opponent=" + opponentId);
		}
		
		/**
		 * Resigns a specified match for the current user
		 */
		public function resignMatch(gameId:uint):void {
			this.sendGetRequest(Constants.UriResignMatch + "?match=" + String(gameId));
		}
		
		/**
		 * Sends a GET request to the backend
		 * 
		 * @param url the url to send the request to
		 */
		private function sendGetRequest(url:String):void {
//			var randomParam:String = "?p=" + Math.floor(Math.random() * (10000000)); // random parameter to avoid getting cached result
			trace("Communicating: " + url);
			var loader:URLLoader = new URLLoader();
			configureListeners(loader);
			
			var request:URLRequest = new URLRequest(url);
			request.method = URLRequestMethod.GET;
			
			try {
				loader.load(request);
			} catch (error:Error) {
				trace("Unable to load requested document.");
			}
		}
		
		private function configureListeners(dispatcher:IEventDispatcher):void {
			dispatcher.addEventListener(Event.COMPLETE, completeHandler);
			dispatcher.addEventListener(Event.OPEN, openHandler);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			//dispatcher.addEventListener(IOErrorEvent.NETWORK_ERROR, errorHandler);
			//dispatcher.addEventListener(IOErrorEvent.VERIFY_ERROR, errorHandler);
			//dispatcher.addEventListener(IOErrorEvent.DISK_ERROR, errorHandler);
		}
		
		private function completeHandler(event:Event):void {
			var loader:URLLoader = URLLoader(event.target);
			var data:String = loader.data;
			trace("completeHandler: " + data);
			
			this.dispatchEvent(new NavigationEvent(NavigationEvent.RESPONSE_RECEIVED, {data: data}, true));
		}
		
		private function openHandler(event:Event):void {
			trace("openHandler: " + event);
		}
		
		private function progressHandler(event:ProgressEvent):void {
			trace("progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
		}
		
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			trace("securityErrorHandler: " + event);
		}
		
		private function httpStatusHandler(event:HTTPStatusEvent):void {
			trace("httpStatusHandler: " + event);
		}
		
		private function ioErrorHandler(event:IOErrorEvent):void {
			trace("ioErrorHandler: " + event);
		}
	}
}