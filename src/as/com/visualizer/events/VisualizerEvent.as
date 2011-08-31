package com.visualizer.events
{
	import flash.events.Event;
	
	public class VisualizerEvent extends Event
	{
		public static const CATEGORY_SELECTED:String = "categorySelected";
		public static const DATE_SELECTED:String = "dateSelectedTest";
		public static const DETAILS_UPDATE:String = "detailsUpdate";
		
		public static const IDEA_OVER:String = "ideaOver";
		public static const IDEA_OUT:String = "ideaOut";
		public static const IDEA_CLICK:String = "ideaClick";
		
		public static const IDEA_DATA_LOADED:String = "ideaDataLoaded";
		
		private var _data:Object;
		
		public function VisualizerEvent(type:String, bubbles:Boolean=false , data:Object = null)
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