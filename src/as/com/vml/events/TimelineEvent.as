package com.vml.events
{
	import flash.events.Event;

	public class TimelineEvent extends Event
	{
		
		public var data:Object;
		public var currentFrame:int;
		
		public static const TIMELINE_ANIMATION_START:String = "animationStart";
		public static const TIMELINE_ANIMATION_AT_FRAME:String = "animationAtFrame";
		public static const TIMELINE_ANIMATION_COMPLETE:String = "timelineAnimationComplete";
			
		public function TimelineEvent(type:String, currentFrame:int, bubbles:Boolean = false, data:Object = null)
		{
			this.data = data;
			this.currentFrame = currentFrame;
			super( type, bubbles );
		}
		
	}
}