/**
 * AbstractSlider Class
 * Stage instances 
 *
 * PUBLIC
 * @track - a sprite on the stage marking the bounding box of the handle can slide
 * @handle - a sprite on the state that is the object user can drag
 * 
 * PROTECTED
 * @_bounds - the rectange that is sets on start drag
 * @_active - boolean value, set to true when slider is in use, read only
 * 
 * EVENTS
 * PercentEvent.PERCENT 
 * 
 * NOTES
 * 
 * 
 *  */

package com.vml.ui
{
	import com.vml.events.PercentEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	[Event(name="percent", type="com.vml.events.PercentEvent")]
	public class AbstractSlider extends Sprite
	{
		
		
		public var track:Sprite;
		public var handle:Sprite;
		
		protected var _bounds:Rectangle;
		protected var _active:Boolean;
		protected var _bubbleEvent:Boolean;
		protected var _percent:Number;
		
		
		public function AbstractSlider()
		{
			super();	
			_percent = 0;
		}
		
		public function set bounds( value:Rectangle ):void
		{			
			_bounds = value;
		}
		
		override public function set width(value:Number):void
		{
			track.width = value;
			_bounds.width = track.width - handle.width;
		}
		
		public function addEvents():void
		{
			handle.buttonMode = true;
			handle.addEventListener( MouseEvent.MOUSE_DOWN, handleStartDrag );
			handle.addEventListener( MouseEvent.MOUSE_UP, handleStopDrag );		
		}
		
		public function removeEvents():void
		{
			handle.buttonMode = false;
			handle.removeEventListener( MouseEvent.MOUSE_DOWN, handleStartDrag );	
			handle.removeEventListener( MouseEvent.MOUSE_UP, handleStopDrag );	
			stage.removeEventListener( MouseEvent.MOUSE_UP, handleStopDrag );	
			removeEventListener(  Event.ENTER_FRAME, onUpdatePosition );
		}
		
		protected function handleStartDrag( event:MouseEvent ):void
		{
			_active = true;
			stage.addEventListener( MouseEvent.MOUSE_UP, handleStopDrag );	
			addEventListener( Event.ENTER_FRAME, onUpdatePosition );
			handle.startDrag( false, _bounds );
		}
		
		protected function handleStopDrag( event:MouseEvent ):void
		{
			_active = false;
			removeEventListener( Event.ENTER_FRAME, onUpdatePosition );
			stage.removeEventListener( MouseEvent.MOUSE_UP, handleStopDrag );
			handle.stopDrag();
		}
		
		protected function onUpdatePosition( event:Event ):void
		{
			_percent = handle.x / _bounds.width;
			dispatchEvent( new PercentEvent( PercentEvent.PERCENT, percent, _bubbleEvent ));	
		} 
		
		
		public function get bounds():Rectangle
		{
			return _bounds;
		}
		
		
		public function set percent( value:Number ):void
		{
			_percent = value;
		}
		
		public function set bubbleEvent( value:Boolean ):void
		{
			_bubbleEvent = value;
		}
		
		public function get active( ):Boolean
		{
			return _active;
		}
		
		public function reset():void
		{
			handleStopDrag( null );
			handle.x = 0;
		}
		
		public function get percent():Number
		{
			return _percent;
		}

		
		
		
	}
}