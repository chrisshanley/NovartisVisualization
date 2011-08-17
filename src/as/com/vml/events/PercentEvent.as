package com.vml.events
{
	import flash.events.Event;

	public class PercentEvent extends Event
	{
		
		public static const PERCENT:String = "percent";
		
		public var data:Object;
		public var percent:Number;
		
		public function PercentEvent(type:String, percent:Number, bubbles:Boolean = false, data:Object = null)
		{
			super(type, bubbles );
			this.data = data;
			this.percent = percent;
		}
		
		override public function clone():Event
		{
			return new PercentEvent( type, percent, bubbles, data ) as Event;
		}
		
	}
}