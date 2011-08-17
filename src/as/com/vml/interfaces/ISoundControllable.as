package com.vml.interfaces
{
	import flash.media.SoundTransform;

	
	
	public interface ISoundControllable
	{
		function get name():String;
		function set name( value:String ):void;
		
		function get soundTransform( ):SoundTransform;
		function set soundTransform( value:SoundTransform ):void; 
	}
	
	
}