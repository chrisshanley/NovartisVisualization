package com.vml.physics
{
	import com.vml.interfaces.IPhysicsObject;
	import com.vml.utils.MathUtils;
	
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.geom.Point;

	public class PhysicsObject extends EventDispatcher implements IPhysicsObject
	{
		
		
		private var _world:Stage;
		private var _speed:Number;		
		private var _oldPos:Point;
		private var _currentPos:Point
	
		private var _vx:Number;
		private var _vy:Number;
		private var _angle:Number;
		private var _view:DisplayObject;
		private var _active:Boolean;
		
		private static const FRICTION:Number = 0.7;
		
		public function PhysicsObject(view:DisplayObject, world:Stage)
		{
			_view = view;
			_world = world;
			_vx = 0;
			_vy = 0;
			_speed = 0;
			_angle = 0;
			_currentPos = new Point( _view.x , _view.y );
			_oldPos = _currentPos;
		}
		
		
		public function update():void
		{
			var dx:Number = 0;
			var dy:Number = 0;
			if( _active )
			{
				_view.x += _vx;
				_view.y += _vy;
				
				_vx *= PhysicsObject.FRICTION;
				_vy *= PhysicsObject.FRICTION;
				_currentPos = new Point( _view.x, _view.y );
				
				dx = Math.abs( _currentPos.x - 0 );
				dy = Math.abs( _currentPos.y - 0 );
				
				_angle = MathUtils.radiansToDegrees( Math.atan2( dy, dx ) );
				_oldPos = _currentPos;
	
			}	
		}
		
		
		
		public function get active():Boolean
		{
			return _active;
		}
		
		public function set active( value:Boolean ):void
		{
			_active = value;
		}
		
		
		
		public function get angle():Number
		{
			return _angle;
		}
		
		public function set angle(value:Number):void
		{
			_angle = value;
		}
		
		public function get spped():Number
		{
			return _speed;
		}
		
		public function set speed(value:Number):void
		{
			_speed = value
		}
		
		public function get vx():Number
		{
			return _vx;
		}
		
		public function set vx(value:Number):void
		{
			_vx = value;
		}
		
		public function get vy():Number
		{
			return _vy;
		}
		
		public function set vy(value:Number):void
		{
			_vy = value;
		}
		
		
		public function get view():DisplayObject
		{
			return _view;
		}
	}
}