package com.vml.interfaces
{

	public interface IComponent 
	{
		
		function init():void
		function show():void;
		function hide():void;
		
		function addEvents():void;
		function removeEvents():void;		
		function destroy():void;
		
		
		function get id():int;
		function set id( value:int ):void;
		
		function get active( ):Boolean;
		function set active( value:Boolean ):void;
		
		
		
	}
}