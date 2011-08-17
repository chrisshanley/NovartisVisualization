/**
 * chris shanley
 * loades one piece of content at a time, used for swfs and images
 * sends one loadComplete event per image loaded and the loader info is passes along to get to the content
 * takes an array of strings, file paths
 * 
 *   */


package com.vml.net
{
	import __AS3__.vec.Vector;
	
	import com.vml.events.LoadingEvent;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	[Event(name="loadComplete", type="com.vml.events.LoadingEvent")]
	[Event(name="seriesComplete", type="com.vml.events.LoadingEvent")]
	public class SerializedLoader extends EventDispatcher
	{
		
		protected var _loader:flash.display.Loader;
		protected var _request:URLRequest;
		protected var _context:LoaderContext;
		protected var _items:Vector;
		protected var _index:int;
		
		
		public function SerializedLoader( items:Vector , useAppDomain:Boolean = false)
		{
			_items = items;
			if( useAppDomain )
			{
				_context = new LoaderContext( true, ApplicationDomain.currentDomain );
			}
			
			_loader = new flash.display.Loader();
			_request = new URLRequest();
			_index = 0;
		}
		
		
		public function load():void
		{
			_request.url = _items[ _index ];
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, handleContentLoaded );
			_loader.load(_request, _context )
		}
		
		private function handleContentLoaded( event:Event ):void
		{
			dispatchEvent( new LoadingEvent(LoadingEvent.LOAD_COMPLETE, _loader.contentLoaderInfo ));
			_index ++;
			if( _index != _items.length )
			{
				load();	
			}
			else 
			{
				dispatchEvent( new LoadingEvent( LoadingEvent.SERIES_COMPLETE ));
			}
		}
		
		public function cancel():void
		{
			try 
			{
				_loader.close();			
			}
			catch( e:Error )
			{
				
			}	
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, handleContentLoaded );
			_index = 0;
		}
		
		public function get index():int 
		{
			return _index;
		}
		
		
	}
}