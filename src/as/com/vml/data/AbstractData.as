package com.vml.data
{
	import com.vml.interfaces.IData;
	
	import flash.events.EventDispatcher;

	public class AbstractData extends EventDispatcher implements IData
	{
		
		protected var _name:String;
		protected var _id:int;
		protected var _active:Boolean;
		
		public function AbstractData()
		{
		}

		public function toXML():XML
		{
			var xml:XML = new XML( <data></data> );
			var node:XML;
			var child:XML;
			var i:int = 0;
			var j:int;
			var obj:Object
			
			for( i; i < readableTypes.length; i++ )
			{
				if( this[readableTypes[i]] is Array )
				{
					node = new XML( "<"+readableTypes[i]+">"+"</"+readableTypes[i]+">" );
					j = 0;
					for( j; j < this[readableTypes[i]].length; j++ )
					{
						obj = this[readableTypes[i]][j];
						if( obj.hasOwnProperty( 'toXML' ) )
						{
							node.appendChild( obj.toXML() );
						}
						else 
						{
							child = new XML( "<element"+j+">"+obj+"</element"+j+">" );
							node.appendChild( child );
						}
					}
				}
				else 
				{
					node = new XML( "<"+readableTypes[i]+">"+this[readableTypes[i]]+"</"+readableTypes[i]+">" );
				}
				xml.appendChild( node );
			}
			return xml;
		}
		
		
		
		public function get readableTypes():Array
		{
			return [];
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function set name(value:String):void
		{
			_name = value
		}
		
		public function get id():int
		{
			return _id;
		}
		
		public function set id(value:int):void
		{
			_id = value;
		}
		
		public function get active():Boolean
		{
			return _active;
		}
		
		public function set active( value:Boolean ):void
		{
			_active = value;
		}
		
	}
}