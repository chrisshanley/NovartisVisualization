package com.vml.events
{
	import flash.events.Event;

	public class ViewEvent extends Event
	{
		
		public static const REMOVE_VIEW:String = "removeView";	
		public static const ADD_VIEW:String = "addView";	
		
		public static const ANIMATE_OUT_COMPLETE:String = "animateOutComplete";
		public static const ANIMATE_IN_COMPLETE:String = "animateInComplete";
		
		public static const ANIMATE_SHOW_COMPLETE:String = "animateShowComplete";
		public static const ANIMATE_HIDE_COMPLETE:String = "animatHideComplete";
		
				
		public var data:Object
		public function ViewEvent(type:String, bubbles:Boolean=false, data:Object = null)
		{
			super(type, bubbles );
			this.data = data;
		}
		
		override public function clone():Event
		{
			return new ViewEvent( this.type, this.bubbles, this.data) as Event;
		}
		
	}
}