package com.vml.events
{
	import flash.events.Event;

	public class ModelEvent extends Event
	{
		
		public static const DATA_LOADED:String = "dataLoaded";
		public static const MODEL_NOT_INITIALIZED:String = "modelNotInitialized";
		public static const MODEL_INITIALIZED:String = "modelInitialized";
		
		protected var _dataname:String
		protected var _data:Object;
		
		public function ModelEvent(type:String, dataname:String = null, data:Object = null)
		{
			super( type );
			_dataname = dataname;
			_data = data;
		}
		
		public function get data():Object
		{
			return _data;
		}
		
		public function get dataname():String
		{
			return _dataname;
		}
		
	}
}