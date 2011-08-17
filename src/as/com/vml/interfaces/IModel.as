package com.vml.interfaces
{
	import flash.display.LoaderInfo;
	
	public interface IModel
	{
		function init( info:LoaderInfo, key:String = "datapath" ):void;
		function get configData():XML;
		function get loaderInfo():LoaderInfo;
	}
}