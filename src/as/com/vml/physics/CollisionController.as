package com.vml.physics
{
	import flash.display.Stage;
	import flash.events.EventDispatcher;

	public class CollisionController extends EventDispatcher
	{
		
		private var _bounds:Stage;
		private var _objects:Array;
		
		public function CollisionController( bounds:Stage, objects:Array )
		{
			_objects = objects;
			_bounds =  bounds;	
		}
		
		public function update():void
		{
			var obj:PhysicsObject;
			for each( obj in _objects )
			{
				if( obj.active )
				{
					checkCollision( obj );
				}
			}
		}
		
		
		private function checkCollision( obj:PhysicsObject ):void
		{
			if( obj.view.x < 0 )
			{
				obj.view.x = 0;
				obj.vx *= -1;		
			}
			
			if( obj.view.x > _bounds.stageWidth - obj.view.width )
			{
				obj.view.x = _bounds.stageWidth - obj.view.width;
				obj.vx *= -1;	
			}
			
			if( obj.view.y < 0 )
			{
				obj.view.y = 0;
				obj.vy *= -1	
			}
			
			if( obj.view.y > _bounds.stageHeight - obj.view.height )
			{
				obj.view.y = _bounds.stageHeight - obj.view.height;
				obj.vy *= -1;
			}
		}
		
		
	}
}