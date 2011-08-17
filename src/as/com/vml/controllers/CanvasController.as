package com.vml.controllers
{
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import com.vml.core.VMLObject;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class CanvasController extends EventDispatcher
	{
		
		private var _stage:Stage;
		private var _que:VMLObject;
		
		public function CanvasController(stage:Stage)
		{
			_que = new VMLObject();
			_stage = stage;
			_stage.addEventListener( Event.RESIZE, update );
			_stage = stage;
		}
		
		public function addObject( obj:DisplayObject ):void
		{
			_que[obj.name] = obj;
			update( null );
		}
		
		public function removeFromQue( obj:DisplayObject ):void
		{
			_que = _que.removeObject( obj.name );
		}
		
		public function update( event:Event ):void
		{			
			
			var obj:DisplayObject;
		
			for each( obj in _que )
			{
				obj.width = _stage.stageWidth;
				obj.scaleY = obj.scaleX;
				
				if (obj.height < _stage.stageHeight ) 
				{
					obj.height = _stage.stageHeight ;
					obj.scaleX = obj.scaleY;
				}				
				obj.x = _stage.stageWidth * 0.5 - obj.width * 0.5;
				obj.y = _stage.stageHeight - obj.height;
			}
		}
		
	}
}