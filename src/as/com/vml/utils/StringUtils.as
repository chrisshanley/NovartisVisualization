package com.vml.utils
{
	public class StringUtils
	{
		public function StringUtils()
		{
		}
		
		public static function hasCharacters( string:String ):Boolean
		{
			var number:Number = Number( string );
			return ( isNaN( number ) ) ? true : false;
		}

	}
}