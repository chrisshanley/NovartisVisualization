package com.vml.data
{
	import com.vml.interfaces.IModel;
	import com.vml.net.AbstractService;
	
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class AbstractModel extends EventDispatcher implements IModel
	{
		
		
		private static var _instance:IModel;
		
		protected var _info:LoaderInfo;
		protected var _configData:XML;
		
		public function AbstractModel(  )
		{
			
		}
		
	
		
		public function init(info:LoaderInfo, key:String = "dataPath" ):void
		{
			_info = info;
			var url:String = ( _info.parameters[key] != null ) ? info.parameters[key] : "../xml/config.xml"; 
			var loader:AbstractService = new AbstractService();
			loader.addEventListener(Event.COMPLETE, handleInit );
			loader.loadService( url );
		}
		
		protected function handleInit(event:Event):void
		{
			var loader:AbstractService = event.target as AbstractService;
			loader.removeEventListener(Event.COMPLETE, handleInit );
			_configData = new XML( loader.xml );
			loader = null;
			dispatchEvent( new Event( Event.INIT ));
		}
		
		public function get configData():XML
		{
			return _configData;
		}
		
		public function get loaderInfo():LoaderInfo
		{
			return _info;
		}
		
		public function get language( ):String
		{
			return _info.parameters.language;
		}
		
	}
}