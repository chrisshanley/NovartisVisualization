package com.visualizer.data
{
	import mx.core.UIComponentDescriptor;

	public class Category
	{
		private var _name:String;
		private var _colors:Array;
		private var _display:Boolean;
		
		public function Category(name:String, colors:Array, display:Boolean )
		{
			_colors = colors;
			_name  = name;
			_display = display;
		}
		
		public function display():Boolean
		{
			return _display;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function get colors():Array
		{
			return _colors;
		}
	}
}