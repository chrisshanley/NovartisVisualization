package com.vml.net
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	[Event(name="complete", type="flash.events.Event")]
	public class AbstractService extends EventDispatcher
	{
		protected var _xml:XML;
		protected var _loader:URLLoader;
		protected var _vars:URLVariables;
		protected var _request:URLRequest;
		
		public function AbstractService( )
		{
			_loader = new URLLoader();
			_request = new URLRequest();
			_vars = new URLVariables();
		}
		
		public function loadService( url:String, params:Object = null ):void
		{
			_loader.addEventListener(Event.COMPLETE, handleServiceLoaded );
			_request.url = url;
			_request.method = URLRequestMethod.POST;
			
			var parmsDebug:String = "?";
			if( params )
			{
				_request.url += "?"
				for( var prop:String in params )
				{
					_vars[prop] = params[prop];
					parmsDebug +=  prop +"="+_vars[prop]+ "&";
					_request.url += prop +"="+_vars[prop]+ "&";				
				}
			}

			_loader.load( _request );
		}
		
		protected function handleServiceLoaded( event:Event ):void
		{
			_xml = new XML( event.target.data );
			dispatchEvent( event.clone() );
		}
		
		protected function parse():void
		{
			// override me
		}
		
		public function get xml():XML
		{
			return _xml;
		}
		
		
		
	}
}