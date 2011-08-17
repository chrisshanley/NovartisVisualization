package com.vml.views
{
	import com.vml.data.AbstractModel;
	
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;

	public class AbstractApplication extends MovieClip
	{

		
		public function AbstractApplication()
		{
			super();
		}
		
		public function init( info:LoaderInfo ):void
		{
			dispatchEvent( new Event ( Event.INIT ) );	
		}
		
		public function initView():void
		{
			
		}
		
	}
}