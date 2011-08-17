package com.vml.views
{
	import com.vml.events.ViewEvent;
	
	import flash.display.MovieClip;

	[Event(name="animateOutComplete", type="com.vml.events.ViewEvent")]
	[Event(name="animateInComplete", type="com.vml.events.ViewEvent")]
	public class AbstractView extends MovieClip
	{
		protected var _data:XMLList;
		protected var _active:Boolean;
		protected var _id:int;
		
		public function AbstractView()
		{
			super();
		}
		
		public function init( ):void
		{
			
		}
		
		
		public function animateIn():void
		{
		}
		
		protected function notifyAnimateInComplete():void
		{
			this.dispatchEvent( new ViewEvent(ViewEvent.ANIMATE_IN_COMPLETE));
		}
		
		public function animateOut():void
		{
					
		}
		
		protected function notifyAnimateOutComplete():void
		{
			this.dispatchEvent( new ViewEvent(ViewEvent.ANIMATE_OUT_COMPLETE));
		}
		
		public function destroy():void
		{
			
		}
		
		public function set data( value:XMLList ):void
		{
			_data = value;
		}
		
		public function set id( value:int ):void
		{
			_id = value;
		}
		
		public function get id():int
		{
			return _id;	
		}
		
		
		public function get active():Boolean
		{
			return _active
		}
		
		public function set active( value:Boolean ):void
		{	
			_active = value
		}
		
		
	}
}