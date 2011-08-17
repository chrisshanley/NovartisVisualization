
package com.visualizer.data
{
	public class IdeaGroup
	{
		
		private var _ideas:Array;
		private var _radius:int;
		
		public function IdeaGroup( ideas:Array , radius:int )
		{
			_ideas = ideas;
			_radius = radius;
		}
		
		public function get ideas():Array
		{
			return _ideas;
		}
		
		public function get radius():int
		{
			return _radius;
		}
	}
}