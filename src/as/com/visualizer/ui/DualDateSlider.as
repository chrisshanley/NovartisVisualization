package com.visualizer.ui
{
	import com.visualizer.events.VisualizerEvent;
	import com.vml.text.VMLTextField;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextFieldAutoSize;
	
	public class DualDateSlider extends Sprite
	{
		
		private static const left:String = "left";
		private static const right:String = "right";
		
		private var _rightSlider:TrackSlider;
		private var _leftSlider:TrackSlider;
		
		private var _rightBounds:Rectangle;
		private var _leftBounds:Rectangle;
		private var _track:DateSliderTrack;
		
		private var _rightPercent:Number;
		private var _leftPercent:Number;
		
		private var _dates:Array;
		
		private var _dragging:Boolean;
		private var _state:String;
		
		private var _startDateCopy:VMLTextField;
		private var _endDateCopy:VMLTextField;
		
		public function DualDateSlider(  )
		{
			super();
			_track       = new DateSliderTrack();
			_rightSlider = new TrackSlider( new DateSliderHandle() );	
			_leftSlider  = new TrackSlider( new DateSliderHandle() ); 
			
			_rightSlider.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown );
			_leftSlider.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown );
			
			_leftSlider.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp );
			_rightSlider.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp );
			
			
			
			addChild( _track );
			addChild( _rightSlider );
			addChild( _leftSlider );
	
			_rightSlider.x = _track.width - ( _rightSlider.width + 2 );
	
			_leftBounds  = new Rectangle( 0, 0, _track.width - ( _leftSlider.width * 2 ), 0 );
			_rightBounds = new Rectangle( _leftSlider.width, 0, _track.width - ( _rightSlider.width * 2 + 2 ) , 0 );
		
			_leftSlider.name = DualDateSlider.left;
			_rightSlider.name = DualDateSlider.right;
			addEventListener( Event.ADDED_TO_STAGE, handleOnStage );
			
			dates = [ Model.getInstance().startDate, Model.getInstance().endDate ];
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
			dispatchEvent( new Event( Event.CHANGE, true) );
		}
		
		public function set state( value:String ):void
		{
			_state = value;
		}
		
		private function handleMouseDown( event:MouseEvent ):void
		{
			_dragging = true;
			var handle:TrackSlider = event.currentTarget as  TrackSlider;
			var b:Rectangle = ( handle.name == DualDateSlider.right ) ? _rightBounds : _leftBounds;	
			state = ( handle.name == DualDateSlider.right ) ? DualDateSlider.right : DualDateSlider.left;	
			addEventListener( Event.ENTER_FRAME, handleEnterFrame );
			handle.startDrag( false, b );
		}
		
		public function get state():String
		{
			return _state;
		}
		
		private function handleMouseUp( event:MouseEvent ):void
		{
			if( _dragging )
			{			
				removeEventListener( Event.ENTER_FRAME, handleEnterFrame );
				dispatchEvent( new VisualizerEvent( VisualizerEvent.DATE_SELECTED, true ));
				_leftSlider.stopDrag();
				_rightSlider.stopDrag();		
			}
			_dragging = false;
		}
		
		
		public function get leftPercent():Number
		{
			return _leftSlider.x / ( _track.width - _leftSlider.width );
		}
		
		public function get rightPercent( ):Number
		{
			return _rightSlider.x / ( _track.width - _rightSlider.width )
		}
		
		public function set dates( value:Array ):void
		{
			var leftDate:Date    = value[ 0 ];
			var rightDate:Date   = value[ 1 ];
			var leftArry:Array   = leftDate.toDateString().split( " " );
			var righArray:Array  = rightDate.toDateString().split( " " );
			
			var startDate:String = leftArry[1] + " " + leftArry[2] + " " +leftArry[3];
			var endDate:String   =  righArray[1] + " " + righArray[2] + " " +righArray[3]; 	
			if( !_startDateCopy )
			{
				createTextFields( startDate, endDate);
			}
			
			
			_startDateCopy.htmlText = startDate;
			_endDateCopy.htmlText   = endDate;
		}
		
		private function createTextFields(startDate:String , endDate:String):void
		{
			_startDateCopy = new VMLTextField( startDate, "date-format" );
			_endDateCopy   = new VMLTextField( endDate, "date-format" );
			
			_startDateCopy.x =  ( _startDateCopy.width + 10 ) * -1;
			_endDateCopy.x   = _track.width + 10;
			
			addChild( _startDateCopy );
			addChild( _endDateCopy );
		}
	}
}