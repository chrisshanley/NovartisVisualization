package com.vml.data
{
	import flash.display.DisplayObject;
	
	public class StageObjectData
	{
		
		private var _view:DisplayObject;
		private var _x:Number;
		private var _y:Number;
		private var _id:int;
		
		public function StageObjectData( object:DisplayObject, x:Number, y:Number, id:int )
		{
			_view = object;
			_x = x;
			_y = y;
			_id = id;
		}
		
		public function updateX( xpercent:Number ):void
		{
			_view.x = _x * xpercent;
		}
		
		public function updateY( ypercent:Number ):void
		{
			_view.y = _y * ypercent;			
		}
		
		public function get view():DisplayObject 
		{
			return _view;
		}
		
		public function get id():int
		{
			return _id;
		}
		
		public function destroy():void
		{
			_view = null
			_x = NaN;
			_y = NaN;
		}
		

	}
}