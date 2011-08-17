package com.vml.controllers
{
	import com.vml.events.ViewEvent;
	import com.vml.views.AbstractView;
	
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;

	[Event(name="animateOutComplete", type="com.vml.events.ViewEvent")]
	[Event(name="animateInComplete", type="com.vml.events.ViewEvent")]
	public class TransitionController extends EventDispatcher
	{
		
		protected var _section:AbstractView;
		protected var _requestedSection:Class;
		protected var _container:MovieClip;
		
		public function TransitionController(container:MovieClip)
		{
			_container = container;
		}
		
		public function changeSection( classRef:Class ):void
		{
			if( _section )
			{
				_section.addEventListener(ViewEvent.ANIMATE_OUT_COMPLETE, handleSectionOut );
				_section.animateOut();
			}
			else 
			{
				_section = new classRef() as AbstractView;
				_section.addEventListener(ViewEvent.ANIMATE_IN_COMPLETE, handleSectionIn );
				_section.init( );
				_section.animateIn();
				_container.addChild( _section );
			}
		}
		
		
		protected function handleSectionIn( event:ViewEvent ):void
		{
			_section.removeEventListener(ViewEvent.ANIMATE_IN_COMPLETE, handleSectionIn );
			dispatchEvent( event.clone() );
		}
		
		protected function handleSectionOut( event:ViewEvent ):void
		{
			
			_section.removeEventListener( ViewEvent.ANIMATE_OUT_COMPLETE, handleSectionOut );
			_section.destroy();
			_container.removeChild( _section );
			
			_section = null;
			
			if( _requestedSection )
			{
				_section = new _requestedSection() as AbstractView;
				_section.addEventListener(ViewEvent.ANIMATE_IN_COMPLETE, handleSectionIn );
				_section.init( );
				_section.animateIn();
				_container.addChild( _section );
				
				_requestedSection = null;
			}
			else 
			{
				dispatchEvent( event.clone() );
			}
		}
		
		
		public function get section():AbstractView 
		{
			return _section;
		}
		
		
	}
}