package com.vml.media
{
	import com.vml.data.AudioData;
	import com.vml.events.AudioEvent;
	
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;


	[Event(name="started", type="com.vml.events.AudioEvent")]
	[Event(name="stopped", type="com.vml.events.AudioEvent")]
	[Event(name="finished", type="com.vml.events.AudioEvent")]
	[Event(name="restart", type="com.vml.events.AudioEvent")]
	[Event(name="soundComplete", type="flash.events.Event")]
	public class AudioFile extends Sound
	{
		
		public static const SOUND_PLAYING:String = "soundPlaying";
		public static const SOUND_NOT_PLAYING:String = "soundNotPlaying";
		public static const SOUND_LOOPING:String = "soundLooping";
		
		protected var _state:String;
		protected var _channel:SoundChannel;
		protected var _transform:SoundTransform;
		protected var _volume:Number;
		protected var _data:AudioData
		
		public function AudioFile( )
		{
			super( );
			
			_volume = 1;
			_transform = new SoundTransform();		
			_state = AudioFile.SOUND_NOT_PLAYING;
			_data = new AudioData( this );
		}
		
		public function get transform():SoundTransform
		{
			return _transform;
		}
		
		public function playSound():void
		{
			_state = AudioFile.SOUND_PLAYING;
			_channel = play();		
			_channel.soundTransform  = _transform;
			_channel.addEventListener(Event.SOUND_COMPLETE, handleSoundComplete );
			dispatchEvent( new AudioEvent( AudioEvent.STARTED ));
		}
		
		public function pause():void
		{
			_state = AudioFile.SOUND_NOT_PLAYING;
			_channel.stop();
			dispatchEvent( new AudioEvent(AudioEvent.STOPPED ));
		}
		
		public function resume():void
		{
			clearChannel();
	
			_state = AudioFile.SOUND_PLAYING;
			_channel = play( _data.elapsed * AudioData.SECONDS );		
			_channel.soundTransform  = _transform;
			

			_channel.addEventListener(Event.SOUND_COMPLETE, handleSoundComplete );
	
			dispatchEvent( new AudioEvent( AudioEvent.STARTED ));
		}
		
		public function loopSound():void
		{
			_state = AudioFile.SOUND_LOOPING;
			_channel = play();
			_channel.soundTransform = _transform;
			_channel.addEventListener(Event.SOUND_COMPLETE, manageLoop );
			dispatchEvent( new AudioEvent( AudioEvent.STARTED ));
		}
		
		protected function manageLoop( event:Event ):void
		{
			clearChannel();
			loopSound();
		}
		
		protected function clearChannel( ):void
		{
			_channel.removeEventListener(Event.SOUND_COMPLETE, handleSoundComplete );
			_channel.removeEventListener(Event.SOUND_COMPLETE, manageLoop );
			_channel = null;
		}
		
		protected function handleSoundComplete( event:Event ):void
		{
			dispatchEvent( event.clone() );
		}
		
		public function stop():void
		{
			_state = AudioFile.SOUND_NOT_PLAYING;
			_channel.stop();
			clearChannel();
			dispatchEvent( new AudioEvent( AudioEvent.STOPPED ));
		}
		
		public function set volume( value:Number ):void
		{
			_volume = value;
			_transform.volume = _volume;
			_channel.soundTransform = _transform;
		}
		
		public function get data():AudioData
		{
			return _data;
		}
		
		public function get volume():Number
		{
			return _volume; 
		}
		
		public function mute():void
		{
			_transform.volume = 0;
			_channel.soundTransform  = _transform;
		}
		
		public function unmute():void
		{
			_transform.volume = _volume;
			_channel.soundTransform = _transform;
		}
		
		public function get state():String
		{
			return _state;
		}
		
		public function destroy():void
		{
			stop();
			_transform = null;
			_state = null;
			_volume = 0;	
		}
		
		
	}
}