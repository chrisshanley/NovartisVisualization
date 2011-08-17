package com.vml.events
{
	import flash.display.LoaderInfo;
	import flash.events.Event;

	public class LoadingEvent extends Event
	{
		
		public static const LOAD_COMPLETE:String = "loadComplete";
		public static const SERIES_COMPLETE:String = "seriesComplete";
		
		protected var _loaderInfo:LoaderInfo;
				
		public function LoadingEvent(type:String, loaderInfo:LoaderInfo = null, bubbles:Boolean=false )
		{
			super(type, bubbles );
			_loaderInfo = loaderInfo;
		}
		
		public function get loaderInfo():LoaderInfo
		{
			return _loaderInfo;	
		}
		
	}
}