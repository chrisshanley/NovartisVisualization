package com.visualizer.ui
{
	import com.visualizer.events.VisualizerEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	public class DualDateSlider extends Sprite
	{
		
		private static const left:String = "left";
		private static const right:String = "right";
		
		private var _rightSlider:DateSliderHandle;
		private var _leftSlider:DateSliderHandle;
		
		private var _rightBounds:Rectangle;
		private var _leftBounds:Rectangle;
		private var _track:DateSliderTrack;
		
		private var _rightPercent:Number;
		private var _leftPercent:Number;
		
		private var _state:String;
	
		
		public function DualDateSlider()
		{
			super();
			
			_track       = new DateSliderTrack();
			_rightSlider = new DateSliderHandle();
			_leftSlider  = new DateSliderHandle(); 
			
			_rightSlider.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown );
			_leftSlider.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown );
			
			_leftSlider.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp );
			_rightSlider.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp );
			
			addChild( _track );
			addChild( _rightSlider );
			addChild( _leftSlider );
			
			_rightSlider.x = _track.width - _rightSlider.width;
	
			_leftBounds  = new Rectangle( 0, 0, _track.width - _leftSlider.width, 0 );
			_rightBounds = new Rectangle( _leftSlider.width, 0, _track.width - _rightSlider.width , 0 );
			_leftSlider.name = DualDateSlider.left;
			_rightSlider.name = DualDateSlider.right;
			addEventListener( Event.ADDED_TO_STAGE, handleOnStage );

		}
		
		
		private function handleOnStage( event:Event ):void
		{
			stage.addEventListener( MouseEvent.MOUSE_UP, handleMouseUp );
			addEventListener(Event.REMOVED_FROM_STAGE , handleOffStage );
		}
		
		private function handleOffStage( event:Event ):void
		{
			stage.removeEventListener( MouseEvent.MOUSE_UP, handleMouseUp );	
		}
		
		
		private function handleEnterFrame( event:Event ):void
		{
			var handle:Sprite = event.target as Sprite;
			if( _state == DualDateSlider.right )
			{
				if( _rightSlider.x < _leftSlider.x + _leftSlider.width )
				{
					_leftSlider.x = _rightSlider.x - _leftSlider.width;
				}
			}
			else
			{
				if( _leftSlider.x + _leftSlider.width >= _rightSlider.x )
				{
					_rightSlider.x = Math.ceil( _leftSlider.x + _leftSlider.width );
				}
			}
		}
		
		public function set state( value:String ):void
		{
			_state = value;
		}
		
		private function handleMouseDown( event:MouseEvent ):void
		{
			var handle:Sprite = event.target as Sprite;
			var bounds:Rectangle = ( handle.name == DualDateSlider.right ) ? _rightBounds : _leftBounds;	
			state = ( handle.name == DualDateSlider.right ) ? DualDateSlider.right : DualDateSlider.left;	
			addEventListener( Event.ENTER_FRAME, handleEnterFrame );
			handle.startDrag( false, bounds );
		}
		
		private function handleMouseUp( event:MouseEvent ):void
		{
			removeEventListener( Event.ENTER_FRAME, handleEnterFrame );
			dispatchEvent( new VisualizerEvent( VisualizerEvent.DATE_SELECTED, true ));
			_leftSlider.stopDrag();
			_rightSlider.stopDrag();
		}
		
		
		public function get leftPercent():Number
		{
			return Math.floor(_leftSlider.x ) / ( _track.width - _leftSlider.width );
		}
		
		public function get rightPercent( ):Number
		{
			return 1 - ( Math.floor(_leftSlider.x ) / ( _track.width - _leftSlider.width ) );
		}
	}
}