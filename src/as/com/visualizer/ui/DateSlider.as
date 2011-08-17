package com.visualizer.ui
{
	import com.visualizer.events.VisualizerEvent;
	import com.visualizer.views.SortView;
	import com.vml.text.VMLTextField;
	import com.vml.ui.AbstractSlider;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import org.osmf.net.dynamicstreaming.INetStreamMetrics;
	
	public class DateSlider extends AbstractSlider
	{
		
		private var _ranges:Array;
		private var _model:Model;
		private var _current:VMLTextField;
		private var _label:VMLTextField;
		private var _closestIndex:int;
		

		
		public function DateSlider()
		{
			super();
		trace( this )
			_ranges = new Array();
			_model = Model.getInstance();
			addEventListener(Event.ADDED_TO_STAGE, handleOnStage );
			
			track = new DateSliderTrack();
			addChild( track );
			handle = new DateSliderHandle();
			addChild( handle );
			handle.y = 1;
			handle.x = 1;
			super.bounds = new Rectangle( 0, 1, track.width - ( handle.width + 3 ), 0 );
			super.addEvents();
		}
		
		private function handleOnStage( event:Event ):void
		{
			_label = new VMLTextField( _model.configData.display.datesearcher, _model.configData.display.datesearcher.@format ); 
			_label.x = ( _label.width + 10 ) * -1;
			addChild( _label );
			
			var child:XML;
			var num:int;
			var i:int = 0;
			for each( child in _model.configData.display.dateslider.children() )
			{
				num = ( i /_model.configData.display.dateslider.children().length() )  * _bounds.width;
				i++;
				_ranges.push( num );
			}
			
			_current = new VMLTextField( "", SortView.format );
			
			_current.x = track.x + track.width + 10;
			addChild( _current );	
		}
		
		override protected function onUpdatePosition(event:Event):void
		{
			var index:int;
			var closestRang:Number = _bounds.width;;
			var distance:Number; 
			var range:Number;
			
			for each( range in _ranges )
			{
				distance = Math.abs( handle.x - range );
				if( distance < closestRang )
				{
					index = _ranges.indexOf( range );
					closestRang = distance;		
				}	
			}
			closestIndex = index;	
			super.onUpdatePosition( event );
		}
		
		public function set closestIndex( value:int ):void
		{
			if( _closestIndex != value )
			{
				_closestIndex = value;
				_current.htmlText = "";
				_current.htmlText = _model.configData.display.dateslider.item.(attribute("id") == _closestIndex.toString() );
			}
		}
		
		
		override protected function handleStopDrag(event:MouseEvent):void
		{
			super.handleStopDrag( event );
			dispatchEvent( new VisualizerEvent(VisualizerEvent.DATE_SELECTED, true ) );
		}
		
		public function get dateIndex( ):int
		{
			return _closestIndex;
		}
		
	
		
	
		
		
	}
}