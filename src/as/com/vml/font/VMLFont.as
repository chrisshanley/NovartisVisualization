package com.vml.font
{
	import flash.text.Font;

	public class VMLFont extends Font
	{
		
		protected var _id:String;
		
		public function VMLFont(  )
		{
			super();
		}
		
		public function set id( value:String ):void
		{
			_id = value;
		}
		
		public function get id():String
		{
			return _id;
		}
		
	}
}