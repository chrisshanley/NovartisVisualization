package com.visualizer.data
{
	public class RingData
	{
		private var _id:int;
		private var _items:int;
		public function RingData(id:int, items:int )
		{
			_id = id;
			_items = items;
		}
		
		public function get id():int
		{
			return _id;
		}
		
		public function get items():int
		{
			return _items;
		}
	}
}