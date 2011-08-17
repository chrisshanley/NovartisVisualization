package com.vml.interfaces
{
	public interface IData
	{
		
		function toXML():XML;
		function get readableTypes():Array;
		function get name():String;
		function set name( value:String ):void;
		function get id():int;
		function set id( value:int ):void;
	}
}