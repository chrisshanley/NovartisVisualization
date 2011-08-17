package com.vml.events
{
	import flash.events.Event;

	public class DisplayEvent extends Event
	{
		public static const SET_HIGHEST_DEPTH:String = "setHighestDepth";
		public static const START_DRAG_OBJECT:String = "startDragObject";
		public static const HIT_CHECK:String = "hitCheck";
		public static const COLLISION_HAPPENED:String = "collisionHappened";
		
		private var _data:Object;	
		public function DisplayEvent(type:String, bubbles:Boolean=false, data:Object = null )
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