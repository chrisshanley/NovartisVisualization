package com.vml.interfaces
{	
	[Event(name="animateShowComplete", type="com.vml.events.ViewEvent")]
	[Event(name="animateHideComplete", type="com.vml.events.ViewEvent")]
	public interface IAnimatable
	{	
		function animateShow( time:Number = 0.7 ):void
		function animateShowComplete():void
		function animateHide( time:Number = 0.7 ):void
		function animateHideComplete():void
	}
	
	
}