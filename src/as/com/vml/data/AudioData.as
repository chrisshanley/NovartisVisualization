package com.vml.data
{
	import com.vml.events.AudioEvent;
	import com.vml.media.AudioFile;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.casalib.util.ConversionUtil;
	
	public class AudioData extends AbstractData
	{
		
		public static var SECONDS:Number = 1000;
		
		protected var _duration:Number
		protected var _timer:Timer;
		protected var _elapsed:Number;
		protected var _audio:AudioFile;
		
		public function AudioData( audioFile:AudioFile )
		{
			super();
			
			_audio = audioFile;	
			_audio.addEventListener(AudioEvent.STARTED, handleStarted );
			_audio.addEventListener(AudioEvent.STOPPED, handleStopped );
			
			_elapsed = 0;
			_duration = ConversionUtil.millisecondsToSeconds( _audio.length );
			
			_timer = new Timer( AudioData.SECONDS );
			_timer.addEventListener( TimerEvent.TIMER, handleCount );
		}
		
		protected function handleRestart( event:AudioEvent ):void
		{
				
		}
		
		protected function handleCount( event:TimerEvent):void
		{
			_elapsed += AudioData.SECONDS;
		}
		
		protected function handleStarted( event:AudioEvent ):void
		{
			_timer.start();
		}
		
		protected function handleStopped( event:AudioEvent ):void
		{
			_timer.stop();
		}
		
		
		
		public function get elapsed():Number
		{
			return _elapsed/AudioData.SECONDS;	
		}
		
		public function get duration():Number
		{
			return _duration;
		}
		
		
		
		
	}
}