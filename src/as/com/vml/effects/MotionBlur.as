package com.vml.effects
{
	import flash.display.DisplayObject;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	
	public class MotionBlur
	{
		private static const MAX_BLUR:Number = 10;
		private static const MAX_SPEED:Number = 10; 
		
		private var _blur:BlurFilter;
		private var _view:DisplayObject;
		private var _currentPos:Point;
		private var _previousPos:Point;
		
		public function MotionBlur(view:DisplayObject)
		{
			_blur = new BlurFilter( 0, 0 );
			_view = view;			
			_view.filters = [_blur];
			_currentPos = new Point( _view.x, _view.y );
			_previousPos = _currentPos;
		}
		
		public function update():void
		{
			_currentPos = new Point( _view.x, _view.y );
			var vx:Number = _currentPos.x - _previousPos.x;
			var vy:Number = _currentPos.y - _previousPos.y;
			var percent_x:Number = vx / MotionBlur.MAX_SPEED;
			var percent_y:Number = vy / MotionBlur.MAX_SPEED;
			_blur.blurX = Math.abs( percent_x * MotionBlur.MAX_BLUR );
			_blur.blurY = Math.abs( percent_y * MotionBlur.MAX_BLUR );
			_view.filters = [_blur];
			_previousPos = _currentPos;
		}
		
		
		

	}
}