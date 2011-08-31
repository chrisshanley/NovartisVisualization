
package com.visualizer.data
{
	public class IdeaGroup
	{
		
		private var _ideas:Array;
		private var _radius:int;
		
		public function IdeaGroup( ideas:Array )
		{
			_ideas = ideas;

		}
		
		public function set radius( value:int ):void
		{
			_radius = value;
		}
	
		public function get radius():int
		{
			return _radius;
		}
			
		public function get ideas():Array
		{
			return _ideas;
		}
	}
}