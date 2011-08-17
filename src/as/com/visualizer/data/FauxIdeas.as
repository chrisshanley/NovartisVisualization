package com.visualizer.data
{
	import org.osmf.layout.AbsoluteLayoutFacet;

	public class FauxIdeas
	{
		private var _dummy:Array;
		
		public function FauxIdeas( itemsToFake:int = 0 )
		{
			var i:int = 0;
			var len:int = ( itemsToFake == 0 ) ? Math.random() * 100 : itemsToFake;
			var data:IdeaData;
			var cat:String
			var types:Array = ["yellow", "orange", "brown"];
			
			_dummy = new Array();
			
			for( i; i < len; i ++ )
			{
				cat = types[ i % types.length ];
				data = new IdeaData( "Test idea copy",  i,cat , int(Math.random() * 1000)   );
				_dummy.push( data );
			}
		}
		
		public function get dummy():Array
		{
			return _dummy;	
		}
	}
}