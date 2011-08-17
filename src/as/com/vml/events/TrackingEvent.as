package com.vml.events
{
	import flash.events.Event;

	public class TrackingEvent extends Event
	{
		public static const TRACK:String = "track";
		
		public static const YAHOO:String = "yahoo";
		public static const WEBIQ:String = "webiq";
		public static const MEDIAMIND:String = "mediamind";
		
		
		private var _trackingId:String;
		private var _trackLink:Boolean;
		private var _params:Array;
		
		public function TrackingEvent(type:String, trackingId:String, trackLink:Boolean = false, trackLinkParams:Array = null, bubbles:Boolean=true)
		{
			super(type, bubbles );
			_trackingId = trackingId;
			_trackLink = trackLink;
			_params = trackLinkParams;
		}
		
		public function get trackingId():String
		{
			return _trackingId;
		}
		
		public function get trackLink():Boolean
		{
			return	_trackLink; 
		}
		
		public function get params():Array
		{
			return _params;
		}
		
	}
}