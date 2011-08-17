/**
 * author chris shanley
 *   */

package com.vml.utils
{
	public class ArrayUtils
	{
		public function ArrayUtils()
		{
		}
		
		
		public static function clone( array:Array ):Array
		{
			var clone:Array = new Array();
			var i:int = 0;
			for( i; i < array.length; i++ )
			{
				clone.push( array[i] );
			}
			return clone;
		}
		
		public static function inArray( value:Object, array:Array ):Boolean 
		{
			var i:int = 0;
			var exists:Boolean = false;
			for( i; i < array.length; i++ )
			{	
				if(array[i] == value )
				{
					exists = true;
					break;
				}
			}
			return exists
		}
		
		/**
		 * takes two arrays , arrays can be of primitive types or not, loops through the baseArray, check
		 * to see if there are any matches in the checkArray and removes them from the check array, the
		 * check array is then returned;
		 * 
		 * @baseArray - the array you compare the checkArray elements agains
		 * @checkArray - the arrray that is modified and remvoed, any copies from baseArray 
		 * @searchProp - and prop of the object type in base array baseArray , 
		 * 
		 *   */
		
		public static function compareAndRemove( baseArray:Array, checkArray:Array, searchProp:* = null ):Array
		{
			var i:int = 0;
			var j:int;
			var element:Object;	
			var checkObject:Object;
			var arrayOfDifElements:Array = new Array();
			
			for( i; i < baseArray.length; i++ )
			{
				if( searchProp )
				{
					element = baseArray[i][searchProp].toString().toLowerCase();
				}
				else 
				{
					element = baseArray[i].toString().toLowerCase();	
				}
				
				j = 0;
				for( j; j < checkArray.length; j++ )
				{
					if( element == checkArray[j].toString().toLowerCase() )
					{
						checkArray.splice( j, 1 );
					}		
				}
			}	
			return checkArray;	
		}
		
		
		
		
		public static function getElementIndex( element:Object, array:Array ):int
		{
			var i:int = 0;
			var index:int = -1;
			for( i; i < array.length; i ++ )
			{
				if( element == array[i] )
				{
					index = i;
					break;
				}
			}
			return index;
		}
		
	 	
		public static function removeEmptyElemts( array:Array , checkEmptyString:Boolean = true ):Array
		{
			var i:int = 0;
			for( i; i < array.length; i ++ )
			{	
				if( array[i] == undefined || !StringUtils.hasCharacters( array[i].toString() ) )
				{
					array.splice( i, 1 );
				}
			}
			return array;
		}
	}
}

internal class ArrayElement
{
	private var _type:Class;
	private var _exists:Boolean;
	private var _obj:Object;
	
	public function ArrayElement( obj:Object )
	{
		_obj = obj;
	}
	
	public function get obj():Object
	{
		return _obj
	}
	
	public function set exists( value:Boolean ):void
	{
		_exists = value;
	}
	
	public function get exists():Boolean
	{
		return _exists;
	}
	
	
}