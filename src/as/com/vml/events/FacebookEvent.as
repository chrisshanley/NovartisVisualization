package com.vml.events
{
	import flash.events.Event;
	
	public class FacebookEvent extends Event
	{
		
		public static const DATA_LOADED:String = "dataLoaded";
		public static const IMAGE_LOADED:String = "imageLoaded"
		public static const REQUEST_LOGIN:String = "requestLogin";
		
		private var _data:Object;
		
		public function FacebookEvent(type:String, bubbles:Boolean = false, data:Object = null )
		{
			super(type, bubbles );
			_data = data;
		}
		
		public function get data():Object
		{
			return _data;
		}
	}
}