package com.vml.net
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.SecurityDomain;

	[Event(name="complete", type="flash.events.Event")]
	[Event(name="progress", type="flash.events.ProgressEvent")]
	
	public class AbstractDisplayLoader extends EventDispatcher
	{
		
		protected var _loader:Loader;
		protected var _context:LoaderContext;
		protected var _request:URLRequest
		protected var _loaderInfo:LoaderInfo;
		protected var _active:Boolean;
		
		public function AbstractDisplayLoader( useAppDomain:Boolean = false )
		{
			_loader = new Loader();
			
			_context = new LoaderContext( true );
			_request = new URLRequest();
			
			_context.securityDomain = SecurityDomain.currentDomain;
			
			_loaderInfo = _loader.contentLoaderInfo;
			
			if( useAppDomain )
			{
				_context.applicationDomain = ApplicationDomain.currentDomain;
			}
		}
		
		public function addEvents():void
		{
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, handleLoaded );
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, handleProgress );
		}
		
		public function removeEvents():void
		{
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, handleLoaded );
			_loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, handleProgress );
		}
		
		public function load( path:String):void
		{
			addEvents();
			_request.url = path;
			_loader.load( _request, _context );	
		}
		
		public function cancel():void
		{
			removeEvents();
			try 
			{
				_loader.close();
			}
			catch( e:Error )
			{
				trace( this," error cought : ",  e );
			}		
		}
		
		protected function handleProgress( event:ProgressEvent ):void
		{
			dispatchEvent( event.clone() );
		}
		
		protected function handleLoaded( event:Event ):void
		{
			dispatchEvent( event.clone() );
		}
		
		public function get content():Object
		{
			return _loaderInfo.content;
		}
		
		public function get appDomain():ApplicationDomain
		{
			return _loader.contentLoaderInfo.applicationDomain;
		}
		
		public function destroy():void
		{
			removeEvents();	
		}
		
	}
}