package com.vml.events
{
	import flash.events.Event;

	public class AudioEvent extends Event
	{
		
		public static const STOPPED:String = "stopped";
		public static const RESTART:String = "restart";
		public static const STARTED:String = "started";
		public static const FINISHED:String = "finished";
		
		
		private var _data:Object;
		
		public function AudioEvent( type:String, data:Object = null )
		{
			super(type );
			_data = data;
		}
		
		public function get data():Object
		{
			return _data;
		}
		
	}
}