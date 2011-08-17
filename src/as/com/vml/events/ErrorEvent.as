package com.vml.events
{
	import flash.events.Event;

	public class ErrorEvent extends Event
	{
		
		public static const ERROR:String = "error";
		
		
		protected var _message:String;
		
		
		public function ErrorEvent(type:String, message:String, bubbles:Boolean=false )
		{
			super(type, bubbles);
			_message = message;
		}
		
		public function get message():String
		{
			return _message;
		}
		
		override public function clone():Event
		{
			return new ErrorEvent( type, _message, bubbles ) as Event;
		}
		
		
		
		
	}
}