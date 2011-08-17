package com.vml.utils
{
	import com.vml.views.AbstractView;
	
	public class ViewUtils
	{
		
		private static var _instance:ViewUtils;
		
		private var _currentSection:AbstractView;
		
		public function ViewUtils( key:Key )
		{
		}
		
		public static function getInstance():ViewUtils
		{
			if( !_instance )
			{
				_instance = new ViewUtils( new Key() );
			}
			
			return _instance;
		}
		
		
		public function get currentSection( ):AbstractView 
		{
			return _currentSection;
		}
		
		public function set currentSection( value:AbstractView ):void
		{
			_currentSection = value;
		}
		
		public function clear():void
		{
			_currentSection = null;
		}

	}
}

class Key{}