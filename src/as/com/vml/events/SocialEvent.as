package com.vml.events
{
	import flash.events.Event;

	public class SocialEvent extends Event
	{
		
		public static const SHARE:String = "share";
		
		public var data:Object;
		
		public function SocialEvent(type:String, bubbles:Boolean=false, data:Object = null)
		{
			super( type, bubbles );
			this.data = data;
		}
		
	}
}