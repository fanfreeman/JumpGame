package
{
	import com.adobe.crypto.MD5;
	
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
		
	public class Communicator
	{
		public static const URL:String = "/score/get";
		
		public var dataAvailable:Boolean = false;
		public var data:String;
		public var fbid:uint;
		
		private var _loader:URLLoader;
		private var _request:URLRequest;
		
		public function Communicator()
		{
		}
		
		public function readData():String {
			if (this.dataAvailable) {
				this.dataAvailable = false;
				return this.data;
			} else {
				return null;
			}
		}
		
		public function retrieveUserData():void {
			var randomParam:String = "?p=" + Math.floor(Math.random() * (10000000));
			var loader:URLLoader = new URLLoader();
			configureListeners(loader);
			
			var request:URLRequest = new URLRequest(Constants.UriUserInfo);
			request.method = URLRequestMethod.GET;
			
			try {
				loader.load(request);
			} catch (error:Error) {
				trace("Unable to load requested document.");
			}
		}
		
		public function syncUserData(data:*):void {
			var preSalt:String = "oMgTHIS__$iS?Saltted!@#39-";
			var afterSalt:String = "-=^pErrf_-_+=f3$ct:)#";
			var hash:String = MD5.hash(preSalt + data + afterSalt + afterSalt);
			
			var loader:URLLoader = new URLLoader();
			configureListeners(loader);
			
			var request:URLRequest = new URLRequest("/score/submit");
			request.method = URLRequestMethod.POST;
			var variables : URLVariables = new URLVariables();
			variables.data = data;
			variables.hash = hash;
			request.data = variables;
			
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
			this.data = loader.data;
			this.dataAvailable = true;
			trace("completeHandler: " + this.data);
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