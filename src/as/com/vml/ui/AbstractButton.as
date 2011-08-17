package com.vml.ui
{
	import com.vml.events.ButtonEvent;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	[Event(type="com.vml.events.ButtonEvent", name="onClick")]
	[Event(type="com.vml.events.ButtonEvent", name="onOver")]
	[Event(type="com.vml.events.ButtonEvent", name="onOut")]
	[Event(type="com.vml.events.ButtonEvent", name="onPress")]
	[Event(type="com.vml.events.ButtonEvent", name="onRelease")]
	public class AbstractButton extends MovieClip
	{
		
		protected var _id:int;
		protected var _active:Boolean;
		protected var _bubbles:Boolean;
				
		public function AbstractButton()
		{
			super();
			_active = true;
			buttonMode = true;
			addEvents();
		}
		
		public function addEvents():void
		{
			addEventListener( MouseEvent.CLICK, handleClick );
			addEventListener( MouseEvent.MOUSE_OVER, handleOver );
			addEventListener( MouseEvent.MOUSE_OUT, handleOut );
		}
		
		public function removeEvents():void
		{
			removeEventListener( MouseEvent.CLICK, handleClick );
			removeEventListener( MouseEvent.MOUSE_OVER, handleOver );
			removeEventListener( MouseEvent.MOUSE_OUT, handleOut );	
		}
		
		protected function handleOver( event:MouseEvent ):void
		{
			if( _active )
			{
				dispatchEvent( new ButtonEvent ( ButtonEvent.ON_OVER, _bubbles, {id:_id} ));	
			}
		}
		
		protected function handleOut( event:MouseEvent ):void
		{
			if( _active )
			{
				dispatchEvent( new ButtonEvent ( ButtonEvent.ON_OUT, _bubbles, {id:_id} ));
			}
		}
		
		protected function handleClick( event:MouseEvent ):void
		{
			
			if( _active )
			{
				dispatchEvent( new ButtonEvent ( ButtonEvent.ON_CLICK, _bubbles, {id:_id} ));
			}
		}
		
		
		
		
		
		
		
		public function set active( value:Boolean ):void
		{
			_active = value;
		}
		
		public function get active( ):Boolean
		{
			return _active;
		}
		
		
		public function set id( value:int ):void
		{
			_id = value;
		}
		
		public function get id():int 
		{
			return _id;
		}
		
		
		public function set bubbles(  value:Boolean ):void
		{
			_bubbles = value;
		}
		
		public function get bubbles( ):Boolean 
		{
			return _bubbles;
		}
		
		
		
		
	}
}