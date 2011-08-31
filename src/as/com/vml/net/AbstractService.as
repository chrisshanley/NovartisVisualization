package com.vml.net
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
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
		
		public function set postVars( value:Object ):void
		{

			_request.method = URLRequestMethod.POST;
			var propName:String;
			
			for( propName in value )
			{
				_vars[ propName ] = value[ propName ];
			}
			_request.data = _vars;
		}
		
		public function loadService( url:String, queryString:Object = null ):void
		{
			_loader.addEventListener(Event.COMPLETE, handleServiceLoaded );
			_request.url = url;
			
			if( queryString )
			{
				_request.url += "?"
				for( var prop:String in queryString )
				{
					_request.url += prop +"="+queryString[prop]+ "&";				
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