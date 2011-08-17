package com.vml.core
{
	public dynamic class VMLObject extends Object
	{
		public function VMLObject()
		{
			super();
		}
		
		public function removeObject( key:String ):VMLObject
		{
			var obj:VMLObject = new VMLObject();
			var prop:String;
			
			for( prop in this )
			{
				if( prop != key )
				{
					obj[ prop ] = this[prop];
				}
			}
			return obj;
		}
		
		public function get length():int
		{
			var i:int = 0;
			var prop:String;
			for( prop in this )
			{
				i ++; 
			}
			return i;
		}
		
		public function push( name:String, value:Object ):Object
		{
			this[name] = value;
			return this[name];
		}
		
		public function getObjectIndex( obj:Object ):int
		{
			var index:int = 0;
			var prop:String;
			for( prop in this )
			{
				if( this[prop] == obj )
				{
					break;
				}
				index ++; 
			}
			return index;
				
		}
		
		public function contains( obj:Object ):Boolean
		{
			var prop:String;
			var contains:Boolean
			for( prop in this )
			{
				if( this[prop] == obj)
				{
					contains = true;
					break;
				}
			}
			return contains;
		}
		
		public function clear():void
		{
			var prop:String;
			for( prop in this )
			{
				this[prop] = null;
			}
		}
		
	}
}