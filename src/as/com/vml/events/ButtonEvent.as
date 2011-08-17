package com.vml.events
{
	import flash.events.Event;

	public class ButtonEvent extends Event
	{
		
		public static const ON_CLICK:String = "onClick";
		public static const ON_OVER:String = "onOver";
		public static const ON_OUT:String = "onOut";
		
		public static const ON_PRESS:String = "onPress";
		public static const ON_RELEASE:String = "onRelease";
		
		public var data:Object;
		
		public function ButtonEvent(type:String, bubbles:Boolean=false, data:Object = null)
		{
			super( type, bubbles );
			this.data = data;
		}
		
		override public function clone():Event
		{
			return new ButtonEvent( type, bubbles, data ) as Event;
		}
		
	}
}