package com.vml.views
{
	import com.vml.events.VideoEvent;
	import com.vml.video.FLVPlayer;
	import com.xerox.components.VideoControls;	
	public class VideoView extends AbstractView
	{
		
		protected var _flvPlayer:FLVPlayer;
		protected var _controls:VideoControls;
		
		public function VideoView()
		{
			super();
		}
		
		override public function init():void
		{
			_active = true;
			_controls = new VideoControllerComponent() as VideoControls;
			_flvPlayer = new FLVPlayer( 550, 300 );
			
			_controls.x = _flvPlayer.width * 0.5 - _controls.width * 0.5;
			_controls.y = _flvPlayer.height + 10;
						
			addChild( _flvPlayer );
			addChild( _controls );
			
			addEvents();
		}
		
		override public function set active(value:Boolean):void
		{
			switch(  value )
			{
				case false :
					removeEvents();
				break;
				case true :
					addEvents();
				break;
				
			}	
			super.active = value;
		}
		
		protected function addEvents():void
		{
			_controls.addEventListener(VideoEvent.MUTE_VIDEO, handleMuteVideo );
			_controls.addEventListener(VideoEvent.UNMUTE_VIDEO, handleUnmuteVideo );
			_controls.addEventListener(VideoEvent.PAUSE_VIDEO, handleResumeVideo );
			_controls.addEventListener(VideoEvent.PAUSE_VIDEO, handlePauseVideo );
			_controls.addEventListener(VideoEvent.MUTE_VIDEO, handleMuteVideo );
		}
		
		protected function removeEvents():void
		{
			
		}
		
		protected function handleSeek( event:VideoEvent ):void
		{
			_flvPlayer.seek( event.data.percent );
		}
		
		protected function handleResumeVideo( event:VideoEvent ):void
		{
			_flvPlayer.resumeVideo();	
		}
		
		protected function handlePauseVideo( event:VideoEvent ):void
		{
		
			_flvPlayer.pauseVideo();
		}
		
		protected function handleMuteVideo( event:VideoEvent ):void
		{
			_flvPlayer.mute();
		}
		
		protected function handleUnmuteVideo( event:VideoEvent ):void
		{
			_flvPlayer.unMute();
		}
		
		
		
		
	}
}