/**
 * author chris shanley
 * checks an array of strings for matches in characters
 * pushes the matches into a new array every time search is called
 *   */
package com.vml.utils
{
	
	public class StringSearcher
	{
		
		private var _words:Array;
		private var _matches:Array;
		
		private static var _instance:StringSearcher;
		
		public function StringSearcher( key:Key )
		{
			_matches = new Array();
		}
		
		
		public static function getInstance():StringSearcher
		{
			if( !_instance )
			{
				_instance = new StringSearcher( new Key() );
			}
			return _instance;
		}

		
		public function set words( value:Array ):void
		{
			_words = value;
		}
		
		public function get matches():Array
		{
			return _matches;
		}
		
	
		public function search( value:String ):void
		{
			var i:int = 0;
			var exp:RegExp = new RegExp(value, "g");
			var word:String;
			
			
			
			if( matches )
			{
				_matches = null;
				_matches = new Array();
			}
			
			for( i; i < _words.length; i ++ )
			{
				word = _words[i].toString().toLowerCase();
			
				if( word.search( exp ) > -1 )
				{
					_matches.push( word );
				}		
			}
		}
		
		public function destroy():void
		{
			_matches = null;
			_words = null;
			StringSearcher._instance = null;
		}		

	}
}

class Key { function Key(){} }