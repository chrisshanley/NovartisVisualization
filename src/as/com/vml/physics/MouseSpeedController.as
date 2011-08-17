package  com.vml.physics
{
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.geom.Point;

	public class MouseSpeedController extends EventDispatcher
	{
		
		private var _stage:Stage;
		private var _speed:Number;		
		private var _oldPos:Point;
		private var _currentPos:Point
		
		private var _vx:Number;
		private var _vy:Number;
		private var _angle:Number;
		
		public function MouseSpeedController(stage:Stage)
		{
			_angle = 0;
			_vx = 0;
			_vy = 0;
			_speed = 0;
			_stage = stage;
			
			_currentPos = new Point( stage.mouseX, stage.mouseY );
			_oldPos = _currentPos;
		}
		
		public function update():void
		{
			_currentPos =  new Point( _stage.mouseX, _stage.mouseY )
			_speed = Point.distance( _currentPos, _oldPos );
			_vx =  _currentPos.x - _oldPos.x ;
			_vy =  _currentPos.y - _oldPos.y ;
			_oldPos = _currentPos;
		
		}	
		
	
		
		public function get vx():Number
		{
			return _vx;
		}
		
		public function get vy():Number
		{
			return _vy;
		}
		
		public function get speed():Number
		{
			return	_speed;			
		}
		
	}
}