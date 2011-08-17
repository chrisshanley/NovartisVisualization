package com.vml.ui
{
	import com.vml.events.ButtonEvent;
	
	import flash.events.MouseEvent;
	
	public class ToggleButton extends AbstractButton
	{
	
		protected var _frame:int;
		
		public function ToggleButton()
		{
			super();
			gotoAndStop( 1 );
			_frame = 1;
		}
		
		override protected function handleClick(event:MouseEvent):void
		{
			_frame = ( _frame == 1 ) ? 2 : 1;
			gotoAndStop( _frame );
			dispatchEvent( new ButtonEvent( ButtonEvent.ON_CLICK, _bubbles, {value:_frame} ) );
		}
		
		
		
		
		public function set frame( value:int ):void
		{
			_frame = value;
		}
		
		public function get frame( ):int
		{
			return _frame;
		}
		
		
		
		
	}
}